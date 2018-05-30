require 'formula'

class I386ElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  url "https://ftp.gnu.org/gnu/gcc/gcc-8.1.0/gcc-8.1.0.tar.xz"
  mirror "https://ftpmirror.gnu.org/gcc/gcc-8.1.0/gcc-8.1.0.tar.xz"
  sha256 "1d1866f992626e61349a1ccd0b8d5253816222cdc13390dcfaa74b093aa2b153"
  revision 1

  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'
  depends_on 'i386-elf-binutils'

  def install
    binutils = Formulary.factory 'i386-elf-binutils'

    ENV['CC'] = '/usr/local/bin/gcc-8'
    ENV['CXX'] = '/usr/local/bin/g++-8'
    ENV['CPP'] = '/usr/local/bin/cpp-8'
    ENV['LD'] = '/usr/local/bin/gcc-8'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=i386-elf', '--disable-werror',
                             "--prefix=#{prefix}",
                             "--enable-languages=c",
                             "--without-headers",
                             "--with-gmp=#{Formula["gmp"].opt_prefix}",
                             "--with-mpfr=#{Formula["mpfr"].opt_prefix}",
                             "--with-mpc=#{Formula["libmpc"].opt_prefix}"
      system 'make all-gcc'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/"i386-elf", prefix/"i386-elf"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/"man"/"man7"
    end
  end
end
