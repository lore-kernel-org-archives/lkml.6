Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934696AbeEIMnS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:43:18 -0400
Received: from ozlabs.org ([203.11.71.1]:50937 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934126AbeEIMnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:43:17 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 9 May 2018 22:43:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Vinod Koul <vinod.koul@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ksummit-discuss@lists.linuxfoundation.org"
        <ksummit-discuss@lists.linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180509224313.5e5fe381@canb.auug.org.au>
In-Reply-To: <20180509105534.GE7985@vkoul-mobl>
References: <20180503020550.GP2714@sirena.org.uk>
        <20180503031000.GC29205@thunk.org>
        <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
        <20180503224217.GR2714@sirena.org.uk>
        <20180503230905.GA98604@atomide.com>
        <CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
        <20180509084440.GW13402@sirena.org.uk>
        <CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
        <20180509090346.GY13402@sirena.org.uk>
        <20180509204727.7ff38021@canb.auug.org.au>
        <20180509105534.GE7985@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/aQBQzqyF/.gCNJZYOb3UsPn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aQBQzqyF/.gCNJZYOb3UsPn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vinod,

On Wed, 9 May 2018 16:25:34 +0530 Vinod Koul <vinod.koul@linaro.org> wrote:
> >=20
> > I currently have 44 such fixes branches.  More welcome! =20
>=20
> Great so do you want us to send fixes branch or scan the existing trees a=
nd add
> them.

The former.

> In case of former please do add slave-dma/fixes as well

Done.  Should I switch your contact address to your kernel.org one
(from your Intel one)?

--=20
Cheers,
Stephen Rothwell

--Sig_/aQBQzqyF/.gCNJZYOb3UsPn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlry7OEACgkQAVBC80lX
0GypjAf9Eu4wch6Mlzdh6JijoxRYW0OxPXkyh/8vyjjQKt4XSwSUM84Q6D9dzNbM
RimuzlgQFOaZ76xqI//hscGjBpF9Pvsm8YVWfG3Gzb2aPV/AI5USL+GTZ+6s3ees
35y/ogvOKLqcNwQ2JVePX2E+cCKv+H39PxX2RlzATPjCsCyOktsPSJKdzhW27KF4
LwS/lLMCY+4wQ/rP4bRFuElyoVw8boYlF9pI3ApSpde894tIEFdyiOZukSwzPVoc
tOr7AxsxnLsyfJIEO0fmMWnR9H7F2juQ59ZtcudDZLyIHxY3UymVrw48aSYLvWpR
OjYmEO/25MmgPssRM7UIndkNHhp/QQ==
=CvRB
-----END PGP SIGNATURE-----

--Sig_/aQBQzqyF/.gCNJZYOb3UsPn--
