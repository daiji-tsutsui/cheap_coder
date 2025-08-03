# frozen_string_literal: true

RSpec.describe CheapCoder::Authorizer do
  describe '#allow?' do
    before do
      whitelist = [:permitted_method]
      @authorizer = CheapCoder::Authorizer.new(whitelist)
    end

    subject { @authorizer.allow?(node) }

    context 'if receiver exists' do
      context 'any method' do
        let(:node) { Parser::AST::Node.new(:send, [nil, :any_method]) }

        it 'is NOT allowed' do
          is_expected.to be_falsy
        end
      end
    end

    context 'if receiver is nil' do
      context 'a method not permitted' do
        let(:node) { Parser::AST::Node.new(:send, [nil, :unpermitted_method]) }

        it 'is NOT allowed' do
          is_expected.to be_falsy
        end
      end

      context 'a method permitted' do
        let(:node) { Parser::AST::Node.new(:send, [nil, :permitted_method]) }

        it 'is allowed' do
          is_expected.to be_truthy
        end
      end
    end

    context 'for non-send node' do
      let(:node) { Parser::AST::Node.new(:other, [nil, :permitted_method]) }

      it 'raises ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end
  end
end
