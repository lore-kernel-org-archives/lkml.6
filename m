Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7B6C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410CF20883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410CF20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbeGZIpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:45:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45661 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbeGZIpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:45:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1A036208FF; Thu, 26 Jul 2018 09:29:34 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id E162220730;
        Thu, 26 Jul 2018 09:29:23 +0200 (CEST)
Date:   Thu, 26 Jul 2018 09:29:24 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Akash Gajjar <Akash_Gajjar@mentor.com>
Cc:     icenowy@aosc.xyz, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: activate spi flash on pine64 LTS
 board
Message-ID: <20180726072924.bnvljmd2sf6bf5ae@flea>
References: <Akash_Gajjar@mentor.com>
 <1532587906-5415-1-git-send-email-Akash_Gajjar@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ndzggc7564bawbq5"
Content-Disposition: inline
In-Reply-To: <1532587906-5415-1-git-send-email-Akash_Gajjar@mentor.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ndzggc7564bawbq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

1;5202;0c
On Thu, Jul 26, 2018 at 12:21:46PM +0530, Akash Gajjar wrote:
> This board has SPI flash. add spi flash support in device tree.
> Tested on pine64 LTS.
>=20
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>

Queued for 4.20, thanks!

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ndzggc7564bawbq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltZeFMACgkQ0rTAlCFN
r3SKHBAAhrdmAn1O2DhmWqpmGPtRLtMmV3DjdelNZEgQYMXdUcex33FT6cW8qUJf
NMhfEcICqyseV0yt4O8wJ9LgKI2WDuPTSHMFwSYB+3ojCmdHuuDvcltQtozp12VK
feaxc6Ny3PWAHBp9ZSxnKZVU0wjfoCMc1mM8nh9CbATJOkVr/SYoeIdT75hu85Ep
P87J7LTH7VPu4ZGlF96DmZHtq9Y05muRWTYcQ9r44QWfyz5T31tZQzt800s1YrCS
X5yQFfX+xmJM5ZT/yxK8/Grade2NgiQMY65bg99JNOHPNnbKEX1I/hRHcTbuxa+B
/7RSrro5yTHlZFnld4NqmfMeq7rw6J1EAY9mxCbZnDgbRWhjtwjSYWeImovNUaQG
wTdK3/dKTuw8hvrgFTlrTn/PxKT6Q5hAIen0ZK/UE4VX5G9yoprqarBZ9kf5EIiM
zusGlPGKB6ss9ZKKgcIkcmwXYaec+F+qPLWYXE8wUCptu/K96MLcM38D5UdBbOBh
XNegiFqEfKcsD1PRbsGNHjAnuI9j0T3FQ6KDtR7osHVZKH22nsmkzmJpCd6qKJFB
fmBUIWTd1/HxybWsioCb7gMwd+iyFgjVR+iErqfEqEHpKRPy+B19zMhHg6U5jNe+
P7VhkNIL4wvsE60XbK1d5B6caH1e3keuoF7DBlwPhD4SMm9l6Hw=
=Ahkx
-----END PGP SIGNATURE-----

--ndzggc7564bawbq5--
