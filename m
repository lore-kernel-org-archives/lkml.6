Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1DFC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 22:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367BC20835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 22:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367BC20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbeJOGPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 02:15:42 -0400
Received: from sauhun.de ([88.99.104.3]:38450 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbeJOGPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 02:15:42 -0400
Received: from localhost (p54B33E30.dip0.t-ipconnect.de [84.179.62.48])
        by pokefinder.org (Postfix) with ESMTPSA id 9DD5F2C786F;
        Mon, 15 Oct 2018 00:33:11 +0200 (CEST)
Date:   Mon, 15 Oct 2018 00:33:11 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mmc: uniphier-sd: two bug-fixes
Message-ID: <20181014223311.GE3260@kunai>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Content-Disposition: inline
In-Reply-To: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> In further testing in uniphier-sd.c,
> I found my stupid mistakes.

I don't have the uniphier HW but I still had a look at these patches.
You never know if there is something interesting for SDHI in there :)

> Can you squash this series into
> 3fd784f745dd
> "mmc: uniphier-sd: add UniPhier SD/eMMC controller driver"
> if you have a chance to do rebase?

Please don't rebase! We actually develop on top of mmc/next and rebasing
creates a lot of pain because we lose the base for that work.


--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvDxCYACgkQFA3kzBSg
KbZz3w/8C+AjQKdK8RwipxwPj7yxXCIEz1arXMXn/FhWTo4KwFI0bwESKdFGDcrr
edcGkc7Eqj52t6Fs9onpc+mbOUfaMWhBIqHUJ5EJz4RMKhPVFFWgZDm+5nNCduJn
bCb+Z+g91ww6APySwxDxeE/PVUDbVa6X7inSDAaJUmdnWzl4EDjHPB9pKRLqNxEM
UMo8QQEyYFCvgfh5EDaQW5DYb8UpSHfcGQyCpDH9041V1E6ouQhVjuoMAzIU8Co0
qB2zV2+TcIDZXX5hHUfYoNwubWXQNJ8QPqhFzMutfZc9DItL3F92K4sht84HUZ2h
n0KHVvt0mkdsQ3rLKUuCatXdQONGxiMH5rTzmdK6+U5V6nb4F9cxL+eYs0C2mdDP
7Vdiuuh64D/d4nos5BQsrVrlDeMQ3vsIXTOOtaPa5PhmHp31JdrWn9ZbiiysdTaU
jaFcksIhMwWTV+EQ1bH5WEeNkUmKij40/5XFgboYrbNSobJdEqNo8P3qqhIfJrew
2nhhB03501bg0ph2Wh+rRBXLb+rWxqRRhXXJyFi0xO2qyjqtdA1UJjrofFKewbuv
Z3eIWKHfJ5yfibeJ5YKWdQ1LG9WIm4Gl37w3E5J6/jyAcZklTmEaTGOBaiT1uxlw
O/iLkAQQyZETT+dN5u3eC/6NW0MiXUNTO/1mZObCHC1surmEXo4=
=pbql
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
