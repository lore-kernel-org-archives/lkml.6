Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeEBNSy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:18:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51391 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbeEBNSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:18:51 -0400
Date: Wed, 2 May 2018 15:18:49 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, horms@verge.net.au,
        geert@linux-m68k.org, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/12] ARM: sunxi: smp: Move assembly code into a file
Message-ID: <20180502131849.rwthjkpf7nxojeui@flea>
References: <20180501123131.7738-1-mylene.josserand@bootlin.com>
 <20180501123131.7738-3-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gjbvu2v2ro5cizgo"
Content-Disposition: inline
In-Reply-To: <20180501123131.7738-3-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gjbvu2v2ro5cizgo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 01, 2018 at 02:31:21PM +0200, Myl=E8ne Josserand wrote:
> Move the assembly code for cluster cache enabling and resuming
> into an assembly file instead of having it directly in C code.
>=20
> Remove the CFLAGS because we are using the ARM directive "arch"
> instead.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--gjbvu2v2ro5cizgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrpurgACgkQ0rTAlCFN
r3QZORAAkNl/AqxJTu7X0QkR7XGUf4YhEpUikmjP1wG683jgnMsgf2AQyfkmCJ2W
ApL3stC0aF/QxZpWfWGP896d0Wb0w4uYPlEwADOlQ4qPjRQA5n5M44Qsz8NyUJ/F
FNGb3i4ZwfaNtfQLtczxnvxy6tOGvDlkgJc2c53z1l9FGq1SfahA+go0iju+Efmu
9r/uWUD8iJGw1bFVwqp+OITCAFNpC+OYC8qilc6/12YFrsRjop+mXdPl1hLZ3kvc
RHQTQvFq+c0iIYER/+OAaJYG1WMt/YMnZVOmVj/h9HGElUzq/nlagn1fixTO9fFY
TYICnYxECh953zExSYFUeeIL+xfQYTB/InDGzl7sHBBB53mB0DlfQmtARkSl+uw5
5JsEw3fBEcdp9/d1bN87fgUmqt40pL9QcgseN9B4Ob3bYT3cYkiL7LbtTzciEvEM
pCcDaAMVFOEJHAzF5dXVjTlPY5tSJh2lpV57XIHk2qvQShUp+w7th/lMfaCVGgsK
zXlZ46Srfi7zURQOW6GgS2aBl2tY5QKwT2vVlCgIZ+f+e4sH8KuPtuLlEHCK0rJ2
PybJZPBKz+wBbxGcYvpKnznKirZ18WBcUziq6j5+eG0tonAzKiko/DDpz2YQ7l+s
J5ffyeDwfokFL0MjgAkdjaqRmRzomuJga/0VcLNNPP9tZqROivo=
=2HPA
-----END PGP SIGNATURE-----

--gjbvu2v2ro5cizgo--
