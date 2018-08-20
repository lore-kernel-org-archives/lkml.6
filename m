Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59971C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E56213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E56213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbeHTPIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:08:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38046 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbeHTPIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:08:05 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 328C020DEE; Mon, 20 Aug 2018 13:52:44 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-85-9.w90-88.abo.wanadoo.fr [90.88.27.9])
        by mail.bootlin.com (Postfix) with ESMTPSA id 092C220DE0;
        Mon, 20 Aug 2018 13:52:44 +0200 (CEST)
Date:   Mon, 20 Aug 2018 13:52:44 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, stable@vger.kernel.org
Subject: Re: [PATCH] drm: sun4i: exclusively set HDMI-related clocks for
 dw-hdmi
Message-ID: <20180820115244.x5z6lm4i7tpqptgs@flea>
References: <20180815120745.36593-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7pnyoscnooihysgb"
Content-Disposition: inline
In-Reply-To: <20180815120745.36593-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7pnyoscnooihysgb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Aug 15, 2018 at 08:07:45PM +0800, Icenowy Zheng wrote:
> The glue in sun4i-drm of dw-hdmi currently doesn't set the clocks of
> dw-hdmi exclusively, which will lead the display fails to initialize in
> some situations.

Apart from the feedback already given, detailing which situations
would be very helpful.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--7pnyoscnooihysgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlt6q4sACgkQ0rTAlCFN
r3RC9xAAjfSaAglXWZvbSyCHH6VxiA/sZSuEzdSWxOY8rOAFP2O+R2jiAMh+Ij1T
biUQdwVfgU1CcUFBpPV6hj2Cc4WRFmViKk97mXnpzybZdYI2E5fi4Kufdrmklk7s
hCZrEmXrXNfykrC464mXZgWPl931E+a7M4Qm9KcAAp6IbuQJrUi8SUF6QqLBXm6b
K+z6mC2RJfbbCsyExYsgVwbgfzShh82irJiJ+d8Usk8Tw3Ehvj5GU8gBKhZC/uze
lT7vqonoKxF5vJvS1RJ9kNptXF+Csa3eRcegzQ58rFey9uDMSAwrwEG3hpe9Y0/y
c4Mc0a5qTW4yh7CX9B5v5IfTvHkYAHpVVSMcHxg9QLdeRKKtgciZCN1/DZ37aV9q
s+BAe5mSb5hlVVpYz4PbJ94Y96sLZvSJgl2mRCjL0Iu3ylgCd1Y59+IH9+n+8QaD
tr8NbOC9GkBAEXGL7lUlq2+TcNEilVefVeDFCxvn1apEXqK5423ab22qWAb1BJJx
cVDoRjLbN9eqWh/6LmJDKKsj6JP3zipBDMOtoKz7dDnhsxBaoC/0fOmRKA74Fpfc
/UHuFGWG62gIGvPyOQjmGPnrfPi1gaZ5aGpsQUBQBhSGZgR5I/wY6FCB/LTB2lcl
dIzAqyfrcZ3BUWqrdvZ1VCZdAPBGPzPbsg1KfY04k281vSW/05I=
=M3Jn
-----END PGP SIGNATURE-----

--7pnyoscnooihysgb--
