require 'formula'

class I586ElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftpmirror.gnu.org/gcc/gcc-7.3.0/gcc-7.3.0.tar.xz'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-7.3.0/gcc-7.3.0.tar.xz'
  sha256 '832ca6ae04636adbb430e865a1451adf6979ab44ca1c8374f61fba65645ce15c'

  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'
  depends_on 'i586-elf-binutils'

  def install
    binutils = Formula.factory 'i586-elf-binutils'

    ENV['CC'] = '/usr/local/bin/gcc-7'
    ENV['CXX'] = '/usr/local/bin/g++-7'
    ENV['CPP'] = '/usr/local/bin/cpp-7'
    ENV['LD'] = '/usr/local/bin/gcc-7'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=i586-elf',
                             '--disable-werror',
                             "--prefix=#{prefix}",
                             "--enable-languages=c",
                             "--without-headers"
      system 'make all-gcc'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/"i586-elf", prefix/"i586-elf"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/"man"/"man7"
    end
  end
end
