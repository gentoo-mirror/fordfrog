# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Not using the upstream repo as it is not developped anymore but a live clone
EGIT_REPO_URI="https://github.com/bubonic/VobSub2SRT.git"

inherit cmake git-r3

IUSE=""

DESCRIPTION="Converts image subtitles created by VobSub to SRT subtitles using OCR engine"
HOMEPAGE="https://github.com/ruediger/VobSub2SRT"

LICENSE="GPL-3"
SLOT="0"

CDEPEND="
	app-text/tesseract:=
"
RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"
