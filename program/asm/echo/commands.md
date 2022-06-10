# ASM COMMANDS RISC-V

#   https://habr.com/ru/post/533272/

псевдоним 	имя  	        назначение                                  сохранение

zero 	    x0   	        Вечный и неизменный ноль                 	n/a
ra 	        x1 	            Адрес возврата 	                            нет
sp 	        x2   	        Stack pointer, указатель стека 	            да
gp  	    x3              Регистры для нужд компилятора,
tp          x4 	            Лучше их вообще не использовать             n/a
t0-t6 	    x5-x7, x28-x31 	Временные регистры 	                        нет
s0-s11 	    x8, x9, x18-x27 Рабочие регистры 	                        да
a0-a7 	    x10-x17 	    Аргументы функции 	                        нет
a0, a1 	    x10, x11 	    Возвращаемое значение функции 	            нет


инструкция 	аргументы 	    описание

add 	    rd, r1, r2 	    rd = r1 + r2
addi 	    rd, r1, N 	    rd = r1 + N
and 	    rd, r1, r2 	    rd = r1 & r2
andi 	    rd, r1, N 	    rd = r1 & N
auipc       rd, N           rd = PC + N
beq 	    r1, r2, addr 	if(r1==r2)goto addr
beqz 	    r1, addr 	    if(r1==0)goto addr
bgeu 	    r1, r2, addr 	if(r1>=r2)goto addr
bgtu 	    r1, r2, addr 	if(r1> r2)goto addr
bltu 	    r1, r2, addr 	if(r1< r2)goto addr
bne 	    r1, r2, addr 	if(r1!=r2)goto addr
bnez 	    r1, addr 	    if(r1!=0)goto addr
call 	    func 	        вызов функции func
csrr 	    rd, csr 	    rd = csr
csrrs 	    rd, csr, N 	    rd = csr; csr |= N, атомарно
csrs 	    scr, rs 	    csr |= rs
csrs 	    scr, N 	        csr |= N
csrw 	    csr, rs 	    csr = rs
ecall 		                провоцирование исключения для входа в ловушку
j 	        addr 	        goto addr
la 	        rd, addr 	    rd = addr
lb 	        rd, N(r1) 	    считать 1 байт по адресу r1+N
lh 	        rd, N(r1) 	    считать 2 байта по адресу r1+N
li 	        rd, N 	        rd = N
lw 	        rd, N(r1) 	    считать 4 байта по адресу r1+N
mret 		                возврат из обработчика исключения
mv 	        rd, rs 	        rd = rs
or 	        rd, r1, r2 	    rd = r1 | r2
ori 	    rd, r1, N 	    rd = r1 | N
ret 		                возврат из функции
sb 	        rs, N(r1) 	    записать 1 байт по адресу r1+N
sh 	        rs, N(r1) 	    записать 2 байта по адресу r1+N
sw 	        rs, N(r1) 	    записать 4 байта по адресу r1+N
slli 	    rd, r1, N 	    rd = r1 << N
srli 	    rd, r1, N 	    rd = r1 >> N
sw 	        rs, N(r1) 	    записать 4 байта по адресу r1+N
xor 	    rd, r1, r2 	    rd = r1 ^ r2
xori 	    rd, r1, N 	    rd = r1 ^ N


директива 	    аргументы 	    описание

.align 	        N 	            выравнивание по 2^N. Например, .align 9 это выравнивание на 2^9 = 512 байт
.bss 		                    секция нулевых данных в ОЗУ
.data 		                    секция ОЗУ
.equ 	        name, val 	    присвоить макроконстанте name значение val
.global 	    name 	        глобально видимое имя для стыковки с другими модулями
.macro / .endm 	name 	        создание макроса по имени name
.section 	    name 	        войти в подсекцию name
.short 	        N[, N[, N…]] 	объявить одну или несколько переменных размером 2 байта с заданными значениями
.text 		                    секция кода
.weak 	        name 	        “слабое” имя, которое может быть перекрыто другим
.word 	        N[, N[, N…]] 	см. .short, только размер 4 байта

.byte   1, 2, 3         # три однобайтные переменные со значениями 0x01, 0x02 и 0x03
.short  4, 5            # две двухбайтные переменные со значениями 0x0004 и 0x0005
.word   6, 7            # две четырехбайтные переменные 0x0000'0006 и 0x0000'0007
.quad   100500          # одна восьмибайтная переменная 0x0000'0000'0001'8894
.ascii  "abcd", "efgh"  # две переменные по 4 символа (обратите внимание! Терминирующий ноль не добавляется)
.asciz  "1234"          # строка "1234\0" - с терминирующим нулем на конце. Обратите внимание что в имени директивы только одна буква 'i'
.space  10, 20          # ОДНА переменная размером 10 байт, каждый из которых равен 20.
