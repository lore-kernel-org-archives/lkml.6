Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF631C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864E72075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864E72075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeIGNBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:01:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57903 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbeIGNBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:01:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DFDF120799; Fri,  7 Sep 2018 10:21:23 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id B287420728;
        Fri,  7 Sep 2018 10:21:23 +0200 (CEST)
Date:   Fri, 7 Sep 2018 10:21:22 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v4 08/11] arm64: dts: allwinner: a64: Add display pipeline
Message-ID: <20180907082122.bcylf2jpf6eq6dgq@flea>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-9-icenowy@aosc.io>
 <20180905075056.tob7itg3judccooe@flea>
 <CAMty3ZBo+X5o22i1=HR9d1VjkEWQ7=DHHPL9RLtbzbyzCZLyFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oztiuxukmzniiijw"
Content-Disposition: inline
In-Reply-To: <CAMty3ZBo+X5o22i1=HR9d1VjkEWQ7=DHHPL9RLtbzbyzCZLyFw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oztiuxukmzniiijw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 09:43:29AM +0530, Jagan Teki wrote:
> On Wed, Sep 5, 2018 at 1:20 PM, Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> > On Tue, Sep 04, 2018 at 12:40:50PM +0800, Icenowy Zheng wrote:
> >> +             hdmi_phy: hdmi-phy@1ef0000 {
> >> +                     compatible =3D "allwinner,sun8i-h3-hdmi-phy";
> >> +                     reg =3D <0x01ef0000 0x10000>;
> >> +                     clocks =3D <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_D=
DC>,
> >> +                              <&ccu 7>;
> >> +                     clock-names =3D "bus", "mod", "pll-0";
> >> +                     resets =3D <&ccu RST_BUS_HDMI0>;
> >> +                     reset-names =3D "phy";
> >> +                     #phy-cells =3D <0>;
> >> +             };
> >
> > This needs to use the bindings we have for that phy.
>=20
> You mean allwinner,sun50i-a64-hdmi-phy ?

Yes

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--oztiuxukmzniiijw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluSNQIACgkQ0rTAlCFN
r3S5WA//eNCGuZAzWXacEDnqAJ0gjLsV/r+sM+X9md3xgNEAUrTNl4VPRIbSK88V
KJ216U3ihjhLdG6yRRaao5h7ubhuKr2xkZNN9SfEErE4riKZ1MVtj1st51xl1VrF
uocv3nB7f+SLfwOYOB99nOmewnwighDb0aH76Qhyp4m5OfPBTUGDODfF8vdwDeMH
tgZ88284P4DbTrRw7GzbmzArxF2KR/eGNkCrEU01o++hL9+CSG5qjFj+5G/iDEFn
zD2jAklWiXndDFYobQxDgjzAmK8pzHB9tAK7wuKARZsZdWxZqkdxwVpEGt3hPXGk
nLkY0MEB7CEArhiyiJZCXxkxt2bhxpUtYou/O85K68crRtD8d+3X/zQkdwwcW/SQ
Z7zSBhEqu0rbXHuIoOMOHjiHwtr3j//0/WQJjBfv7OHVlT34fP08hZ9hmjDEpNFf
S8O5rBv7m+skEr0ef3siIe6OGHk6z8n3vfQz9YETCjBq0K8Vf62B3zfR/jlv+GWy
hwCCwkEIFC1qk1VcyDWAdpCF9T/NsJSB8yNS/e6ZLTGx7X+RwE+2Xal201qlIKBX
eQcXbin9FS1fM7+7tK8I0oCvkKWofUiS43yRILCzOKayIGo1wBY91qpgIMv9Nh+m
OHYRYbMiPBtNHNcpdFFkMeHnSCi8qQfMOO0v+gu7K5ppXRBHO8g=
=XDhe
-----END PGP SIGNATURE-----

--oztiuxukmzniiijw--
