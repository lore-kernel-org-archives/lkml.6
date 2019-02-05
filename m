Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73F7C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70B0206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfBENQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:16:44 -0500
Received: from sauhun.de ([88.99.104.3]:57518 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfBENQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:16:44 -0500
Received: from localhost (unknown [46.183.103.8])
        by pokefinder.org (Postfix) with ESMTPSA id CD58C2C0509;
        Tue,  5 Feb 2019 14:16:41 +0100 (CET)
Date:   Tue, 5 Feb 2019 14:16:41 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     qii wang <qii.wang@mediatek.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com, ryder.lee@mediatek.com,
        xinping.qian@mediatek.com, liguo.zhang@mediatek.com
Subject: Re: [PATCH v3 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Message-ID: <20190205131641.GF12401@kunai>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qftxBdZWiueWNAVY"
Content-Disposition: inline
In-Reply-To: <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +  - mediatek,share-i3c: i3c controller can share i2c function.

I am not happy with this binding. There must be a better way of using
the I3C controller in I2C mode. I think it would be easier to tell if we
had an I3C driver to see how it implements I2C fallback there. Is the
I3C driver on the way?


--qftxBdZWiueWNAVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxZjLUACgkQFA3kzBSg
KbZ3kw/+MPQnVnSHx074f3k4k9AbHCPpsJjFvArfPHwjRjIzGcf8jm/qxMrSppV5
Jjhbjy4VBTdXWt27pyjEhZyc/cypfl+PgCypWi51nvXor7AVu+Cn0oKPeSvQM6QF
6LnUyxnQ+g2gLPM0iZR4QyiY34YVGY3XL6hYcsNFYsX5ezVgFmlH1Rc7m2K1b5KT
CdKaULa8YvRaBfEdCJr3vxszVr8dJXocollbbbWFxTM7O6mIeSKhJ2nG8PiZVhYc
gA6wKFyS+RQrIwRZSAUXvuP6haDpWMzzUCJ6WvHiByGwnuXKq1lk9d4IBe7qjqx4
M8o0gX+uyCV28q6EeUn4s7hWMVp8YL/bjyaVlwmtphNypRRBs9iqeIhSsJ1LdvWD
8m5eTFDdRE2cWfbAM4XfKQ2KPOYVQlVsCo5NFFN28xzfGzFrp1ilIaw1rbM+8nYH
pf942Oxyk2cjoxJJv/O2xoJckESWcNfX7snlYiyFJcGhSQITn/FcFQQSc2uKNX8Q
1hByqi4GD2B2U9lwSWGaiu5yuz3kgwYpcqc0hED7dkOS9dk7vDIGuV88dZS5jo09
rIcU1UwVtCSWLtoIMLVc+PYZEsjtmmlx7293W3BWZjBAoLVUQpPVrdUAl1vM93Lp
NQi1oxly7GIeo2AvFM83rdiI1bcmndZv5yZwgCpbPl0Bf5XgdHY=
=/6Dp
-----END PGP SIGNATURE-----

--qftxBdZWiueWNAVY--
