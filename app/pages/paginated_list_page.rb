class PaginatedListPage < BasePage
  option :per, optional: true
  option :after, optional: true
  option :before, optional: true

  def list
    limited_scope
  end

  def can_load_more
    if before
      scope.first != limited_scope.first
    else
      scope.last != limited_scope.last
    end
  end

  def cursor
    limited_scope.last.id if limited_scope.any?
  end

  def cursor_first
    limited_scope.first.id if limited_scope.any?
  end

  private

  def scope
    logger.info 'limited_scope'
    raise NotImplementedError
  end

  def limited_scope
    return @limited_scope if @limited_scope.present?

    @limited_scope = scope.limit(2)

    if after.present?
      @limited_scope = @limited_scope.where(
        @limited_scope.arel_table[:id].lt(after)
      )
    elsif before.present?
      @limited_scope = @limited_scope.where(
        @limited_scope.arel_table[:id].gt(before)
      )
    end

    @limited_scope
  end
end
