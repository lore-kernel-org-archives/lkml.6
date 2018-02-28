Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbeB1OkR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:40:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35045 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752528AbeB1OkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:40:15 -0500
Date: Wed, 28 Feb 2018 15:40:13 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, thomas.petazzoni@bootlin.com,
        mylene.josserand@bootlin.com
Subject: Re: [PATCH 0/3] add CPUs OPPs to sun8i a83t
Message-ID: <20180228144013.ayd65zbezdya7cbo@flea>
References: <cover.f1ec43f8d2a0151c52434f0952e973b19626f285.1519823347.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6mf4y4m4gj2fmxli"
Content-Disposition: inline
In-Reply-To: <cover.f1ec43f8d2a0151c52434f0952e973b19626f285.1519823347.git-series.quentin.schulz@bootlin.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6mf4y4m4gj2fmxli
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 02:11:19PM +0100, Quentin Schulz wrote:
> Hi all,
>=20
> The Allwinner A83T is an octacore A7 divided in two clusters of 4 A7,
> each cluster having its own regulator and clock.
>=20
> Let's add the OPPs for each cluster so that we can use cpufreq on this So=
C.
>=20
> The operating points were found in Allwinner BSP and fex files and have
> been tested on a TBS A711 with cpuburn and cpufreq-ljt-stress-test.
>=20
> Note that there are a few OPPs that are missing:
>=20
> 1608000000Hz with 920000mV
> 1800000000Hz with 1000000mV
> 2016000000Hz with 1080000mV
>=20
> These OPPs are pretty unstable but it might be due to the SoC quickly
> overheating (till the board completely shuts down).
> It seems[1] impossible to reach those frequencies with none or passive
> cooling, so better leave them out by default.
>=20
> It's still possible to add those OPPs on a per-board basis though.
>=20
> [1] http://linux-sunxi.org/User:Tkaiser#First_steps_with_Banana_Pi_M3

Applied all three. The patch 3/3 wasn't ordered properly, so I fixed
it, and I removed the newline pointed out by Thomas.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--6mf4y4m4gj2fmxli
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqWv0wACgkQ0rTAlCFN
r3RJXBAAkKBrPoLCjiNPWSC4VcL/RFmryHF6u9AAEi048Plk7i3SFsvKVhwHBjtN
youjnFAzX7En/rHgAFsK9D4IyvvZW5tcHFwWpo60pwmcHfmikzC7oQeQKaq+F8Lz
Ldn0eSIfzmn8mPc0yv+v7zvk6eqW9KjrD8H3mRarY2WQwG/QTFFbjRyxmwYoZNOf
Nq+cgNcGRqS0rByxRmfsVXEPIb/iNEmdTgva0YsrdBoNHmvS22VLlpCiDbRQYx3g
z/Uz6wZPKwNic3II7CeXvZpm5V2GXJgsFdaLNO1VhBUQk4TH4Br2vRGMijlfqJa0
uoOazryXiCAABk8YuBmRvwLx5AmIfxtFm4t5+pdgBzGbQA6KrkwIPhEc07Uf4eqF
eMZR8GwOsiotvug4YP5zW/gJ5vxSE0qPI6WN8UMAnF8eg/P3sC4GcoDer1oj/LYz
01Z4b8FuSSl6TQHtLTxl8Uo6qSjjjJRr4TUHz7tTIMK4ABznG9pSBwpHm+GZukC+
WTa0oEwtxflJ0Nk66aVcly1dd7447pYOVEhhdJBGNin4DOL7kbgXmVNolQ0lXQyx
CysteY+rs7iGxoDyLlKCMcDGABR3jV5m67VDyDf6WsK8+/NaR77h9E7zK8JbTK0C
XtIB0iwMwanygmwWcqCeZH8Vsu4fQ//CeeYoj9X1E0cWJoys9Hc=
=Fqwd
-----END PGP SIGNATURE-----

--6mf4y4m4gj2fmxli--
