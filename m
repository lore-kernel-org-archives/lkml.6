Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C6FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD8820858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD8820858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeKKCkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 21:40:14 -0500
Received: from anholt.net ([50.246.234.109]:50648 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbeKKCkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 21:40:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id DB14310A138E;
        Sat, 10 Nov 2018 08:54:34 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id UT4yvY_FpbIH; Sat, 10 Nov 2018 08:54:33 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id D56EB10A0552;
        Sat, 10 Nov 2018 08:54:33 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 7A3B92FE1B8F; Sat, 10 Nov 2018 08:54:33 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Kauer <florian.kauer@koalo.de>
Subject: Re: [PATCH 06/17] dma: bcm2835: Switch to SPDX identifier
In-Reply-To: <1541864080-7320-1-git-send-email-stefan.wahren@i2se.com>
References: <1541864080-7320-1-git-send-email-stefan.wahren@i2se.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Sat, 10 Nov 2018 08:54:33 -0800
Message-ID: <878t20zxdi.fsf@anholt.net>
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
> management.

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvnDUkACgkQtdYpNtH8
nuizxQ//cec+xGDsG0DVAm31B/52Mfl+Zglk7RKw01I9J0S/rey+w21gJ6UoWwuh
CS+Y1hE6VEtC0iGihwI+Nei8xYGrS7QoGSP1uU6CzVt6ND0JpHG+CeZx45GnzWq8
2Xg0YWx5L+X/Y9P4Tb07+oyG/AGSD5gjR8ecVHx6uqpqFdNx2owGkf+DJWemcCjW
dt5943XtGOsI+0vCA4jZkOTKSSY3ciwV8cY3t1dMP5g/ecl/q1ZROhGOU6f1rsl8
1iMQVwFS7kUgS/QBN+y6EY5rWZ43DxARth7Vdqthi/W5o6ClNnIupgswJ1UOlb+3
yzfHI0HW/ry7l7z6ce3+xxUmWNQDfdH8wr82V/TMzNDIa2VRu+hGMUrqLYhohgmc
WqwMsIWDr3Z38tVu+g/+j2oWEVqRvgSaH8iiJLCLTNbkvHAy6RHoz2ZKs8R+4Yiq
vDzd8tkc8bok/yPzxqUhc4BX8qPtKiAocThOMJUFWxPsmQmj8CZW9fYKpLMdRHNp
Il/OMfK2fIaQpwaPRarDveDhrgSZ/ujfuzbQOQBvj3pN4W/n82zBZiKcWsXVPyT4
ASs0KHfn7toPXQJ19bxhKZp0k/a78krkS74qG/hqtxLaoURUt3DpKZg4evYAicGF
s0nQHVyUQQR5KGAZ0n6gSUTgzsJj/podXstZKPPpe329nHSMnXE=
=jAg1
-----END PGP SIGNATURE-----
--=-=-=--
