Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755516AbeD3VEa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 17:04:30 -0400
Received: from anholt.net ([50.246.234.109]:40530 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755162AbeD3VE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 17:04:29 -0400
From: Eric Anholt <eric@anholt.net>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panel: Enable DSI transactions on the RPi panel.
In-Reply-To: <20180430092731.GA2270@ulmo>
References: <20171031193258.17373-1-eric@anholt.net> <20171031193258.17373-2-eric@anholt.net> <20180430092731.GA2270@ulmo>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Mon, 30 Apr 2018 14:04:26 -0700
Message-ID: <87vac8jtid.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Thierry Reding <thierry.reding@gmail.com> writes:

> [ Unknown signature status ]
> On Tue, Oct 31, 2017 at 12:32:58PM -0700, Eric Anholt wrote:
>> It turns out that I had just mistaken what type of write the register
>> writes were supposed to be, using DCS instead of generic long writes.
>>=20
>> Switching to transactions instead of using the atmel as a bridge also
>> seems to resolve the sparkling pixels problem I've had.
>>=20
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> Fixes: 2f733d6194bd ("drm/panel: Add support for the Raspberry Pi 7" Tou=
chscreen.")
>> ---
>>  drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 14 +-----------=
--
>>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> Did you want to take this along with patch 1 through drm-misc-next? If
> so:
>
> Acked-by: Thierry Reding <treding@nvidia.com>

I've pushed both to drm-misc-next.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlrnhNoACgkQtdYpNtH8
nuj7xg/6A3VFmzRxvtI2hP43Qt6Sl7ONcN4UYwbDg0yPqx6gkV5WScNDPZrQCBcy
NzPElt9RBWzj4CDVKqlekcjxtOXVqInd5j6EbI3EYTIuXN/hKv94TdvU7J+4OnFh
eWit/w/xa++0inaXfe62spejLZX9MxQyEGeVDFQP9GRdQTpk6Qsb+urKmomTaou4
CDEyIpz5RWGQPqYxe2VMUUfyH5jjzdcj1IFX9SAtRVQIARD1Cltyg/K9qyJGJy5x
Q5N80pFB+GH0Gw1E8WKJYHYrQz+eMcFHPvuaap977H3r6dRfytSIWvGMMb7vsS3C
dMSXLA+64edlLsLwnudEpWSjLxK6lmKtEugNIyKgdAKU/Gd7GGdapXraYEBhVsgi
WM5fn/HNYx4Jt6GBIiV9PuPVLOARxpMPJWTdWtKi7dew64SHZojzlRgmbuFWPYne
yjSq4DACmdNFgibvITFihBaENpjsjT28j2k5DIoWPr7kINSekDBHazWIUhWDPRNz
9/X7LY1uxwIXK+2n1u6RjG8HAm7uneU4OGN4yW9edHORZDzxrBBru6kd0IoEIII5
g9kPtwLjDg279X5KSqF4/x/jUWc8jUun/SWNrCz1/D3flC5vHFRhWUZSTVODxROT
Z99xDhwBaS0rSqYls2vdh+zSNXmIAFvGxJylN3XyYp7+dt0pV5c=
=s0WP
-----END PGP SIGNATURE-----
--=-=-=--
