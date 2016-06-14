fn main() {
    let mut previous = 1;
    let mut current = 2;

    let mut total = 0;

    while current <= 4000000 {
        if current % 2 == 0 {
            total = total + current;
        }

        let m = current + previous;
        previous = current;
        current = m;
    }

    println!("total: {}", total);
}
