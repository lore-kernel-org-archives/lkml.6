Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E87C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3A02086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3A02086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbeKJBuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:50:23 -0500
Received: from sauhun.de ([88.99.104.3]:46380 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbeKJBuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:50:23 -0500
Received: from localhost (p54B3380A.dip0.t-ipconnect.de [84.179.56.10])
        by pokefinder.org (Postfix) with ESMTPSA id 19DFE3E4486;
        Fri,  9 Nov 2018 17:09:09 +0100 (CET)
Date:   Fri, 9 Nov 2018 17:09:08 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Frank Lee <tiny.windzz@gmail.com>, peda@axentia.se,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: rk3x: fix some typo
Message-ID: <20181109160908.GJ1031@kunai>
References: <20181102124535.24331-1-tiny.windzz@gmail.com>
 <19a28033-9241-1f4e-97cd-7c6648a73c6d@axentia.se>
 <CAEExFWtQrPD8hUn15Add-EuueCL5=Crb+yvDckWejG75BExGug@mail.gmail.com>
 <12637568.SqdzpTGmKQ@phil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SBT+cnFS/G3NVgv4"
Content-Disposition: inline
In-Reply-To: <12637568.SqdzpTGmKQ@phil>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SBT+cnFS/G3NVgv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2018 at 01:01:33PM +0100, Heiko Stuebner wrote:
> Hi Yangtao, Peter,
>=20
> Am Montag, 5. November 2018, 16:59:58 CET schrieb Frank Lee:
> > I am sorry.
> > -- Yangtao
>=20
> If anything, it is me that should be sorry, as I did suggest the
> patch description, including the new spelling error.
>=20
> And it took me like the whole weekend to actually realize where the
> Calculated / Calculates error was hiding ;-) .

You guys are fun :) Anyhow, $subject is way too generic, that is the
real culprit here. I don't mind empty descriptions, so you can basically
move the message into the header.


--SBT+cnFS/G3NVgv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvlsSQACgkQFA3kzBSg
KbZszw//YZ3I1+X30cth1s8LYLSktuM1/NVu7Rtej+O2j5wjVhGABg5nj/WsIII1
9+bu4xZTrV+enypDy40JyCJp68d4BovOExFZJmckOXqCWwveKvjk6nLh1wqNRdfv
sVlfuD8BRTG4J8Lx9Y4yZCUtOISZAHlndoh9YxdtyASFzXEVzaZ9jm95ulBqXAH4
ll7LvsnYHhp5kxfbttWiUfsG5zkc5QgQ4IHBik6eh0p/F5Ls8ehoufgQfo+n6H8q
vnaKf1DYvxQnHOB+CJUO1Ls53uisfoyFDCf8LfrHoEL2gqIq5qnp0+kBv/95YVE9
Caj5om7c5lylGWnwr3CNyJwHbpBF7zBZSwkueoHIhRTYSye+64T1dpr+foRAy6Ns
CbOYO6D41Ag8ZyRwMKwrcFDetkm27Zgm5FkxBLq6MEU2qf2iZN3oul3egDtxrZys
Yke7Ng0FwCls59qZ1L4WMsiqtgQLwd5drfUYh60CNjkXTMx3+kaEbF0fqQpXgUs9
CvKKsPobqfTW8a2FrfRMSNus7HWt7gOh6cYR/0RwQAQDjjh/+5QmtgBpJNb6kdhM
WBB34KszLKkJaoF+EQjX0+EFfuy7lEd9MeVghbAG2Q19FONeDbtyGVbn5NOa9jXf
JhB6k4ziR1YhAaZBiDRG9amrOAl5bkOxd5GjS4jSP32YuIaYCZs=
=l63O
-----END PGP SIGNATURE-----

--SBT+cnFS/G3NVgv4--
