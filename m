Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753055AbeEOLzU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 07:55:20 -0400
Received: from ozlabs.org ([203.11.71.1]:45555 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753032AbeEOLzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 07:55:19 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 15 May 2018 21:54:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "ksummit-discuss@lists.linuxfoundation.org"
        <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180515215458.00f92def@canb.auug.org.au>
In-Reply-To: <CAJKOXPf=y_D4qA-M=cf4nuL3-J4D9k5UrVo=fDPjJwtntCUBFA@mail.gmail.com>
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
        <20180509224313.5e5fe381@canb.auug.org.au>
        <CAJKOXPf=y_D4qA-M=cf4nuL3-J4D9k5UrVo=fDPjJwtntCUBFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7NifbdT/4FMpEq.FRvUTzAM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7NifbdT/4FMpEq.FRvUTzAM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Tue, 15 May 2018 12:42:49 +0200 Krzysztof Kozlowski <krzk@kernel.org> wr=
ote:
>
> Please merge following fixes branches from my trees:
> Tree: samsung-krzk
> git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
> branch: fixes
>=20
> Tree: pinctrl-samsung
> git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git
> branch: pinctrl-fixes
>=20
> Although both are currently empty... but I guess you are collecting
> this also for future.

Yes, indeed.

Added from tomorrow.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/7NifbdT/4FMpEq.FRvUTzAM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr6ypIACgkQAVBC80lX
0GzXrAf+Iie5ugOF7rKgcAVgkS6uk/BxzEuseZukkmPsEew5mncMmmf88uZlhN+L
0zJFtpKwLulKyu8NeIqiHzGDB3NfHVrmGEBTWD1TDw24aHBufZkoXZgM/w5SAszt
anO1tNMMO6BpjBXHkTp5mxOEqkFkkjpfAZsegFi+HJ9eoZf6iAiWoAnwmF9jZHDo
Abyifbqt7SlU00wZ6UXgcppc+pVg6MC1HenUJ/hjZ9l6/pJTdk04pGSp2DDO6yvs
H6hRUWMwRoVN4gT6JCs3EU5uPVqsolw0YQ/RxIJX7fV992o2xLCHxXK/JK40XG2f
L5WIS1vyKa4XSFYdAvAffL1E88W9zw==
=jkXy
-----END PGP SIGNATURE-----

--Sig_/7NifbdT/4FMpEq.FRvUTzAM--
