Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D77AECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42AF2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42AF2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbeGRIBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:01:53 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:40389 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeGRIBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:01:53 -0400
Received: by mail-vk0-f66.google.com with SMTP id s23-v6so1964175vks.7;
        Wed, 18 Jul 2018 00:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YL1PcrW/1rjL24NSmB+7bMDC08eXBnYrqXeusQF9srg=;
        b=XEaOwl0XnRawNrevHbSa9R7Nx3IPxS3n7vRZpiV1xaP0VpuAFkPECF6W9nUMHKaN8L
         lucC1V2p9O1xYfuo0RMsv+mBpmTRA6K3Mbia+wfr0pc54URdceWtgosFSpED1a39oUIj
         dLn/RClSwUzEG3eHbDwoYiKtacZeOojlyNCVfJc8VTinPIrTw1qD5ajoxY9IUF2mnjcX
         +O8peqFrqFNY2w1Ah2sapsyx7++2NABaxzoQ8DPlV3P5spsvPWUKQKLXq9dZOaOddhMD
         l6vUdjfIPZX6XQuopwxVUH6Y/xRPBqIR6g2IUajnUc3irlGsGxomzer4oFJIT1CeI0wQ
         UZwg==
X-Gm-Message-State: AOUpUlGw4PBfzbjpoAEck47KYpGNde8OK0yLjvOTr2KJSKoXijKmDmii
        WGBABtSqML49wbyvXDRmTc/rO7kf5yPatAljXyM0qu8m
X-Google-Smtp-Source: AAOMgpeOnePEbR8Sy2r3Bd6t8QwCorEkewYLtpUQn7WME/WUpqvcxkB0L6SLJP2m9/TCTTIQBXEPpi4u1y2B9m5fVGM=
X-Received: by 2002:a1f:2cce:: with SMTP id s197-v6mr2695859vks.106.1531898726216;
 Wed, 18 Jul 2018 00:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180718010242.5254-1-nicolas.pitre@linaro.org> <20180718010242.5254-4-nicolas.pitre@linaro.org>
In-Reply-To: <20180718010242.5254-4-nicolas.pitre@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Jul 2018 09:25:14 +0200
Message-ID: <CAMuHMdUB4DvxGv6ogcm9UiV-4BHZHWKyGwSPsGELMru7D9dHaQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] vt: add /dev/vcsu* to devices.txt
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-console@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 3:02 AM Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> Also mention that the traditional devices provide glyph values whereas
> /dev/vcsu* is unicode based.
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
