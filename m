Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A18C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE8E24481
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE8E24481
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937436AbeF2Unp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:43:45 -0400
Received: from anholt.net ([50.246.234.109]:39858 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937421AbeF2Unk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:43:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 21FB110A18A9;
        Fri, 29 Jun 2018 13:43:40 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 6rXzv714WXER; Fri, 29 Jun 2018 13:43:39 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 24B2E10A0748;
        Fri, 29 Jun 2018 13:43:39 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id AC42C2FE2D94; Fri, 29 Jun 2018 13:43:38 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: Introduce tracepoints for CL execution.
In-Reply-To: <20180517131824.29619-1-eric@anholt.net>
References: <20180517131824.29619-1-eric@anholt.net>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Fri, 29 Jun 2018 13:43:38 -0700
Message-ID: <876021nx1h.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Eric Anholt <eric@anholt.net> writes:

> This has been useful for debugging the window movement lag in X11, and
> I have patches to sysprof that watch these to produce nice
> visualizations.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

I'd love an ack from someone for this.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAls2mfoACgkQtdYpNtH8
nuhFxQ/9GLL3OTbsqg9/ViPVa7I1PhCCV1FpZJRtujPtqzOhMMA3YIQuRyjXryam
f8NPDUb1dxBGtodrPHS5imzWk7KZnhRcVBd+k3jkc/TtSz0Lmav266ovTr4NPJBx
08IfK+X+L1eRG5lUyheDtT8WWHYXiFWn6IAF0AvKCgJypmDFcLbWRjyFKT3TnV3d
OSfVHOoKk2e4tAZE5aj2gbgtQzHPxUze03whwTr+cVN3pMV/viCwrU4rpXivzDLs
+9uVFAFXybAWxsH51o4lNxK53zz+zzaS74ZkcRvL4dtYvANYbe5eJGiLlDs0CpXQ
b9wSg47Jiq7/qEub8Xr0wJy3eBG8HxQaWMoQyds0lkZjMTFGXITUNMIfRoh7vIqN
RUlOOKWxXib1YD4qK1XhvDnT8rrEUQ0rPKPJg1pPrEhT66XedH7P9rg90/p1t6Vw
bZzT9P5wl/Woymz9UAoQKDsFP7Rjhe1CIjqgUJBX+DS2534h2NsLIfTC6Qwj8QGa
QV5n0kzl4OARsCMz2L0uxJXRTB9dRhxs/RF8Qv3GDfi9XumM/fmC2SVnMdOBkYuR
JdONZ/jigVLNOxgZOv9N6Dp9IZppFMVixL/R83gbPX0jSoZKY4xRv3Ynr1gbQiub
Zg3UtfMi+LPgtYY7I0r1XSejYdZvk4rB5VVCm4LClZm0fDpIp3k=
=Q/5q
-----END PGP SIGNATURE-----
--=-=-=--
