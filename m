Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3318313F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE7520893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE7520893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeG3KAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:00:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49481 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbeG3KAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:00:25 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B005220737; Mon, 30 Jul 2018 10:26:30 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8556920618;
        Mon, 30 Jul 2018 10:26:30 +0200 (CEST)
Date:   Mon, 30 Jul 2018 10:26:31 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] arm64: dts: allwinner: a64: Add SID node
Message-ID: <20180730082631.es2fbqce5uabi5jc@flea>
References: <20180727115205.20955-1-manu@freebsd.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gu2eabfhidk4tilw"
Content-Disposition: inline
In-Reply-To: <20180727115205.20955-1-manu@freebsd.org>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gu2eabfhidk4tilw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 01:52:02PM +0200, Emmanuel Vadot wrote:
> The A64 have a SID controller which consist of EFUSE (starting at 0x200)
> and three registers to read/write some of the protected efuses.
>=20
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>

Queued all 4 for 4.20, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--gu2eabfhidk4tilw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltey7YACgkQ0rTAlCFN
r3RGMQ//a7/Pzi6IclTBAEJiQeaoMfgwEZWiKIkj2/uUfmiVEUi/3wrYMNlfN96R
FK2uPANsvpfTMZLmbu0g+TrEEfDObC1c02m2yvv0EVFcB2x/UhzG4w/YDR2nzqjl
bh2Fvfe8o+qdWE9FEZWWxa3M1xPwBxAMPZTGEjntS9IX1FJ1DQKlSrg2BApooqi2
F6IoXas8yMzkjYehtIda6f9n3eqpEo1A3SrRDObapL5qnsJQUBatNcreyp7TnUv/
2+E2Tz3QsBkr92NRqjuOyMB3GYRH66vZVEVol5T5tJi2Y3vw17RjFzdPH/gSt9ww
pHUOp6AQB7T/d5EvsIKDCqOPhJmrvHvlfVgOIcgrL7vGrD/lNoA1bP0jJ5cb38d3
Sxg7sAqedzpTZZjr31gxtogxBbZpuLgD5/myDRenTM7BO1N819exbCsox76s7ptL
vGB4/an8gOH9z6d2inoGzsG0zV8acqG1X1EvOCmNLJ+zqS8CBI707Jd/l4kUwGTy
FP4Ntxd/43vBv0VqINE1kHMf9uiqoZjCVMwQ7eQpdKdnvtPpXQ19ZivlmjQMeET2
QRLPedo0OWbPntIsflHgIDphEl09F8zIgyUQ2YoQLo70ben8khOOjcU+Tz0PSlKs
FLjIAveQDhWC9aGruugBpSkCd2FMMXhFPj8UYjc2kVLkFtJ3tJM=
=Z+Jb
-----END PGP SIGNATURE-----

--gu2eabfhidk4tilw--
