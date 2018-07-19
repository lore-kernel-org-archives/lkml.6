Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19708ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA5720673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA5720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbeGSPfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:35:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41022 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeGSPfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:35:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 862FD20893; Thu, 19 Jul 2018 16:51:59 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 544D4207E8;
        Thu, 19 Jul 2018 16:51:49 +0200 (CEST)
Date:   Thu, 19 Jul 2018 16:51:49 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 0/3] Allwinner H6 MMC support
Message-ID: <20180719145149.4bubmpvnvg3l3cu3@flea>
References: <20180719042810.6546-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rznujrq4zak2wt2z"
Content-Disposition: inline
In-Reply-To: <20180719042810.6546-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rznujrq4zak2wt2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 19, 2018 at 12:28:07PM +0800, Icenowy Zheng wrote:
> This patchset adds support for MMC controller in the Allwinner H6 SoC.
>=20
> Its function is a superset of the A64 MMC controller's, so it currently
> use A64 compatible as a fallback.

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--rznujrq4zak2wt2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltQpYQACgkQ0rTAlCFN
r3Rpdg/+JRqfsLZ/ujchY3+htij5KtMIUTG19t/NzZjIOsfekNfxEFa1fX75xoO1
nRC7xvajZjZvxlRp+xXHh1pMK+SOijClKAu3WCrqANAkUS9XguAcvtx7vysS8Q4r
CJt36ePbBB1KHQGF1R6Cjdd4+J69rlhbyG0YaOP4hoFB1QSw8kyyYeTjjbTlZ1IO
EdgpANemQTGhPjpDtnIoASGP2KDqPYO5eAd1M7kfJXCs1kXfoA4csn5sI0IBAgu8
993payUp3n9aZ6TLMH6dLHDQvRnkWsYHTYEZQyDLrDEy2j8OVRud9mAS9CxOiU79
vESoBA9GPyLSNilsQUxCCtQPGvtFDh303AglMjGBEOq57y69KrOi7AcSxSXY7RB6
Q7b24rnXVcbf7tg0uE5THwX6v+bg/+wp/RV+s4EJsVz76szSj8wKrwROQZAXglo2
4ps5yW8P7T4Kj7EyZkwSCLcYGee/kQ8wgr+7iZ3gOhZrIS1n1pmlN50Vx8GjRAxY
dXRLFkadSphh1709Kal54UwD8Yv5ytWjrkOI8HzMiSs/gjI7b/chQyBzZxhMPwMw
07X/u73S4cvKSnBTwerXeTNUEr1kvREv05oJJbR1oaf0rkedZfo+szoHcS9miUkB
xDdhYJgXLrSiqykrAbXx+mgiDnNb0JCo1TU10ZxpQiY+sYeVj1A=
=vDDo
-----END PGP SIGNATURE-----

--rznujrq4zak2wt2z--
