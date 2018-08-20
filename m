Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A66C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D097421581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D097421581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeHTQwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:52:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41353 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbeHTQwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:52:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E59EB206F6; Mon, 20 Aug 2018 15:36:56 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-85-9.w90-88.abo.wanadoo.fr [90.88.27.9])
        by mail.bootlin.com (Postfix) with ESMTPSA id B6C60203EC;
        Mon, 20 Aug 2018 15:36:46 +0200 (CEST)
Date:   Mon, 20 Aug 2018 15:36:47 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/5] Set max rate for video PLLs
Message-ID: <20180820133647.vpj7p36ir334g4am@flea>
References: <20180809165217.30680-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zyn3xcoio4kmfyvv"
Content-Disposition: inline
In-Reply-To: <20180809165217.30680-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zyn3xcoio4kmfyvv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 06:52:12PM +0200, Jernej Skrabec wrote:
> This patch series implement maximum rate constraint for video PLLs,
> because it is possible to set higher PLL rate that is actually
> supported in HW.
>=20
> Issue became apparent when user reported non-working monitor connected
> to board with H5 SoC. Native monitor resolution in this case was
> 2560x1080, with 185580 kHz pixel clock. Clock subsystem found out that
> best matching pixel clock can be generated if video PLL is set to 2040
> MHz, which is way out of specs for PLL. With this patch series applied,
> everything worked just fine, with slightly higher rate error, but within
> working limits for PLL and HDMI.
>=20
> I'm not sure if "Fixes" tag should be added. It solves real world
> problem, but there was nothing wrongly implemented, just upper limit
> is missing.
>=20
> While user reported that these patches solve the issue on H5, I added
> similar fixes for other SoCs too. Since I don't have such monitor,
> I only tested if board boots up and if HDMI works (H3, R40 and A83T).

Queued for 4.20, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--zyn3xcoio4kmfyvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlt6w+4ACgkQ0rTAlCFN
r3T9Qg/7B308BYfOx10shjSayQgyDKLjhhnbpIJAaqCNvFpJws2N45+3A6zndjH9
03XaTrno1MyG39ZvZpI4ugacHPLaqvfC2JkbyIPI8YDSvyGKFIxtsN98dnhtG+UO
T5osMUT6DeX9W4dGZCyP15Ml0kBLEifIMx+6aQRwrOIk1+OfdHwHw7gvXqiPqsDy
7vnNOYbPO7YuFt6g+uGDtXiPjIoOYCumltr9ZMspPwNY63RQDUoZxvmosHyIoTCB
7AQZMqD8kw0dw/ahmftAjZIco0F1WzkEk0mxYb8E9x9Ppf8GQqaS7XfpL3EYF1TZ
2p8OhObhL61IR8CnX6tJ+QZnfnk4uaKfC9MxHYEGFXzC7MU7hSXcHZyILCLymEBX
gwqz7whcm6dXyYh7pI32WM/adAkal0GUpsdpvPbPzK8cVqFuk9uUqQedZMMHZ4Lv
GKaeQ3420Yb284CGBIf+cZueU6SmuRQ6fAZnjTPeLoieZv8NJq5Iz3wnSQdWt4pO
6vQwgFpZpYto4Z158bk1wip6vK2EWDwxDEnja1bQStmx7c4SEjvtmi4XirUorn1N
bJGiMuc/MXBIbDXmzswQz1wkBxHPSTvWz8vFuyjVOZGm2GxHMuXUocTePMytpfu3
zcJSwu82chOTFR2lSv92Xpb/wOonToKnOKPFopqzrS95/UdtK/U=
=/uUV
-----END PGP SIGNATURE-----

--zyn3xcoio4kmfyvv--
