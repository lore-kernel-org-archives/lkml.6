Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8963C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8131D20858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8131D20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeKKCl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 21:41:56 -0500
Received: from anholt.net ([50.246.234.109]:50812 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbeKKCl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 21:41:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id D3EE810A13BE;
        Sat, 10 Nov 2018 08:56:16 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 56-OM308qMaN; Sat, 10 Nov 2018 08:56:16 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E6D9510A1128;
        Sat, 10 Nov 2018 08:56:15 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 847172FE1B8F; Sat, 10 Nov 2018 08:56:15 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Bart Tanghe <bart.tanghe@thomasmore.be>
Subject: Re: [PATCH 13/17] pwm: bcm2835: Switch to SPDX identifier
In-Reply-To: <1541866978-7943-1-git-send-email-stefan.wahren@i2se.com>
References: <1541866978-7943-1-git-send-email-stefan.wahren@i2se.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Sat, 10 Nov 2018 08:56:15 -0800
Message-ID: <87r2fsyiq8.fsf@anholt.net>
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

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvnDa8ACgkQtdYpNtH8
nujDPg/+Pesihf2sETykqYJ7+U6uPWEd74trGLjIto3OiOvhxJG3djUUu9uyRiZD
sS9w9gOpWYQtvZv9F7ZsDri1pWQc9DPIGkfzg7jN68AA9tuyiM85PbSS1eCR/yOF
p6W+vL7owy8ICX5yXBMiyD6fdRaKnkK5gT8zqrvXX1uJPcHpybM9lv1b4PoL0Hk9
Air/ikMAj+icVkLB3vVMR+0EmDGkWdbBpeQMsvc6C/BY2hqaQAT4Qnu3F29L53N6
oDhDNF9vs8fgOUndOmFR7wjogIoXhSa5n0Qo9CQE73uxPFtL/pReaOsVWT+EVC1l
kmsFVOERupq6xrJBNvZYXvK+VUFTefgBxrQYrvyiw/uwqzXSJ5lOCfFGeTrz1x74
UhBg+C69SJNKUoBl5orLL1Du+rM2XMiOFgBlrIL+QNVn2EQv4fDEkLTfD9b1357J
LminKq3j44fxcOh7uUYXTRy9deOWyCbVDlISpSFkysMg+PwiPTmD1DmhX6rfz825
RqVkGB/ZRYFtOw/1/6ZQv2XZfccaw8epXprBKq3oHlmqAH/VJIFEaKiiDD9max7b
W4AEXRrk+WbwKgHvV0+13qykL5WgQ/zcpSrCqT3f70UxZNIoi3Ia1YSU8n/IpPeX
C7hRdpRlTBCL8sumnVwsPduGMz1QQKadDpUAC3EJxc+HmhUFEys=
=9i8p
-----END PGP SIGNATURE-----
--=-=-=--
