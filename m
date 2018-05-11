Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbeEKOhB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 10:37:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44467 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752948AbeEKOg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 10:36:59 -0400
Date: Fri, 11 May 2018 16:36:47 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <contact@paulk.fr>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v4 3/3] ARM: dts: sun7i: Add support for the Ainol AW1
 tablet
Message-ID: <20180511143647.ici2bfoeeldto3ju@flea>
References: <20180507220413.21990-1-contact@paulk.fr>
 <20180507220413.21990-3-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xxiga6mvouif32wv"
Content-Disposition: inline
In-Reply-To: <20180507220413.21990-3-contact@paulk.fr>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xxiga6mvouif32wv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 12:04:13AM +0200, Paul Kocialkowski wrote:
> +++ b/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
> @@ -0,0 +1,297 @@
> +/*
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)

This really should be the first line, and with a C++ style comment, as
in:

// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
/*
 * Copyright (C) ...

See Documentation/process/license-rules.rst

> +	backlight: backlight {
> +		compatible =3D "pwm-backlight";
> +		pwms =3D <&pwm 0 50000 PWM_POLARITY_INVERTED>;
> +		brightness-levels =3D <  0   1   1   1   1   2   2   2
> +				       2   3   3   3   3   4   4   4
> +				       5   5   5   6   6   6   7   7
> +				       8   8   8   9   9   9  10  10
> +				      10  11  11  12  12  12  13  13
> +				      14  14  14  15  15  16  16  17
> +				      17  17  18  18  19  19  20  20
> +				      21  21  21  22  22  23  23  24
> +				      24  25  25  26  26  27  27  28
> +				      28  29  30  30  31  31  32  32
> +				      33  33  34  35  35  36  36  37
> +				      38  38  39  39  40  41  41  42
> +				      43  43  44  44  45  46  47  47
> +				      48  49  49  50  51  51  52  53
> +				      54  54  55  56  57  57  58  59
> +				      60  61  61  62  63  64  65  65
> +				      66  67  68  69  70  71  71  72
> +				      73  74  75  76  77  78  79  80
> +				      81  82  83  84  85  86  87  88
> +				      89  90  91  92  93  94  95  96
> +				      97  98  99 101 102 103 104 105
> +				     106 108 109 110 111 112 114 115
> +				     116 117 119 120 121 123 124 125
> +				     127 128 129 131 132 133 135 136
> +				     138 139 141 142 144 145 147 148
> +				     150 151 153 154 156 157 159 161
> +				     162 164 166 167 169 171 173 174
> +				     176 178 180 181 183 185 187 189
> +				     191 192 194 196 198 200 202 204
> +				     206 208 210 212 214 216 219 221
> +				     223 225 227 229 232 234 236 238
> +				     241 242 244 246 248 250 253 255>;

You kind of overdid it here :)

What I meant to say before was that if you have 10 elements (and you
really should have something in that magnitude) each step should
increase the perceived brightness by 10%.

In this particular case, I really think having something close to <0 4
8 16 32 64 128 255> would be enough.

And in general, that kind of odd looking table without any more
context is just screaming for a comment :)

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--xxiga6mvouif32wv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr1qn4ACgkQ0rTAlCFN
r3T1fhAAg4IkyfpJOLPsTAh0O8cLo+82Lfa/YLz78L91phK/uCyVebNoQGvrJHHg
M4wR4rjKqB5ehTCPer3F+BWYA/obvHZObmj6eHCy17poU+tJbsa3b7OgZCS9Bwe4
bUbqYZveII1P2qUsOaOyWkka5UoJOZjxs0rBaShdGb1p//TibzXuCBZsH7z650TT
ZF/7wdFLkPm67Vp8mbFWnITMqYOyjhN4uwhriqiuAaA7nDz5DqXaiGHTE5eP7Hoq
Bpo6joFFwi82JzpXDSx5Ig4YJW2cMb6Idn9alqL553picznf04GZ0psPnuwC/0q5
LXppCh8b7Dvnzv3upO0Jv6mTU8szqgOK5YqhWHTxLtLv4o0SHIS49VmsHBw9yfJd
KqFlAUTNoBq83unXD7FqH6ONrn49Nj7RkB/rcecdEjtU3KdyFpy3WIa23BaSZAHx
x68wnA56M+kQeXZGTzJdxlfnRZu21B99tXkGTsOXYIHpxzgnNFmQlnQxVXwQ/E/b
xYrGfC8VO5BynKzX1VYIfQFkJ1xGsoMksQ7Htc7VkSx0BociG57iup++7xPC0oQM
7fP6jPb+MqJre7Mxz47ikY0IpFhLuB5dW3YAeOYlYbofdv9adr/VUKYGPmjavnZ3
ScfXnIWEQKlKYle/DjEfkqbscIVLoGzr3kliXk+nJfYgXQqtRnk=
=RPPW
-----END PGP SIGNATURE-----

--xxiga6mvouif32wv--
