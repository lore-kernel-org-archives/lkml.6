Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D233ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7073820827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7073820827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeKHRze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:55:34 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56679 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeKHRze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:55:34 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9B8962072D; Thu,  8 Nov 2018 09:21:11 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6DDF22039F;
        Thu,  8 Nov 2018 09:21:11 +0100 (CET)
Date:   Thu, 8 Nov 2018 09:21:11 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-sunxi@googlegroups.com, loic.poulain@gmail.com,
        linux-bluetooth@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/15] Bluetooth: hci_bcm: Add BCM20702A1 variant
Message-ID: <20181108082111.3jt3eukjzfy46kv4@flea>
References: <20181107101308.7626-1-wens@csie.org>
 <20181107101308.7626-12-wens@csie.org>
 <20181107203608.ff32gmb4u54kcvep@flea>
 <CAGb2v64asgNbYch6gwj0BTTz84=Jfbmu9th0Dyfdx_o8N5tNXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gpfwphpxwbmirm24"
Content-Disposition: inline
In-Reply-To: <CAGb2v64asgNbYch6gwj0BTTz84=Jfbmu9th0Dyfdx_o8N5tNXg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gpfwphpxwbmirm24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2018 at 02:53:33PM +0800, Chen-Yu Tsai wrote:
> On Thu, Nov 8, 2018 at 4:36 AM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > Hi!
> >
> > On Wed, Nov 07, 2018 at 06:13:04PM +0800, Chen-Yu Tsai wrote:
> > > From: Maxime Ripard <maxime.ripard@free-electrons.com>
> > >
> > > The BCM20702A1 chip is a single-chip Bluetooth 4.0 controller and
> > > transceiver. It is found in the AMPAK AP6210 WiFi+BT package.
> > >
> > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > if you resubmit it, could you do s/free-electrons/bootlin/ ?
>=20
> OK. And for the author as well?

Yes, please :)

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--gpfwphpxwbmirm24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+Px9wAKCRDj7w1vZxhR
xZjOAQDnZIAeel1CWH3cfJfECDCzeyv5UI9PcpCEDOmk4eZvogEAwDcRw7W/oeLc
FEwL4guBiDAUo7VZxnTPRkrEU1AWggQ=
=qoGZ
-----END PGP SIGNATURE-----

--gpfwphpxwbmirm24--
