Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653B2FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1551520893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1551520893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeG3KBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:01:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49532 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeG3KBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:01:16 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0F49920876; Mon, 30 Jul 2018 10:27:22 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id D57FA20799;
        Mon, 30 Jul 2018 10:27:11 +0200 (CEST)
Date:   Mon, 30 Jul 2018 10:27:12 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: allwinner: dts: h6: fix Pine H64 MMC bus width
Message-ID: <20180730082712.koiaej6dxjnnk6lb@flea>
References: <20180726044805.55888-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7e2hjc2as7a2niec"
Content-Disposition: inline
In-Reply-To: <20180726044805.55888-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7e2hjc2as7a2niec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2018 at 12:48:05PM +0800, Icenowy Zheng wrote:
> Currently the enabled MMC controllers on Pine H64 do not have bus-width
> set, which make them fall back to 1-bit mode and become quite slow.
>=20
> Fix this by add the corresponding bus-width properties.
>=20
> Fixes: ecbd611882a1 ("arm64: allwinner: h6: enable MMC0/2 on Pine H64")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--7e2hjc2as7a2niec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltey98ACgkQ0rTAlCFN
r3SYPQ/+KYu6CrcM4OWWjt9yjtf25hT9HFAtByzcZ26f0LM/w4ZPDyg3lNL1G0bp
Z7qnrF7Z8Rm2v4OhlSefw54lpjBCO0B+G9zqO4Or/YQlbo/3A7C22/y+1Pp3FCqy
6RhQbfpYctaA/nvhf/Smn2ylRcWGK00Sa0HM0WXf99vQmNF3Fs1IEGfip2WA7Nw1
Ng+Qgp5MysLiUNvG7wdDHl440SeO0YeA81AuES4nHcn4yPCprGm7bwOvRSHd1z9V
X0DUgMBMsc/B4gQnVn19nJXXbHnJZu2BhxVWJOT3pvEmdUaevzuFkANl7n2rtSPL
PTdcuj8Z2KtOH+QJZei/9fe8fe1S7lIjIwd4KemtYqfEwei7dA5JlKGr7R/n3uP8
dRcmWRyoxYorBKJXbs7tBevZjJ9bmOevN9WdAq7dYNgaeGQd182J/FIuVy3jKzBQ
syUfYprTeu+pdfuqBX13bu+mfwmJVUF9ey73s8yLUlnWw5If1ij9IR4Xla2PI/Mk
y68XE3fhirvTTcyXpZTTYOJdhuozo9gOMU68tJ4RFhiBWc3JMipghlo6S1pvjHLZ
jxRYpcfWr2sA3eV9RTaq72lStz1OGJEShPgw0mE6Vi/qYFfvBZO9z3cLDZ54yYDj
mctPxj3Tx3Fs+RRRV3XAmLVdi7GwMgeTsgzYhSFNkclBwtfraNQ=
=RvF3
-----END PGP SIGNATURE-----

--7e2hjc2as7a2niec--
