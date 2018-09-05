Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE42C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EAC2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EAC2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeIELtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:49:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34760 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbeIELtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:49:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B8FCB20766; Wed,  5 Sep 2018 09:20:52 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8492E206DE;
        Wed,  5 Sep 2018 09:20:52 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:20:51 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 03/11] dt-bindings: display: Add compatible for A64
 DE2 display pipeline
Message-ID: <20180905072051.ac7nfa4f65gcqaf7@flea>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-4-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="77l3kc73q5njcdnm"
Content-Disposition: inline
In-Reply-To: <20180904044053.15425-4-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--77l3kc73q5njcdnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 12:40:45PM +0800, Icenowy Zheng wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
>=20
> Allwinner A64 has a DE2 display pipeline. The TCONs are similar to the
> ones in A83T, but the mixers are new (similar to the later R40 SoC).
>=20
> This patch adds dt-binding documentation for A64 DE2 display pipeline.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> [Icenowy: Refactor and also cover TCON1]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--77l3kc73q5njcdnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluPg9IACgkQ0rTAlCFN
r3Sagg/9G1DUgxGja5yNzn7SLh5g9IwVFLOHdtsfx1EYCGhYnh6yLMa+W4wU9OqK
d9VoyRBU99RYbLFpj7ngYfdVHZ8Zh5ybr51WzLq2Jk51YkG1kt3cxC4GIJClUnMn
auNj8fiFcCtIisaEcUatbD8Bv0QK4GWHdMM95U/p5D/0SUKHxeowvYxZvQ9OjOEm
aVci6TVa85IWb2vn8oDcZLjRHVUnghYtS1UpkOfjcckpuk54+1dcy7FySRKOQ/Js
jzTKEhbp5VqfYU/ErViab+ITJKh+IdIc2ebYBOKmt0CfUjCrUPIiBs2Qq1Lu3cKA
7NHj+Y8Ayc99gi8C2QGyZnliC3SRsKzSuO6ThoADKzZHXRieXAZJYPJ9nrNeXe+o
441fWgqaes+WZC4Ahxm/IBxAnk1IUhWDt2TpLsNfdMqcqv1TsS6UwC4MsSoqzJpz
e7cPMP7IX1uhAjM3TGYsllqnQghmZ8dZgt84Ih4taQto7f9gG64fHoCpdl16u2BL
gb5KEQWRqJBaOMMKuz+gPclfona4iEmEmwZKHS1iBPXDoGGBc3Nt2kMa2dMJhESt
cGnHUXCw7nX2RlIGUfLHvcblKlKm+hRI3T50ajp/jsZcLH2JVV7LXLbCwM2QnJkD
EKivM1K0dIP5QyIh9PdaJEGd891Ky+jdNowvVGTlM1lI3fqd7uQ=
=1Ecl
-----END PGP SIGNATURE-----

--77l3kc73q5njcdnm--
