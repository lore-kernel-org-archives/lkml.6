Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeENVWb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:22:31 -0400
Received: from ozlabs.org ([203.11.71.1]:35573 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751978AbeENVWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:22:30 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 15 May 2018 07:22:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
Message-ID: <20180515072217.0a2ffe25@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.9yCL6CB+.8Q=rtYcoWvhTg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.9yCL6CB+.8Q=rtYcoWvhTg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  949a0c0dec85 ("ARM: dts: stm32: add USB Host (USBH) support to stm32mp157=
c")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/.9yCL6CB+.8Q=rtYcoWvhTg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr5/gkACgkQAVBC80lX
0Gzk3gf/b6grPX/h+SXXksBQDkYi5T3LgtYvbqDaEdU6+JL01CFjxCS6LoFMcjBB
uSAytNKApm+Dapg+dgK835tBP4bAcKXt4aak4PGT6lpxF6BLmA1+50xYLcpzdrqB
F6tDQH84zSEZRARsBpO958RnQo5TKs8u1BeIp6G3bYsI7whOSqQtESYPvt/BxwRT
zHg2Vraxdmg8VYKQ5t77RmlETqTEd3S3/xtJLnLlQQOTPiDOeXkBjWwcJgvjBxGJ
M8Pa22NL/ExVucko11rEPDegPgN4O8j4z5ownmNWirB8ocYMzR2NNsaPHBJqXq3R
ZA537QS05O4yfktrYRdN5uVzW+rrxw==
=jp9s
-----END PGP SIGNATURE-----

--Sig_/.9yCL6CB+.8Q=rtYcoWvhTg--
