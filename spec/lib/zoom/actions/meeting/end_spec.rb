# frozen_string_literal: true

require 'spec_helper'

xdescribe Zoom::Actions::Meeting do
  let(:zc) { zoom_client }
  let(:args) { { host_id: 'dh23hdu23gd', id: '123456789' } }

  xdescribe '#meeting_end action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/meeting/end')
      ).to_return(body: json_response('meeting', 'end'))
    end

    it "requires a 'host_id' argument" do
      expect {
        zc.meeting_end(filter_key(args, :host_id))
      }.to raise_error(ArgumentError)
    end

    it "requires a 'id' argument" do
      expect {
        zc.meeting_end(filter_key(args, :id))
      }.to raise_error(ArgumentError)
    end

    it 'returns a hash' do
      expect(zc.meeting_end(args)).to be_kind_of(Hash)
    end

    it 'returns id and updated_at attributes' do
      res = zc.meeting_end(args)

      expect(res['id']).to eq(args[:id])
      expect(res['ended_at']).to eq('2012-11-25T12:00:00Z')
    end
  end

  xdescribe '#meeting_end! action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/meeting/end')
      ).to_return(body: json_response('error'))
    end

    it 'raises Zoom::Error exception' do
      expect {
        zc.meeting_end!(args)
      }.to raise_error(Zoom::Error)
    end
  end
end
