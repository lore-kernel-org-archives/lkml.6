Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76032C0044B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E44920858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E44920858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeKKCjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 21:39:15 -0500
Received: from anholt.net ([50.246.234.109]:50596 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbeKKCjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 21:39:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8CAA710A135C;
        Sat, 10 Nov 2018 08:53:36 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id OYMMyF6JM76r; Sat, 10 Nov 2018 08:53:35 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 765AE10A130F;
        Sat, 10 Nov 2018 08:53:35 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 158D72FE1B8F; Sat, 10 Nov 2018 08:53:35 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Simon Arlott <simon@arlott.org>,
        Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 04/17] clk: bcm2835: Switch to SPDX identifier
In-Reply-To: <1541862755-7034-1-git-send-email-stefan.wahren@i2se.com>
References: <1541862755-7034-1-git-send-email-stefan.wahren@i2se.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Sat, 10 Nov 2018 08:53:34 -0800
Message-ID: <87efbszxf5.fsf@anholt.net>
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

iQIyBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvnDQ4ACgkQtdYpNtH8
nuj+vw/4kJGMoiX3par3Riv/+DLGbm8gbE6fLzhInZLBPBa9E3xpFqmqAABsdL36
0BzTVOVJfXabFss4IikM6bZP6zXRdjHVNJue4r8DOVN5nlYWFkmJf+sO5YKpSiuG
E/EoxoKutKsA6dBNjttaDe1OjBeM1VmHlosREtCEnSEiQJeU8Jy/99HxiN0GDivT
zK2nn2fjlxWLLXMi/4Tb6fj39a1s2PtgwajW80BLMYWOeerNT6MhQ9UlaOiOkL6s
NcwYeSTddHH9F2oqRl1ObpdvpmEkSxlqA92UqOWJiagyoIai//9E3CoORLhIFIfV
i0/YsFv2LrdOS1oSNH12cJxgVLE6zPLlyynLYTRnCCJ3kLS8jGsJ/mcv7O/aDUW+
Cp0VYDyim37VzFhN2TjN8Rhhu067w3cpKy0cOL+eaMwERPa2qcvYsb9ZRKG+uIJh
MjYeQWaaGxUcI2Qd2xG5sFpgnjP+hSn6+p7grwts1i0FVeZhn7JtQ4xmitAhTrlE
UevjkaIPCdiZ8U0lZ/tIdEkAFdgcteZ646KpV7+qL2w8bR2vyy+YMmN2DYVrbmYF
v2+UlOwlhi+IhZ6Tw5xJu3Q75xlY/19Vr+NHyaFFlvHZ/jBPW2eV8LFRD2W9KvdG
Cd7oem8DonELkGLhxf8uV2OZf8cbeAAZN3i96nVDF+1ehty6gg==
=M8hO
-----END PGP SIGNATURE-----
--=-=-=--
