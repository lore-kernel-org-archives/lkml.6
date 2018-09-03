Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AE0C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E442075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E442075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeICR6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:58:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35928 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbeICR6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:58:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 65D9120799; Mon,  3 Sep 2018 15:37:48 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 26678203DC;
        Mon,  3 Sep 2018 15:37:48 +0200 (CEST)
Date:   Mon, 3 Sep 2018 15:37:46 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        f.fainelli@gmail.com, allan.nielsen@microchip.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next v2 4/7] net: phy: mscc: read
 'vsc8531,edge-slowdown' as an u32
Message-ID: <20180903133746.wsvezy3rbdivnjfs@qschulz>
References: <20180903084853.18092-1-quentin.schulz@bootlin.com>
 <20180903084853.18092-4-quentin.schulz@bootlin.com>
 <20180903132756.GD4445@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tr2jro5eutuoly2l"
Content-Disposition: inline
In-Reply-To: <20180903132756.GD4445@lunn.ch>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tr2jro5eutuoly2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, Sep 03, 2018 at 03:27:56PM +0200, Andrew Lunn wrote:
> On Mon, Sep 03, 2018 at 10:48:50AM +0200, Quentin Schulz wrote:
> > In the DT binding, it is specified nowhere that 'vsc8531,edge-slowdown'
> > is an u8, even though it's read as an u8 in the driver.
>=20
> Hi Quentin
>=20
> of_property_read_u8() will perform bounds checking. Is that important
> here?
>=20

Just to be sure, we're talking here about making sure the value stored
in the DT is not bigger than the specified value (here an u8)? If so,
that isn't the reason why I'm suggesting those two patches.

Without /bits 8/ in the DT property, whatever were the values I put in
the property, I'd always get a 0. So I need to fix it either in the DT
(but Rob does not really like it) or in the driver.

Hope that makes sense.

Quentin

--tr2jro5eutuoly2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAluNOSoACgkQhLiadT7g
8aOyag//a1U+y+KF2So2bcVsTaIpWQsHf0DDy5nyfT5rTMisuhtc/pu9i2/jyb9Z
Y8P9cO5pA7oWnAWTc1eXM/OkBcVusSxKvFxBjf//BtxElzlo+vGge1kYCcPmYn9e
idkiE88lwv4o1OijOlNe03Knoo/dkjVfC2ADVMnCRc19/N6z6Tl6SSmkh5WQH8EN
DU6ZCF9Ncyjocsks5oMNve+SXXyze1kitsz85BwVSUSByGqPp/pbStuOL+veq/VD
o0CqtKkchvF9PiszTWYc9QE3M/l+PlWgtfGvgx+Pb1/yEfYiMxlRrMaPBaVXo6RG
38noj0XsAxUOoIhbb4NfcOHJMmshv6A4wT4/1B9OZ/OFwwLqIThueQlYmVsCzZhY
1fLxnjaRjpwyvEVWKuDbcLLIRj4qSrCuIR2VtV8T9KYk9Ccqfimh4JuAuMEcaNwK
MI0ylfoKvaJTHPdBlGp9THeVC0mDGOgxLrmImMhfic2rveFxPQ+/unMPOP4uo3CP
1iKdNK7kZYq+2JgWeIcJsi18+AN9n3au8jYrE1eQYsYu/aQCNqpq7WNpnkZqGGkl
wdk3okc4rZJPIXH7wUvwghcrFRBiNE//Xa5Q29DwJZQUafoZIOEm5uvBqiw7zx/4
jmeBOXnnePz7mGHBTKcXAMqEJVE/JV+EkgjRB0++rcXOX+Al0ag=
=0XK8
-----END PGP SIGNATURE-----

--tr2jro5eutuoly2l--
