Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B3FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C1320844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C1320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387676AbeHAJiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:38:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60628 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729769AbeHAJiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:38:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 034C420740; Wed,  1 Aug 2018 09:54:20 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1657E207BD;
        Wed,  1 Aug 2018 09:54:00 +0200 (CEST)
Date:   Wed, 1 Aug 2018 09:54:00 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 00/10] mscc: ocelot: add support for SerDes muxing
 configuration
Message-ID: <20180801075400.cvvasvi2g2m56xp4@qschulz>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <20180730132441.GC13198@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u35ohko4nfagn3ww"
Content-Disposition: inline
In-Reply-To: <20180730132441.GC13198@lunn.ch>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u35ohko4nfagn3ww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, Jul 30, 2018 at 03:24:41PM +0200, Andrew Lunn wrote:
> > The SerDes configuration is in the middle of an address space (HSIO) th=
at
> > is used to configure some parts in the MAC controller driver, that is w=
hy
> > we need to use a syscon so that we can write to the same address space =
=66rom
> > different drivers safely using regmap.
>=20
> Hi Quentin
>=20
> I assume breaking backwards compatibility is not an issue here, since
> there currently is only one board using the DT binding. But it would
> be good to give a warning in the cover notes. git bisect will also
> break for this one particular board. And since these changes are going
> through different trees, it could be quite a big break.
>=20

Yes sorry, I should have mentioned it in the cover letter, will do
if/when there is a v2.

Thanks,
Quentin

--u35ohko4nfagn3ww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlthZxcACgkQhLiadT7g
8aPTNw/+IVukDr3iYoXQ4ry2nF4nPhV12+CSQJn1pKAQFUYs3p4DGzfQPXKgXLPR
27hCz+QoYZSJwvyYwCLeh7/DC39p9jKwWZJymUPunuhsExrloLxUwH7XuT386p9O
Ym8bHhtsF2hyicESpNsTc+yQZpslNM0fN6iW87NN3Me5zRXGKr4aUjS4SN73EPyB
JiVT8lF31Whph0mWcCv94sR02u0gU8fqm+EtguJpPj3o6USceNvGo/plgrm6IKam
u2b1qd97AKw3jlFdPIimOJ9fu0vy/L5aj/6/dQqXSwE+Qd4o8lsh5rgOqsJTg322
JBN78zFlng0RcHbWoEoAF/SpYZb5kyMIPU0b5y7xHkPaIiu19AtHMhqfuN85tNt9
kt+77KdcVuDj73HWw3FnhT1f3V8DKtKWWN0bJW5OKO4TdP5RtA9/bU0vcMkcY2mJ
TgXqZCHijh5i0DltePNDqR+RIXeBJ358Dwi5QBdJmnWvsZMV8ZJOHQFJMqCaFHw0
LFo9q1H+u20AhC3jt7iFKDvkddadFcDHQfjT8S7Vh6bnYhVepIuorNVkJRdqp0pI
qzoWbXIRZuuUjBBagA8RwEpxboIwwJ7teAI8YDWUSnM3WTbGtYclVSGSyEdOA7WX
an+3naqXa4/g0/n1XcGs8ksgtskb6ciL/BX8jdYTz9XkHu69aKo=
=LSYK
-----END PGP SIGNATURE-----

--u35ohko4nfagn3ww--
