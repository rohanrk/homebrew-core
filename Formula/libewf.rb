class Libewf < Formula
  desc "Library for support of the Expert Witness Compression Format"
  homepage "https://github.com/libyal/libewf"
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/libe/libewf/libewf_20140608.orig.tar.gz"
  mirror "https://mirrors.kernel.org/debian/pool/main/libe/libewf/libewf_20140608.orig.tar.gz"
  version "20140608"
  sha256 "d14030ce6122727935fbd676d0876808da1e112721f3cb108564a4d9bf73da71"
  revision 1

  bottle do
    cellar :any
    rebuild 2
    sha256 "c362a1ee13cd7a9208d6d742acf4136a61e71d9de1451140ffae4b82ca108ab4" => :high_sierra
    sha256 "5abcb4aaa80ac85b86b3b5d3bc4dce613fe4692d29edff5e48a8e871d2e89225" => :sierra
    sha256 "4d0d3cb0aa198dc0ca569b04d748b3d4f92cdb9e0580c70b9ab6a25dc44ca2f9" => :el_capitan
    sha256 "71af7ed8bbc39e690ef8b22adf5a8e0399fec4d6661323dfdda4581f55ca7dbd" => :yosemite
  end

  devel do
    url "https://github.com/libyal/libewf/releases/download/20170703/libewf-experimental-20170703.tar.gz"
    sha256 "84fe12389abacf63dea2d921b636220bb7fda3262d1c467f6d445a5e31f53ade"
  end

  head do
    url "https://github.com/libyal/libewf.git"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
    depends_on "gettext" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "openssl"

  def install
    if build.head?
      system "./synclibs.sh"
      system "./autogen.sh"
    end
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ewfinfo -V")
  end
end
