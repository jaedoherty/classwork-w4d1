class PolyTreeNode
    
    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @parent = nil 
        @children = []
    end

    def parent=(parent_node)
        @parent.children.delete(self) if @parent != nil
        if parent_node != nil
            # parent_node.remove_child(self)
            @parent = parent_node
            parent_node.children << self if !parent_node.children.include?(self) && parent_node != nil
        else
            @parent = nil
        end
    end

    def add_child(child)
        children << child if !children.include?(child)
        child.parent = self
    end

    def remove_child(child)
        if children.include?(child)
            # children.delete(child)
            child.parent = nil
        else
            raise "Node is not a child"
        end
    end

    def dfs(target) #root would have to be a poly tree node instance from the above class 
        return self if self.value == target
        self.children.each do |node|
            search_result = node.dfs(target)
            return search_result unless search_result.nil?
        end
        nil
    end
    
    def bfs(target)
        array = []
        array << self
        #create loop, take out 1st ele of array and check value 
        #if value == target, return value
        #if not, add it's descendents to the end of the array and loop again
        i = 0
        while array.length > i 
            ele = array[i]
            array[i] = []
            if ele.value == target
                return ele 
            else
                array += ele.children
                i += 1 
            end
        end
        nil
    end
    
end

# class Searachable


# end


