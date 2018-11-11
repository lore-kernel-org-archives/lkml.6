Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82E8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7537E214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7537E214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390350AbeKLIWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:10 -0500
Received: from sauhun.de ([88.99.104.3]:35674 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390257AbeKLIWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:07 -0500
Received: from localhost (p54B33AC0.dip0.t-ipconnect.de [84.179.58.192])
        by pokefinder.org (Postfix) with ESMTPSA id 837F03E4486;
        Sun, 11 Nov 2018 23:32:07 +0100 (CET)
Date:   Sun, 11 Nov 2018 23:32:06 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i2c@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        peda@axentia.se, brgl@bgdev.pl
Subject: Re: [PULL REQUEST] i2c for 4.20
Message-ID: <20181111223206.GA1439@kunai>
References: <20181110112036.GA5905@kunai>
 <CAHk-=wgAJXs32MZNWNO9HjMmgtV9kWmDvjQS7zcFg0PVgJyHog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgAJXs32MZNWNO9HjMmgtV9kWmDvjQS7zcFg0PVgJyHog@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> people able to use a machine at all. So in practice, the "new driver"
> rule has become a "new ID or quirk" rule.

Got it. Will keep it in mind. Thanks!


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvoreIACgkQFA3kzBSg
Kba3NBAApr+gYMeyvRr8MYMXNQZjCzlGeIG4xI6VWk5qEvQhlY/PRbwmAXCPBzj1
jDstNUW9H5oludOjnUn/7GUZczAxuupVTsocBR35AVz7IpMtnSXjmcH13ZMY62cC
hEQu79xy39oOfBbVt5bvIzRqWzbALN3RW+DsbXMd6BFwYrZCbLhili4zNHEzGIE5
A7WO64Y6M0VGoqQGeYOv6H25L0xarB0LJJbIyRazqukVCtj67YVPJ24sJKzVFJ96
vAh6McBleOVbOgx6+70PJgx6fe8mF0GHiIhdMAEkayml8YB/xbk//VPnoO6Qo9z6
NrvKUUV9zApcuLowqNdNrjXyKVq0EOBz400tYr+bUzcBIRbalBHz0Afnnk6BCBS4
xcuKRsZz6q5egsyamLDuRxYFE3+gu10BHawrsWvL39iizRSpqizhe6tz3RKHH8ZV
pJ9OMzyC422G3GpvhVU391QjH7lTr4cnmR3FG/pW6J+KPf5Boqu8y4d/zp4hI154
0o7zGr2AXzQ70zikAXYvxvBs6tPCq8Eu6HUw7FZSNpyWYQoABPDaab0Si2gILMHd
5qD6CIBnUw0yyUbqx8ZlZttpMLN4wAFW1Eox/zaQCDT8xOprnpYGHO8l2oaZdkvr
bJRDrKakQXzlNuKpftMZAEhm65YvvyUkCKt8rHAdOsVmiBTt+YY=
=JNJ9
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
