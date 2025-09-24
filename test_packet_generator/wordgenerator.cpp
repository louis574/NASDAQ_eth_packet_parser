#include <vector>
#include <string>
#include <iostream>

bool true_1_false_0(char x){
    if(x == '0'){
        return false;
    }
    else{
        return true;
    }
}


std::string bin_add(std::string in){
    bool carry = true;
    std::string out = "00000000";
    for(int i = 7; i >= 0; i--){
        if(true_1_false_0(in[i]) && carry){
            out[i] = '0';
            carry = true;
        }
        else if(true_1_false_0(in[i]) || carry){
            out[i] = '1';
            carry = false;
        }
        else{
            carry = false;
        }
    }
    return out;    
}

std::string int_to_bin_string(int n){
    std::string tmp = "00000000";
    for(int i = 0; i < n; i++){
        tmp = bin_add(tmp);
    }
    std::string out = "0000";
    for(int i = 0; i < 4; i++){
        out[i] = tmp[i+4];
    }
    return out;

}




std::pair<std::vector<std::string>, std::vector<std::string>> data_with_tkeep(std::string source_mac, std::string ip_type, int payload_length_bytes, std::pair<std::vector<std::string>, std::vector<std::string>> payload){
    std::vector<std::string> data; 
    std::vector<std::string> tkeep;
    std::vector<std::string> payload_data = payload.first;
    std::vector<std::string> payload_tkeep = payload.second;

    std::string tmp_byte = "00000010";
    
    
    data.push_back(source_mac + "0000000000000000");
    tkeep.push_back("11111111");

    data.push_back("00000000000000000000000000000000"+ip_type+payload_data[0].substr(0,16));
    tkeep.push_back("11111111");

    int new_payload_length_bytes = payload_length_bytes - 2;
    int words = new_payload_length_bytes / 8;
    int remainder = new_payload_length_bytes % 8;
    std::string tmp;
    for(int i = 0; i < words; i++){
        data.push_back(payload_data[i].substr(16,48) + payload_data[i+1].substr(0,16));
        tkeep.push_back("11111111");
    }

    if(remainder > 0){

        data.push_back(payload_data[payload_data.size()-1].substr(16,48) + "0000000000000000");
        std::string ones(remainder,'1');
        std::string zeros((8-remainder),'0');
        tkeep.push_back(ones+zeros);
    }


    std::pair<std::vector<std::string>, std::vector<std::string>> out(data,tkeep);
    return out;
}

std::pair<std::vector<std::string>, std::vector<std::string>> ip_sim(int header_length_4_bytes, int payload_length_bytes){
    std::vector<std::string> data; 
    std::vector<std::string> tkeep;

    std::string fifty_six(56,'0');
    std::string sixty_four(64,'0');
    std::string thirty_two(32,'0');


    
    
    data.push_back("0000" + int_to_bin_string(header_length_4_bytes) + fifty_six);
    tkeep.push_back("11111111");


    std::string tmp_byte = "00000000";

    int overlap = header_length_4_bytes % 2;
    int header_words = (header_length_4_bytes / 2) + overlap;

    for(int i = 1; i < header_words; i++){
        if(i== header_words-1 && overlap == 1){
            data.push_back(thirty_two + "00000000"+ "00000001"+"00000010"+"00000011");
            payload_length_bytes = payload_length_bytes-4;
            tmp_byte = "00000100";
        }
        else{
            data.push_back(sixty_four);
        }
        tkeep.push_back("11111111");
    }



    int words = payload_length_bytes / 8;
    int remainder = payload_length_bytes % 8;
    std::string tmp;
    for(int i = 0; i < words; i++){
        tmp = "";
        for(int x = 0; x<8; x++){
            tmp = tmp+tmp_byte;
            tmp_byte = bin_add(tmp_byte);
        }
        data.push_back(tmp);
        tkeep.push_back("11111111");
    }

    if(remainder > 0){
        tmp = "";
        for(int x = 0; x<8; x++){
            tmp = tmp+tmp_byte;
            tmp_byte = bin_add(tmp_byte);
        }
        data.push_back(tmp);

        std::string ones(remainder,'1');
        std::string zeros((8-remainder),'0');
        tkeep.push_back(ones+zeros);
    }


    std::pair<std::vector<std::string>, std::vector<std::string>> out(data,tkeep);
    return out;
}


std::pair<std::vector<std::string>, std::vector<std::string>> eth_ip(int header_length_4_bytes, int payload_length_bytes, std::string source_mac, std::string ip_type){
    std::pair<std::vector<std::string>, std::vector<std::string>> ip_payload = ip_sim(header_length_4_bytes,payload_length_bytes);

    int payload_length = header_length_4_bytes * 4 + payload_length_bytes;

    return data_with_tkeep(source_mac,ip_type,payload_length,ip_payload);   
}





void write_for_tb(std::pair<std::vector<std::string>, std::vector<std::string>> in){
    for(int i = 0; i < in.first.size(); i++){
        std::cout << "din = 64'b" << in.first[i] << ";" << std::endl;
        std::cout << "tkeep = 8'b" << in.second[i] << ";" << std::endl;
        std::cout << "tvalid = 1;" << std::endl;
        if(i == in.first.size()-1){
            std::cout << "tlast = 1;" << std::endl;
        }
        else{
            std::cout << "tlast = 0;" << std::endl;
        }
        std::cout << "#10;" << std::endl;

    }

    std::cout << "tvalid = 0;" << std::endl;
    std::cout << "tlast = 0;" << std::endl;
    std::cout << "#20;" << std::endl;

}




int main(){


    std::string forty_eight(48,'1');
    write_for_tb(eth_ip(11,100,forty_eight,"000000010000000"));

}