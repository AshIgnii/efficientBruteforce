def customBaseCounter(limit, step, initial, elements, prevArr) #counts up in given numerical system, by step. if the given array is the biggest possible number given the element count, returns true.
    if prevArr == nil then #check if a previous array has been passed
        prevArr = Array.new
        for i in 0..elements-1 do #creates one if not
            prevArr.push(initial)
        end
        print "start: #{prevArr}\n"
        return prevArr
    end

    for i in 0...prevArr.size do #iterate through array
        @carry = 0
        if prevArr[i] == limit then #check if current element reached the limit
            for k in 0..prevArr.size do #check how many elements reached the limit
                if prevArr[k] == limit then
                    @carry += 1
                end
            end

            if @carry == prevArr.size then #if all have reached the limit, return true
                return true
            end

            if prevArr[i+1] != nil && prevArr[i+1] < limit then #if the current element is equal to the limit and the next one exists and is lower than the limit, add to the next element and reset the current
                prevArr[i] = 0
                prevArr[i+1] += step
                break
            end
        else #if current element is less than limit count up by step
            prevArr[i] += step
            break #prevents counting up all elements
        end
    end

    return prevArr #returns the new array
end

#create possible characters array (increases execution time linearly)
abc = "abcdefghijklmnopqrstuvwxyz1234567890"
arr = abc.split("")

#base values
base = abc.size-1
stp = 1
iValue = 0
elNum = 3

#input
puts "letter count? (increases execution time exponentially)"
elNum = Integer(gets)
puts ""

puts "word with #{elNum} letters:"
pass = gets
puts ""
passArr = pass.split("")
passArr.pop()

print "objective: #{passArr} \n"
sleep(5)

#count up through all possibilities
$tries = 0
for j in iValue..(base+2)**elNum do
    if j < 1 then #pass nil if its the first cycle
        $prv = customBaseCounter(base, stp, iValue, elNum, nil) #create and returns the initial array with all elements being the iValue
    elsif j >= 1 then
        $prv = customBaseCounter(base, stp, iValue, elNum, $prv) #count up by stp on the previous array

        if $prv != true then #check if function reported that the upper limit has been reached
            @toletter = Array.new
            for l in 0..$prv.size-1 do #convert the number array to the corresponding letter array
                @toletter.push(abc[Integer($prv[l])])
            end

            print "#{@toletter.reverse}" + "\n" #reverse because the function counts from left to right and i cant be bothered to fix it
        else
            break
        end
        $tries += 1 #counts the cycles
        if @toletter.reverse == passArr then #check if the word was correctly guessed
            puts "success"
            break
        end
    end
end

puts "done!"
puts "cycles: #{$tries}" 