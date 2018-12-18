Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB001C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01CA21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeLRXrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:47:10 -0500
Received: from sauhun.de ([88.99.104.3]:50074 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbeLRXrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:47:10 -0500
Received: from localhost (p54B3362C.dip0.t-ipconnect.de [84.179.54.44])
        by pokefinder.org (Postfix) with ESMTPSA id 89A3B2E3542;
        Wed, 19 Dec 2018 00:47:08 +0100 (CET)
Date:   Wed, 19 Dec 2018 00:47:08 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Rosin <peda@axentia.se>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT 10/10] i2c: rcar: add suspend/resume support
Message-ID: <20181218234707.bpagrnelne5xwuot@ninjato>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-11-wsa+renesas@sang-engineering.com>
 <944a2523-aa40-eaf2-2c4a-d27254e7cbca@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2wd5zy6ly6ev5syp"
Content-Disposition: inline
In-Reply-To: <944a2523-aa40-eaf2-2c4a-d27254e7cbca@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2wd5zy6ly6ev5syp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Because the adapter will be set up before every transaction anyhow, we
> > just need to mark it as adapted to the I2C core.
>=20
> mark it as "suspended", not "adapted"?

Sure thing :D Thanks!


--2wd5zy6ly6ev5syp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwZhvsACgkQFA3kzBSg
KbbaJA/+Ob1YPSF6Xjksbil3XEOIkN0XoZ3Nj8E89hLT7tS3ctwAGg38gGTkA9jq
oh4UfWpqw6EkGle/mcg2NAzqjZgZssQ5zJnq7CbJKnAQqL5Ss35o7iWle3gCX5Wt
0ebH5rcksESYEsL3a+3r/jw4YRPllAJjna76uhX+rcQ3TeNxRzXfvHOUWErW90SD
PPwZjUQbk5ryO9hLzaHvOFst8eid7Cjv5EwZc6NAfxuHzg3BtDVooSeKdESDhUww
DyejT1aYuDOHbhSNqecz61QYxbORlaVTTbLPaaM8/9DPFnlUrGGDWr1THawwLN4C
0osmhb/MxPA3SFGkWliGbGPvhE4y+fT8+oBucsQWx+Rg8L/4JtqImhu3AY8WrVDN
9TXWFp1u75plrBfnuCrv6zfLE/qgXg8QljNRsBVgBeZe/dwZ2MPhICqxOF2FI3ZV
tblDZUUS7wRWom/eAwHt1+BlZ0IlDfx2+hZNTsDW7Gvdm5P82rQieior4RP7BJYo
f6p0UIJUARj3M3zhUC3frNiYvVF871b9AiBuXuqFElfAEnc29RoXO7PwChHwF9Xo
BLoi5V8t78NMAkOhx5R+FUiTxt2ur4O5qn0xeq9RDkIt1Z/7vNOfgiUeN3kKQLA0
QRnbOjrvBz3X7xxIRWqV/R1YSyGYCP1d56yHYhoT/RLJdDxnnFA=
=mlgw
-----END PGP SIGNATURE-----

--2wd5zy6ly6ev5syp--
