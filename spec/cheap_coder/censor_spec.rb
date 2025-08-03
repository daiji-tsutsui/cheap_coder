# frozen_string_literal: true

RSpec.describe CheapCoder::Censor do
  describe '#process' do
    before do
      @censor = CheapCoder::Censor.new
    end

    let(:script) { 'def main; end' }
    subject do
      expr = Parser::CurrentRuby.parse(script)
      @censor.process(expr)
    end

    it 'returns AST head node' do
      is_expected.to be_instance_of Parser::AST::Node
    end

    context 'when script includes shell commands' do
      let(:script) { 'test = `echo "hello"`' }

      it 'removes shell commands' do
        censored = Unparser.unparse(subject)
        expect(censored).to eq 'test = "echo \"hello\""'
      end
    end

    context 'when script includes %x literals' do
      let(:script) { 'test = %x(ls | grep test)' }

      it 'removes %x literals' do
        censored = Unparser.unparse(subject)
        expect(censored).to eq 'test = "ls | grep test"'
      end
    end

    context 'when script includes non-authorized methods' do
      let(:script) { 'str = "hello"; puts str' }

      it 'removes non-authorized methods' do
        expected = <<~EXPECTED
          str = "hello"
          nil
        EXPECTED

        censored = Unparser.unparse(subject)
        expect(censored).to eq expected
      end
    end

    context 'when script includes authorized methods' do
      before do
        @censor = CheapCoder::Censor.new(allowed_methods: [:puts])
      end

      let(:script) { 'str = "hello"; puts str' }

      it 'permits authorized methods' do
        expected = <<~EXPECTED
          str = "hello"
          puts(str)
        EXPECTED

        censored = Unparser.unparse(subject)
        expect(censored).to eq expected
      end
    end

    context 'when script includes inline-defined methods' do
      let(:script) { 'val = 0; def tested_method; val = 1; end; tested_method' }

      it 'permits inline-defined methods' do
        expected = <<~EXPECTED
          val = 0

          def tested_method
            val = 1
          end
          tested_method
        EXPECTED

        censored = Unparser.unparse(subject)
        expect(censored).to eq expected
      end
    end
  end

  describe '#score' do
    let(:censor) { CheapCoder::Censor.new(evaluator: evaluator) }
    subject do
      script = 'def main; end'
      expr = Parser::CurrentRuby.parse(script)
      censor.process(expr)
      censor.score
    end

    context 'without evaluator' do
      let(:evaluator) { nil }

      it 'returns nil' do
        is_expected.to be_nil
      end
    end

    context 'with AbcEvaluator' do
      let(:evaluator) { CheapCoder::AbcEvaluator.new }

      it 'returns Hash with keys :A, :B, :C' do
        expect(subject.keys).to match_array %i[A B C]
      end
    end
  end
end
