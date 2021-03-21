module RegisterFile (clk,read_address1,read_address2,write_address,write_data,valid_address,read_data1,read_data2);
    
    input clk;
    input [4:0] read_address1,read_address2,write_address;
    input [15:0] write_data;
    input [2:0] valid_address;

    output reg [15:0] read_data1,read_data2;

    reg [15:0] file [0:31];

    reg [1:0] cycles=0;

    always @(posedge clk) begin
        
        cycles=cycles+1;

        if(cycles==2) begin
            if(valid_address[2]==1)begin // read data2
                read_data2 <=  file[read_address2];
            end

            if (valid_address[1]==1) begin // read data1
                read_data1 <=  file[read_address1];
            end

            if (valid_address[0]==1) begin // write data
                file[write_address] <=  write_data;
            end 
            cycles <= 0;  
        end

    end

    initial begin
        file[0]=0;
        file[1]=0;
        file[2]=0;
        file[3]=0;
        file[4]=0;
        file[5]=0;
        file[6]=0;
        file[7]=0;
        file[8]=0;
        file[9]=0;
        file[10]=0;
        file[11]=0;
        file[12]=0;
        file[13]=0;
        file[14]=0;
        file[15]=0;
        file[16]=0;
        file[17]=0;
        file[18]=0;
        file[19]=0;
        file[20]=0;
        file[21]=0;
        file[22]=0;
        file[23]=0;
        file[24]=0;
        file[25]=0;
        file[26]=0;
        file[27]=0;
        file[28]=0;
        file[29]=0;
        file[30]=0;
        file[31]=0;       
    end

endmodule