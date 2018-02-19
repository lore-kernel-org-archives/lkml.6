Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbeBSIwT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 03:52:19 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:56097 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbeBSIwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 03:52:17 -0500
Date: Mon, 19 Feb 2018 09:52:05 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: wens@csie.org, linux@armlinux.org.uk, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v3 6/7] arm: dts: sun8i: a83t: Fix undefined offset with
 virtual timer
Message-ID: <20180219085205.jh6bcmbzcxqffkhk@flea.lan>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
 <20180219081837.15482-7-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="swcqkmnxnqqwxqtn"
Content-Disposition: inline
In-Reply-To: <20180219081837.15482-7-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--swcqkmnxnqqwxqtn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 19, 2018 at 09:18:36AM +0100, Myl=E8ne Josserand wrote:
> The ARM architected timers use an offset between their physical and
> virtual counters. That offset should be configured by the bootloader
> in CNTVOFF.
>=20
> However, the A83t bootloader fails to do so, and we end up with an
> undefined offset (which in our case is random), meaning that each CPU
> will have a different time, which isn't working very well.
>=20
> Fix that by setting the arm,cpu-registers-not-fw-configured that will
> make Linux use the physical timers instead of the virtual ones. One
> possible side effect would be that the virtualization features would
> be disabled. However, due to the way the GIC has been integrated in
> the system, it is already unusable so we're effectively not losing any
> feature.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>

One small nitpick on this one (and the previous one), arm in the
subject prefix should be uppercase.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--swcqkmnxnqqwxqtn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqKkDQACgkQ0rTAlCFN
r3SXPQ/9HiMOITN6rhCMOcwolM6if0cK1KZMFq1LLftQXV5N/6JUdehvV7aSZfC6
YRGq3Nmz33cgnwnZcuZzWTwSSCOwtQox2P6G91q5W/nT8cMvP+nS6j8RoNVAdxkn
SfqI+yJzAxkW9fJy2lWtohIzPRShorGlnkEhq9hK7/6W5dQtEXUEKvjrY2eW2RPy
UmV4XtPcXGb++A+mnLyTq7NtcYu4zFRkrierrVefi6GHFeHlxIlWqP2KdkpZl5qM
mV+pulcZhMT/7u8EwBYlJI/0eAPz7IkwzqCFAn4K3oV6RwXP4Icx0aejgbcMyspB
ySy4L1XxqzuB9zxZX/bPyeo9vFddMULl39w+K23Ivil0KIdo9Ec8aDegpSOa+4zW
z5fZkoJmMdYtA1ZPA9G2p9NHk4akNoEniZxhA3L2HmJ1wcXcYW8wOxLuGCHU/Len
SgiJyg0I+X5v4smtcNrvoILH9KcuvLzUjDFInqaiGCJyUWaoqbeNcer6UpX7in8s
kMVllEu6QXYaIrQ2khujCknj4InyMqv1pgIoOuYULbxxZ1g/B/UYng9okd3kw1Am
Oyakr/GgPLtE14cHmqBu9wLVkYclzvIULNVqzHvDWAgaGphw0JLtx8XKzeDfClfU
juEzyz1BaDY+zWYZ8eaoaZ2QGpBrK5xVFsl6z++20HykBUwsE0I=
=s1e8
-----END PGP SIGNATURE-----

--swcqkmnxnqqwxqtn--
