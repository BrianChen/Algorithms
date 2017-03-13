def dfs(root, target)
  return nil if root.nil?
  return root if root.val == target

  root.children.each do |child|
    search_result = dfs(child, target)
    return search_result unless search_result == nil
  end
  nil
end
