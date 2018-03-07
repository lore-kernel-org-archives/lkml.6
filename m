Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934250AbeCGWgM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:36:12 -0500
Received: from ozlabs.org ([103.22.144.67]:49409 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754498AbeCGWgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:36:11 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 8 Mar 2018 09:35:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Emmanuel Vadot <manu@freebsd.org>
Subject: linux-next: build failure after merge of the sunxi tree
Message-ID: <20180308093532.7fcfb205@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9n2_Q1=wciWOgmAUxS7vdDu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9n2_Q1=wciWOgmAUxS7vdDu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sunxi tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dtb: ERROR (phandle_references): =
Reference to non-existent node or label "mmc2_8bits_pins"

Caused by commit

  89fd776b2b9f ("dts: sunxi: Add eMMC for NanoPi M1 Plus")

I have merged the version of the sunxi tree from next-20180307 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/9n2_Q1=wciWOgmAUxS7vdDu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqgaTQACgkQAVBC80lX
0Gyykwf9Fa5NUeuUzcJe7V9Cl9CBGe0u7iBXf2K7bDHdUWd0fJdfA5vFhGAUbLzG
pDKJcpMVmsXxoUezov9ghE6WB3TdKvcLhSXRt4Vr/JVLEgWft+7QoAOA8h4fJwUB
55tSHI5OM2XbqDpy9SFMP8Ew5gO+jnyRnuU54jDBrh8ZSjRFxrILUYGJMRVrqc2s
xCUtDKSZRcEUHCA6qThm9x+YX31fTBoyI64MdRctC3egKaB+0KyfdBeyGC4K0Ke2
geKmgxqyL2R1O4Ab6bXExS0hvqpBtXc3xvL0fKD3V2FQRzXloCc2wbI2rlF4fW12
pgmD7WWXoxr9m/y7R+H8uAlsb8Tf0w==
=rNCe
-----END PGP SIGNATURE-----

--Sig_/9n2_Q1=wciWOgmAUxS7vdDu--
