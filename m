Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7784FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449082145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449082145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeKUSZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:25:50 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36479 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeKUSZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:25:50 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 733BA207AB; Wed, 21 Nov 2018 08:52:22 +0100 (CET)
Received: from qschulz (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 115BB20729;
        Wed, 21 Nov 2018 08:52:22 +0100 (CET)
Date:   Wed, 21 Nov 2018 08:52:20 +0100
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v3 4/5] phy: mvebu-cp110-comphy: convert to use eth phy
 mode and submode
Message-ID: <20181121075220.z6smcpk3y7vab7ix@qschulz>
References: <20181120012424.11802-1-grygorii.strashko@ti.com>
 <20181120012424.11802-5-grygorii.strashko@ti.com>
 <d80901b2-a38a-7abf-23b2-c2b0c84ff321@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ee7o6gc4xs4vs53"
Content-Disposition: inline
In-Reply-To: <d80901b2-a38a-7abf-23b2-c2b0c84ff321@ti.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2ee7o6gc4xs4vs53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kishon,

On Wed, Nov 21, 2018 at 01:08:42PM +0530, Kishon Vijay Abraham I wrote:
> Antoine,
>=20
> On 20/11/18 6:54 AM, Grygorii Strashko wrote:
> > Convert mvebu-cp110-comphy PHY driver to use recently introduced
> > PHY_MODE_ETHERNET and phy_set_mode_ext().
>=20
> Care to give ACK for this patch?
>=20

Acked-by Antoine and Tested-by Maxime given in v2:
https://patchwork.kernel.org/patch/10676749/

Quentin

--2ee7o6gc4xs4vs53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlv1DrQACgkQhLiadT7g
8aMsxw/8DZIY08G7GiQ6Hhpu4eFYrQOVzgAbVHkOswZR6czVJiUlqnP64QR+k8j9
3znL+KA7X45/BEMPoai1QtnA1fHoDAjrKtgyqtcJyRBaxk96AEWZNnpdBFAhTw9w
QRVl0b0OQ+ckNMOze4BIhrtUB2+JnCDaf339WOIN4Eup0N+4Y7OsTS4N3Ngy7rTQ
Rs3kmA7wwSePQ2ylbgG5yRoo7bVVItrOogK9x6acSiP02waEse4n1gfoWrQv005e
qoEeZZYjX3ILe8b3v2yQKIV5VYA7D2HOPv0uIv9KzWGqST9c/B8aEW8Duqq1soCr
8x79jqpGvDTYwlVmPR1sLpy48l3ejKEVE0y8RTm7g6gshuNhG0c7MVI99vzj0Jwi
8bPxO2CTu0scVYVh233VYJSWvg6oOBmZsYjmoJiABIO+Ol9uZlYBGEwIQDz1P+t0
cHKWFd0IYARVasAAtwwyLUeYXTC2TU2LkZmsg1bjjFIOoHPKFckGyEspp1OfJs/A
oA02GQK+n2SxCSYq14BXvYDb1ckD+bgQPtD6CV4Uxw7K8U83EkF6qFefNkRhZU7K
+NVagxaCscHEkt+WmH/4YW2Hu1Eti6SrQ1ImQi5E0tDJpPly2trU1Qqty0gQsUix
BPXJXOoGY6cmam6jmoBXpVzkARPjFpNgkgCjtOIKBIIhsUTzoTk=
=hpTL
-----END PGP SIGNATURE-----

--2ee7o6gc4xs4vs53--
