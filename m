Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755226AbeDCIq6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:46:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40494 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755174AbeDCIq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:46:56 -0400
Date: Tue, 3 Apr 2018 10:46:55 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/13] ARM: sun9i: smp: Add is_sun9i field
Message-ID: <20180403084655.x6u7s4jzqdvq2eey@flea>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-12-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n4rkxyokbn3s45tp"
Content-Disposition: inline
In-Reply-To: <20180403061836.3926-12-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n4rkxyokbn3s45tp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 08:18:34AM +0200, Myl=E8ne Josserand wrote:
> To prepare the support of sun8i-a83t, add a field in the smp_data
> structure to enable the case of sun9i.
>=20
> Start to handle the differences between sun9i-a80 and sun8i-a83t
> by using this variable.
>
> Add an index to retrieve which structures we are using.

This should have been in a separate commit, but maybe we can store a
pointer to the array cell we're using instead of always using the
index?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--n4rkxyokbn3s45tp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrDP34ACgkQ0rTAlCFN
r3Qm4g//bPfB2331etPvExaOQPcQve6RHCxTFiq2//e1JZ+mW1KP5eTWUXZ3J9Jz
/h+mGLy3yUoW/Vekgy1wLjEv1XMkCXSSHg9vtKck24luDHkdoBqEiOeWvPZ3jy7l
2J2EvenU1JB22VGcKHPoxPpHazs1TfB0NWVnhk0lRWEuO6IYaqZSJIqyvpdgfgQi
wqAsrxQ5YahNYFknOKwA1KWB/IVX+od2LEBNzSS7KiPhriG9e7m6Op8173cWNy4t
aXmXlOMhdh+Lwd+v52czRehv8nvzlMiUAkg5afy9+G5HjVRgqngMnFIjl5Zityv9
qd61IxKMeBKVBrBNAsp/M6LSl5bRjQFCQOznZOW0fCjFsph/DhXQyw5N9EKfMKhH
nbbfD4BKuhTa57rgXqgfeOYv1xp0Hz7U7jno4gnPylLq0qF19opsnQx/xkkcRgzA
GFoj88vR6LpIjfgY1vuMXXEg9Z+EW0EOxPEMyIBZv+W8d+EoYy8YdtzQs/snJAXF
kwAEtFV1JJ36M9ludU3lqqEG43EP1DJvQR9kKWpx2R0BG+rHQfydTj3cvq1Fn24Y
B9JMibCxAer5w3yqjmFWtaWvXe/L5lqG/NeLeDdOmNbksuf0Ccs63tczBAQTuwKX
wgx6LVc84yK7CnUNXUT99j/T0sbd93KT3JKs+7LP5mVzz/9aLcQ=
=6WCb
-----END PGP SIGNATURE-----

--n4rkxyokbn3s45tp--
