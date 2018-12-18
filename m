Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91262C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1CE218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeLRTYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:24:15 -0500
Received: from anholt.net ([50.246.234.109]:36442 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbeLRTYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:24:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 903B110A1DD2;
        Tue, 18 Dec 2018 11:24:14 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id IQQWQBmDLuA1; Tue, 18 Dec 2018 11:24:13 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9AB7A10A0612;
        Tue, 18 Dec 2018 11:24:13 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 3653D2FE36F0; Tue, 18 Dec 2018 11:24:13 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2 03/19] mailbox: bcm2835: Use device-managed registration API
In-Reply-To: <20181217150217.32435-4-thierry.reding@gmail.com>
References: <20181217150217.32435-1-thierry.reding@gmail.com> <20181217150217.32435-4-thierry.reding@gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Tue, 18 Dec 2018 11:24:12 -0800
Message-ID: <87mup2zlib.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Thierry Reding <thierry.reding@gmail.com> writes:

> From: Thierry Reding <treding@nvidia.com>
>
> Get rid of some boilerplate driver removal code by using the newly added
> device-managed registration API.
>
> Cc: Eric Anholt <eric@anholt.net>

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlwZSVwACgkQtdYpNtH8
nugMaBAAswCBChn9iKrcqm1kSu6ciwf8jnsvTMRO5Rh5IL2oheupMBsj/TfGo7Q8
bTM2xavRMzo1en3DU5iLW1qABpDKSwu2Rj1o38c7KFkXkhvju8pSjF1V+qbsP8cM
U5I3gUmtzCQQ6KTbU0fp0o5Ic4Pa75SZusiJDQHRVUGQKGNawEcJ7u4ZEAVY6VgT
sD5ujXxHh0KrkvXMNYJLIes9vNEy8J1NcCm8xe9rNXzEzAVndQmOxevYMVeoF5R4
HAI0ZBTUMCYn3oS3ugWzKkH4fvgugCWXGifhAz6N1zut9QlZLikAAIf274sCBaLa
gkZPTkBl9uzcQkHcYO9kqomTlwroWVBgD+AZMvQtmEhIJXISv2smPrj83FKPX6z0
jRufu4xqwR0XwpLavP50JSaTmwjrFWb4hqRRRBqwPUFH0rgFaz8lm4dp09XRwb2W
l9Vq5YzCvAnqKJt5C0c4ToDRSLkVW5nEZx85wySLq1h8xWtodnwhJhmNTFFD31KT
rrasMC+hacRVmTllXFCPbnGGZsuT/x9+qGzTpR8ifgK35z8J2ztfWrLVyNv4n+13
lhV0MvPHCWmOIdxNYCHmg3FGqyb4Bi8MTlW9TiRYRASErx3k8yAG0s+8gFw+RQ9B
fBypGi/pv4tplhbGYkS2T7a6OEaQrzBtbYtrGwZiD60YIHn8P3E=
=7boS
-----END PGP SIGNATURE-----
--=-=-=--
