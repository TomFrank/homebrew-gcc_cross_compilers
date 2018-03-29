require 'formula'

class I586ElfBinutils < Formula
  homepage 'http://gcc.gnu.org'
  url "https://ftp.gnu.org/gnu/binutils/binutils-2.30.tar.gz"
  mirror "https://ftpmirror.gnu.org/binutils/binutils-2.30.tar.gz"
  sha256 "8c3850195d1c093d290a716e20ebcaa72eda32abf5e3d8611154b39cff79e9ea"

  depends_on 'gcc' => :build

  def install
    ENV['CC'] = '/usr/local/bin/gcc-7'
    ENV['CXX'] = '/usr/local/bin/g++-7'
    ENV['CPP'] = '/usr/local/bin/cpp-7'
    ENV['LD'] = '/usr/local/bin/gcc-7'

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=i586-elf',
                             '--enable-gold=yes',
                             '--disable-werror',
                             "--prefix=#{prefix}"
      system 'make all'
      system 'make install'
      FileUtils.mv lib, libexec
    end
  end

end
