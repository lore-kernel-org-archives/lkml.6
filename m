Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754493AbeDWIOa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:14:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56474 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754475AbeDWIOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:14:25 -0400
Date: Mon, 23 Apr 2018 10:14:23 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, horms@verge.net.au,
        geert@linux-m68k.org, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/11] ARM: sun9i: smp: Add is_a83t field
Message-ID: <20180423081423.h7b35sobagypokpe@flea>
References: <20180420211022.11759-1-mylene.josserand@bootlin.com>
 <20180420211022.11759-9-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qmq5ehzlj356zjuy"
Content-Disposition: inline
In-Reply-To: <20180420211022.11759-9-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qmq5ehzlj356zjuy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 11:10:19PM +0200, Myl=E8ne Josserand wrote:
> To prepare the support of sun8i-a83t, add a field in the smp_data
> structure to know if we are on sun9i-a80 or sun8i-a83t.
>=20
> Add also a global variable to retrieve which architecture we are
> having.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/mach-sunxi/mc_smp.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
> index 03f021d0c73e..48e5f4db64b6 100644
> --- a/arch/arm/mach-sunxi/mc_smp.c
> +++ b/arch/arm/mach-sunxi/mc_smp.c
> @@ -74,6 +74,7 @@ static void __iomem *sram_b_smp_base;
> =20
>  extern void sunxi_mc_smp_secondary_startup(void);
>  extern void sunxi_mc_smp_resume(void);
> +static int is_a83t;
> =20
>  static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int clu=
ster)
>  {
> @@ -624,6 +625,7 @@ struct sunxi_mc_smp_nodes {
>  struct sunxi_mc_smp_data {
>  	const char *enable_method;
>  	int (*get_smp_nodes)(struct sunxi_mc_smp_nodes *nodes);
> +	int is_a83t;

This can be made a boolean.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--qmq5ehzlj356zjuy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrdld4ACgkQ0rTAlCFN
r3QoohAAmqsGMdtV9sKqbxoEg9PNx3E5cqw7/5L8YY+nFx+m33Osld8kJzyP4/uL
QPSU91AWDuujEE62O5K599qtOFO6IATGkE92gx/HgHiNGQvO604ci0tEpH7JnKEE
hmRnf4MN+CXh/bgCZJ8lsfLx5i3nw2wk9mmXVr9fzVDOgyPU6iXHJa8f2T+f8mcG
SQ8GFKGCgmnyNHCTWTAPKChTuT8YpujSWrkaLBo3msWf3CHXy6dfRHrPFo5poqF7
8tXH5NqrRfq1QwyD2sxBKHzWOioFMNOqvJyoGtDC99P5UZC+QGEWsin5/BwI3qxj
pWEyyAV/FGyJ2tmX3RBScgg3yqLRwplL18giS5uwON0N2kbW6x8Yq2SmLwzK/Mes
91cTNpC7eP9+q3t3/Dc0PrCN1gGO5eDjWuvbaeIA15z6+4WcjaNyrO+cQ846kTID
UTd/Dh/PxdivW2atu7LkMRjXbB77ZZeQyT6dWpr5+PxY5Bh6JByCwg8gorHKpGN0
ezABMxPJdyI1cG2CPPkirUWI3s7DOszTRMh2ONMsO3691NzkTnoc9XrH2ff+cv8Q
rqgnz+QNEBnyi+6qvge0jl+A0giBASfWCmJv3JOPGcJxc7ZDiDr+KJsI5m98WOqr
PozjDhp+HqEzymCME1BsgVAT3L8VGwSPyjsF/SUfjZyfa27szMA=
=kwK7
-----END PGP SIGNATURE-----

--qmq5ehzlj356zjuy--
