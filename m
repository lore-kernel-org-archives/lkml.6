Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753770AbeE3TSi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:18:38 -0400
Received: from anholt.net ([50.246.234.109]:46548 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751623AbeE3TSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:18:37 -0400
From: Eric Anholt <eric@anholt.net>
To: Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] drm/v3d: add CONFIG_MMU dependency
In-Reply-To: <20180525155030.3667352-5-arnd@arndb.de>
References: <20180525155030.3667352-1-arnd@arndb.de> <20180525155030.3667352-5-arnd@arndb.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Wed, 30 May 2018 12:18:34 -0700
Message-ID: <87o9gxne9h.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Arnd Bergmann <arnd@arndb.de> writes:

> Without CONFIG_MMU, we get a link error:
>
> drivers/gpu/drm/v3d/v3d_bo.o: In function `v3d_gem_fault':
> v3d_bo.c:(.text+0x3ca): undefined reference to `vm_insert_mixed'
>
> The other drivers with this problem already depend on CONFIG_MMU,
> so let's do the same thing here.
>
> Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to drm-misc-next-fixes.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlsO+QoACgkQtdYpNtH8
nuhJJhAAmWQNvV0njl7oCwx8Yw2gKeqPlvHyPk6q7gXZ/vH9Xm9orS2pjzDmINEt
hoX2uFbFmCwWyaZhk+BYRFFUWtEENvVJAWBa/1tIfdVaVgWQAFIFAX1V3QRHKUHz
5zq0gDHzcN/Bww9xjzhQmBPnMoVxjiTT7Lv0pU6DtN6P2L3vap6R+FVzXEq1KJ2X
qDMZBPh0+9luy8RNyOsbP3iaHHZ1Udg1N1iZhmLBUq4bwWZEQVNMY3qKyXQEq8eo
jXzYGv2EbUI/m2jhhIGlQ2EAO+QQnPhQw0Za8VvpeyHRYApMj0543Uglt5ssOr1/
fZ2C+BuT/Pi+/VoroGYLO7W6fJNG8NXqh+K+wHdYGxk/hZkB3ajRnTr1ffsyWPnL
Wm4RpH4Trf7xoHbFYAGetNt4M28BqugDWDXbG0uL0mL8gvEkUwAE/tBJ5AcwI0Zu
iwyrB+Dey010RdeCUiCR+4V6xZ4hRNMngSlxn1DLISvCDoQUOhVKSyM64Ra1Ww93
lVdTKNvq4nBqUxujRQ/PfslLwfByepdHIPaRzuY1AVFF+VXW5DhNkjiuk2lHrd2b
mwsa0d/50JL7muAGyHVKJLXpo1iD6nzNo1Me1x0TTgMBQF9F3giOq7YehFyLjIDJ
BbPHQBM1r8x288VGf+mGX/4hd/nVPhRfgq1qC9tiG473TWnA128=
=Ga9x
-----END PGP SIGNATURE-----
--=-=-=--
