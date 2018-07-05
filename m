Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB12C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF41C235FB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF41C235FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754001AbeGEOxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:53:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56058 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753592AbeGEOu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:50:59 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5878D207D4; Thu,  5 Jul 2018 16:50:57 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4F535208E5;
        Thu,  5 Jul 2018 16:50:30 +0200 (CEST)
Date:   Thu, 5 Jul 2018 16:50:31 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     "Jonathan A. Kollasch" <jakllsch@kollasch.net>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dts: fix status gpioleds on nanopi-neo-plus2
Message-ID: <20180705145031.2qf2kblvebttt6dv@flea>
References: <20180703132636.21587-1-jakllsch@kollasch.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="im7tnp2yrzd45qt2"
Content-Disposition: inline
In-Reply-To: <20180703132636.21587-1-jakllsch@kollasch.net>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--im7tnp2yrzd45qt2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 03, 2018 at 08:26:36AM -0500, Jonathan A. Kollasch wrote:
> Signed-off-by: Jonathan A. Kollasch <jakllsch@kollasch.net>

So, the prefix of your commit title should be "arm64: dts: allwinner:
<title>", and having a commit log explaining what you're doing, why
(and in this case the source) is going to be needed.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--im7tnp2yrzd45qt2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAls+MDYACgkQ0rTAlCFN
r3Rfog/+MlKv5xYFoFWaOguW9J4UksS1LK6LppAeXxWEyn8EaRamp5KoWjsC9KDI
G2xO/4buy+JpA0YgI8n4B+yg+iDROV4HzFQEumeImfl4r94DYhx+xW49YeaS09hO
EDuZOCgjGKq14MLs9EBXCPX6gWR1uaRoDnWIy6jcS9YLMRMo+9hkDvudEJM3T6s4
RxoxkWHYy4VkppEb+E24/G0GvUEWwWS277g3xuh+71LS4eFLqW0uulxuKGODChe3
fvN6U8K92/OXb2yOrtmUjyNHv1lfp53vI131ulh/CQxgzahPtb4aD3jyd9BBsPHC
QOiPIo7XMbzHeHn6kbKRdkLCH1grWPWU2I1Yw+prWArKoDtZ8W8yx0S09V/DXYEM
tevBGbFUh9RNpRw3DMtD8UzU5g1EPVheApKIHhgn/F5rlwFVerdNg+isEuKclnI6
pqs4UbIU8jcdZO73TcVLdOXv3bB0LfMqZgXru00fC0i20LGip7aPFFTNGMTBOEmw
9NVyOhO1VfBWNRtNbpPdGVSAgwfRYgFkBsnFnQiFaIBiuacjpHqw3vuSHMBUBd74
T9TUkcpKtkVEoxOO+5GGgXvWLTOkAxdxkNAQ42XvnD4t4xRdMU7zTTPfo+CMFG0v
ypbsmK5A1JJlarXDLo1lMuNojoCfWYXEg7YIZm9nmKMiD4d/OFI=
=RhFw
-----END PGP SIGNATURE-----

--im7tnp2yrzd45qt2--
