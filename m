Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933232AbeE2LDC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:03:02 -0400
Received: from ozlabs.org ([203.11.71.1]:37647 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932840AbeE2LDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:03:00 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 29 May 2018 21:02:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Malaterre <malat@debian.org>
Subject: linux-next: boot messages from today's linux-next
Message-ID: <20180529210257.26da8de7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qW63_4G3s+Rn81/meypW38y"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qW63_4G3s+Rn81/meypW38y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

My qemu boots of today's powerpc linux-next kernel produced the following
boot message differences:

-Max number of cores passed to firmware: 2048 (NR_CPUS =3D 2048)
+Max number of cores passed to firmware: u (NR_CPUS =3D 2048)

Seemingly caused by commit

  eae5f709a4d7 ("powerpc: Add __printf verification to prom_printf")

--=20
Cheers,
Stephen Rothwell

--Sig_/qW63_4G3s+Rn81/meypW38y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsNM2EACgkQAVBC80lX
0GyCXwgApP8ZwkJRONX4Vk1eCSzCXxDkYm5ZEP7inV2Ur/wshd8dm/C/1GLVGmkM
1ilp4TFgULSCLEqJL7OxEU9ivjZBj+78zvzJaXBSt4Vr78eyrYxvpH7FQggpBn5H
en1Oyc2yeBur74e+aPw2wKtSWYwPU5gj8lP6+OwQwkYjKk8VBQbYXiYbjMvrTzlG
rtdMqGTkX9FY4f29bqayLHsnj61nwkZlSrQ6KwoVRv9aiol6uMttTLpSLp4xmTxF
/rP5S3+Ps2S7rzbu+m9BYdMMOI9KfCTUMo6OiDdbSLcPEEyiNjwCsGyD1+fzv2Uv
dV8kNTNlzJahxQFqzEFpqlx9a7lFjA==
=LcnE
-----END PGP SIGNATURE-----

--Sig_/qW63_4G3s+Rn81/meypW38y--
