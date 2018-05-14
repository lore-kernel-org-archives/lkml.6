Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeENXJa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 19:09:30 -0400
Received: from ozlabs.org ([203.11.71.1]:54205 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752414AbeENXJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 19:09:28 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 15 May 2018 09:09:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@lst.de>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the samsung-krzk tree with the
 dma-mapping tree
Message-ID: <20180515090901.74c9429e@canb.auug.org.au>
In-Reply-To: <20180510091634.7fb3aaf2@canb.auug.org.au>
References: <20180510091634.7fb3aaf2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GMW0qBhCSwxNPm2W8A8H_3S"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GMW0qBhCSwxNPm2W8A8H_3S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 10 May 2018 09:16:34 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the samsung-krzk tree got a conflict in:
>=20
>   arch/arm/mach-exynos/Kconfig
>=20
> between commit:
>=20
>   4965a68780c5 ("arch: define the ARCH_DMA_ADDR_T_64BIT config symbol in =
lib/Kconfig")
>=20
> from the dma-mapping tree and commit:
>=20
>   c5deb598089c ("ARM: exynos: Remove support for Exynos5440")
>=20
> from the samsung-krzk tree.
>=20
> I fixed it up (the latter removed the whole section modified by
> the former, so I just removed the section) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the arm-soc tree and the dma-mapping tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/GMW0qBhCSwxNPm2W8A8H_3S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr6Fw0ACgkQAVBC80lX
0GzaRQgAhplWggt/EOx/th8EogHsYGQ62l0YeXwMjc7E5A2kUAo4JLNS/79hOL+w
Kp1YoB3Yph38T0LyfqycMb6ibup5wemtRhr8PkDm9JJlqdSmhIMxTWv85qbYSJL3
cDOX4eIap1KHL+/+SCMlNNQGyUGo6ihgvXbUZhehh/9R5fYZWYBahLGdwynByJog
f9XLk8zJwPm93IRpJ7tMKN/miW5WiezD3Fv7Nqc3JjRWePKuW5gQEvP4pDgo7FEV
h7P6FvRZnOwxCNutPyevCKH3PYnzFPQMOlEvGFmuTljEAZeGTS5U0slRn159U4kA
UmZ1aBuiDMEb831JX4xRS4mfwvdEgw==
=KATa
-----END PGP SIGNATURE-----

--Sig_/GMW0qBhCSwxNPm2W8A8H_3S--
