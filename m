Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbeC0XJW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 19:09:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34874 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752367AbeC0XJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 19:09:18 -0400
X-Google-Smtp-Source: AIpwx4+US9mE2HGgg/djtjenh2e0Iwc1xTcoT3TCTM88RMuQM4QlxXiRgSIDSDnPia35l+5va6IqYw==
Date: Wed, 28 Mar 2018 01:09:15 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: sun4i: properly check current state
Message-ID: <20180327230914.GA4097@mithrandir>
References: <20180225015558.4843-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20180225015558.4843-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2018 at 02:55:58AM +0100, Alexandre Belloni wrote:
> Correctly extract the prescaler value from CTRL_REG before comparing it to
> PWM_PRESCAL_MASK.
>=20
> Also, check that both PWM_CLK_GATING and PWM_EN to ensure the PWM is
> enabled instead of relying on only one of those.
>=20
> Fixes: 93e0dfb2c52f ("pwm: sun4i: Improve hardware read out")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6zxcACgkQ3SOs138+
s6H5Vg/+LCxDBAhnjfKyTfgW1mu3GJguzK0YULyX3OsT1+ufKKLjKiaC8E7NRwnU
qlrNN8gZM1ci+6QPIJFZkyA/AwpkIife0F7jP1oKxoYofsRryVbErsaGywbsUVJT
9A2IHRYw8sEw+JPAImocxrRF6vSUDGO7RPB8e4vxAFFP5+UJh5Yed74Ed2Uh6EJ2
CS01eS/M6J7MDdHs0LjHRebVS8AslwR34ym46y05yqmHE7xGgUoY/9bbVnDKu/Ds
ghURCZv1N8t62E4Rc2Usi+np9wRizS2GuMSxTHbToA5w471yga4YOW1f7fa6yrGT
jJTMqqZo3uP7AFypRws0tQLOtoSKvt4Q/thiYnb9c/kmED7ce37BPw62TaTjpYPm
hOyW373KEY+EE+n7bG6MUTAj7V8ZjDl0Gbj8LIseZQBQAQ9eFUJ6kRTH8YhPjxRR
bUwEOkA5sC2DcrSWOsOARXRFdEVtAG7x9IUOm0gxFrYV3BVPoyR1Z4Osv2aTviF2
OrI91/1fFecgrq/nZ+ojzpQSxNKcSF66tuu9qbT/6/IdH0BHN7C1mVEz6+RRtbWM
Tu9gQvtY9gD+Ogap0PxrMg0msxHPhX1g/SDducZv/8TdF5kEfx8TXWoYo39mejJC
zQ4uYOzm2VYaPjkUijpyPUhzj8rB3D8R61ocoGFjNJEX8CLmQ4k=
=/xhI
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
