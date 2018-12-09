Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A263EC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 08:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A6E20831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 08:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Y5Qtke9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A6E20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeLIIHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 03:07:25 -0500
Received: from ozlabs.org ([203.11.71.1]:46019 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbeLIIHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 03:07:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43CJhl5SBRz9s3Z;
        Sun,  9 Dec 2018 19:07:19 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544342842;
        bh=D3drTf3IlN9YSMYP94U8kAC/7dQd1JQYw4pzN7B8OoA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y5Qtke9hh4ZMg3FidyCY2i4psuj55OQTk1VJzOrQh7OndlgDUXLT2nsx9tKX9R6UG
         CJT7fKvhKM28HWQfYN0VpNK2ZMloK4Sx6ILHxdNqc3TArJgcRtsS6aFLyvNdq6pmUF
         e+jkpx/J3qBytIAWarP5LP0AM4RHdl6ydz+b4vqBtgTzA+0GwsMKQovw03fnFvz0hu
         NzVLhuB8GQkoxmTf6u36BG8Zz4PoVMFlGo/wsij9qD5LUFlP8pPdWL3QBT8CQ8JleC
         g6vTgcll7HkpSw+vMAIto+ZO8axeDE7t1yIzllMiiGGyE4NNddVwykoDrs24yujmbP
         pWmwwz5lYtXlA==
Date:   Sun, 9 Dec 2018 19:07:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <akpm@linux-foundation.org>, <mhocko@suse.com>,
        <ebiederm@xmission.com>, <riel@surriel.com>,
        <keescook@chromium.org>, <guro@fb.com>,
        <marcos.souza.org@gmail.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] fork: remove duplicated include from fork.c
Message-ID: <20181209190702.753fae88@canb.auug.org.au>
In-Reply-To: <20181209062952.17736-1-yuehaibing@huawei.com>
References: <20181209062952.17736-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mxLJ1VtgPEB_K7CTWduccNV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mxLJ1VtgPEB_K7CTWduccNV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sun, 9 Dec 2018 14:29:52 +0800 YueHaibing <yuehaibing@huawei.com> wrote:
>
> Remove duplicated include.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>
--=20
Cheers,
Stephen Rothwell

--Sig_/mxLJ1VtgPEB_K7CTWduccNV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwMzSYACgkQAVBC80lX
0Gz+KAf/SEZxATXNb7/o88hhgdnBz2WA6sHySmkXbpIruSMlUV6qpre+uLgPyQMh
Zd3NOpOT6naRG9OJ7AuoiGxyQ95AUmd+37TMMSYCC+rhG6vnbnyy3sob1uaGMS/i
b9AZhlE3dC7AORLuFvr16pSyaocRX8QWEOboLVmszHz6Rrp29quVFrpjdv852bhK
wprq98N7tLGDFMhxtorMegwB/XevkYkGTwOiY6/ZxI1FoXr4ZplmTMEXWVKQQQPV
53P4gmtz4UCnjLAOo/MtOGiHsVMAMk46OfANYi/8ZuahmJRh4nBctY3sKD/7Szn7
k7kfEAtCPJVg3mqJqIK13qKZnAWmkQ==
=Yzag
-----END PGP SIGNATURE-----

--Sig_/mxLJ1VtgPEB_K7CTWduccNV--
