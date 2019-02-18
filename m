Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7375CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE192089F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfBRIuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:50:05 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:36979 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBRIuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:50:04 -0500
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id D1EB5C0015;
        Mon, 18 Feb 2019 08:50:01 +0000 (UTC)
Date:   Mon, 18 Feb 2019 09:50:01 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] nvmem: sunxi-sid: add binding for H6's SID controller
Message-ID: <20190218085001.or32zojdpluocg3g@flea>
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
 <20190217162316.14111-4-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d7e7m6pjzbgim6fq"
Content-Disposition: inline
In-Reply-To: <20190217162316.14111-4-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d7e7m6pjzbgim6fq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 17, 2019 at 11:23:14AM -0500, Yangtao Li wrote:
> Add a binding for H6's SID controller.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--d7e7m6pjzbgim6fq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGpxuQAKCRDj7w1vZxhR
xYKAAQD2lZlnwHL5FMSNiVLoKkH8ifGzZ48tShn3ROIDjxnPygEAtUO2NnpZzbWh
TJAMgcrFJJ1bF33CnS5mVnEpIQz7Dg8=
=BlLD
-----END PGP SIGNATURE-----

--d7e7m6pjzbgim6fq--
