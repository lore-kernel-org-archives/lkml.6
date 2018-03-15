Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932424AbeCOU5L (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:57:11 -0400
Received: from ozlabs.org ([103.22.144.67]:60245 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752238AbeCOU5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:57:09 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 16 Mar 2018 07:56:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
Message-ID: <20180316075629.019b6560@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CtyQ/K0PVmIdC=bJE6dxSvV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CtyQ/K0PVmIdC=bJE6dxSvV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  9a5f4879cd8d ("ARM: dts: stih4xx: Add missing #sound-dai-cells")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/CtyQ/K0PVmIdC=bJE6dxSvV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqq3f0ACgkQAVBC80lX
0Gzzdwf/TCh9xFq7P3e7iZ1uPdvXbI5mfqfWin9rUZnUAcmDLARW4nskkFav5YyQ
K3aTo4BqsIEaNM3yi1W+S7Unq2zHrryauzlPh76eQlm0KiMWV240e5uvI0fLG8vB
jht8YE9OY/6y+lMI/l5F8dVD9vY/2FCC/sdoxekezQ3JrtEExvAhWhlAtC/Tv/w5
sU4PSw92X8qec4koQWwFERlg3v9ZgUzFd+elJ5YeUyqK/RUMAzf8MiDRKjIupDy3
NOoBbCckAIZJHFnpSA2xi6tJa/W5X52RVUr655JK1Ukm4zahMMZdg2wUso2oM3tl
wdW5RStcgMWEePSP2e4FFVtpYX7GPQ==
=IQ/1
-----END PGP SIGNATURE-----

--Sig_/CtyQ/K0PVmIdC=bJE6dxSvV--
