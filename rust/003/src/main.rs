fn is_prime(n: i64) -> bool {
    let sqrt_n = (n as f64).sqrt() as i64;

    for x in 2..sqrt_n {
        if n % x == 0 {
            return false;
        }
    }

    true
}

fn main() {
    let n = 600851475143;

    let sqrt_n = (n as f64).sqrt() as i64;

    let mut lpf = 1;

    for x in 2..sqrt_n {
        if n % x == 0 && is_prime(x) {
            lpf = x;
        }
    }

    println!("lpf: {}", lpf);
}
