Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94099C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516D72083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516D72083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbeJAPxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:53:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50311 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbeJAPxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:53:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B1CDB20828; Mon,  1 Oct 2018 11:16:31 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5CD1C206A2;
        Mon,  1 Oct 2018 11:16:31 +0200 (CEST)
Date:   Mon, 1 Oct 2018 11:16:31 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com
Subject: Re: [PATCH net-next 2/7] net: phy: mscc: add support for VSC8584 PHY
Message-ID: <20181001091631.5adxhbz2q4bwwjjf@qschulz>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <a61d9affd3f1ec9deb60c882cce1daf37fbe2427.1536916714.git-series.quentin.schulz@bootlin.com>
 <20180914131846.GG14865@lunn.ch>
 <20180914132930.fphdm3dm2incetbq@qschulz>
 <20180914162828.5e75ffh5sig4om3d@qschulz>
 <20180914165824.GA3811@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xcrcdsgrqxxzw7hb"
Content-Disposition: inline
In-Reply-To: <20180914165824.GA3811@lunn.ch>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xcrcdsgrqxxzw7hb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Sep 14, 2018 at 06:58:24PM +0200, Andrew Lunn wrote:
> > Confirmed by HW engineers, it only impacts PHYs in the same package.
>=20
> Hi Quentin
>=20
> Thanks for checking. As you said, it would be counter intuitive,
> meaning a lot of confusion if it actually did happen.
>=20
> Maybe you can add "in package" before broadcast in the commit message
> and the code comments.
>=20

ACK.

Quentin

--xcrcdsgrqxxzw7hb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlux5e8ACgkQhLiadT7g
8aPaIw//TcWacMbWZ0UqdM1MMbe4582w/miWjfQ/2T7MUp96YNokTw8cbTU8iINX
8YXrtk9pxWWN2MJ+CsVDWZmuR/ZoU/S4DOTMjE7dQivsa+5X0r4nRpbFbJiehf13
cqhW24e+lek6CgNZDYJdFH7RDCmEWiyeI3wIVkgCD/8QSf2hIikDfPstExWFKprn
0FQfyhWRCZxktjNwCrBua/xT0nciGfgq+jwW8HMQQdWPZxJrVn19F33xKVkM/iDC
kh3P5sCnhNGiFfZqBxH8bJ9qQwrdf85o6sbnbe2LoaIphmaW0B5HraVFVVOXisyg
TqHxCDyXkYDFEK1/DFet93Bru/AlO1nksRubei55WNNTpbaOvyIRDpYsAo28Jxkq
F9vbBnCyaBzfh6VOlCXmkiN8M54S1kOjtORalrGMvFX9Vhxn2/f+p520Kuo+gMeS
X/XEZu+CDcc+lJj5T/wGRKhAkM9yHlTWNP6jWd551LT2UqmQisJggZ1U3o34IqFY
Xy++sZoPczyuLK1TvmdBTbBahO/0AvWKnRpe5UnedvT5hL2VenNcjvxrDwJD+vZZ
sjpGBVXsjzVShWzVUt1IaDYhxP0W2f1QKbd3N+9gT2V4KqObRcEX9O1+JWiV0tSN
hiDe3Tr1GO/caHJLpZJvEmzxCx/0kTPwS/xHZjFgMwNHZzX1kM0=
=bgXb
-----END PGP SIGNATURE-----

--xcrcdsgrqxxzw7hb--
