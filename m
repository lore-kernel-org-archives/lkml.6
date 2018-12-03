Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81A7C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE0B20881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE0B20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbeLCIzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:55:49 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51867 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbeLCIzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:55:49 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2B1BC20D04; Mon,  3 Dec 2018 09:55:41 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id E629C20787;
        Mon,  3 Dec 2018 09:55:30 +0100 (CET)
Date:   Mon, 3 Dec 2018 09:55:31 +0100
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
Subject: Re: [PATCH v6 13/17] clk: sunxi-ng: add support for suniv F1C100s SoC
Message-ID: <20181203085531.exlmkfs6b4ejv5dr@flea>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
 <b3d266d9f5f0f7504701c3bbec819acde6d19257.1543781680.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rnvyyf5rs3zyws7h"
Content-Disposition: inline
In-Reply-To: <b3d266d9f5f0f7504701c3bbec819acde6d19257.1543781680.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rnvyyf5rs3zyws7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 02, 2018 at 11:23:47PM +0300, Mesih Kilinc wrote:
> diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi=
-ng/ccu-suniv-f1c100s.c
> new file mode 100644
> index 0000000..ea335a6
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> @@ -0,0 +1,541 @@
> +/* SPDX-License-Identifier: GPL-2.0

This isn't the proper SPDX format, and this is reported by
checkpatch. I've fixed it while applying, but please make sure to run
checkpatch.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--rnvyyf5rs3zyws7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXATvgwAKCRDj7w1vZxhR
xShhAQD4Q++0q3mTx9P/3XT0dfmclxH6ucI6A2hLBiWk2cR6SgEAu+w+ec+2YbIk
rYN+ht83QOBIxVSTInlAz/PNcXoM4Aw=
=b4TG
-----END PGP SIGNATURE-----

--rnvyyf5rs3zyws7h--
