program DataMahasiswa;
uses crt;

type
  TData = record
    nama: string[50];     
    NIM: string; 
    KOM: char;
    nilai: real;   
    next: ^TData;          
  end;

var
  awal, sekarang, baru: ^TData; 
  pilihan: char;
  
procedure judul;
begin
  writeln('--------------');
  writeln('DATA MAHASISWA');
  writeln('--------------');
  writeln('Menu:');
  writeln('1. Tambah Data Mahasiswa');
  writeln('2. Lihat Semua Data');
  writeln('3. Edit Data Mahasiswa');
  writeln('4. Keluar');
end;

procedure TambahData();
begin
  new(baru);
  write('Masukkan Nama  : '); readln(baru^.nama);
  write('Masukkan NIM   : '); readln(baru^.NIM);
  write('Masukkan KOM   : '); readln(baru^.KOM);
  write('Masukkan Nilai : '); readln(baru^.nilai);
  baru^.next := nil;

  if awal = nil then
    awal := baru
  else
  begin
    sekarang := awal;
    while sekarang^.next <> nil do
      sekarang := sekarang^.next;
    sekarang^.next := baru;
  end;

  writeln('Data berhasil ditambahkan.');
end;

procedure TampilkanData();
begin
  if awal = nil then
    writeln('Belum ada data.')
  else
  begin
    writeln('Daftar Data Mahasiswa:');
    writeln('-------------------');
    sekarang := awal;
    while sekarang <> nil do
    begin
      writeln('Nama  : ', sekarang^.nama);
      writeln('NIM   : ', sekarang^.NIM);
      writeln('KOM   : ', sekarang^.KOM);
      writeln('Nilai : ', sekarang^.nilai:0:2);
      writeln('-------------------');
      sekarang := sekarang^.next;
    end;
  end;
end;

procedure EditData();
var
  editDariNIM: string;
begin
  write('Masukkan NIM yang ingin diedit: '); 
  readln(editDariNIM);

  if awal = nil then
  begin
    writeln('Belum ada data untuk diedit.');
    exit;
  end;

  sekarang := awal;
  while (sekarang <> nil) and (sekarang^.NIM <> editDariNIM) do
    sekarang := sekarang^.next;

  if sekarang <> nil then
  begin
    writeln('Data mahasiswa ditemukan.');
    writeln('Nama sebelumnya : ', sekarang^.nama);
    writeln('NIM sebelumnya  : ', sekarang^.NIM);
    writeln('KOM sebelumnya  : ', sekarang^.KOM);
    writeln('Nilai sebelumnya: ', sekarang^.nilai:0:2);

    write('Masukkan Nama baru    : '); readln(sekarang^.nama);
    write('Masukkan KOM baru     : '); readln(sekarang^.KOM);
    write('Masukkan Nilai baru   : '); readln(sekarang^.nilai);

    writeln('Data berhasil diperbarui.');
  end
  else
    writeln('Data mahasiswa dengan NIM ', editDariNIM, ' tidak ditemukan.');
end;

begin
  clrscr;
  awal := nil;

  repeat
    judul;
    write('Pilih (1-4): '); readln(pilihan);

    case pilihan of
      '1': TambahData();
      '2': TampilkanData();
      '3': EditData();
      '4': writeln('Keluar dari program.');
    else
      writeln('Pilihan tidak valid.');
    end;

    writeln;
  until pilihan = '4';
end.
