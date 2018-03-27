Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeC0WZF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 18:25:05 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43557 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752325AbeC0WZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 18:25:03 -0400
X-Google-Smtp-Source: AIpwx4/sNh9QObqKJcARXZ319PLzy/QeAXjS6penla7sdRrLjpbGvhR1SG6l3Q3McmuYrsCyPMoKXg==
Date: Wed, 28 Mar 2018 00:25:00 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: Re: [PATCH 1/4] pwm: jz4740: Make disable operation compatible with
 TCU2 mode
Message-ID: <20180327222459.GF28163@mithrandir>
References: <20180106165843.3461-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hK8Uo4Yp55NZU70L"
Content-Disposition: inline
In-Reply-To: <20180106165843.3461-1-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hK8Uo4Yp55NZU70L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 06, 2018 at 05:58:40PM +0100, Paul Cercueil wrote:
> From: Maarten ter Huurne <maarten@treewalker.org>
>=20
> On the JZ4750 and later SoCs, channel 1 and 2 operate in a different
> way (TCU2 mode) as the other channels. If a TCU2 mode counter is
> stopped before its PWM functionality is disabled, the output is not
> guaranteed to return to the initial level.
>=20
> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
> ---
>  drivers/pwm/pwm-jz4740.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Applied patches 1-4, thanks.

Thierry

--hK8Uo4Yp55NZU70L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6xLsACgkQ3SOs138+
s6G7Cw/+LFLqLDBxg+Iv8MhX2p4gqp1tzC6xaibAEDZyD3pYtbBTMT5sQEWvYvGb
X6VypbFBDI/ISAG8/IsE2dFC/bJbQdM9q00W9VYk9rif6UruiNi2GLmkQ50uokjA
9Uw4ZjBnTsHb4yh6wTqhueYyFDgIojSb5Grvkp5tMP3uWIYP2OVFLU74OHCw+tXm
gWGQstA+/QbHKOFBh3cVqN/G/GUrZCAzifDn8Cm2ZaIb/4cM3tW2oC7F76CcrZw/
NsEOrKFIZnIgXDbyiJccDwQTUggVnmlDKfQfddXyYorT3wplvObJK3h0tzgWTpYF
NRa88liLU7upD5hMiExrevWzBMeuC4xVWIz6NbZdFVE7dgrN3Qg85OACL+kKhX4r
qVREb0cgyEiMySM4gHQnEzN70rwYWxa5O3z4jW5mahNDjxf9EheGkRZx/hViDhXz
HXEdS4CM0rceukeHDU3hrmSn9ayODEESaLwYpuOBwH8XLXyXH8U2uR4bDazQLfXr
ohpYQh+jnylu6xDMwVujoFo1q6BVuKJoNvhR5509JA/hkHFn1MsncMcv7MH2JJcr
h5kln/oB/PAsu4MVKne/ETBYRPkUi/75yChMIGVi/czVl1de8Xkukfko/aokT8e9
Khr39wzZV6HuEG/rIy7ExnSJ25gUDSdPDB9dntf4eBKMYRQzHFE=
=WaEz
-----END PGP SIGNATURE-----

--hK8Uo4Yp55NZU70L--
