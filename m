Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754856AbeDWMY4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:24:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36900 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754788AbeDWMYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:24:55 -0400
Date: Mon, 23 Apr 2018 14:24:44 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Pascal Roeleven <dev@pascalroeleven.nl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] Re: [PATCH] ARM: dts: sun4i: Fix incorrect clocks
 for displays
Message-ID: <20180423122444.msxpe5e4ovr6eqqb@flea>
References: <20180420102112.2843-1-dev@pascalroeleven.nl>
 <20180423071421.byupsz4gxpmhfe44@flea>
 <887c9144972ab75a4520141a17e1607b@pascalroeleven.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2tmxv6dh5nmwdvru"
Content-Disposition: inline
In-Reply-To: <887c9144972ab75a4520141a17e1607b@pascalroeleven.nl>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2tmxv6dh5nmwdvru
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 01:01:03PM +0200, Pascal Roeleven wrote:
> On 2018-04-23 09:14, Maxime Ripard wrote:
> > On Fri, Apr 20, 2018 at 12:21:12PM +0200, Pascal Roeleven wrote:
> > > Some displays on SUN4i devices wouldn't properly stay on unless
> > > 'clk_ignore_unused' is used.
> > >=20
> > > Change the duplicate clocks to the probably intended ones.
> > >=20
> > > Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
> >=20
> > What was the difference with the first patch you sent?
> >=20
> > Anyway, I've applied it, thanks
> >=20
> > Maxime
> >=20
> > --
> > Maxime Ripard, Bootlin (formerly Free Electrons)
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
>=20
> I'm sorry there isn't any.
> It's the first patch I have ever send so had some git-send-email issues a=
nd
> didn't know the correct procedure to resend a patch.

Just set RESEND in the subject prefix (using --subject-prefix=3D"PATCH
RESEND"), and say why you resent it in the patch / cover letter after
the --- and before the diffstat.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--2tmxv6dh5nmwdvru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrd0IsACgkQ0rTAlCFN
r3Sdhg/+LThkqlPVTzr0CIoG/5+0yaikJ0vqBmarQBmO5GjpRTQOZoM/iGiyZbdm
aFI6WSDkJ+CZOvnN3FLXa1WwJZ8Oak/avoyKFYNcHkBHg1urzDmZybO2Q9uK9PcA
NCa6vBMspGEJG7tchjWkOMy/h5p31ejnZldlpSmBI17HnK4m74kfPws4IgaiJZpH
Xyp5aMJTltM2r5vbpN3lhJ9itVGgI9EejYBgxhLCHtHmsfjU4F+W3WUY3OJMAVsn
LEuprG9zLdfPqb82tITDNAhlX3qN/TJXfHjsbrmmHhlc4mMxFEdbw9MM74Px10q+
jIxEpFI1MuURur9a1hJqqId4vJAD+E27tzgbPBp0oCTIwZV8b6txYsTi838jpDbA
b63XWN1hWAZuTKDMnpnP3FRDPoAtiooXDtmRhiKwvZLjGV93zlkibECukH7ZyaFe
RU6/NoX089mPiOnvYo9X/5ermzennpnA4Fcpk1ZZVbEPXYPMoAYL3b/5QjQhgjC8
tVDCxhbck9scYvVdmksiWY1FWDu80Q4ldrSJO5fHwC0Bt0XtK8Ca/R9Xx8YOIojc
Ym0pLMRH8XigkFXsZZ0tRCz/uNirAYDlGif0vrLHG8D/yIHUk6iJ4aqqsP/nT7xu
4NMFWTSPj6LKHw7zOsvNxO+2fAJmyOKNBTm/pqDtdlsKVEr7BdA=
=QDMo
-----END PGP SIGNATURE-----

--2tmxv6dh5nmwdvru--
