Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87072C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5819821104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5819821104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbeKUVuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:50:52 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44627 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730075AbeKUVuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:50:52 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 728BF20E3C; Wed, 21 Nov 2018 12:16:51 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id B661320DBE;
        Wed, 21 Nov 2018 12:16:23 +0100 (CET)
Date:   Wed, 21 Nov 2018 12:16:23 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: fixes for 4.20
Message-ID: <20181121111623.GA10372@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Arnd, Olof,

A simple DT fix that is necessary to get reliable access to the NAND on
sama5d2 based boards.

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.20-f=
ixes

for you to fetch changes up to 4ab7ca092c3c7ac8b16aa28eba723a8868f82f14:

  ARM: dts: at91: sama5d2: use the divided clock for SMC (2018-11-21 11:50:=
32 +0100)

----------------------------------------------------------------
AT91 fixes for 4.20

 - Fix the SMC parent clock

----------------------------------------------------------------
Romain Izard (1):
      ARM: dts: at91: sama5d2: use the divided clock for SMC

 arch/arm/boot/dts/sama5d2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXx9Viay1+e7J/aM4AyWl4gNJNJIFAlv1PnsACgkQAyWl4gNJ
NJIxDg//c2ESUXN1YQ/EMv7qe6w3d73K8gz+0hPMuE6HidqOS7WxaTC7/KFFQ7Ek
PKS6fUEj145KrdZfU115fNkO3Jzwnf8yKOJIjLP0LI4T8l6ki4y7pMQIHm/fQOof
KR0bEeil6nJcCYt7PCffVYtqls5jQXUDx8NHT2lxt6ca5eNezMGntyo4eHX9mIjh
bpKM6WUnXSWn6x7OpD+Ggx6B1ljHmFVmqhBNzZeiG7ypJEXnEW5zj8S6LNMwkEU6
Dn7CWDbQb2/jg0Hxfdt2DieXI0GjbunNnRJxREmIO2as0YIE+JbspZK0DqTHo6Ro
ItNGB6vvN3dTxlNGlalgITnzLwR5H32FWID7YnOcqySi68aud8xxcJVhWWs36wqC
WhVIi7aiDiSDqsUI7eRIQ/s20hjKxcAB9RIzhkfgNWUNfkxlaixCoPtovfrlrZpX
soawKzLM6SBNEvf9T1WsRipzJRPs9fgvDWy81DG8PZbhfytqyB+CuTzG5WqqWFPB
OyEfcadmoVHgARo7oOQ7PPUrqNyxfuk4IoBbzHONwL5ZZePfOCPn0aIT/gm8XjnU
DedtFev3Dh02nm+aLFlmPNZ94E9DzPcD5gEqSnEkzqLfD18ofqbhehQ/VW08yYxO
5Wu5nTy0OgdmitKBAwq5enW+a5PUCTSfTZWxmJpxfGNW7aqN7yo=
=1OiF
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
