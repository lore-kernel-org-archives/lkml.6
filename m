Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38A0C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A355B2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfAUJms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:42:48 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45630 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfAUJmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:42:47 -0500
Received: by mail-ua1-f66.google.com with SMTP id e16so6684792uam.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84WglW6480kmAUU9csYo1S3Sck6pXMKYUNwxJSA5qPw=;
        b=EsLE8s4/ju5i6t27LItFermlIzUxMJSk3SvuvV0ydICKGw9KVccMXG2N3wcmf7aT8L
         chTjA8g1ax3WQHxx3KEVHrXJUGqyU/KpuZ6bkDQaQYn1+NF5WcaJqSg16pOel1QyUvtq
         rL2xe/1ccG+TX7rWNA20XPqcmanAQawPxCiP7PG3cAeADls4mHEnXMA8Qf1Le79y0NFA
         C7AB5zo/Q6YoAxg1x2WksK9K1s+mCTpLdSlZWwRa7tBp3MhwcUYvIddSFFSUIfn1Iscq
         uKtkM2zplnUBghE/1ciSsjkFDPwfNp9uKyb1O4C4beFedrqNThRC/c5lFErlDmxiBSDh
         WcEQ==
X-Gm-Message-State: AJcUukf0GaeWnuycp/d/HTYmCUW/BVfm27yd75O7I1R9lBhd/CboRrhg
        UE6Beec9p/0KcJGxtOlnlQe8Gha6+mayGU+osDFnMiFw
X-Google-Smtp-Source: ALg8bN7X/xPliZzPf1hCx/B9SQjhgR9MMKpfl7OWb29G3RNq7I6fAlhTxKHxsX/HF3TvMQOYofvXBvt246oe/lEc0Ak=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr11432291ual.20.1548063766739;
 Mon, 21 Jan 2019 01:42:46 -0800 (PST)
MIME-Version: 1.0
References: <20190107093015.14824-1-geert@linux-m68k.org>
In-Reply-To: <20190107093015.14824-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Jan 2019 10:42:34 +0100
Message-ID: <CAMuHMdW6OaGDeJUTr+fe5_8eCSWxGjQHbK8fr0Y5ax2nfwYxRw@mail.gmail.com>
Subject: Re: [PATCH] m68k/defconfig: Update defconfigs for v5.0-rc1
To:     linux-m68k <linux-m68k@lists.linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 10:30 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Actual changes:
>     -CONFIG_IOSCHED_DEADLINE=m
>     -CONFIG_BATMAN_ADV_MCAST=y
>     -# CONFIG_SCSI_MQ_DEFAULT is not set
>     +CONFIG_CRYPTO_ADIANTUM=m
>     +CONFIG_CRYPTO_STREEBOG=m
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied and queued for v5.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
