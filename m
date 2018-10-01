Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504E3C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABD52084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCcny8+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABD52084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbeJATZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbeJATZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:25:05 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 926202084C;
        Mon,  1 Oct 2018 12:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538398044;
        bh=xIZYzG+IYgZwySQQsE8Ut/LwUtRgwBNhkyuzJRcHtTU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oCcny8+GPcy3TSwTx15feIh2HLBm6pLeOpgObTJr5LFWhKaZ5VrO4GZW4qxVZwoCg
         Xwd9c0KOsJEDwGI5p9ZktIm5sELwvyVkX5M3JQXjK/lNVfqOT0PKI5hGfI+xRnV5C0
         5uTKe/gP0r3BLV3SWsNj9bgmX2+WQZ+/J1wznSUc=
Received: by mail-qk1-f175.google.com with SMTP id a85-v6so7962966qkg.3;
        Mon, 01 Oct 2018 05:47:24 -0700 (PDT)
X-Gm-Message-State: ABuFfoheXFsSBxcOBAW5zHpIFjlVDjSJN78lu9dnd+wp0L5vVRPDAd5n
        f12J762+sN/MaKa2BAgE3+2ml7j/r9r6dhghDg==
X-Google-Smtp-Source: ACcGV63B4D6JVwfKBIQt494SKFH0HAWmphIRZ4F6DGsAgTNpxwmo/v1YGDJRU4b2qo1tmcKrM7ut2gyXbOLAw2I9Vmk=
X-Received: by 2002:a37:12d1:: with SMTP id 78-v6mr8077829qks.147.1538398043752;
 Mon, 01 Oct 2018 05:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181001080750epcas2p21b4c3e14be32859f31bede0656ffa09d@epcas2p2.samsung.com>
 <20180928220330.31325-1-joe@perches.com> <875zym5bue.fsf%l.stelmach@samsung.com>
In-Reply-To: <875zym5bue.fsf%l.stelmach@samsung.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 1 Oct 2018 07:47:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLoZfU+DMxHJg7ZqD06dgcsxiDbYYW99x8H4C0sOwdiiw@mail.gmail.com>
Message-ID: <CAL_JsqLoZfU+DMxHJg7ZqD06dgcsxiDbYYW99x8H4C0sOwdiiw@mail.gmail.com>
Subject: Re: Bad MAINTAINERS pattern in section 'SAMSUNG EXYNOS TRUE RANDOM
 NUMBER GENERATOR (TRNG) DRIVER'
To:     =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
Cc:     Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 3:07 AM =C5=81ukasz Stelmach <l.stelmach@samsung.com=
> wrote:
>
> It was <2018-09-29 sob 00:03>, when Joe Perches wrote:
> > Please fix this defect appropriately.
> >
> > linux-next MAINTAINERS section:
> >
> >       12851   SAMSUNG EXYNOS TRUE RANDOM NUMBER GENERATOR (TRNG) DRIVER
> >       12852   M:      =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> >       12853   L:      linux-samsung-soc@vger.kernel.org
> >       12854   S:      Maintained
> >       12855   F:      drivers/char/hw_random/exynos-trng.c
> > -->   12856   F:      Documentation/devicetree/bindings/rng/samsung,exy=
nos5250-trng.txt
> >
> > Commit that introduced this:
> >
> > commit 6cd225cc5d8a6526b2bea41955882be55d4f109e
> >  Author: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> >  Date:   Fri Dec 22 17:48:35 2017 +0100
> >
> >      hwrng: exynos - add Samsung Exynos True RNG driver
> >
> >      Add support for True Random Number Generator found in Samsung Exyn=
os
> >      5250+ SoCs.
> >
> >      Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> >      Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> >      Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
> >      Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> >
> >   MAINTAINERS                          |   7 ++
> >   drivers/char/hw_random/Kconfig       |  12 ++
> >   drivers/char/hw_random/Makefile      |   1 +
> >   drivers/char/hw_random/exynos-trng.c | 237 ++++++++++++++++++++++++++=
+++++++++
> >   4 files changed, 257 insertions(+)
> >
> > No commit with Documentation/devicetree/bindings/rng/samsung,exynos5250=
-trng.txt found
>
> Please merge the version 3[1] of the patch you've acked[2].

Bindings in a series go in with the rest of the series. If you want me
to apply please resend as I don't have year old patches in my inbox.

Rob
