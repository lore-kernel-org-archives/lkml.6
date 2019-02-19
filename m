Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE16C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A6C2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfBSN1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:27:08 -0500
Received: from sauhun.de ([88.99.104.3]:46042 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbfBSN1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:27:07 -0500
Received: from localhost (p54B338D8.dip0.t-ipconnect.de [84.179.56.216])
        by pokefinder.org (Postfix) with ESMTPSA id 32EBD2CF689;
        Tue, 19 Feb 2019 14:27:05 +0100 (CET)
Date:   Tue, 19 Feb 2019 14:27:04 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Qii Wang <qii.wang@mediatek.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com, ryder.lee@mediatek.com,
        xinping.qian@mediatek.com, liguo.zhang@mediatek.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Message-ID: <20190219132704.pmtai25fltxkwso6@ninjato>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
 <20190205131641.GF12401@kunai>
 <1550109268.30065.13.camel@mhfsdcap03>
 <20190215090257.geumssb2cucs7rzt@ninjato>
 <1550316723.30065.44.camel@mhfsdcap03>
 <20190216122915.hchghozcn7ntdkbm@ninjato>
 <1550582023.30065.52.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k2kejit4druie2cz"
Content-Disposition: inline
In-Reply-To: <1550582023.30065.52.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k2kejit4druie2cz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > Maybe you think that MT8183 SoC only has the I3C controllers. Actuall=
y,
> > > there are I2C and I3C controllers on MT8183 SoC. We will remove
> > > "mediatek,share-i3c" for I2C controller driver, so these patches are
> > > just to support the I2C controllers on MT8183 SoC. For the I3C
> > > controller we will send some new patches which are based on i3c
> > > framework directories(kernel/drivers/i3c), not based on
> > > i2c-mt65xx.c.
> >=20
> > Sounds perfect to me. If it turns out that the I3C driver can share
> > things with the I2C driver, we can discuss it then. But unless we have
> > an I3C driver and know for sure, the above strategy seems good to me.
> >=20
>=20
> Can I push the V4 patches of I2C controller driver now? or you just want
> an I3C driver that is compatible with the I2C controller?

If the V4 series does not use the "mediatek,share-i3c" binding anymore,
please resend it. From what I recall, it should be OK then.

> According to our plan, I2C controller will use
> i2c-mt65xx.c(kernel/drivers/i2c/busses/)and I3C controller will use
> i3c-xxx.c(kernel/drivers/i3c/master/)

Sounds OK from what I understood. The I2C fallback from I3C will be
interesting.


--k2kejit4druie2cz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxsBCgACgkQFA3kzBSg
KbaQMA//RJ3BJa9WaL2VJq/24hYu8KHYFLR8oSwjgTCVTU5CEx/wuhF9Aw06Zntr
WkkM9aCiuqmp2J2WdtYjAHZoaKybFrvF4ktxWQ/iaopO1MHWBFoF4ZbOlKlTiO6s
bT/LA2xCHrc2iDdmgTTNJm9EzAWag9oqx1GYUjwYmMGuwz3H+buaCztv0OKJLz7F
jD5GQTAd1NfDFU+FSM+SAzcSTpI4rIEMr3V6wgGELwmpzS2Tg9MlZIoAcfwvIKyT
gGTlX+nwqQuM1x1NmCsoc8zi2feG32yFbQJg+7lihFMGLsqwbyBVXDY7IBhWuDwG
DWU1+KxNRUsNb5J1HGU/31EfVp4vdaQnZ0yHHx9LRwTcYSJgkXK+tHrfquH+5SQ7
fEbTLai903NE/2E2/OCZ3fJA0uuiwwhr7nVh9SDhFlglFUnmb2YuLZl9OKhtKTss
Fis7vn51hOLOOe3BAY1QFab8/MZ8gBG6/kxaKsf1X5PMXT3CVICGDLerIjFYSqa9
XajG/uYjvOvJWfT400Kkbh/xmXnQg+7TDeohwFvqgwVe32d+3iV4rFxDOklQYGms
VVT9Ahq82ZCjUoj4+21q0B1mI+5E6FwSh83u6ATe0aUD01vwlrsbnd9P3MlGtLeM
Rw86N9PlDnLbaG08s/74s/tJ98/f9ykiH5XelxbdXnfdY20GeUA=
=Bofb
-----END PGP SIGNATURE-----

--k2kejit4druie2cz--
