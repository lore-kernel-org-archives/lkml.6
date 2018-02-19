Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeBSIt5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 03:49:57 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:55895 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752066AbeBSItz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 03:49:55 -0500
Date: Mon, 19 Feb 2018 09:49:44 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: wens@csie.org, linux@armlinux.org.uk, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v3 5/7] arm: dts: sun8i: a83t: Add CCI-400 node
Message-ID: <20180219084944.iqrdzhpl63gdf6wy@flea.lan>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
 <20180219081837.15482-6-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3wtrrwihokkagakw"
Content-Disposition: inline
In-Reply-To: <20180219081837.15482-6-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3wtrrwihokkagakw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 19, 2018 at 09:18:35AM +0100, Myl=E8ne Josserand wrote:
> +				interrupts =3D <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;

You should align these blocks on the first one in the array.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--3wtrrwihokkagakw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqKj6cACgkQ0rTAlCFN
r3S60w//c/kfpgsnq89Es2YlR9bEb/fuju59qDYxfA2CDHmr9hi/SnyFDq9aU2wo
0SvMOf8oF9xuoEosEHEjDS255JOYkDeBO0umWDqDfCwnwT0bCshNRClZNtcDs4ge
uFDV730/dHWjTqvYgoSO0jAjz8nRhvaKPf9VEZuGBxlS0i/RSfLzx4Ss+86b6APp
yUJpQRVgCDwmb9+MHHIA6Rv3mYKjR82v64y2nfO8r3E0a6aHMfobKiK84G0zEFL1
T3byG3Zg1Oiyox2r7hsdZ6UgJMni74WPqTMzu+RbOpgVcfH90xIt5HuMmHVEgYfc
/THLtT92c0cuR+4JMGcSWddkFjCTaKmY2KLmM+Uvg5XRDcT+5mKhrOGsjqirw9kc
/FdS6+GIMSumOJmZ966OhFcTbOhZqPxiKKJ9umz6VXPj15A5mtL0vgSRawjkUn0Q
ahbbA5hD6dfYzUIPYi9YM92jbS0PepbHrMkrhvagHsz+ymVDAg3qbssupiVED+o2
a1A7QoByjZgRlgHaehKLy3KnJdUbbzkiZAnf2nekP+tU+7cUHokeMdmeFN0mzKeX
tGnufSIQEerMcC03nzqYd7EINBCEW6hOTOCWsua+0T7M+NcGHtS3FspMSReveL0C
Gli2z3FB6NT87BdYy5l+pnJMq7e3yK4xFxDsrP2/I3tD0zV5omg=
=kjdy
-----END PGP SIGNATURE-----

--3wtrrwihokkagakw--
