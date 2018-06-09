module Articles
  class Index < PaginatedListPage
    protected

    def scope
      Article.all
    end
  end
end
