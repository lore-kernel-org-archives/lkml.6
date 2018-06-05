Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752904AbeFEXR2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 19:17:28 -0400
Received: from ozlabs.org ([203.11.71.1]:44507 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752261AbeFEXR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 19:17:26 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 6 Jun 2018 09:17:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the y2038 tree
Message-ID: <20180606091707.18a8f2f0@canb.auug.org.au>
In-Reply-To: <CABeXuvqG_DQMOwa0vrmJB+kx7DPbuMo=s-aS-DK7LdBy_ZGtTw@mail.gmail.com>
References: <20180606075535.09b41c23@canb.auug.org.au>
        <CABeXuvqG_DQMOwa0vrmJB+kx7DPbuMo=s-aS-DK7LdBy_ZGtTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/agPBo=wCUax1VmSP5M_fqJV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/agPBo=wCUax1VmSP5M_fqJV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Deepa,

On Tue, 5 Jun 2018 15:00:24 -0700 Deepa Dinamani <deepa.kernel@gmail.com> w=
rote:
>
> That patch belongs to Kees.

But you committed it to the tree ...

--=20
Cheers,
Stephen Rothwell

--Sig_/agPBo=wCUax1VmSP5M_fqJV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsXGfMACgkQAVBC80lX
0GzSDAgAjmRmSjICu9NxBES/wdxkFMdbJYWdgN3zAHfhLI8Dagr8s0dNy1nX+G09
Ngz8Bg1p4TVTnoykZldiuGcw7T6qiHxvRx0x/zLpgmSeNtNvRzM0MYw4PTdkrsK+
vykjDu2CnJw55opYc9TnSveT1pvNEwUyaN/0uEf0JZVvQKSvCNA9xQxSl5xiixnz
XFfmWNEXYdBbkW2nE+Z9i4BNl4fiYbZ/ufs3Yqj3DGjTxtyFQ6IenkeSvBlRHwuF
FsHyLpLncqgeT4zKnkr1Qb0TcB/pAgLvQBSJ5Yqb4aXZBKaTghSxqJQjLJi6HXqn
p3Z/0kYAe+8lf+Sni9PmUI1KyGstaQ==
=RXrR
-----END PGP SIGNATURE-----

--Sig_/agPBo=wCUax1VmSP5M_fqJV--
