Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754096AbeE1Iou (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:44:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37780 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754043AbeE1Ios (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:44:48 -0400
Date: Mon, 28 May 2018 10:44:46 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] arm: dts: sun: Add missing cooling device
 properties for CPUs
Message-ID: <20180528084446.g24fphqqac2hi3rr@flea>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <eded393f4b508a1f377f9af6859a3b82a6787e1c.1527244201.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l4dcsg23dumy77y5"
Content-Disposition: inline
In-Reply-To: <eded393f4b508a1f377f9af6859a3b82a6787e1c.1527244201.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l4dcsg23dumy77y5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 25, 2018 at 04:01:52PM +0530, Viresh Kumar wrote:
> The cooling device properties, like "#cooling-cells" and
> "dynamic-power-coefficient", should either be present for all the CPUs
> of a cluster or none. If these are present only for a subset of CPUs of
> a cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order. For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
>=20
> Add such missing properties.
>=20
> Fix other missing properties (clocks, OPP, clock latency) as well to
> make it all work.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

The prefix should be sunxi and not sun, but it looks good to me
otherwise.

Let me know what your preferred merge method is.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--l4dcsg23dumy77y5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsLwX0ACgkQ0rTAlCFN
r3RTFw/+LvuG8dQ9Ks/IdzZIq1rc1Nx/wOZ/ZXEjoSkAkGSNsZ8ybTgBgxcEbyiS
mPRsoPKw2tF/nYdZfk31GzDoCTns64e/xuqdH5rKS+Dtu0h3NCsYY/8Nky6pHdfX
Shbksby8TlVEu/1YYraB/l+xrSzUqGnz5OHVGcYhc5qhzE9jqgvrVyFt8JWRqhPT
FlDKYHGox+fpqdEannhvPl2maPoT4Ox9b3ZNKihGQv5Ag/uUN2VpXUnjGI7AvSjY
DLEcyU/4yyFkfX7NGWz5opWurePWAzwI2KRUO3SjDkXlawpmz5Mi1a0nZALcvsaG
y85hxZypa354XEtWe2bQJQWBDLdeWzvHar9Y3H157BxwthyLuH/ZzCqDt1eThrxN
b5fGm2uqyr/hHxWNjMtq/6exMvXD3E6zufZ3PhbW5BmqCKEIIPxLapRsu6Jsxb0Q
G39zc6N9ml0qTPqJ5JDgPDoDxI1+pTN8BBV89mgVNlqcyX6e9xehU+y7Kgx0XrJL
CMYlBAENIYosOWqdO2ZlxmkC03rRq+A4ZCvMbFhtc93VXT3ZQZxfHnJaX/m2HUK9
253UeU18vFs4SyUvwgFgU5QicpNqdzei+3/KV5c32frHZVZKgoSyswjjKcf7dnBG
Bh+f3PvRXXgrE060DyqzNVBjrTEYKm9J3ImdjMlL8kpSivuF6Lw=
=zAUF
-----END PGP SIGNATURE-----

--l4dcsg23dumy77y5--
