Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F92C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C90F2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C90F2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeK3Svq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:51:46 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44183 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbeK3Svq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:51:46 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C116720CFC; Fri, 30 Nov 2018 08:43:20 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 97658209AB;
        Fri, 30 Nov 2018 08:43:20 +0100 (CET)
Date:   Fri, 30 Nov 2018 08:43:20 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][media-next] media: sun6i: fix spelling mistake "droped"
 -> "dropped"
Message-ID: <20181130074320.6spzycux7hrqd6wk@flea>
References: <20181129105038.17902-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="amdigqxhty2obyqy"
Content-Disposition: inline
In-Reply-To: <20181129105038.17902-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--amdigqxhty2obyqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2018 at 10:50:38AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There are spelling mistakes in dev_dbg messages, fix them.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--amdigqxhty2obyqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXADqGAAKCRDj7w1vZxhR
xZgaAP40Hi5WIMUHJMWcF/VgTjhvdJ6GdeVuRuZgodrhOWr55wD/V/92v/kyp1TD
NZelKPHKcr1jy5Gl0LwfL7+MhHBxpgE=
=2dfI
-----END PGP SIGNATURE-----

--amdigqxhty2obyqy--
