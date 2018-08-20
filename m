Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED574C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36DE21581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36DE21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeHTQLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:11:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40305 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbeHTQLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:11:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C929C20DB5; Mon, 20 Aug 2018 14:56:20 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-85-9.w90-88.abo.wanadoo.fr [90.88.27.9])
        by mail.bootlin.com (Postfix) with ESMTPSA id 981C120703;
        Mon, 20 Aug 2018 14:56:10 +0200 (CEST)
Date:   Mon, 20 Aug 2018 14:56:11 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Tuomas Tynkkynen <tuomas@tuxera.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: sunxi: Don't use cd-inverted in
 sun50i-a64-pinebook
Message-ID: <20180820125611.3txlxkxhzppfmztp@flea>
References: <20180807232554.16825-1-tuomas@tuxera.com>
 <20180807232554.16825-2-tuomas@tuxera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cmpxf4oasnmpljug"
Content-Disposition: inline
In-Reply-To: <20180807232554.16825-2-tuomas@tuxera.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cmpxf4oasnmpljug
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 08, 2018 at 02:25:54AM +0300, Tuomas Tynkkynen wrote:
> Another user of cd-inverted seems to have crept in. Switch it away from
> cd-inverted to be consistent with other sunxi boards.
>=20
> Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>

Queued for 4.20, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--cmpxf4oasnmpljug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlt6umoACgkQ0rTAlCFN
r3TMOQ/5AVmGOh1lCU1MQm7ch86Gj/ZuFKIaSGGWz43osYD3nEDYtc/1QeOASMra
9CRvYb6F1htjdcWNcvFVed0pv9UCHglsc3NDibxMVlr039ABpriI2ZGU4W+O/hPk
F6XUkBii23YGPUp+Xz9oVls5Kjs7NuhWd4NdaKcra/TgfivOg4UmL7qMxA/hXKGx
M0so0wVVl4QVReD/Y+cFA137ZasG6/UBA2n/JoZ5Ae2JEd5EkgWxmgy8uTMc5z/7
IOUeBp1qWmjV495rP5DzNEtooSI+Js6GVzcPiSbsrgxNrwbMZHvgptQp9BfpOx8P
9Pe/9TV42mcnxF8fQlF7DDTVw5yf41TZksRm0jrbvEQQr75LbwmxMc8qzgelyUAS
lddcXtr5aGOLy1na8D/749WwoRDIQMH0PBNBsc/L82RYHLt86V/YdV4K43y0z611
tFGvTEsRrJKt7+Sn8MTjMG/jaTR9YU5VpqUfLZhCeZsaeX/bn2ah0dJFHzqKJUJG
HltULGABgGxwTlXhLYshfOCB8RyHgwD93aS48WXTJI8JYNDViR9X+1eqWjJrzb1N
VDgtO1hdziuW81DgqxTg64Gr24aKINMZNZJ1Ute/0wpTyZbXAo1VsvTb3Ho3XPaY
p975ca3I2lsyGjEXkPt7iakYPQrFHcjlqnbiBWF4mw7B0ZHCJB4=
=+uPK
-----END PGP SIGNATURE-----

--cmpxf4oasnmpljug--
