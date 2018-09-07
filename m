Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED25C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822A32077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822A32077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbeIGP57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:57:59 -0400
Received: from sauhun.de ([88.99.104.3]:53078 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbeIGP57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:57:59 -0400
Received: from localhost (p54B3324C.dip0.t-ipconnect.de [84.179.50.76])
        by pokefinder.org (Postfix) with ESMTPSA id 07B1F2C27DA;
        Fri,  7 Sep 2018 13:17:28 +0200 (CEST)
Date:   Fri, 7 Sep 2018 13:17:28 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        linux-i2c@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Heiko Schocher <hs@denx.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        u-boot@lists.denx.de, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] i2c: xiic: Record xilinx i2c with Zynq fragment
Message-ID: <20180907111728.GC2310@kunai>
References: <a36257084b0816bd84bb1caacdcde586b7fcb007.1536300108.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline
In-Reply-To: <a36257084b0816bd84bb1caacdcde586b7fcb007.1536300108.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 08:02:05AM +0200, Michal Simek wrote:
> Include xilinx soft i2c controller to Zynq fragment to make clear who is
> responsible for it.
>=20
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Applied to for-current, thanks!


--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluSXkQACgkQFA3kzBSg
KbZdsBAAjInnEoE4WFpRMK5NcJ4eCUG213dAZV7RbKw94ETLqSf3Nq1rTsCsMeMv
0wUjQ97B4KYBQeQigmaCzfJRv19sLBirxqUb1ahgx8xfMcwALiBRIZPa/lfPel/r
z0fFwd+2CQpzg6kNnJY2MRxXChi+vdhUIcFTB/cbXdkhvLL6amMqKG6CC9Qduas1
5WRXDqCFKwYl20/F/akVQYpVHmAFvMAhxmq8XelwBqTIzQBtSjsyuAZ+aQnIBCjB
+t74ssbj2P1WaQHpoYLEZanK+bA/zcLY2D3WrskH4Tfh28BXE5OXIdUMDGlWBe0F
MHTgDzxW7h6e/CILsZQRBPrHQQCXtdSOpaNl2KavVDfGIgJMQ2EtCOQadCVRMxO0
cuhrYIP71UrVwRXT8QYtQhNmJMBGNNRXIhqaFNQZFCPkA3ofJvdQJvEV7Xf7+VT3
DBoHli2CtcdU18vlvtTCaz9ErLzV6IGQxLNMRLvb4Zp27VdjrAZ0mpERuh5ZN36J
bVY9XwIw+r9PzSAWwqAFavQKVI/xlQWtvbrwvJw/mx0vthiZHm1En2Es1Yl+G3bN
bv/fJlWqurO4IWhy7ePVQ9BqCgoBHHeBfNHweVX2dmi/Bfk3mDkOfVT0i6Z+CfXe
9yxfRRfCgHPXfESBXbCIvbI6S/X7RRFI0hpyS6lSYgooE41FFlg=
=/WX+
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
