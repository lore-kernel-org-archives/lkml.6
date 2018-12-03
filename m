Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EA5C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279A720881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279A720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbeLCI50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:57:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52058 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbeLCI50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:57:26 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CB2D320CFA; Mon,  3 Dec 2018 09:57:18 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9BC2B20CFC;
        Mon,  3 Dec 2018 09:57:08 +0100 (CET)
Date:   Mon, 3 Dec 2018 09:57:08 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [PATCH v6 02/17] dt-bindings: arm: Add new Allwinner ARMv5
 F1C100s SoC
Message-ID: <20181203085708.fblw4z66p2vyr52c@flea>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
 <6fa3cf509379a0888388821eef3e322c014df5b8.1543781680.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lvx2wzkx735lsbsm"
Content-Disposition: inline
In-Reply-To: <6fa3cf509379a0888388821eef3e322c014df5b8.1543781680.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lvx2wzkx735lsbsm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 02, 2018 at 11:23:36PM +0300, Mesih Kilinc wrote:
> Add new Allwinner ARMv5 F1C100s SoC's compatible string
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applie,d thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--lvx2wzkx735lsbsm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXATv5AAKCRDj7w1vZxhR
xeKkAP4nP2LHd79lDnjSbWhyCewym9BMqFwQYracNOL6ykFMEQEA9voSEEOLXQCK
dYdkKam4CIoFiYR6QxeEyV+0BNlbHw0=
=D+kO
-----END PGP SIGNATURE-----

--lvx2wzkx735lsbsm--
