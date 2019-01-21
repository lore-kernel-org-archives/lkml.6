Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF11C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09282085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfAUJlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:41:04 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42737 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfAUJlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:41:04 -0500
Received: by mail-ua1-f67.google.com with SMTP id d21so6698358uap.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tCej17OLmF62dw6BPjxSL+3gkRJfbvrCSa73IxL1IBQ=;
        b=BzDqaVfJ1BubrBSE6ndIKpeIpnu2EfUo1h+iwzmO9u58O39iVruCGm6DXPPkAEWRCK
         9YZdJj5N7LSfH2iS21NiQbrs0p7K+06ln5s/4G7EQffKVl301N38qE5jK5OQ5MWRGpSG
         xelUbsXhe6yTL58LcKJA+5G1nxSjYphDnS7X6SSHrgo6oGJBus+MxqB3tD9vgBH1fL9S
         kxhIGcneao/dBtfDJJ8td90xmL1GLcBjCo7tAvuqH7hHMPnEkKHMs6sGhQS7j07HbIJH
         2eJfypKIhU2mmKsmjmH06BtrzITprnqjgDq3Y0t8PEhgSj06XhLoqPmi9fXgvdYlfl58
         lAZw==
X-Gm-Message-State: AJcUukfwy4+khCT/dEZXEvIA7uZ2aoM85ZcS9ajDBK0sTwfBSeFR0WDE
        ++1h4OHOe2i6bNjBabSKuyUEov91PZiatgOswqKO3QKw
X-Google-Smtp-Source: ALg8bN7OUfza8+m+VMIe0F1HQt8M1DocbaIY5aX4M1EgTHs92dPBZv+Ge8eg5vlpmuFn8/zq1P0Jvng3TcfDgmOHf5g=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr11430659ual.20.1548063663165;
 Mon, 21 Jan 2019 01:41:03 -0800 (PST)
MIME-Version: 1.0
References: <e05665950235d8c8a5cc7e3e5f989b46b8e8a631.1545445081.git.fthain@telegraphics.com.au>
In-Reply-To: <e05665950235d8c8a5cc7e3e5f989b46b8e8a631.1545445081.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Jan 2019 10:40:51 +0100
Message-ID: <CAMuHMdXiKZ1yWxZAv8+bFo5Z+gTLmpLGqgyHMJ9KoKb_76bz0A@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Remove obsolete comment
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
> According to The Guide To Mac Family Hardware, this is the correct way
> to disable the VBL interrupt. The confusing comment here doesn't add any
> value so remove it.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks, applied and queued for v5.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
