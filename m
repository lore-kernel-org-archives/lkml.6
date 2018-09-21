Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D46C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C4621550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C4621550
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390164AbeIUURa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:17:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41573 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbeIUURa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:17:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DA786208F4; Fri, 21 Sep 2018 16:28:20 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id AA892208DC;
        Fri, 21 Sep 2018 16:28:10 +0200 (CEST)
Date:   Fri, 21 Sep 2018 16:28:11 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rodrigo =?utf-8?B?RXh0ZXJja8O2dHRlciBUasOkZGVy?= 
        <rodrigo@tjader.xyz>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: allwinner: Olimex A64-OLinuXino: enable
 eMMC.
Message-ID: <20180921142811.h5jraemk565alh3i@flea>
References: <20180919141815.18737-1-rodrigo@tjader.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tce3ovpuguzhkiii"
Content-Disposition: inline
In-Reply-To: <20180919141815.18737-1-rodrigo@tjader.xyz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tce3ovpuguzhkiii
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Sep 19, 2018 at 11:18:13AM -0300, Rodrigo Exterck=F6tter Tj=E4der w=
rote:
> Copied snippet from A64-TERES I.
>=20
> Signed-off-by: Rodrigo Exterck=F6tter Tj=E4der <rodrigo@tjader.xyz>

Expanding a bit more that commit log would be helpful. What is the
eMMC connected to that board? Do all versions have it? Which modes are
supposed to be supported, and which one have been tested?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--tce3ovpuguzhkiii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluk//oACgkQ0rTAlCFN
r3QXKw/7BYnbMDLnhQEBeRx8cU1EYQjORYI3JWaZ57uiBojQBYSwf4JW4iqbgbPa
nQAXK40y5Vc/HaGUfDvzHPVy5uaFcIjH37/IwWcE2+1gKrdExH7Od0HO4tve0wis
7+kDUCmBO0PgbP0oBoKeEgbsY/4Ve+cxbRm+9Cpy+c+eU6GgAS0bDwPqemvkWckb
Lxo0N7wwa4fH+rOV9P8XBZgatJzJMu4TlMMOuOMvJU9DdliaRdcsh255U3SCgVsX
dIsBRTBGNn4NdOSfiiu1mOgWv36HouxlZHbaJvsUMxSgcjWF+Jcc4vAeFZoD1yp2
r+SVOpsAVfnS+7M6mT4pvsv+Ygt+ZXbEA4SC6CI7/Ub7Bzh5bQwWuVz+BG5KPGWe
dIRQfG3J0jZFQKmHq27MtZGf+JhDZpjEVFukgR7ZbomhTD9XfyukrbVTm1fjyzsx
17UyMKPPb3c4dlRSchjnZuHXylVGytUwvkPO0up4OQiVnyP6EW9vm3RtV0dTaIcM
17IewJ7mXPTCXOpdzh4FgkiZHLc9eUp53Pm1WG76Z6UTv2srUgG2zIq6MxWrXEDB
17ObYvSfeotqXV1iwHfpDo7Il4/i4uNjPY5mP1jT1eT+u0/1WuP2AWAvgmknObJC
5IvOgeMw61KVsUWzRhW/ewTrE5voVH85Y1K2W6pq9e30658vHog=
=JbAG
-----END PGP SIGNATURE-----

--tce3ovpuguzhkiii--
