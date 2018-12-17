Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F69C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4BF21783
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeLQXOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 18:14:34 -0500
Received: from sauhun.de ([88.99.104.3]:42230 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbeLQXOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 18:14:34 -0500
Received: from localhost (p54B3357B.dip0.t-ipconnect.de [84.179.53.123])
        by pokefinder.org (Postfix) with ESMTPSA id BE1512E3656;
        Tue, 18 Dec 2018 00:06:29 +0100 (CET)
Date:   Tue, 18 Dec 2018 00:06:29 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Qii Wang <qii.wang@mediatek.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com, ryder.lee@mediatek.com
Subject: Re: [PATCH 4/5] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Message-ID: <20181217230629.i7i3kbreurgt7u73@ninjato>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
 <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
 <20181211202931.xav4gzi7rzh2scgx@ninjato>
 <1544693547.11699.40.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gph3bc2aynqejfb4"
Content-Disposition: inline
In-Reply-To: <1544693547.11699.40.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gph3bc2aynqejfb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > What is "multi-user"? Why can't you add this offset to the reg-property
> > directly?

=2E..

> MT8183 doesn't need to support muti-user according to the latest project
> information, and I'll remove this feature from patches.

Okay. It will be dropped then, thanks for the heads up!

> > > +  - mediatek,share-i3c: i3c controller can share i2c function.
> >=20
> > Please explain in more detail? Is this an I3C controller?
>=20
> Yes, it is a i3c controller, and it is compatible with i2c. I only use
> the feature of i2c, so I need a flag to do some extra settings.

Can't you derive this from the compatible? If it is
"mediatek,mt8183-i2c", then you know you need these extra settings?


--gph3bc2aynqejfb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwYK/UACgkQFA3kzBSg
Kbae4A/+MilZ2mxtZBN5/KQAX4PI8TwMRQpdfTOFfHZL1U1qxKqJm5ojSZvI3Dle
BxpSYHyWhFGblcmMckmfTHFSVfPu12UB7ma0h3A/h/6gXTemtuS1LXMolzhA6rIx
ShCNSsmji6Wk4AH0Bjok+uaO+0dP6SzWX978UmQdNPRAXg12Txf39t8cFzdwkh6t
/kN6UcNP9aUgVXASp/FXlDfGUQEQvN5opoae8JzBJYvmO7/hbECqRykVlQ1S5p4e
cwuRjPohrvKGkAwvWuyL7IoZVFotwtd9NEFE56xpykuDKMHstnmqbUS9vYKboWmZ
oLA0B075zO/iAYhAjKmbD25NAGGIucaTXpB0OsgRdRuQMs6K0rdyUZ9j81iry27N
zU5wKtoim8klrsgqQTHu+pZ1gYYgKP+M0lu7Hc1P4AYGE/qiEx4KSTX8ZBB7xXPm
JndAI+ElJracuCTvxDBPZfx5YlQnqOngKwGSwLInVGClA3sm7gRZu8TY8/5jlx7r
f8evwPSN6A7bSTSLJi5RbKe9PkmXA3XFMa7FWamrluxeVdf1jAmXC39VAF+mIvVi
ncoTmAmoVIo88lSX7qUNjZVGS6syFgQ3WYZ6lxu0b7lbx7j2PggOZl2l3dc9d+vP
GbV9jZYhcSF/57+zDFY0TIvfKT/JxyU9FZCuEHTdGcS3zosRL4E=
=FiE4
-----END PGP SIGNATURE-----

--gph3bc2aynqejfb4--
