require 'formula'

class I586ElfGdb < Formula
  homepage 'http://gcc.gnu.org'
  url "https://ftp.gnu.org/gnu/gdb/gdb-8.1.tar.xz"
  mirror "https://ftpmirror.gnu.org/gdb/gdb-8.1.tar.xz"
  sha256 "af61a0263858e69c5dce51eab26662ff3d2ad9aa68da9583e8143b5426be4b34"

  depends_on 'i586-elf-binutils'
  depends_on 'i586-elf-gcc'

  def install
    mkdir 'build' do
      system '../configure', '--target=i586-elf', "--prefix=#{prefix}", "--disable-werror"
      system 'make'
      system 'make install'
      FileUtils.rm_rf share/"locale"
      FileUtils.mv lib, libexec
    end
  end
end
