Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB3FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0886E20858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0886E20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeKKCk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 21:40:58 -0500
Received: from anholt.net ([50.246.234.109]:50726 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbeKKCk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 21:40:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id B042E10A13B9;
        Sat, 10 Nov 2018 08:55:18 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id MKAGQuxjOvt0; Sat, 10 Nov 2018 08:55:17 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id B5BA810A0FA0;
        Sat, 10 Nov 2018 08:55:17 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 4BB792FE1B8F; Sat, 10 Nov 2018 08:55:17 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 10/17] mailbox: bcm2835: Switch to SPDX identifier
In-Reply-To: <1541865555-7647-1-git-send-email-stefan.wahren@i2se.com>
References: <1541865555-7647-1-git-send-email-stefan.wahren@i2se.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Sat, 10 Nov 2018 08:55:17 -0800
Message-ID: <87zhugyiru.fsf@anholt.net>
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

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvnDXUACgkQtdYpNtH8
nuhHMQ//QISujNSw4lSwEkeir2kajRj1QKgmF2HfpHJg/gggXWS7i/teP7uozwma
gTWZw9U4Ii7esKwTB3OnMwNJLkklmyQ6kyx4WyO1u5Vfa1He16GYcvnhu4+18jyI
4O3SnMXG6dccVJrDkUDMx6BBc2bj68A2JPp8BPrQyrkTi/Zf0oDbpKpDCS20KDLA
vaNmj+laQiPBz9TlKll/YyeB/cz8QKxU2OvhSvxcXPH2pKcixehxFL5epVoTy5Vx
I8msySs/HSJ1xi4BgJ02S5RycYOzKEb929Cj4f9xdWn+4PPmkQCab0WXmk8OhcxD
vldgSBrtOka/QztmaUjVdGyeBeaSM/PUgHcVeaFf4+h11bcx+fkE8KsTNyr1xtw7
lepdfoDy1e8r31ILPWVxukagxKtHJYY+ey+jSvSuKJjfM/SBcM584FZwCaQFgWgI
0E6zO8B6o1KMhpTDIs6i2KNf5KSd4AhowMXVWCehYa7KgASTQplSMYN1cVmawtD2
aaoL+2tuhG7xo8wuocDiqacw/iLAIC4ikuvI5tomEFwd+AnZlvAm9odF5B1NwmPx
UBUiuetLkaYmzgQBkxcLQMQ2V+2+rhGMLh5KgCIXlXgFshhgq/w9feYCEkIY7I4Z
+jhgmG4kmpR1TaAjuxjrajA5ropkIK50nY92sWr0gu4QpHqnkcw=
=xLbo
-----END PGP SIGNATURE-----
--=-=-=--
