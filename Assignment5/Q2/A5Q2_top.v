`include "A5Q2_smallest_value.v"

module A5Q2_top;

    reg [2:0] nums [0:3];
    wire [1:0] index;

    smallest_value SV(nums[0],nums[1],nums[2],nums[3],index);

    initial begin
        $monitor("nums[0]=%d nums[1]=%d nums[2]=%d nums[3]=%d index=%d",nums[0],nums[1],nums[2],nums[3],index);
        nums[0]=1;nums[1]=2;nums[2]=3;nums[3]=4;
        #1
        nums[0]=5;nums[1]=2;nums[2]=6;nums[3]=4;
        #1
        nums[0]=7;nums[1]=6;nums[2]=3;nums[3]=7;
        #1
        nums[0]=5;nums[1]=2;nums[2]=3;nums[3]=0;
        #1
        nums[0]=2;nums[1]=2;nums[2]=2;nums[3]=0;
        #1
        nums[0]=6;nums[1]=2;nums[2]=3;nums[3]=7;
        #1
        nums[0]=0;nums[1]=0;nums[2]=0;nums[3]=0;
        #1
        nums[0]=5;nums[1]=3;nums[2]=3;nums[3]=4;
        #1
        nums[0]=7;nums[1]=6;nums[2]=5;nums[3]=4;
        #1
        nums[0]=3;nums[1]=1;nums[2]=0;nums[3]=5;
        #1
        nums[0]=5;nums[1]=5;nums[2]=5;nums[3]=5;
        #1
        $finish;
    end

    
endmodule