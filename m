Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24163C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAC7208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAC7208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933278AbeGJM3g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:29:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34777 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932620AbeGJM3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:29:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 372D92084E; Tue, 10 Jul 2018 14:29:33 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 08FA9206F3;
        Tue, 10 Jul 2018 14:29:23 +0200 (CEST)
Date:   Tue, 10 Jul 2018 14:29:22 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linux@armlinux.org.uk, mark.rutland@arm.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        icenowy@aosc.io
Subject: Re: [PATCH v2 0/4] sun8i: r40: add AHCI
Message-ID: <20180710122922.6sgmgfislqwhn3tt@flea>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vm7covlgenulwjwo"
Content-Disposition: inline
In-Reply-To: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vm7covlgenulwjwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 03:20:54PM +0000, Corentin Labbe wrote:
> Hello
>=20
> With Moeicenowy's agreement, I have take leadership ot this patchset.
>=20
> There are no really changes appart renaming struct quirck to variant.
>=20
> Since the last serie is really old, I will answer comment here.
> The two regulator (1.2 and 2.5V) are not for the PHY since:
> - nothing in the schematic said that they are for the PHY, they seems
>   only for controller
> - all other AHCI driver use 5V for the target/PHY (vs 1.2/2.5 which
>   cannot be used for target)

That's a pretty bad thing to do, especially for old series. You just
dropped all the context that you reply to, and there's no way for any
reviewer to tell if your answers make any kind of sense, or addresses
any question one might have had.

> Furthermore, the AHCI binding support only one regulator per PHY, so
> using the "target" regulator is out of question for registring this two
> non-phy regulator.

Nothing is "out of question", we have the source code and can change
it if needed.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--vm7covlgenulwjwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltEppsACgkQ0rTAlCFN
r3RDRBAAmTUyhlteXxldpaeQ/cpQVxaFTo2g/u+SluX8uvxkBIipigP6oJMZNfRN
likZ9EefsSR8xXjOh9IPQaGou75zwaD5rWjEZ0HcdpeNQvEaEXkROxXMpIlgSP62
I7WZ3NHbcUfKs1pPGsehsoSliwpvvQK3Yr43wW4o0xzII37v0btdZsd74fsIX9YC
S+P9UsISm5O0jWH4waoTJAyhV1HaHj8324GeDV14YbqyuNUmW6QH5n23KKg/KY0w
DjoArMKraErleto1tQZ2krA4S7Td09HnpOA2cqXeQU+bqzzCIu7V4hWXezs2rR0e
YNAwTPdKkp01qvE009OOOHmarFZ+nMlB0lpTIJzmKFyfL2VzRzwSzcW1OZW0S2hx
BPorL+N5DcvDF4GsUEx0AXq6R+7Pfd7Inkyp7dUptwqLkaq7JEz6rOdnFv+FV3mJ
g7i+2WkX9vKfw0uOU06m7RQBO8xi6EhlTyOiZ6Wjne+xyG5ivXVtubTRxWoi8PgN
xmUmjD5BKzgFvfzhKQaiIMAdDgWkXUsWLP6HDBr06PrMp4n9bqpIPPaWFDkqBKUK
BxrI6nMrmSKUQ9PC5IdXF8Pcdv9YpEMbm2MXfwV1t/CA43VGBah29OhhgDpp3u6m
rsuQJz3nVTezKNSm4Cpas3hbFHgrXgpGEHg/sVpBvO6CWJC4+iA=
=9xwj
-----END PGP SIGNATURE-----

--vm7covlgenulwjwo--
