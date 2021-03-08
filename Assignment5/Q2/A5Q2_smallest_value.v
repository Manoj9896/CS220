module smallest_value (nums0,nums1,nums2,nums3,index);
    
    input [2:0] nums0,nums1,nums2,nums3;
    output wire [1:0] index ;

    wire [1:0] index1,index2;

    wire [2:0] nums [0:3];
    
    assign nums[0]=nums0;
    assign nums[1]=nums1;
    assign nums[2]=nums2;
    assign nums[3]=nums3;

    assign index1 = nums[0]>nums[1]?1:0;
    assign index2 = nums[2]>nums[3]?3:2;
    assign index = nums[index1]>nums[index2]?index2:index1;
    
endmodule