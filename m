Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0C5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867C92084D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfBRIq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:46:27 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60941 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfBRIq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:46:27 -0500
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 9A7394001E;
        Mon, 18 Feb 2019 08:46:24 +0000 (UTC)
Date:   Mon, 18 Feb 2019 09:46:24 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATVH v2 0/4] arm64: dts: allwinner: h6: Enable CPU
Message-ID: <20190218084624.qmv4wavag4uymvrf@flea>
References: <20190215134937.10259-1-tiny.windzz@gmail.com>
 <20190215151357.noovkx3r6ia4boag@flea>
 <CAEExFWs2VuOpZu=Mw221Gp3RDbw=Q24eh8Y=pWdfh-c+mPvwuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vd75snmr6a42d2ox"
Content-Disposition: inline
In-Reply-To: <CAEExFWs2VuOpZu=Mw221Gp3RDbw=Q24eh8Y=pWdfh-c+mPvwuw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vd75snmr6a42d2ox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 15, 2019 at 11:35:20PM +0800, Frank Lee wrote:
> On Fri, Feb 15, 2019 at 11:13 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Fri, Feb 15, 2019 at 08:49:33AM -0500, Yangtao Li wrote:
> > > Add the cpufreq support of h6, source of information is as follows.
> > >
> > > h6 cpu opp info:
> > > https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/arch/=
arm64/boot/dts/sunxi/sun50iw6p1.dtsi
> > >
> > > axp805 spec:
> > > http://linux-sunxi.org/images/b/bc/AXP805_Datasheet_V1.0_en.pdf
> >
> > Was that tested on the two H6 boards this time?
>
> I tested two boards for about two hours.

How did you test it?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--vd75snmr6a42d2ox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGpw4AAKCRDj7w1vZxhR
xbwFAQCJqNtKoCeGw9tRc81u7tcH5VqkkQkk0iVMDl1/nfnXxwD/f5a37BMO/YWd
UG1fZ+OOS0sBayfIjZQoG/Yo/8dl2gM=
=G4JI
-----END PGP SIGNATURE-----

--vd75snmr6a42d2ox--
