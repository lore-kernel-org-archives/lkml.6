Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A33C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A54920673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A54920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbeGZIsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:48:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46064 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbeGZIsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:48:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1758020765; Thu, 26 Jul 2018 09:32:39 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9E27020908;
        Thu, 26 Jul 2018 09:31:37 +0200 (CEST)
Date:   Thu, 26 Jul 2018 09:31:38 +0200
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
Message-ID: <20180726073138.fexu4nxaamqmrbzb@flea>
References: <Akash_Gajjar@mentor.com>
 <1532587906-5415-1-git-send-email-Akash_Gajjar@mentor.com>
 <20180726072924.bnvljmd2sf6bf5ae@flea>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oeexq2bajwy2ctlp"
Content-Disposition: inline
In-Reply-To: <20180726072924.bnvljmd2sf6bf5ae@flea>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oeexq2bajwy2ctlp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2018 at 09:29:24AM +0200, Maxime Ripard wrote:
> 1;5202;0c
> On Thu, Jul 26, 2018 at 12:21:46PM +0530, Akash Gajjar wrote:
> > This board has SPI flash. add spi flash support in device tree.
> > Tested on pine64 LTS.
> >=20
> > Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
>=20
> Queued for 4.20, thanks!

No, sorry, I ended up droping that patch.

You mention that the Pine64 LTS has an SPI flash, yet you change the
sopine baseboard dts. Why is that?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--oeexq2bajwy2ctlp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltZeNkACgkQ0rTAlCFN
r3Ttig/+PcyaeKtRma4H+5ZJMY00IMKNcQxgzSGQdRxuDZyme44ganZjlgS8AYJl
QFV5oVvk4SeULzuW1Oo+Syrx8TIMS2sZhhWdcMB9S4/ODPT57vdsrw1wE1V3oxQI
16dSKqI58pByh3miYFlSXJtUUS21CnrSAuFcYgewzZ2j8uo3Z22RkIJEXfekUU6b
a+iFybgNtpKLJUi48D/QVbnAy1QTPdtRNldGSEiAmtWVjNLVin//l+CLlx73nJBv
NDaRYt4aaspD4qllA9mptK8JbQmDxQL+ObVoSm1S6XNy/HR112OQuoxW9jNh1iHn
qhmb0Ydqe50kPck9HMa1E8ipO35Fc8JZXn8ZgGm53pXP9/eKvCBG8vuOITFBdxN3
W7EWicAHYR3K55n29IGR5kBJA9/34Xn0IubeJwTu1IWzV6ZRP9FyzIq2l7u7EZP3
0lfGRAU4cMVtSWwoqYUSai+It+i63UYD6eKXyYoPudpa/8e/aFjoIvY1fYxehjOl
rVIrmJX0z9FJEHy5Ls2fFFTNUOJl2lcMDUGTflan2PDoPwSpA8aaGr1SKiQF5leG
3QkGyGE7c0iPCVeFKghsvwiUsy+6oidNLhfEvnKVlbkEnUZUFTofBjXEXZAUGspw
knLQopE6tZYFjuboD2PR5PEASIxTMjw2+limvIrNxNe1k31mgHY=
=asom
-----END PGP SIGNATURE-----

--oeexq2bajwy2ctlp--
