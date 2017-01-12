require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do

  describe "POST #create" do
    let!(:user) { create(:user) }
    let!(:book) { create(:book) }
    subject { post :create, bookmark: {user_id: user.id, book_id: book.id} }
    before { login }

    it '新しいBookmarkが作成されること' do
      expect {
        subject
      }.to change(Bookmark, :count).by(1)
    end
  end

  describe "DELETE #destroy" do
    let(:bookmark) { create(:bookmark) }
    subject { delete :destroy, id: bookmark.id }
    before { login }
    it 'Bookmarkが削除されること' do
      subject
      expect {
        Bookmark.find(bookmark.id)
      }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
  
end
