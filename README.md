# verilog
a repository for verilog coding
#### 1. A mod 7 calculator
A circuit module can return the mod 7 result of a 16-bit number stored in the internal register. In each clock cycle, the number will shifted 1 bit to the left, and a random generated bit will become the MLB. Meanwhile, the remainder of the 16 bit register **data_out [2:0]** is returned **in the same clock cycle**.
#### 2. A stop watch
A stopwatch module with the following function:
1. When reset signal **RST_ N** is invalid (RST_ N = 0, valid, RST_ N = 1, invalid) and  **SW_ en** is valid (SW_ EN = 1), the watch starts timing from 00:00. When it reaches 60:00, it returns to 00:00.
2. When the timing reaches a set time, **Time_ Out** signal will be high level.
3. When the **pause** signal is valid (pause = 1), the current display time does not change (the output does not change), but the internal timing continues. When the pause signal is invalid, the current timing time will be output again.
4. When global **RST_ N** signal is valid (low level valid), the stopwatch is cleared, the timing stops, and the previous time_ Out signal set low.
5. When the **clear** signal is valid, the timing is cleared.
6. when **Sw_ en** is set to low, the timing stops, the current time remains unchanged, and the internal timing stops;
