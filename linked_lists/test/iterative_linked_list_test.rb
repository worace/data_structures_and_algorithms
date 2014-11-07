gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/iterative_linked_list'

class IterativeLinkedListTest < Minitest::Test
  attr_reader :list

  def setup
    @list = IterativeLinkedList.new
  end

  def test_it_starts_with_zero_elements
    assert_equal 0, list.count
  end

  def test_it_pushes_three_elements_onto_a_list
    list.push("hello")
    list.push("world")
    list.push("today")
    assert_equal 3, list.count
  end

  def test_it_pops_the_last_element_from_the_list
    list.push("hello")
    list.push("world")
    list.push("today")
    output = list.pop
    assert_equal "today", output
    assert_equal 2, list.count
  end

  def test_a_popped_element_is_removed
    list.push("hello")
    output = list.pop
    assert_equal "hello", output
    assert_equal 0, list.count
  end

  def test_it_pops_nil_when_there_are_no_elements
    assert_nil list.pop
  end

  def test_it_deletes_a_solo_node
    list.push("hello")
    list.delete("hello")
    assert_equal 0, list.count
  end

  def test_it_does_not_delete_when_the_data_does_not_match
    list.push("hello")
    list.push("world")
    list.delete("today")
    assert_equal 2, list.count
  end

  def test_it_deletes_a_tail
    list.push("hello")
    list.push("world")
    list.push("today")
    list.delete("today")
    assert_equal 2, list.count
    assert_nil list.find("today")
  end

  def test_it_deletes_a_middle_node
    list.push("hello")
    list.push("world")
    list.push("today")
    list.delete("world")
    assert_equal 2, list.count
    assert_equal "today", list.pop
    assert_equal "hello", list.pop
  end

  def test_it_deletes_the_head_when_there_are_more_nodes
    list.push("hello")
    list.push("world")
    list.push("today")
    list.delete("hello")
    assert_equal 2, list.count
    assert_equal "today", list.pop
    assert_equal "world", list.pop
  end

  def test_index_of_non_existant_node_is_nil
    list.push("hello")
    list.push("world")
    list.push("today")
    assert_nil list.index("pizza")
  end

  def test_it_converts_to_an_array_when_there_are_no_elements
    assert_equal [], list.to_a
  end

  def test_it_converts_to_an_array_with_several_elements
    list.push("hello")
    list.push("world")
    list.push("today")
    assert_equal ["hello", "world", "today"], list.to_a
  end

  def test_it_finds_the_tail
    list.push("hello")
    list.push("world")
    node = list.tail
    assert_equal "world", node.data
  end

  def test_a_node_links_to_its_next_element
    list.push("hello")
    list.push("world")
    assert_equal "world", list.tail.data
    assert_equal "world", list.head.next.data
  end

  def test_next_for_the_tail_is_nil
    list.push("world")
    assert_nil list.tail.next
  end

  def test_find_if_an_element_is_included_in_the_list
    list.push("hello")
    list.push("world")
    assert_equal true, list.include?("hello")
    assert_equal false, list.include?("bogus")
  end

  def test_find_a_given_node
    list.push("hello")
    list.push("world")
    list.push("today")

    assert_equal "world", list.find("world").data
    assert_equal "today", list.find("world").next.data
  end

  def test_index
    list.push("hello")
    assert_equal 0, list.index("hello")
    list.push("pizza")
    assert_equal 1, list.index("pizza")
    list.push("batman")
    assert_equal 2, list.index("batman")
  end

  def test_braces_gets_item_at_index
    list.push("hello")
    list.push("pizza")
    list.push("batman")
    assert_equal "hello", list[0].data
    assert_equal "pizza", list[1].data
    assert_equal "batman", list[2].data
  end

  def test_inserts_node_at_arbitrary_position
    list.push("hello")
    list.push("world")
    list.push("today")

    list.insert(1, "pizza")

    assert_equal ["hello", "pizza", "world", "today"], list.to_a
    assert_equal 1, list.index("pizza")
  end

  def test_inserted_node_is_next_for_previous_node
    list.push("hello")
    list.push("world")
    list.push("today")

    list.insert(1, "pizza")

    assert_equal "world", list.find("pizza").next.data
    assert_equal "pizza", list.find("hello").next.data
  end

  def test_insert_after_adds_a_node_after_a_given_node
    list.push("hello")
    list.push("world")
    list.push("today")

    list.insert_after("hello", "pizza")

    assert_equal "world", list.find("pizza").next.data
    assert_equal "pizza", list.find("hello").next.data
  end

  def test_insert_after_does_nothing_if_anchor_is_not_in_list
    list.push("hello")
    list.push("world")
    list.push("today")

    list.insert_after("batman", "pizza")

    assert_nil list.find("pizza")
  end

  def test_map_works_on_data
    list.push("hello")
    list.push("world")
    list.push("today")
    assert_equal ["hello", "world", "today"], list.map(&:data)
  end

  def test_each_yields_each_item
    list.push("hello")
    list.push("world")
    list.push("today")

    a = []
    list.each do |item|
      a << item.data
    end
    assert_equal ["hello", "world", "today"], a
  end

  def test_node_has_children
    list.push("hello")
    list.push("world")
    list.push("today")

    assert_equal ["world", "today"], list.head.children.map(&:data)
  end
end
