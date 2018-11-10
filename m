Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC2DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DA020858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DA020858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeKKCkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 21:40:03 -0500
Received: from anholt.net ([50.246.234.109]:50628 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbeKKCkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 21:40:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8A73610A135B;
        Sat, 10 Nov 2018 08:54:24 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 7gVrWui04D3k; Sat, 10 Nov 2018 08:54:23 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 6211710A0552;
        Sat, 10 Nov 2018 08:54:23 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id EF2402FE1B8F; Sat, 10 Nov 2018 08:54:22 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Simon Arlott <simon@arlott.org>
Subject: Re: [PATCH 05/17] clocksource: bcm2835: Switch to SPDX identifier
In-Reply-To: <1541863719-7244-1-git-send-email-stefan.wahren@i2se.com>
References: <1541863719-7244-1-git-send-email-stefan.wahren@i2se.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Sat, 10 Nov 2018 08:54:22 -0800
Message-ID: <87bm6wzxdt.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Adopt the SPDX license identifier headers to ease license compliance
> management. Also drop the FSF address.

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvnDT4ACgkQtdYpNtH8
nugvTBAAh+u769ozt4IIrKVMulhFUTOPg4cDzgWPbbqFoBIY0nK+x0qfxRpAUrv4
I0CEp36mEDn6ZeTjbsT1NdW3BIFMj2EmTw1gjlDTczkl9zZgZimuEogglvq08lKR
0hrFPxVIxP8WIMACSS6c8VtVEDgO4LpC5KuplmdaTH/wXEbAPuXkz9v9BWH4czOT
9YflRpRmhaRwNCnSl5AFZEbQ2qgLKdrAHKT4P3KCX0IEmVU+bMAXbQaidlGIy/+T
yOqVGAaHj9kWMYG2x4Swubn1TSavBMqw1/n1Y9XUB6Ld4tn1IsNPXcKIDOBSK7pf
/993TLrRj7dLZxUrD+4+DSqWmZ9yckuj+bYGz1vyJ1zSqav8cvD+xlXkh1Xmt0nQ
jkGMjrVu5YgIypLlyKCRywYEo5qXyNw+1IMf4CJf0g35nE1ttYDKuQIyOA26utmk
AOpu4L/dtKw7cj4gQOD00L3YRTNAnU6sjn1AXEgRxvIRzIaK4C30YiGFDiko7ilt
YCKtpfjTGyFzoSl3sUm1kAH94oXfZajaobN+97TVWobZ+YbEVEszvMkIBxNnBpQN
Hk1Gv2P9pOZy6bv5Xmy6p0NOPX7AxiMnE5RqZW4K7jD3b5LjI65GhvbulAyTUHcG
nQAKuhtPNLxg5rNolXKf7Tgv5YF3S2Z93ydMtbp7n3IkLN3RFd8=
=LkOg
-----END PGP SIGNATURE-----
--=-=-=--
