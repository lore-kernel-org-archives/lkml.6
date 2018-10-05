Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C20C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B5221473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B5221473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbeJEVsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:48:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47936 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728522AbeJEVsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:48:09 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 33E8320734; Fri,  5 Oct 2018 16:49:04 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 02288206A1;
        Fri,  5 Oct 2018 16:48:53 +0200 (CEST)
Date:   Fri, 5 Oct 2018 16:48:54 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: new board - Emlid Neutis N5
Message-ID: <20181005144854.6bqceyuvdyiv7mtg@flea>
References: <1538745949-13188-1-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1538745949-13188-2-git-send-email-aleksandr.aleksandrov@emlid.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n27cqsjiwdwz67kk"
Content-Disposition: inline
In-Reply-To: <1538745949-13188-2-git-send-email-aleksandr.aleksandrov@emlid.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n27cqsjiwdwz67kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 05, 2018 at 04:25:49PM +0300, Aleksandr Aleksandrov wrote:
> Emlid Neutis N5 is a SoM based on Allwinner H5, has a WiFi & BT
> module, DDR3 RAM and eMMC.
>=20
> - add neutis n5 dtsi file for SoM needs
> - add neutis devboard dts file
> - add neutis devboard target to dtb makefile
> - new vendor prefix - emlid
>=20
> Signed-off-by: Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>

It's still not the correct recipient list, and I have no idea where
the v2 went, or what did you change between v1, v2 and v3.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--n27cqsjiwdwz67kk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlu3edUACgkQ0rTAlCFN
r3TekQ//V/UHu0C1te+UKBmh+/vyUOBe9BqPyn5Vy/6uZjrbVrH7pRMDTMP00CDE
+V+sLYIslsfcjUjoXhyIY3UK5BMU7O6sCN+Ilbv3nnZh2iPQu/8LLN4FAuDJ3y+Y
Gf9EG0BMNfho7VpfJtfr1FhbZJ9za3pcFFvex+aVl9yQttTbM53CCvQwbAAGczsS
lch7AQDhoSpZ03XQ6SMQOSjU5aZdPfRPflRn144Kk6jH2LL410xKmmGM3FsKgAsJ
kAZIkCR+ej5rmPp9gOW88cvKxq894P3t7AZw3n0SyAjg/E61pHGDfPAOS9NtvwnA
u7xGhTlBY9A5JzRqWXP2ECYTvX9grdwK/M2/8O2fo40Q3urj+ClZiwaILk1HhWnY
EI5nWdTUK8ieCYenvDbE6N77m4tTD0q7VphjcervIo16CGeZNtFrU2sQjJzsmHQi
hiOFdnMCXovEHcJHIrtIhbZQLOKiLddjpi0aXLzjAznkmTrQoQupKLfsCfrnw99P
/ZUiZcKr3WD+2hpaenwOBFSqITVQqliZAgsWelneN0BKWZUbNCyUejY06IiOQEfx
iW/XpJLuvXgd0PAYf1kj59nssWPP3DAHZkYd8RsTCUcTDzWtkNRzm3SXMW8wzpY/
32Kpte7mKWoRPU6lYE77oCnevwVe/1ecffNxvzFpHB30iiHk3bQ=
=Hrzi
-----END PGP SIGNATURE-----

--n27cqsjiwdwz67kk--
