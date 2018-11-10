Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD47C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A4720858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A4720858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbeKKCkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 21:40:43 -0500
Received: from anholt.net ([50.246.234.109]:50698 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbeKKCkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 21:40:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 5991410A139B;
        Sat, 10 Nov 2018 08:55:04 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 9SrXJhKIKKoc; Sat, 10 Nov 2018 08:55:03 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 7D50810A0FA0;
        Sat, 10 Nov 2018 08:55:03 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 0FB502FE1B8F; Sat, 10 Nov 2018 08:55:03 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Simon Arlott <simon@arlott.org>
Subject: Re: [PATCH 09/17] irqchip: bcm283x: Switch to SPDX identifier
In-Reply-To: <1541865263-7571-1-git-send-email-stefan.wahren@i2se.com>
References: <1541865263-7571-1-git-send-email-stefan.wahren@i2se.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Sat, 10 Nov 2018 08:55:02 -0800
Message-ID: <8736s8zxcp.fsf@anholt.net>
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

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvnDWYACgkQtdYpNtH8
nuj12BAAmWto+k/y7eO6p+49Nb4/Sn6LREIv1UoBnL3Kweh9n6MZGyyLgGXBITZb
PB7iuJ6jeFa/5B89p+W4BIlkuWaNyTI49iGS90Ls/MJqOjHOlucZQEwXlz6nWquL
mOYRvJXw784ubkn9JJH9/+emHaSCgbdAdLFpmD75nHYSFg8t30NSkhfDJik9x09K
NaEJ9HCXPpBAy/yJ3E6YjkdHOEUErzsEXdQxl2vL0kqXqljVW78TMyzTN8y4VyCP
aqRj2krHEDV+DTLL5eSyZgz/NYxOLL1/tiUKIlYXq5wh2FM8qBLKG4uv8DV/iq37
61VR/jRnXsa6nJg6JF73qMTlbQ8qGbkOjmfK0J/MYBW0y26Jm0NRG2VlP7fMUk6A
QE2dtij6+xfV7XN/vkcq83Lz9+j+UBQ1mbFsRkO0+z0YUP9vppwT4q2mlsBRDxBz
cKTIFAZR9lacl3PgvZSJ501w/jKZPtTvyM0eBf8oOZfHDx2WOIDrEaEJF91NqAVA
YfL81kEA58sbtPzk/zdklNq5cRwgi7rUEJ/eVDczarBIGMMXaSl64+yTY6uwH614
DuYn/r4eCduhGAqLtjRmfY3iY9x+NIpF5F175ePlq+IkrtOlgFax5ol1kviXGnNS
rGvSlugDH4ikaFbQ7PYs19InTkFBNnbLUVjv+KMDt+1lP9KWNaM=
=zrrT
-----END PGP SIGNATURE-----
--=-=-=--
