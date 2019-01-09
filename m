Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02256C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD2A2064C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbfAIKVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:21:43 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39210 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729964AbfAIKVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:21:42 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1F2F020898; Wed,  9 Jan 2019 11:21:40 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id AD9D120A1D;
        Wed,  9 Jan 2019 11:20:49 +0100 (CET)
Date:   Wed, 9 Jan 2019 11:20:49 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH] ARM: dts: sun8i: h3: Add ethernet0 alias to Beelink X2
Message-ID: <20190109102049.npk77pxtxru4tcyb@flea>
References: <20190108191840.16007-1-jernej.skrabec@siol.net>
 <20190109101228.alsaaw6s57dbapfe@flea>
 <CAGb2v64QM9gyPTtpw0C0fpANW5R9DEsWFSDA_tJPYhdgF_FAhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mkj2k5z2j34krmbx"
Content-Disposition: inline
In-Reply-To: <CAGb2v64QM9gyPTtpw0C0fpANW5R9DEsWFSDA_tJPYhdgF_FAhQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mkj2k5z2j34krmbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 06:13:24PM +0800, Chen-Yu Tsai wrote:
> On Wed, Jan 9, 2019 at 6:12 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Tue, Jan 08, 2019 at 08:18:40PM +0100, Jernej Skrabec wrote:
> > > Because "ethernet0" alias is missing, U-Boot doesn't generate board
> > > specific MAC address. Effect of this is random MAC address every boot
> > > and thus new IP address is assigned to the board.
> > >
> > > Fix this by adding alias.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > Applied, thanks!
> > Maxime
>=20
> Might we add a fixes tag, so the patch gets backported?

It's done, thanks for the suggestion!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mkj2k5z2j34krmbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDXLAQAKCRDj7w1vZxhR
xRhyAQDIcRHuTOixnaioB3IrRwVWG+S5j6m/zbAtmcJ3832tCgEAroU7bsx43+oL
M10O81HgPW+/7Us9jOpc86koW4FV/A4=
=JI+r
-----END PGP SIGNATURE-----

--mkj2k5z2j34krmbx--
