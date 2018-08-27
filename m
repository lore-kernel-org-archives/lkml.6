Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068C7C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8991208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8991208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeH0S6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:58:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45417 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbeH0S6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:58:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 238F02079D; Mon, 27 Aug 2018 17:11:41 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id E7FBF20618;
        Mon, 27 Aug 2018 17:11:40 +0200 (CEST)
Date:   Mon, 27 Aug 2018 17:11:40 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Evan Green <evgreen@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/8] dt-bindings: Introduce interconnect provider
 bindings
Message-ID: <20180827151140.luysp2kfbcq6patg@flea>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-3-georgi.djakov@linaro.org>
 <CABGGisxq+hf91R18pnZ=VZ9f99GssWWPhpPCjNAROJmKg5-udA@mail.gmail.com>
 <e114ed83-fd54-4952-f375-e1d94826ac6e@linaro.org>
 <20180820153207.xx5outviph7ec76p@flea>
 <672e6c6c-222f-5e7f-5d0c-acc8da68b1ab@linaro.org>
 <CAL_JsqKMPm=qmfYMQH99_gqSv0-ynUSvbkoNjjeDKtyxfgE1tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zo6ztequdzzl7s7j"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKMPm=qmfYMQH99_gqSv0-ynUSvbkoNjjeDKtyxfgE1tg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zo6ztequdzzl7s7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 24, 2018 at 10:35:23AM -0500, Rob Herring wrote:
> On Fri, Aug 24, 2018 at 9:51 AM Georgi Djakov <georgi.djakov@linaro.org> =
wrote:
> >
> > Hi Maxime,
> >
> > On 08/20/2018 06:32 PM, Maxime Ripard wrote:
> > > Hi Georgi,
> > >
> > > On Tue, Aug 07, 2018 at 05:54:38PM +0300, Georgi Djakov wrote:
> > >>> There is also a patch series from Maxime Ripard that's addressing t=
he
> > >>> same general area. See "dt-bindings: Add a dma-parent property". We
> > >>> don't need multiple ways to address describing the device to memory
> > >>> paths, so you all had better work out a common solution.
> > >>
> > >> Looks like this fits exactly into the interconnect API concept. I see
> > >> MBUS as interconnect provider and display/camera as consumers, that
> > >> report their bandwidth needs. I am also planning to add support for
> > >> priority.
> > >
> > > Thanks for working on this. After looking at your serie, the one thing
> > > I'm a bit uncertain about (and the most important one to us) is how we
> > > would be able to tell through which interconnect the DMA are done.
> > >
> > > This is important to us since our topology is actually quite simple as
> > > you've seen, but the RAM is not mapped on that bus and on the CPU's,
> > > so we need to apply an offset to each buffer being DMA'd.
> >
> > Ok, i see - your problem is not about bandwidth scaling but about using
> > different memory ranges by the driver to access the same location. So
> > this is not really the same and your problem is different. Also the
> > interconnect bindings are describing a path and endpoints. However i am
> > open to any ideas.
>=20
> It may be different things you need, but both are related to the path
> between a bus master and memory. We can't have each 'problem'
> described in a different way. Well, we could as long as each platform
> has different problems, but that's unlikely.
>=20
> It could turn out that the only commonality is property naming
> convention, but that's still better than 2 independent solutions.

Yeah, I really don't think the two issues are unrelated. Can we maybe
have a particular interconnect-names value to mark the interconnect
being used to perform DMA?

> I know you each want to just fix your issues, but the fact that DT
> doesn't model the DMA side of the bus structure has been an issue at
> least since the start of DT on ARM. Either we should address this in a
> flexible way or we can just continue to manage without. So I'm not
> inclined to take something that only addresses one SoC family.

I'd really like to have it addressed. We're getting bit by this, and
the hacks we have don't work well anymore.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zo6ztequdzzl7s7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluEFKsACgkQ0rTAlCFN
r3Q3rw/9GTXP9K0EFEOmC0zlMe8iH8k32ZPazjghmW/LNDnXa8mr6DPdF4Sn8Xt6
+Y0CoX89XgLR96H9SVhUOVJjTNn14//azdje3vBe+LmMuwTQHsYgqbwtSIF17CUk
TYNiPOPlQ0HNj0WG3PMVFaji5saN2IRQIdoP7FffszPJrHCJrOx421ea9m9f//QN
b38J09/uo9hOLVkzH1ufQR5kQsZUzIOW9X2NspgGK8ZHkms88+DKxliOe/qbqbQT
iC9/XwhpSgxzqtyjbdp5kiwWtjRmkAbmf3EmH09siPhWBGWFPZ+lAkCmH2hTPv+d
/R1jtcfLNFD4XZWdcNsqO5ng8dPJRcSwljzM/Q8CEDd+FpZuFudWjDisYHF6WecP
NbirwCBzQqe32iABFKW6+jdhJts/Xp5wQieuJmhsgE8MzM7o7tJNhb3sml5VTARW
BRZRzlcq4qftUZ7LZ0sjAGVKJs1oUNzUPgc7gB8MgqPrhEDWji2B6oHm55sNJ/y3
Kh2sVdz8dFlFcHu/fc/AiUP8bVppUK/jzzWerKCYD0XJrDKXRo6lbjh7Hm02/fq7
L/ofWv+mLPLSli+B/V7KT7SYzggqVGGHVAXHVs8F0NpSInWmYVitTlbl5uWqW9fc
AOwCLMrF9god3vYhRItTWyCDgo5F/4rr2e0NeLSAgn363M8BB5s=
=qybd
-----END PGP SIGNATURE-----

--zo6ztequdzzl7s7j--
