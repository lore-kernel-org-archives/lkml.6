Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203B0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 12:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65E721B18
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 12:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfBPM3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 07:29:19 -0500
Received: from sauhun.de ([88.99.104.3]:42650 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbfBPM3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 07:29:18 -0500
Received: from localhost (unknown [195.52.228.164])
        by pokefinder.org (Postfix) with ESMTPSA id 9483F2C0509;
        Sat, 16 Feb 2019 13:29:16 +0100 (CET)
Date:   Sat, 16 Feb 2019 13:29:15 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Qii Wang <qii.wang@mediatek.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com, ryder.lee@mediatek.com,
        xinping.qian@mediatek.com, liguo.zhang@mediatek.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Message-ID: <20190216122915.hchghozcn7ntdkbm@ninjato>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
 <20190205131641.GF12401@kunai>
 <1550109268.30065.13.camel@mhfsdcap03>
 <20190215090257.geumssb2cucs7rzt@ninjato>
 <1550316723.30065.44.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uvl5pgprc2c6iamr"
Content-Disposition: inline
In-Reply-To: <1550316723.30065.44.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uvl5pgprc2c6iamr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Maybe you think that MT8183 SoC only has the I3C controllers. Actually,
> there are I2C and I3C controllers on MT8183 SoC. We will remove
> "mediatek,share-i3c" for I2C controller driver, so these patches are
> just to support the I2C controllers on MT8183 SoC. For the I3C
> controller we will send some new patches which are based on i3c
> framework directories(kernel/drivers/i3c), not based on
> i2c-mt65xx.c.

Sounds perfect to me. If it turns out that the I3C driver can share
things with the I2C driver, we can discuss it then. But unless we have
an I3C driver and know for sure, the above strategy seems good to me.


--uvl5pgprc2c6iamr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxoAhcACgkQFA3kzBSg
KbZX6Q//fbtn+bsK5KVjERP9EokrSE8Pn/Q8MsFHFKLxQm2ZQsc2yMzOu0YUYvnF
X531Roh9TkDU3SkJL/xnERFtamDianlugO11qGRxvJnSGCjrUDogHdw8awM6BE1e
G01y8agD7lRVmrZb3AidW9HAfgCBalucvrKovIQSkvvhvnCglVnZHBpwmQwFEZ/E
NlB20w8KdvAKNXeT8GgxsjFBfanSHAHOTJKUcnkeO4Lg10TDlnh85c1FGcuOmbcE
j0yvYzcFIUJ5Xdw1f0BVG12RDuN0pOSN/FuVDZRBb/FkOJx+CIb62jJiieCYVTMl
/jwL6gkGbyZyo2YJJ/P6twDzxXE3JtjP1gtnN9FPBVFOeaWN3qoabOM/aO1iWlZM
K2hsLVorxvdHedrDEqwNFawEFSF0Y2sdPCndwlgKRqRcdJRh4f5VzPNXTxDmPeQI
5zubdYEA1dE8NfX3xM4/05/vBNK9JDwj+U5EczvGL7PI+q8n5X/QoQqu7x6tWMq8
D9VMUWRpM6usbQ52gt/hQi08taNuaxP4BQJkDduDVZ/x09aAdKrKDStwtwhIABH1
gnLt/3qJqEo6o2LM6fpK/hvhUgjiZ5KlTJ/RylosAcAbRkho4lFwI6AyzEGRFGHe
lntFJiamVASorn7fg4GVdNNJAzVsNTIdVcSJfxij5TjtbqVjiBg=
=2hOh
-----END PGP SIGNATURE-----

--uvl5pgprc2c6iamr--
