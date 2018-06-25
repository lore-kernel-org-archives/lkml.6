Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B6EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82FB25DA2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82FB25DA2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754699AbeFYQBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:01:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60549 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752031AbeFYQBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:01:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7E41A206A0; Mon, 25 Jun 2018 18:01:02 +0200 (CEST)
Received: from localhost (unknown [88.128.82.118])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3DA7B20CF8;
        Mon, 25 Jun 2018 18:00:52 +0200 (CEST)
Date:   Mon, 25 Jun 2018 18:00:52 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 0/7] Allwinner A64 DE2 CCU support with dedicated DE2
 bus driver
Message-ID: <20180625160052.kgje2hnzwhfcm2i5@flea>
References: <20180622122615.55836-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wmxasll2s52fhhq4"
Content-Disposition: inline
In-Reply-To: <20180622122615.55836-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wmxasll2s52fhhq4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 22, 2018 at 08:26:08PM +0800, Icenowy Zheng wrote:
> This patchset tries to implement the Allwinner A64 DE2 as a bus driver,
> in order to model the fact that the SRAM claim controls the access to
> the whole DE2 memory space.
>=20
> PATCH 1 and PATCH 4 are for the CCU part.
>=20
> PATCH 2 is the device tree binding for the A64 DE2 bus, and PATCH 3
> implements the bus driver.
>=20
> PATCH 5 adds the DE2 CCU device tree node, with the DE2 bus node.
>=20
> PATCH 6 and 7 are HDMI simplefb patches for A64. They're present as a
> test to this patchset.

Apart from the (minor) comments I made that can be fixed up while
applying, I'm happy with those changes. I'd still like to get a review
=66rom Rob, so I'll wait for it to apply them.

Thanks a lot for working on this,
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--wmxasll2s52fhhq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsxEbMACgkQ0rTAlCFN
r3Tq8g/+NQ8s3Cp8SzJS6v7IGwwGTHxvAFSmlW96Ize2uROz7Ha1DF6hWp5w/yp6
ugjXrcgyHbgWvOKJ4sdiLbyMgz1Dk5y+7pW0KFcDyDEtJq8SxVZerGv76i8SdjRd
Ai64eIXqkZaiSq50VZBlfeJ6AcbKsTz1hqq94irICU/W5qE0mJivfgbySGDmFUuW
NlAFXxVkxWfWBCdQGqrh+fUdUSgdULZCaOt6AwSh/pR17/HTkhk5JICQUTayfYyQ
YygcTvPiStatCKabI+OnPcw+kaNb2Eqm1OkeM2g1Yx2QWTeLPuwOqvmPoE5UhRDs
6Om7OBsLf8WHQ2KlMSxg2Z7MqRaqgAFW446nRsHHA4CNHeDUlfN+zxrlDt9Mf/tk
lxr2DmN5JGywZeCiV0UhUo92xJ55fbEx4Gtqtn0Td+SR6mBRvvjcCqWqERKqbFVC
YaMXGGWJ5bro70hi3WN98miDjaBUdpPQthtZ6gN3QeSkUsESHfiJ/rkONVt2BB/6
5D1rd14JqpVeyE1ZPADBjnl4pR3S8o8HTKMAwziAZyu9qZ1fgUQQ2yY49rL/aCsI
nafobbPsfISvjTOXUYoqcydvUEpi8HS+mBi523EuakeYjmCQyVWPZbH4woFqzARX
GqHOR0Decy7z3F5nLL4hXHSBditzwj9rjLIpI793Hc9ot3JeXzY=
=VZnJ
-----END PGP SIGNATURE-----

--wmxasll2s52fhhq4--
