Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510A9C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF632085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfAUJlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:41:31 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40834 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfAUJlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:41:31 -0500
Received: by mail-vk1-f194.google.com with SMTP id v70so4439121vkv.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZxDm1GwJyvN2+sLNUkHn4Vb6f3JwRBk2PI939aIyXUQ=;
        b=VpV16xFoeMVZ4K866dqwt5qIwB3C89PZ+QHb3Mb2vxtyJ374j+bgUNtjEIRIatlHmq
         KlWXMcQmBwEk9AeloIYkw9qhYAMbIVnIvmiXVkJwZi56erCXkJmhv9HgBgQY3zlzjMN1
         zwOEdiy1Gkonn5vjtqAzy/rli18ogO3Lss6+stNRtP1hfp4biaxjrj4XWem1aTZRbuhw
         9A/jBZ6imQEuoa5fUXaDbmKmeetro061AgawfSORY7onkwK9ouuovNu2PRX3MYgJVet9
         0piPTpG71wGRYczrJkrz0+9h5LRQq7A8Vu0vB/4Wgsa7vD9lDRJQilloCBqagjRlp0T1
         Caiw==
X-Gm-Message-State: AJcUukf/qRlyDb5w4fn2HX3usP7sVhLN9EUl9QXFYZ3MHst0xMtAmVbX
        RF5MpwOV2VSXfYErA46UQrHqawTLHPa99A616kb1ffKl
X-Google-Smtp-Source: ALg8bN63ANY28IFt/wS2Hql5C22dW4WqKSIWGMwn2Ff5VOtK6NOi4fqrqv3JFsfwWrr6P7jdHpfjJkxz4CfmB8egAQQ=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr11187634vkd.74.1548063690455;
 Mon, 21 Jan 2019 01:41:30 -0800 (PST)
MIME-Version: 1.0
References: <dc3abf702c1f54d536c94305c44de7182f5212b6.1545445081.git.fthain@telegraphics.com.au>
In-Reply-To: <dc3abf702c1f54d536c94305c44de7182f5212b6.1545445081.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Jan 2019 10:41:18 +0100
Message-ID: <CAMuHMdXLSPaht7NHgeNQ+DdsT8Bn6gnbauMDipvguW4t9L0PaA@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Use '030 reset method on SE/30
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 4:07 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> The comment says that calling the ROM routine doesn't work. But testing
> shows that the 68030 fall-back reset method does work, so just use that.
>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks, applied and queued for v5.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
