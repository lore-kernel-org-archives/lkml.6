Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F2EECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741962075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741962075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbeGRQPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:15:17 -0400
Received: from sauhun.de ([88.99.104.3]:43374 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731193AbeGRQPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:15:17 -0400
Received: from localhost (p54B335A7.dip0.t-ipconnect.de [84.179.53.167])
        by pokefinder.org (Postfix) with ESMTPSA id 7A4935E0581;
        Wed, 18 Jul 2018 17:36:48 +0200 (CEST)
Date:   Wed, 18 Jul 2018 17:36:48 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH -next v4 3/3] media: ov9650: use SCCB regmap
Message-ID: <20180718153648.afjc7uflae2fryh2@ninjato>
References: <1531756070-8560-1-git-send-email-akinobu.mita@gmail.com>
 <1531756070-8560-4-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ajmgruggxs5tkc2q"
Content-Disposition: inline
In-Reply-To: <1531756070-8560-4-git-send-email-akinobu.mita@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ajmgruggxs5tkc2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 17, 2018 at 12:47:50AM +0900, Akinobu Mita wrote:
> Convert ov965x register access to use SCCB regmap.
>=20
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Again, for the I2C parts:

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--ajmgruggxs5tkc2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltPXo8ACgkQFA3kzBSg
KbazUQ/9E4kN278MPTq57ySF7VFeiZnvZxzDikIwtuO4MboxLecxiZpMA7sb8Diy
P9tr+t6daN4OptBb2QGQs010vu4ynITPczxm/4XLoBUPwFWbjFIQfipmwdSIAX9Y
4fek+/Q4LRfLubRlYkjEz9TegKQFypbIHKw/jmYqqkgfILR08LeOISFsXIWcv534
nSyZCdzsEirYOK/gRSnRI8+ShMhEAbfgopfW8n/iofTBDC4J9VLEGohpTJYE/BNC
TidSDbRGUdqUe5706KsNAq3ZZ+P/DUKywntj55sGgWHoxImc/dE67fkd6vVZYT/h
TFqMLG6GULtwj/u+f6SEL8RCz8JHnQCKu+O1b06OJe8uiB1KcPy4lkt0C78SAhWa
HpPd1WhPxNGcigsukLsTstC13JtMwaU+I75RcsJq1dxZsZcUS6CtlnRVTWjqiq/n
D8wfGxLAi3UJrUwJ6bzwtKq71MEn8BKJ/yJKk3EwOI5zf2qG8M4Cthn52ovIeDWM
MNCEIb6zr0Q/MCZih5la0Dldejz/C/xd/ikbN35GqKCxiBB/qHsjIVYRcONZB7/2
1vSQ1Z22h9ECIIMBuy9vgLNX1s+043i+CKSJSRn62MRkyYnHpGqkvb2sExFdh4zy
R/6aW5w/nmdUTUtk+HQZOGydHb8B5OcFWZ9LlpbjxwD1MliCgXk=
=p+4x
-----END PGP SIGNATURE-----

--ajmgruggxs5tkc2q--
