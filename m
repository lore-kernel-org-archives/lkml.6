Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A721BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC082229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394388AbfBNIMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:12:20 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37189 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfBNIMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:12:20 -0500
Received: by mail-ua1-f65.google.com with SMTP id v26so1736194uap.4;
        Thu, 14 Feb 2019 00:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gyhVZT2cvH02qo+0nGpWrG/zXh7SGwoDkx6XeIiXPzo=;
        b=DUNSncaSswEVeuYjgTjYJtmFfqbZwUycjPKq4P10n9PaUORzaJWlhNnvvakEgi06hu
         yTmOu1M4pBZEI+/LvUPt9sA4ADCNZkYjjjyTyDEzWxnynQXc0rt9H9skHcrh37LFE1Ul
         QW3frUZKLG0ExIT2mOfyZ/w+djAxTLJW7KmkeH6UgaYfF0dKEsgeNykWXzAxDJa/Yez/
         OCaIArGH9+fjoibsnK4veA0g50bnaZyVka6vfbw8yhPyx99ZrQTe4FYtLtWwhAVOSBxv
         5kUOvv34EVpxC+9Ta2Gez43RSixznBgWgQCxqZ1VA1CHbXCYb69sBc2xgKjKv6F4jrQE
         ue8Q==
X-Gm-Message-State: AHQUAuZIC3Pt3ehcl28WtlydN9inLlGYnvD/6Vp6krUsI91RQEy5JVuZ
        kgzKrbMhj5AjwALsColw+9jzVIlDhrPDPfZ9+wGx2Was
X-Google-Smtp-Source: AHgI3IZarNBxgZqVSOHbG6fu5WSACF5VlsCI/qxhQmwcEzw1zAysB+AexGAtBhb6oMJQSg01PbRqjo2LsHbPzEA6iy4=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr1341942ual.20.1550131938902;
 Thu, 14 Feb 2019 00:12:18 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-10-hch@lst.de>
In-Reply-To: <20190213174005.28785-10-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Feb 2019 09:12:07 +0100
Message-ID: <CAMuHMdUX=dq49b08UUxkLCn+HikUBOEs29314fYbwregfrSEqg@mail.gmail.com>
Subject: Re: [PATCH 09/11] lib: consolidate the GENERIC_CSUM symbol
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 3:25 AM Christoph Hellwig <hch@lst.de> wrote:
> Add one definition to lib/Kconfig and let the architectures
> select if it supported.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/Kconfig       | 3 ---

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
