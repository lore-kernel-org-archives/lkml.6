Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F96C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB562085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfAUJnl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:43:41 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45648 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbfAUJn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:43:27 -0500
Received: by mail-ua1-f66.google.com with SMTP id e16so6685276uam.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X11wMsr0XECBdmbmFf76KkzTrt98UYgvyYMKi7g33os=;
        b=uUgDrf8BG5yas5iqgm2mQno3j5pIJgYGMWJkh8dlQAaf9zn4djwdI5tsIU12xE4E70
         aPkEOOm3bARUQIUvxsDU1syrIo7CEJL/CzeHws4ghQ2J5H9zmlLP7s6kbe+q0XdqjlS/
         4CsMan8LcBc4LWKRUB3Rsx5+HdSN24Rk2p3lyqkKax4ybtdleuO7DwqEkmwQQhS2kB2E
         1sDKRHlU3cMKYLTGoX3TZJ4IUXxbOebqDQo/RPfbydS+Q3Xv9lkaVGMMROrvfy0nKFbh
         J1+dwWoR0oMo3/hh6foBaVQUfXiPEzo8R2Mfh6UVABZ6QfLZYb1VmvqNo/h9Qy7IHTy3
         PGVQ==
X-Gm-Message-State: AJcUukfyH1aqypDgMe8zMWzIAK4oVcFZrh+TWFuQ5iePPsnXQX1+jyJy
        1sJsif+9/w8rHM3oZHqCJF47pPR6kY3aNSXwP7zmfH5Y
X-Google-Smtp-Source: ALg8bN6EEC0wjVnRhsvapla1rVV7CZqRWv9pXN49RfJLqbUJyz1ZF1fESk+QtOCJQ0FpJTBRv7YxDQKAoZNMmGzHu7k=
X-Received: by 2002:ab0:1393:: with SMTP id m19mr11268748uae.75.1548063807039;
 Mon, 21 Jan 2019 01:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20190112172618.13073-1-j.neuschaefer@gmx.net>
In-Reply-To: <20190112172618.13073-1-j.neuschaefer@gmx.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Jan 2019 10:43:15 +0100
Message-ID: <CAMuHMdXW28sWDa4j5teyPdkEiiBp4SO2-hwnBgUkrVw+Zf-wQA@mail.gmail.com>
Subject: Re: [PATCH] m68k/apollo: Fix comment in Makefile
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 6:27 PM Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:
> This comment has been wrong since before git.
>
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Thanks, applied and queued for v5.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
