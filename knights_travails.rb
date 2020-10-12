require "byebug"
require_relative "00_tree_node.rb"

#2,2
#3,4
#1,4
#4,3
#pos + i1 == (1 || 2)
#pos - i1 == (1 || 2)

class KnightPathFinder

    MOVES = [[1,2],
    [1,-2],
    [2,1],
    [2,-1],
    [-1,2],
    [-1,-2],
    [-2,1],
    [-2,-1]
    ]
    attr_reader :pos

    def self.valid_moves(pos)
        x = pos[0]
        y = pos[1]
        valid_moves = []
        MOVES.each do |ele|
            new_pos = [x + ele[0], y + ele[1]]
            valid_moves << new_pos if new_pos.all? {|pos| pos>= 0 && pos <= 7}
        end 
        valid_moves

    end

    def initialize(pos)
        @pos = pos
        # @root_node = PolyTreeNode.new(pos)
        @considered_pos = [@pos]
        build_move_tree
    end

  

     def find_path(end_pos)
        # debugger
        end_node = root_node.dfs(end_pos)
        result = trace_path_back(end_node)
        result.reverse.map(&:value)
    end

    private 
    attr_accessor :root_node, :considered_pos

 
    def build_move_tree
        # debugger
        self.root_node = PolyTreeNode.new(pos)
        nodes = [root_node]
        until nodes.empty?
            current_node = nodes.shift 
            current_pos = current_node.value
            new_move_positions(current_pos).each do |i|
                next_node = PolyTreeNode.new(i)
                current_node.add_child(next_node)
                nodes << next_node
            end
        end
    end

    def new_move_positions(pos)
        moves = KnightPathFinder.valid_moves(pos)
        moves.select! {|move| !considered_pos.include?(move)}
        moves.each {|move| considered_pos << move}
        return moves
    end 
    
    def trace_path_back(end_node)
        nodes = []
        current_node = end_node
        until current_node.nil?
            nodes << current_node
            current_node = current_node.parent
            
        end
        nodes
    end

       
end

if $PROGRAM_NAME == __FILE__
    kpf = KnightPathFinder.new([0, 0])
    p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
    p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
end
