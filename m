Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F3BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A75B21A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391990AbfBOJDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:03:00 -0500
Received: from sauhun.de ([88.99.104.3]:60290 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731733AbfBOJDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:03:00 -0500
Received: from localhost (unknown [83.221.228.209])
        by pokefinder.org (Postfix) with ESMTPSA id E354F2E3551;
        Fri, 15 Feb 2019 10:02:57 +0100 (CET)
Date:   Fri, 15 Feb 2019 10:02:57 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Qii Wang <qii.wang@mediatek.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com, ryder.lee@mediatek.com,
        xinping.qian@mediatek.com, liguo.zhang@mediatek.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Message-ID: <20190215090257.geumssb2cucs7rzt@ninjato>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
 <20190205131641.GF12401@kunai>
 <1550109268.30065.13.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pzwi6i3t3hyzmfbc"
Content-Disposition: inline
In-Reply-To: <1550109268.30065.13.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pzwi6i3t3hyzmfbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 09:54:28AM +0800, Qii Wang wrote:
> On Tue, 2019-02-05 at 14:16 +0100, Wolfram Sang wrote:
> > > +  - mediatek,share-i3c: i3c controller can share i2c function.
> >=20
> > I am not happy with this binding. There must be a better way of using
> > the I3C controller in I2C mode. I think it would be easier to tell if we
> > had an I3C driver to see how it implements I2C fallback there. Is the
> > I3C driver on the way?
> >=20
>=20
> I am very sorry for the late reply due to the Chinese New Year holiday.

No worries. I hope you enjoyed the holidays!

> After confirmation, for I2C mode in I3C controller, we will push an I3C
> driver to implement I2C fallback there later, and we will remove
> "mediatek,share-i3c" for i2c controller driver in the next patch.

The problem with DT bindings is that you need to support them forever
once you introduced them. Because there might be old device trees on
boards out there which need the property. So, I don't like the idea of
having a temporary binding which is meant to be removed anyway. My take
is that you should just send out the I3C driver which will handle the
I2C support then.

Adding Rob to CC in case he has a different opinion.


--pzwi6i3t3hyzmfbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxmgEEACgkQFA3kzBSg
KbaYzQ/9GMVjiYKg0Awt5r1WZ23GftvsUaudHFYCqO3OuZ4iTC3cHFAvYIDxsUKh
1L/HNEup5EICTXVUe6AoFPe6MFyC4w8e7/00n2Nsj9mfTUFjaR/2DcRWqrR0kv4T
x48s/UmUVhe8PtRT7AbX3aKkA/Jm6puhFHPCjpaLaDX20mw35B/hLIJ7lkqmpce0
fN1R2Vuo2xGHueDHv4MBbtsTC4wcOTfPVJwNVfd6nOoDOhQX+UyAqYJyoQ8exaJM
QmCfPea170F4Ov6fLgrGilWqwiN9EQDbudmlZA8vt0dflDMG+Awt5rFgEpvfKlj0
Zndw5Kwi1NCCH6b4P/GcUOaTKcrNwwA7b7/A4/dQTIVcAx/WXM+ibKY7ZQz3mfAg
LgswXBgkDL3jx3gLjHWtYjc39KVzROIBed24BIX80F1G7tfvkkhshm9KJ7gi4yks
NA2CSlS4Ufgqb0LVgRGK7e6LEFVoBL4kMlMutSToiWdrwB1tJAdWj8F986EB4v9t
5BzNW9pjN922TqY0k2gtrhFcFGyeb1BP9rvobMaFHLLt31hCIp4gkuWln7TjMFtD
LiHknLpKMjHUUd4jib/5RRnXtIAmSh7dag/5zM3m7m+Jx4T2k8E5MCQ9eI4ZlGfm
Rw2Pno7LzRHIeS5oZBAVt2n4U2gfl/okiqdkP0d9kMF1z5vbduY=
=A+6v
-----END PGP SIGNATURE-----

--pzwi6i3t3hyzmfbc--
