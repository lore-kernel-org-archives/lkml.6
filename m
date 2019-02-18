Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FDCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62CB2184A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbfBRJdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:33:43 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44195 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfBRJdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:33:43 -0500
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 7EBB3E000E;
        Mon, 18 Feb 2019 09:33:40 +0000 (UTC)
Date:   Mon, 18 Feb 2019 10:33:40 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] arm64: dts: allwinner: h6: Add CPU Operating
 Performance Points table
Message-ID: <20190218093340.jcggm7jplpwrogsv@flea>
References: <20190214130910.9201-1-tiny.windzz@gmail.com>
 <20190214130910.9201-5-tiny.windzz@gmail.com>
 <20190214143842.nqsh6trwdjxq2ecd@flea>
 <CAEExFWuxrVC1J0g93R3ifaDxOGy-20B4jftoHw932V7+wqhtxw@mail.gmail.com>
 <CAEExFWv_K_07e30dgPbafVhDD_smwZkpi6Fqk6yzCahesdnrGg@mail.gmail.com>
 <20190215135613.sdz56vtiawqeryi5@flea>
 <CAEExFWt84MmpoWeibVf4bBJXOuPy9P7RrAFmEx304zz5z1GHwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i5c56aqsedye5nda"
Content-Disposition: inline
In-Reply-To: <CAEExFWt84MmpoWeibVf4bBJXOuPy9P7RrAFmEx304zz5z1GHwQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i5c56aqsedye5nda
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 15, 2019 at 10:09:51PM +0800, Frank Lee wrote:
> On Fri, Feb 15, 2019 at 9:56 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > Hi
> >
> > On Fri, Feb 15, 2019 at 12:56:03AM +0800, Frank Lee wrote:
> > > How about to implement a thermal driver that is not integrated with
> > > gpadc =EF=BC=9F
> > >
> > > GPADC on soc is rarely used now.
> >
> > You mean GPADC in general, or the gpadc driver in particular?
> > Otherwise, yes, having a driver for the thermal sensor in the H6
> > sounds like a good plan for thermal throttling, but I don't see it as
> > a dependency for that whole series.
>
> At present, sunxi's thermal driver is integrated with the gpadc driver.
> I have a idea to implement the thermal driver alone. I haven't started ye=
t,
> and it may take a while to do it.
>=20
> How about the plan to implement a thermal drive alone and put i
> under drivers/thermal?

The Thermal Sensor is basically a stripped down GPADC, which is why it
would make sense to have a single driver.

There was a pending series doing this that could be a good idea to
improve and merge:
https://lkml.org/lkml/2018/8/30/729

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--i5c56aqsedye5nda
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGp78wAKCRDj7w1vZxhR
xYT8AQDFxHvCKmLk+1YErRAvdFGGHBrdOrKxpjtJeofe/lDUvQD/Uhgp577MmwWQ
kR6nS3Mly0LqyrhHUlvweeyb6jR+zw8=
=qt/e
-----END PGP SIGNATURE-----

--i5c56aqsedye5nda--
