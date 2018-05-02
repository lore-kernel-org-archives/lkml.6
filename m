Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeEBNJL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:09:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50951 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751076AbeEBNJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:09:09 -0400
Date: Wed, 2 May 2018 15:09:08 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, horms@verge.net.au,
        geert@linux-m68k.org, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/12] ARM: sun9i: smp: Add is_a83t field
Message-ID: <20180502130908.nuykfypradbmggs5@flea>
References: <20180501123131.7738-1-mylene.josserand@bootlin.com>
 <20180501123131.7738-10-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zkxm64ha7pf6swcd"
Content-Disposition: inline
In-Reply-To: <20180501123131.7738-10-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zkxm64ha7pf6swcd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 01, 2018 at 02:31:28PM +0200, Myl=E8ne Josserand wrote:
> To prepare the support of sun8i-a83t, add a field in the smp_data
> structure to know if we are on sun9i-a80 or sun8i-a83t.
>=20
> Add also a global variable to retrieve which architecture we are
> having.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--zkxm64ha7pf6swcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrpuHMACgkQ0rTAlCFN
r3QJLQ/7BZLYOy+KhTa4nm4lR1xhZ6Wsd/n1GY5dtM0m5HKWDfSsMpXEq4xjZCmL
Kgcd8Iz1LBMQhyVO978ZztaHiEzDCiq8O1FXd0f6kQNThnTf4KDBkZyrJFOrTeL/
bIVjg+9eLo8kzz/BAcE9v7ys5JIgbK4lVhHaU1YZPVNQcSbLRlFg/sa/6UBmVWO7
7cp5CVrkNBwRoInC/C6ZMpKtstyyucttBoUx1doR7qkNBiDKyzBju02E0St+HtVi
MIPeEzBHSYxZTzKYzsATXdRIKN7UpToApuhWkQI7E3V4TFw4XCGvV3HIKbkNeiZi
7Wp3hui/L8XXPmpfQFNcKd4FkyalukAL1nZN7DoxfG1FwAcCw0lhTE5a6SZmjn61
Losgn/LtfK4FlIFdWhykK/qXsOEfoKl7wQjwiAXffyeJAmHvqxiZtbyrYGgBxm1Y
UDAJshu1x7uxSBc9PHzo2h7vpR1M5hZnOpZlwwmQFiIODyhbkpcLR6145xayykbu
5Fy83F1MU+2FTA86QJPDuwlsMDLIMWDOE2uk4gYSCULcZtSURyIAInSad/FoieZq
miJyXqLkrb882Rcul/yybRhEopc2/jpbkD7w4HWJt65u8ofOmpspmXqE5ksHPlS+
yik+SQjl+E/IWYDen8OCxFLaywuFm3Nt5qpos9K3nzOHiDSV7wM=
=G4h2
-----END PGP SIGNATURE-----

--zkxm64ha7pf6swcd--
