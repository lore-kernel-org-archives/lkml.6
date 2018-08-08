Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8BEC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BAB21A53
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BAB21A53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbeHHWna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 18:43:30 -0400
Received: from sauhun.de ([88.99.104.3]:38086 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729703AbeHHWna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 18:43:30 -0400
Received: from localhost (p54B334CC.dip0.t-ipconnect.de [84.179.52.204])
        by pokefinder.org (Postfix) with ESMTPSA id 562B16DC2E4;
        Wed,  8 Aug 2018 22:22:11 +0200 (CEST)
Date:   Wed, 8 Aug 2018 22:22:10 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH v3 1/6] i2c: designware: use generic table matching
Message-ID: <20180808202210.qkocl4hckqla7exe@ninjato>
References: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
 <20180806185412.7210-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qebv7hyem3d6rgy2"
Content-Disposition: inline
In-Reply-To: <20180806185412.7210-2-alexandre.belloni@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qebv7hyem3d6rgy2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 06, 2018 at 08:54:07PM +0200, Alexandre Belloni wrote:
> Switch to device_get_match_data in probe to match the device specific data
> instead of using the acpi specific function.
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Andy, you happy with this patch?


--qebv7hyem3d6rgy2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltrUPIACgkQFA3kzBSg
KbaIaxAAglFXoMQYzEDtLC4xW5R2IY/3q0HtEncf4ExyKGuclwPtfaEN0ECDPC14
96nZJednR4FDHm25y5ThZtGyllbm4YNomkQzSJgoplSNCuMZdnEmAOC5+XJilbTH
oLwxhVrc/txYTAzRVbFgfCGReziyHPzBJjOw1jd8cmjFlTSjBwzS5FtzFYnVd+Fi
yddQjjAJsvj/WFa8KdQ41Nmq6mUYosldUFQYfQ4kXREj1Kk9f0cdsF0Re6fjkC9S
ZrFQI7zeooRVE+Tas5l9umdg0aIPJDdyVEKGLAGOU/HpyB4R5nvr3KHDvGaqqlAt
/SE3vTuf2s0fJdR28vjxkekwMSZawFlcQ8vOhUtDOWJUzJdsTRiXHkBRb6wOY+wx
dYLN1mWx6yq5TDnIYSf3JCi2m4uz8y/7q0P3l6Wcs8Z1LYJo0xNTMrCWzrrxCMGO
1cA4qpJ1S7LqMFIS/scDO83TEpsOkKunozNBqElNGRdnMyTgZznysFAPn9dKiBx3
BQS2xfGl/rlWsXZaKaqoKjrIk2rl2pP1BbMtDi3dB3C7lLfLlCLkd8bzL1t/+CFN
tugPZcQJwVMeIYnjR6hK89RiupqPRtqs1UH1bnCie6P2kTubOd2Wvt4UaQ57alTj
BWwI/55tMlFCGldsGApZao/0vJ36jwNZVmM9x743o094tAN7HtM=
=t7TX
-----END PGP SIGNATURE-----

--qebv7hyem3d6rgy2--
