Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8306FECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD1220850
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD1220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbeGQPwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:52:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44388 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbeGQPwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:52:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 52D4120765; Tue, 17 Jul 2018 17:19:05 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 23C12207AC;
        Tue, 17 Jul 2018 17:18:55 +0200 (CEST)
Date:   Tue, 17 Jul 2018 17:18:55 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     catalin.marinas@arm.com, linux@armlinux.org.uk,
        mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM: dts: sunxi: Remove unused address-cells/size-cells
 of dwmac-sun8i
Message-ID: <20180717151855.wsz6om7uf3j6c7it@flea>
References: <1531655749-14063-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="brh6osardy5yiqfo"
Content-Disposition: inline
In-Reply-To: <1531655749-14063-1-git-send-email-clabbe@baylibre.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--brh6osardy5yiqfo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 15, 2018 at 11:55:49AM +0000, Corentin Labbe wrote:
> address-cells/size-cells is unnecessary for dwmac-sun8i node.
> It was in early days, but since a mdio node is used, it could be
> removed.
>=20
> This patch fix the following DT warning:
> Warning (avoid_unnecessary_addr_size): /soc/ethernet@1c50000: unnecessary=
 #address-cells/#size-cells without "ranges" or child "reg" property
>=20
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--brh6osardy5yiqfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltOCN4ACgkQ0rTAlCFN
r3Rr3Q/8CQMB2h4tIMc4r507c1JmHHpb4zDbkCdA9T+7cP9KkaZzD2WOC9UKJd43
02WZpTSSmnA18RzKHNofXVxLjGvAZnWPJfYui+l0J+p+tRomF5bmHktYBVPcyCpa
uAriaTGWFXaADXMqSL58Pw98nFu06LkrWu4lH28b2uZeec6xz1AVKQ/BiGdTlaOp
cGZTBu0L5PD7dW/fA8iOkjyBKaot1XOtlmnsQ7CaAGwcMFfThUyHXWJx6fez/sJ7
nq3NeaQlbEEunHLNUG2l2aa5jFKFwqpXz1CCIswTWu8z+e8sz4kCDUcCrvOLSiEI
rAFjWW/dWGJLo/u9xTXSKvSH0YXAESz5ieQpiZvv/rMdx3XjKS9fSj2S8ILnI26O
YWWg1n2222p+gCbRMrRC0hivwnoymuHT1hRx0t/X5BJ3yDO4PbOj5+j+2IHDIu1+
oPql9KUVTWzSBOC1BKoRgYK0cDA7R2gP42RSRoagAkqqOBeArZZQzNuqBLZd1Xzx
tcdHXjRe+NSVBgP6JskrmEk/HQUfbJMMNSRoNeJcs4/1XaK1JkjlJFmcWeljf/ow
UC4V/iSeivn/2i6S2AZNsfP6q/iufmlonyzyz5LYBXOgqZQyMOvFL5tzKn+ijAMF
fKbmn2s3+kMyESZAqvPoOQytquRr/QNTsvx1ZwMbuxZbno280Ss=
=Tm0y
-----END PGP SIGNATURE-----

--brh6osardy5yiqfo--
