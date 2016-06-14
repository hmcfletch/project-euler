fn is_palindrome(n: u32) -> bool {
    let mut v: Vec<u32> = Vec::new();

    let mut x = n;

    while x > 0 {
        let r = x % 10;
        v.push(r);
        x = (x - r) / 10;
    }

    for i in 0..((v.len()) / 2) {
        if v[i] != v[v.len() - 1 - i] {
            return false;
        }
    }

    true
}

fn main() {
    let mut lp = 0;

    let mut x1 = 0;
    let mut y1 = 0;

    for x in 100..999 {
        for y in ((x/2) as u32)..999 {
            let val = x * y;

            if val > lp && is_palindrome(val) {
                lp = val;
                x1 = x;
                y1 = y;
            }
        }
    }

    println!("largest palindrome: {} * {} = {}", x1, y1, lp);
}
