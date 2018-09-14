Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFF4ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D48C20671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D48C20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeINSoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:44:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43124 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727611AbeINSoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:44:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C2B5F206FF; Fri, 14 Sep 2018 15:29:41 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7215B206EE;
        Fri, 14 Sep 2018 15:29:31 +0200 (CEST)
Date:   Fri, 14 Sep 2018 15:29:30 +0200
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
Message-ID: <20180914132930.fphdm3dm2incetbq@qschulz>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <a61d9affd3f1ec9deb60c882cce1daf37fbe2427.1536916714.git-series.quentin.schulz@bootlin.com>
 <20180914131846.GG14865@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w2cfxpmyvzbuyq6t"
Content-Disposition: inline
In-Reply-To: <20180914131846.GG14865@lunn.ch>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w2cfxpmyvzbuyq6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Sep 14, 2018 at 03:18:46PM +0200, Andrew Lunn wrote:
> > Most of the init sequence of a PHY of the package is common to all PHYs
> > in the package, thus we use the SMI broadcast feature which enables us
> > to propagate a write in one register of one PHY to all PHYs in the
> > package.
>=20
> Hi Quinten
>=20
> Could you say a bit more about the broadcast. Does the SMI broadcast
> go to all PHY everywhere on an MDIO bus, or only all PHYs within one
> package? I'm just thinking about the case you need two of these
> packages to cover 8 switch ports.
>=20

Ah sorry, that wasn't very explicit. That's a feature on the PHY side so
my wildest guess is that it wouldn't impact any other PHY outside of
this package. Affecting any other PHY on the bus is counter-intuitive to
me but I'll ask the HW engineers for confirmation.

Thanks,
Quentin

--w2cfxpmyvzbuyq6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlubt7oACgkQhLiadT7g
8aMP+g/+L2iC+PhfMSiTn/swWLrAkWxgR7/1NH4N7Kb5wIBJPN659JJnEUHtnQQd
HRu4vqlMEu9c6T6B6fo23w8xHvKSTtQdcPtKgX2AbtwvuNelfPTUtOVQYbdAzqKB
ZG0TKTL5BIFn49N9vwf9SpvVKFJ4e3+XU2/OMAO/PiG3hTwlcqH3JX5TXzDlBSUM
1w+MS/UMzqTRVNnXfCvyGk6/xtAcOIu/GCxCGQviP6iZWtewVrnowqY94FURE8h4
eF4Mc8udp3OLVUOh5Ki3DtWY42oRTG9KPqwDXzxKIgZ4V91n1USVOE8kPIZrvbW8
6N61KHuJTlwZfdcpl5VdUqkOfVfpclnCkJOQkmySZcn9OEGHNxAa/IHN+1eX6wOX
zbD0i7IccvHdjIfoAmQwpO5kO72x3XFaJhcZEq87LBpdcY6QodUJddqjlUdyeSae
BmJN4RhgNi+l3IFFYbOTAQY0o6dTdvSO1W2RzA0//IDeUSXBSirf+dow6vockwf6
cPOjUaq82xJlFzyucsGH1G4Xp6G/sZN1ML3ETnRKLRBIy34dREcfgOE2k5FAtcN4
hzv322g8YR+tuQ7EIXWwxQwM/osiCniaz8Zi7IzJ/aksFJBITLP24rLHEb/xEknL
nIOZfQaVOkE02pxyW/qPU7nUe66hnJUAwdcgr/TIk/hoIeKRVUs=
=Rb1D
-----END PGP SIGNATURE-----

--w2cfxpmyvzbuyq6t--
