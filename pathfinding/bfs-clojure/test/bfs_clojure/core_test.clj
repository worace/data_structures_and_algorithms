(ns bfs-clojure.core-test
  (:require [clojure.test :refer :all]
            [bfs-clojure.core :refer :all]))

;super simple landscape -- 2 lines with 1 space and 1 "#" in each line
(deftest parsing-a-landscape
  (testing "it parses lines of text into a landscape structure"
    (is (= {[0 0] "#" [1 0] " " [0 1] " " [1 1] "#"} (parse-landscape "# \n #")))))

(deftest reading-a-landscape-file
  (testing "it reads contents of landscape file from resources"
    (is (= "# \n #") (landscape-file "2by2.txt"))))

(deftest finding-start-position
  (testing "it finds coords for start-position in grid"
    (let [ls (parse-landscape (landscape-file "easiest.txt"))]
      (is (= [1 1] (start-pos ls))))))

; # -- [1,0]
;#S# -- [0,1 1,1(start) 2,1]
; #  -- [1,2]
(deftest finding-neighbors-of-a-coord
  (testing "it finds top,bottom,left,right neighbors"
    (is (= [[1 0] [0 1] [2 1] [1 2]] (neighbors [1 1])))))

(deftest queueing-neighbors-of-coord
  (testing "it only queues passable (non-#) cells"
    (let [ls (parse-landscape (landscape-file "easiest.txt"))
          queue (queue-neighbors (clojure.lang.PersistentQueue/EMPTY) ls [1 1])]
      (is (= [2 1] (first queue)))
      (is (= 1 (count queue))))))
