Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB06BECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BD82084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BD82084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbeGSPxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:53:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41901 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731126AbeGSPxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:53:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 068FF20728; Thu, 19 Jul 2018 17:09:27 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id D2D39206EE;
        Thu, 19 Jul 2018 17:09:16 +0200 (CEST)
Date:   Thu, 19 Jul 2018 17:09:17 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH RESEND v2 1/2] drm/sun4i: sun4i: Register quirks with the
 backend structure
Message-ID: <20180719150917.mzybrbbosjt2i2hm@flea>
References: <20180719080838.31598-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tshq54eml6ozdys7"
Content-Disposition: inline
In-Reply-To: <20180719080838.31598-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tshq54eml6ozdys7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 19, 2018 at 10:08:37AM +0200, Paul Kocialkowski wrote:
> In prevision for introducing a new quirk that will be used at atomic
> plane check time, register the quirks structure with the backend
> structure. This way, it can easily be grabbed where needed.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied both, thanks

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--tshq54eml6ozdys7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltQqZwACgkQ0rTAlCFN
r3RA8Q//aMADqIU4LuR+MGK7dbx2gHT1w2fUzlVStQEt1tUHIph79DYO1y9ntBYQ
L02sFDVUCf/P/ZYK8Bob/lO7Cs27ww+JhhHU9Tpmq4kYdvMh8pRSqi2gaTtwV0xa
GSVzPP61dbrxomAX4KaZ6hCmf11K0mWEZaWvhyoyensa7e1YgpVaA8Y2R+mSiNC/
Rh750spU9WSNZdxopHcGHop/gaYgkEnzeLqDci/rWvZQu6+zH8Dh6NwUWTLIbBYW
7g/Nb7+9CcBoJb+tRCYtZf+TAj1H/Fu43cXok8yOtubpEq1ckFTxLDdyKJiXCvV+
asSb00qryW+sdDMK6BRF8hdjtLlvQvpb/h4RolXuc4RKlwfmpDugPdDLR841LG+M
wc3SSTl5EWWoWl6bDbLt6a1g8vO140vZSyhyPSRKWGa3HttX2SUYIbYQ85tFLBmC
19NyFcB7isDoanD4y6lhL0JqojwjZDxKT1MlNdIZIY4fGJtCe5CU3n4l1jTQ0/9L
WI2LNRFpJbGD2G7zwgeeXFaPEz1RgCNG8S8rqnewTM1H/O4YNyyP+D92ErIG3qx8
gSMqH+dPHyHnk4BqgiNUzvEibRU6chfV+gQCMLCMQ0Ooi3onNlb7ZT1N6sY/lYuU
aEKgETzaRW3XNjJU6Yho635SVi+PCbfu3LHrhhF/cuMoFiVv3iQ=
=IWV8
-----END PGP SIGNATURE-----

--tshq54eml6ozdys7--
