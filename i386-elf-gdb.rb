require 'formula'

class I386ElfGdb < Formula
  homepage 'http://www.gnu.org/software/gdb/'
  url "https://ftp.gnu.org/gnu/gdb/gdb-8.1.tar.xz"
  mirror "https://ftpmirror.gnu.org/gdb/gdb-8.1.tar.xz"
  sha256 "af61a0263858e69c5dce51eab26662ff3d2ad9aa68da9583e8143b5426be4b34"

  depends_on 'i386-elf-binutils'
  depends_on 'i386-elf-gcc'

  def install
    # ENV['CC'] = '/usr/local/bin/gcc-8'
    # ENV['CXX'] = '/usr/local/bin/g++-8'
    # ENV['CPP'] = '/usr/local/bin/cpp-8'
    # ENV['LD'] = '/usr/local/bin/gcc-8'

    mkdir 'build' do
      system '../configure', '--target=i386-elf', "--prefix=#{prefix}", '--disable-werror'
      system 'make'
      system 'make install'
      #FileUtils.rm_rf share/"locale"
      #FileUtils.mv lib, libexec
    end
  end
end
