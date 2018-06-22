Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E239C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A1F224E8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A1F224E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbeFVHly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:41:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44078 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751209AbeFVHlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:41:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3E790207EB; Fri, 22 Jun 2018 09:41:43 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0F1B820794;
        Fri, 22 Jun 2018 09:41:43 +0200 (CEST)
Date:   Fri, 22 Jun 2018 09:41:43 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: allwinner: a64-sopine: Add cd-gpios to mmc0 node
Message-ID: <20180622074143.kaobrlvqplq25gry@flea>
References: <20180620093055.10928-1-manu@freebsd.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="shrrj3he6isqmzjs"
Content-Disposition: inline
In-Reply-To: <20180620093055.10928-1-manu@freebsd.org>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--shrrj3he6isqmzjs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 20, 2018 at 11:30:55AM +0200, Emmanuel Vadot wrote:
> The card detect GPIO for Sopine and Pine64-LTS is PF6.
> Add this to the dts.
>=20
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--shrrj3he6isqmzjs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlssqDYACgkQ0rTAlCFN
r3QH+BAAhZchcfL4tkTEe5+AitB50zpXGUyOSiQ1s7Mr86YDSliI8eNS+R3/KKUT
XumhwGexwJUAq47Mh3tNhT2yurVb52wDl4x5h5yNcWChYcG0zi9NvfImjxKprqd6
8dTJ9v3xnIQdgwRllaOgonNVCaVUdXp+7LA1yeb0yes5EcpJ8vk7lMCUMZIotMEk
fCVSJcCLMIBeqggH9QzDSvIefO4VuVyWVyWzav7ZhD89Il8fSvxa3209D05xLsTH
XMQyHnRFn2gFMSxYIVIq1G+/iQF24et2tjKoXAOQavLdqw4BMl/qZJVyWLDgwWOo
hzXl3qZNWadiakd+cmYalZkuzD8aUKyb0Nrg9y5uRl19yC1HapqaUePrO06AFh5M
dGWSPXiCtycXvLgiGYK3ju1O7XBMID6Ndl2dXS+qHjMpTkfRiHS5rXhFSyj/ctYR
x6wa+p8/e/jEB8UTIbGKYdMJDzFfsbePX72laCa3ScAYfqdeFP7KfHtTXclNjCUC
j25XzWxHeMUrpXbIBWYh1P1GKu6dm9wQJBGUcPM5MuXNp61o2SVZuAVfRU8atFtO
VUvoTdVtw10Y3dH15Nz4TA4H8EwQNK4Doww6cdYNWlvrDx/hWgFY0/QhyLwNFIFG
R6JJTTw/3wfW2Cwc2LrDP1VmIWELRQMYOefIRKq/f45+3ZY59bw=
=RgX7
-----END PGP SIGNATURE-----

--shrrj3he6isqmzjs--
