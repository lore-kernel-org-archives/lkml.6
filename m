Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F42DC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE6F26045
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE6F26045
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965067AbeFYS4I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 14:56:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38880 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964859AbeFYS4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 14:56:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3B1D7206D8; Mon, 25 Jun 2018 20:56:05 +0200 (CEST)
Received: from localhost (unknown [88.128.82.118])
        by mail.bootlin.com (Postfix) with ESMTPSA id D4E8E203B4;
        Mon, 25 Jun 2018 20:56:04 +0200 (CEST)
Date:   Mon, 25 Jun 2018 20:56:04 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 0/3] drm/panel: Add Ilitek ILI9881c controller driver
Message-ID: <20180625185604.v2zwleb7gim63clp@flea>
References: <cover.e73f3ed1a9adc36fc1648d563cd967ec99219839.1527587352.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vz5rcg25iuvkhl63"
Content-Disposition: inline
In-Reply-To: <cover.e73f3ed1a9adc36fc1648d563cd967ec99219839.1527587352.git-series.maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vz5rcg25iuvkhl63
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 11:49:13AM +0200, Maxime Ripard wrote:
> Hi,
>=20
> Here is the next version of the patches to add the support for the Ilitek
> ILI9881c panel controller.
>=20
> This used to be a part of the larger DSI support series for the Allwinner
> SoCs whose patches have been since merged and are obviously not part of
> this series anymore.
>=20
> Let me know what you think,
> Maxime

Applied the two first patches, with Linus' Reviewed-By and Daniel's
Acked-by as discussed on IRC.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--vz5rcg25iuvkhl63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsxOsMACgkQ0rTAlCFN
r3SjSg/+MP/Heix63tSoE21VIQnK+OW5TVMKyfAgwHikaJvH4LKl8NE05PBkJQ+h
eA0P93i8Mi0Yh5Zq442jTSSHG3WZER43CACTAv8eppJpwzLzNeLi9gqrphxiVP7n
k589CrMxr+GD7cl+Konw7up1WofySeNfod6/RWHymabSQIsOESiiiuqMDWYgZyZf
zOHainY12wvX8GB7P8ns+czlyxzXoNkt7FLIUNF5Yf2lUM/fRREwF9XtG1/JAAh4
vOtAQ94N7PVyhAPaKQzacZjgqeBJDk8z8n9MrRuCo3c4ByDzRTIW/B4hqtlRfla7
vebFyVryuqjRqyxzj7lzEJvedb/cHFZ/E3ErARZUemSxmasyv1utRc9DelF02J2r
ady8s6cDLEpH8xKkkSGDAdOcvgtwsvxDXHSZrXSok+4WXZkMauYsbSIId38OqMg+
dnVGIxMnGLRt3cW5cVNTgSWih12WFZcIj+BGRHN0s9Mb2UIHGrGiNSZWLrm6T8U9
q8aAMvvfHrzQVGfIfFYDZ4fu1VkHVroenjl3Xk7FtekNJCQSeR792TaEfte7cna2
TPMPZCp609cSixKhX79SlXjBvj6mje3ZnEM5vnJfhgOE+dG++6iWzFX4A0WlG/eK
Og/CG4IDkS/ET2IOKlxgDKDGyKUR72xBmftWsmiGvUnY4qsSVzs=
=ZXyf
-----END PGP SIGNATURE-----

--vz5rcg25iuvkhl63--
