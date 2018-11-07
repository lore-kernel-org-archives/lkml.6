Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CDCC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046222081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046222081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeKHGIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:08:12 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44597 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbeKHGIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:08:11 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A91A2207B8; Wed,  7 Nov 2018 21:36:08 +0100 (CET)
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.bootlin.com (Postfix) with ESMTPSA id 768D020712;
        Wed,  7 Nov 2018 21:36:08 +0100 (CET)
Date:   Wed, 7 Nov 2018 21:36:08 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-sunxi@googlegroups.com,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/15] Bluetooth: hci_bcm: Add BCM20702A1 variant
Message-ID: <20181107203608.ff32gmb4u54kcvep@flea>
References: <20181107101308.7626-1-wens@csie.org>
 <20181107101308.7626-12-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mf6se6s5b6tdxb5f"
Content-Disposition: inline
In-Reply-To: <20181107101308.7626-12-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mf6se6s5b6tdxb5f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Nov 07, 2018 at 06:13:04PM +0800, Chen-Yu Tsai wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
>=20
> The BCM20702A1 chip is a single-chip Bluetooth 4.0 controller and
> transceiver. It is found in the AMPAK AP6210 WiFi+BT package.
>=20
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

if you resubmit it, could you do s/free-electrons/bootlin/ ?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mf6se6s5b6tdxb5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+NMuAAKCRDj7w1vZxhR
xZ9TAP0XC5cSi5OLifkzszkxT84RBo2POjE1FhBS++2wQWay/gEA0MR7BCtk6Lgp
6H2yoSMYiB0AQzDrmt7nKTzJX5PrmAI=
=mfGb
-----END PGP SIGNATURE-----

--mf6se6s5b6tdxb5f--
