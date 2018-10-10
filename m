Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EFFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4909F2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4909F2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rwth-aachen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJJSOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:14:07 -0400
Received: from mail-out-1.itc.rwth-aachen.de ([134.130.5.46]:57909 "EHLO
        mail-out-1.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbeJJSOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:14:06 -0400
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Oct 2018 14:14:04 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AEAAB41r1b/54agoZkGgEBAQEBAgEBA?=
 =?us-ascii?q?QEHAgEBAQGBUQUBAQEBCwGBWyqCDQqMAIwzgg2NXIkigXoIBAEshEAChEohNA0?=
 =?us-ascii?q?NAQMBAQIBAQJtKIU5AQEBAQMnUhALFQMJJQ8BRwYOBYJWTIIBBKVDM4oUCQGCY?=
 =?us-ascii?q?4hNgheEJIpWAohchhSPFgcCgQqPXgmJFIZulWUCAgICCQIUgUI4gVVxgzuCJhe?=
 =?us-ascii?q?OGm16HIoWAYEeAQE?=
X-IPAS-Result: =?us-ascii?q?A2AEAAB41r1b/54agoZkGgEBAQEBAgEBAQEHAgEBAQGBUQU?=
 =?us-ascii?q?BAQEBCwGBWyqCDQqMAIwzgg2NXIkigXoIBAEshEAChEohNA0NAQMBAQIBAQJtK?=
 =?us-ascii?q?IU5AQEBAQMnUhALFQMJJQ8BRwYOBYJWTIIBBKVDM4oUCQGCY4hNgheEJIpWAoh?=
 =?us-ascii?q?chhSPFgcCgQqPXgmJFIZulWUCAgICCQIUgUI4gVVxgzuCJheOGm16HIoWAYEeA?=
 =?us-ascii?q?QE?=
X-IronPort-AV: E=Sophos;i="5.54,364,1534802400"; 
   d="asc'?scan'208";a="58080132"
Received: from rwthex-w2-a.rwth-ad.de ([134.130.26.158])
  by mail-in-1.itc.rwth-aachen.de with ESMTP; 10 Oct 2018 12:42:45 +0200
Received: from pebbles.localnet (93.135.162.176) by rwthex-w2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1531.3; Wed, 10
 Oct 2018 12:42:44 +0200
From:   Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
To:     Colin King <colin.king@canonical.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ina2xx: fix missing break statement
Date:   Wed, 10 Oct 2018 12:42:39 +0200
Message-ID: <1884341.stJYpOWv9L@pebbles>
In-Reply-To: <20181008210904.9362-1-colin.king@canonical.com>
References: <20181008210904.9362-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2861461.cQNSvQuZq1";
        micalg=pgp-sha1; protocol="application/pgp-signature"
X-Originating-IP: [93.135.162.176]
X-ClientProxiedBy: rwthex-w1-a.rwth-ad.de (2a00:8a60:1:e500::26:156) To
 rwthex-w2-a.rwth-ad.de (2a00:8a60:1:e500::26:158)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2861461.cQNSvQuZq1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Montag, 8. Oktober 2018 23:09:04 CEST Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The IIO_CHAN_INFO_SCALE case is missing a break statement and in
> the unlikely event that chan->address is not matched in the nested
> switch statement then the code falls through to the following
> IIO_CHAN_INFO_HARDWAREGAIN case.  Fix this by adding the missing
> break.   While we are fixing this, it's probably a good idea to
> add in a break statement to the IIO_CHAN_INFO_HARDWAREGAIN case
> too (this is a moot point).
>=20
> Detected by CoverityScan, CID#1462408 ("Missing break in switch")

Although it is good for code clarity to add a break statement, the code can=
=20
never return anything but -EINVAL in case chan->address is not handled in=20
IIO_CHAN_INFO_SCALE:

=2D----
switch (mask) {
case IIO_CHAN_INFO_SCALE:
   switch (chan->address) {
       case INA2XX_SHUNT_VOLTAGE:
       ... return IIO_VAL_FRACTIONAL;
      =20
       case INA2XX_BUS_VOLTAGE:
       ... return IIO_VAL_FRACTIONAL;

       case INA2XX_CURRENT:
       ... return IIO_VAL_FRACTIONAL;

       case INA2XX_POWER:
       ... return IIO_VAL_FRACTIONAL;
   }

case IIO_CHAN_INFO_HARDWAREGAIN:
   switch (chan->address) {
       case INA2XX_SHUNT_VOLTAGE:
       ... return IIO_VAL_FRACTIONAL;
      =20
       case INA2XX_BUS_VOLTAGE:
       ... return IIO_VAL_INT;
   }
}
return -EINVAL;
=2D----

The addresses handled in INFO_HARDWAREGAIN is a subset of the ones in=20
INFO_SCALE.

I would prefer an early "return -EINVAL" here, as it matches better with th=
e=20
other "switch (mask)" cases above.

Kind regards,

Stefan

=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart2861461.cQNSvQuZq1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCW73XnwAKCRBvf0o9jP6q
U+v6AJ0fqP/18bNgvBNmMmSjj/o+/TqETwCgjjEq7OPNj2nTtY7xnhYLGS/hkPk=
=jrU5
-----END PGP SIGNATURE-----

--nextPart2861461.cQNSvQuZq1--
