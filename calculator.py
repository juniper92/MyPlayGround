import os
import time


def enum(*sequential, **named):
    enums = dict(zip(sequential, range(len(sequential))), **named)
    return type('Enum', (), enums)


Cal = enum('None', 'Add', 'Sub', 'Mul', 'Div', 'Rem', 'Neg', 'Pow', 'Exit')


def add(a, b):
    return a + b


def sub(a, b):
    return a - b


def mul(a, b):
    return a * b


def div(a, b):
    return a / b


def rem(a, b):
    return a % b


def neg(a):
    return -a


def power(a, b):
    return a ** b


def show():
    time.sleep(1.5)
    os.system("clear")


while True:
    print("========== 계산기 ==========\n")
    print("\t1.더하기\t2.빼기")
    print("\t3.곱하기\t4.나누기")
    print("\t5.나머지\t6.역수")
    print("\t7.제곱  \t8.종료\n")

    key = int(input("번호입력 : "))

    if key == Cal.Add:
        a = int(input("첫번째 숫자 입력 >> "))
        b = int(input("두번째 숫자 입력 >> "))
        print(" >>> 결과 : ", add(a, b))
        show()

    elif key == 2:
        a = int(input("첫번째 숫자 입력 >> "))
        b = int(input("두번째 숫자 입력 >> "))
        print(" >>> 결과 : ", sub(a, b))
        show()

    elif key == Cal.Mul:
        a = int(input("첫번째 숫자 입력 >> "))
        b = int(input("두번째 숫자 입력 >> "))
        print(" >>> 결과 : ", mul(a, b))
        show()

    elif key == 4:
        a = int(input("첫번째 숫자 입력 >> "))
        b = int(input("두번째 숫자 입력 >> "))
        print(" >>> 결과 : ", div(a, b))
        show()

    elif key == Cal.Rem:
        a = int(input("첫번째 숫자 입력 >> "))
        b = int(input("두번째 숫자 입력 >> "))
        print(" >>> 결과 : ", rem(a, b))
        show()

    elif key == 6:
        a = int(input("한 개의 숫자 입력 >> "))
        print(" >>> 결과 : ", neg(a))
        show()

    elif key == Cal.Pow:
        a = int(input("첫번째 숫자 입력 >> "))
        b = int(input("두번째 숫자 입력 >> "))
        print(" >>> 결과 : ", power(a, b))
        show()

    elif key == Cal.Exit:
        print("계산기 프로그램을 종료합니다.")
        show()
        break

    else:
        print("잘못된 입력입니다!! ")
        show()