Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3829BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80D121917
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfBHHpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 02:45:02 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49881 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfBHHpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 02:45:02 -0500
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id ADD6F60008;
        Fri,  8 Feb 2019 07:44:58 +0000 (UTC)
Date:   Fri, 8 Feb 2019 08:44:58 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Chen-Yu Tsai <wens@csie.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Variable "val" in function
 sun8i_dwmac_set_syscon() could be uninitialized
Message-ID: <20190208074458.edgvwfgytlio62yn@flea>
References: <20190207174623.16712-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ktram64yqnag7qmy"
Content-Disposition: inline
In-Reply-To: <20190207174623.16712-1-yzhai003@ucr.edu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ktram64yqnag7qmy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 09:46:23AM -0800, Yizhuo wrote:
> In function sun8i_dwmac_set_syscon(), local variable "val" could
> be uninitialized if function regmap_read() returns -EINVAL.
> However, it will be used directly in the if statement, which
> is potentially unsafe.
>=20
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ktram64yqnag7qmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXF0zegAKCRDj7w1vZxhR
xZAIAP9XLy4fhsazFjOCIM5YOqI9osHgxZAwOYd7hAoxUrBM3gD+J7BlsTyqYo6K
uvUY4PmJLZN6G5k/6Fi7qkvbqMIHEQs=
=I1dd
-----END PGP SIGNATURE-----

--ktram64yqnag7qmy--
