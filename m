Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A4EC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5457E207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfBENKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:10:22 -0500
Received: from sauhun.de ([88.99.104.3]:57438 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfBENKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:10:22 -0500
Received: from localhost (unknown [46.183.103.8])
        by pokefinder.org (Postfix) with ESMTPSA id 7322A2C0509;
        Tue,  5 Feb 2019 14:10:20 +0100 (CET)
Date:   Tue, 5 Feb 2019 14:10:19 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     qii wang <qii.wang@mediatek.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com, ryder.lee@mediatek.com,
        xinping.qian@mediatek.com, liguo.zhang@mediatek.com
Subject: Re: [PATCH v3 1/6] dt-bindings: i2c: Add Mediatek MT7629 i2c binding
Message-ID: <20190205131019.GC12401@kunai>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-2-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <1548057574-8061-2-git-send-email-qii.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2019 at 03:59:29PM +0800, qii wang wrote:
> Add MT7629 i2c binding to binding file.
>=20
> Signed-off-by: qii wang <qii.wang@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to for-next, thanks!


--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxZizsACgkQFA3kzBSg
KbaOBhAAn5gQBSiH1zVHGMVVEsoQ/iM3aRvgJzIe+Kw2ewEd7DgSUl2MfFHDeKO/
GAnml9dH6/28H68FMncaHXzgCasUBM2Kuigbdbhhrhe3pbojdmH4+bkWCYvg5wU8
yC1S85m8C2T4xuvYm7ZvM4A+ieo98xyki7rRIkAwdDRppGo7AUQav1ZH5GhWj33o
DeFJD9gKK9AYNN/5qOnYIpA8AmpFSRJ7t2cTNZ6Ykyo1nSwHs/DebJ46U10uoOwI
SKReqsDzPj3b938asqh8EPVgcaRZTjQhY/BnL0I8kHL4jvBZLICNNsoJOneRnuMO
mYOjOdI9rps9vv54HddOji5BtLmqEiB8Dj/4bmo7SPvdJyJJoCOCA3DOaS0VPK/N
bS72M3axP3nGa1g8WxlQqv4qGBBf1Xx4tmzpMQ0tQqDPx33Vpmvfr0Ka+ZHqYfte
FF1fiO79hKG48G1itlJE3iXV8AwPlD4YiBBOYxk0gQu/alWDaF4bVKeKI8hFDkFt
w2V3/a+5/EOMWHHzGePqiZdzifw1ugK6cTK4Q2Q6obFfkSayp9kfUjTYal08OM6Z
cyFdtGEuhefi774hr3QfR2oFcBKUQiz1TSk2zn0wE3g16UdOi3XiBEecQCIOPrsb
XLB80WMrseoVQiCUCqDqKqU4zyEeynKHHqXPO5OACATXNpHIiAM=
=LkO+
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
