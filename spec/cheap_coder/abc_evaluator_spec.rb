# frozen_string_literal: true

RSpec.describe CheapCoder::AbcEvaluator do
  describe '#score and #check' do
    before do
      @evaluator = CheapCoder::AbcEvaluator.new
    end

    subject do
      @evaluator.check(node)
      @evaluator.score
    end

    context 'for assign node 1' do
      let(:node) { Parser::AST::Node.new(:lvasgn, [:str, 'Hello']) }

      it 'returns A score' do
        is_expected.to eq({ A: 1, B: 0, C: 0 })
      end
    end

    context 'for assign node 2' do
      let(:node) { Parser::AST::Node.new(:casgn, [nil, :CONST, 'TEST']) }

      it 'returns A score' do
        is_expected.to eq({ A: 1, B: 0, C: 0 })
      end
    end

    context 'for branch node' do
      let(:node) { Parser::AST::Node.new(:send, [nil, :some_method]) }

      it 'returns B score' do
        is_expected.to eq({ A: 0, B: 1, C: 0 })
      end
    end

    context 'for condition node' do
      let(:node) do
        Parser::AST::Node.new(:if, [
                                Parser::AST::Node.new(:nil, []),
                                Parser::AST::Node.new(:send, [nil, :some_method]),
                              ])
      end

      it 'returns C score' do
        is_expected.to eq({ A: 0, B: 0, C: 1 })
      end
    end

    context 'for several nodes' do
      it 'cumulates scores' do
        @evaluator.check(Parser::AST::Node.new(:gvasgn, []))
        @evaluator.check(Parser::AST::Node.new(:yield, []))
        @evaluator.check(Parser::AST::Node.new(:while, []))
        expect(@evaluator.score).to eq({ A: 1, B: 1, C: 1 })
      end
    end
  end
end
