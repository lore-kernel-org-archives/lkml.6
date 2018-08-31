Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A29C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B318F20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B318F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeHaLqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:46:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57261 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbeHaLqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:46:35 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C9D112072F; Fri, 31 Aug 2018 09:40:25 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9E082206EE;
        Fri, 31 Aug 2018 09:40:25 +0200 (CEST)
Date:   Fri, 31 Aug 2018 09:40:24 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-ide@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v4 00/13] ata: ahci_platform: support allwinner R40 AHCI
Message-ID: <20180831074024.w7yicj5y4imy57e2@flea>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <f5838eae-fa6c-8699-14a4-95d0daa8a960@kernel.dk>
 <CAGb2v67miUjqeKeDh_E_XPee_0Hq1C6YrfXxsOp_=NtQY+LLmQ@mail.gmail.com>
 <8fa866c5-6800-505f-53bc-5c1b27582ca6@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iiupw3y5uuqzr6al"
Content-Disposition: inline
In-Reply-To: <8fa866c5-6800-505f-53bc-5c1b27582ca6@kernel.dk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iiupw3y5uuqzr6al
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Thu, Aug 30, 2018 at 08:52:52PM -0600, Jens Axboe wrote:
> On 8/30/18 8:32 PM, Chen-Yu Tsai wrote:
> > Hi,
> >=20
> > On Fri, Aug 31, 2018 at 4:31 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 8/30/18 1:01 PM, Corentin Labbe wrote:
> >>> Hello
> >>>
> >>> This patchset add support for allwinner R40 AHCI controller.
> >>>
> >>> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> >>> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> >>> by this serie, so no regression should come with it.
> >>>
> >>> The last patch(ata: ahci_sunxi: remove PHY code) should not be merged,
> >>> but will be resent for inclustion when all patchs will have hit linus
> >>> tree.
> >>
> >> Applied 1-12 with Hans's blessing, thanks Corentin.
> >=20
> > Please don't merge device tree ("dts") patches, i.e. patches 9-12. We w=
ill
> > merge them through the sunxi / armsoc tree. Having them in separate tre=
es
> > introduces conflicts when we have other stuff going through our tree.
>=20
> OK, fair enough, I can drop those.

And the DT bits actually have some issues that would need to change
the code significantly.

Can you drop all of them please?

Thanks!
Maxmie

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--iiupw3y5uuqzr6al
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluI8OcACgkQ0rTAlCFN
r3Q34w/+ONfoARx76FnKBrS0ZGz+3lrYwJtka2ugbUB2xVxyhI6bHCCpt+DAWXcy
dvFSg92m8FvcxQ3CLVvI0s/ZJLiHe37ECOrMTbFXuXB/kVDI9Le8+ZEyNp+r1gZa
uLviUNMhZ14LTeQse74Snnv3IMcKahS9nFtaCEReJi05/7RQI5mHVxvrVF/4rzks
zR3NwWJn9pwiTv17Ubab4ONePVtsLnqI4/XkzK6M+GTmOBJRXcV+EX8Kpm7LYyXP
QxapVvWNaqKWLyGJlK2jheHSJuF8gqbMadM0uY1YRqe8Xnor2SRc2FbpVmkMWow2
ZRICAcvRrh4etDE1HJ8rvgfGL8aoW4d7Z4f5ln896j3rZiEPSDrJVs0mWesD2fk3
xQUn7EGUUnhAb2FstFR8qxG72p4jXZ3zPiqCISK8/wJhoNBUJ1AG3DHTKU7pxIfn
0IgTGTGASpsCkxTeNnmzh6YbL86WkNIZHKNa9AKd6sM3wmuk1ANAYreKoJQavMmE
K8w3esHivBFyNLIYmjw+h0OKbFb6Gk0RnsxLV6gJB0ikpyCzCr4vZhGJCGvdVs9g
aJ27xw25o7Sm/qvuxvrG98KS7ByOuaG+6OuZvOnkgPySDk+VE0aDcz8JYgzNv6oB
rBP7llk8EdCStmUA1pVWBCzx6dXNKW6WV5L6wTJ0hN6E2TCrlG0=
=+kCp
-----END PGP SIGNATURE-----

--iiupw3y5uuqzr6al--
