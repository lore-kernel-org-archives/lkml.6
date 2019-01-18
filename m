Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9099FC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C3A20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfARHy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:54:28 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46631 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfARHy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:54:27 -0500
Received: by mail-vs1-f68.google.com with SMTP id n10so7868475vso.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 23:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPoLJZo/gEQ5CS4P3egopOmilj0JYJvumjzcc4LknrY=;
        b=VL53m+0la/c2rqc3bWvU+vdOrJZQ7MQTylJZ07Xl4JaR5rgtRj/muWnaw4qrPryx8V
         E7Eu6MIJefMYiUxT8cqxdC1lI36lxKsmILHnuM2UsdAmgsz7eRV9zTT+4Pg/fN8C9FM1
         XZcf6w048VNSuR0Mt6+wijlVN3Z83mcnqWfc32SYOZvOuVtDYiZ8WpjnB6An7B2yF3S7
         uPow8m6ss3zNMlKFn2Za9wYB4NApiAOgQRH3pHzcPfbWYsneAf7RAd5yA9trHc0E/yoF
         84/mzE8ekytT5o6YfTVDds+t+TsLJVgMB3nmUDcb9IEfJAapeLHwdl8QDeri16PqJew/
         wQHw==
X-Gm-Message-State: AJcUukf7ntHODFp29pX3w3zRrPx472g3KEBtDw4yCu7sL38fsY4KFgHr
        PksxmJNlWNiMK7W1yjkGYDLJFHiuw/EQ/z/fS80=
X-Google-Smtp-Source: ALg8bN7QHotq6noRvNZo1wpuFJFIteHaX8+PKKeT7KoBc/XAbNwDRz5n6y/PAImVe+7b3DAmV1lyL7x2ZujKgZJ3Q6w=
X-Received: by 2002:a67:3885:: with SMTP id n5mr6372788vsi.96.1547798066614;
 Thu, 17 Jan 2019 23:54:26 -0800 (PST)
MIME-Version: 1.0
References: <20190117215836.26137-1-rep.dot.nop@gmail.com>
In-Reply-To: <20190117215836.26137-1-rep.dot.nop@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Jan 2019 08:54:15 +0100
Message-ID: <CAMuHMdVzqEhw0KTbToUkxiuovoaxoW_mw2hF_uh0qcXYf+POsQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] checkstack.pl: Add blackfin support
To:     Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernhard,

Thanks for your patch!

On Thu, Jan 17, 2019 at 11:01 PM Bernhard Reutner-Fischer
<rep.dot.nop@gmail.com> wrote:
> We've been carrying this since some time now.. Original submission:
> http://lists.busybox.net/pipermail/busybox/2007-August/028420.html
>
> Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>

A similar patch was merged in commit 1e9535a591cf003e ("Add stack
checking for Blackfin").

In the mean time, blackfin support was removed from Linux in commit
4ba66a9760722ccb ("arch: remove blackfin port"), and from checkstack in
commit e53a05a49e10c7cf ("scripts/checkstack.pl: remove blackfin support").

Nevertheless, I can imagine it's nice to have it, as I have used
checkstack for non-Linux projects, too ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
