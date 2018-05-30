Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeE3TyE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:54:04 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38974 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932170AbeE3TyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:54:01 -0400
X-Google-Smtp-Source: ADUXVKJj93S6zgs3lGDnO95XydlvNtfElcLc8WKAY5rbVOfJL9OCTHjvyREAg0Bv2mM0BIZqda1pUPn9R6J/0jihVPg=
MIME-Version: 1.0
In-Reply-To: <cc9b01d2b0e12938fe0e9581dd9d650ad3c4159c.1526551115.git.fthain@telegraphics.com.au>
References: <cc9b01d2b0e12938fe0e9581dd9d650ad3c4159c.1526551115.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 May 2018 21:53:58 +0200
X-Google-Sender-Auth: eWBrRTnpzg9zLLGdeNijAGo8_UA
Message-ID: <CAMuHMdX7NWWPOfSAWLG+gmRa9j7j1O-iWOH8EeKrLqhbfpddYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] m68k: Set default dma mask for platform devices
To: Finn Thain <fthain@telegraphics.com.au>
Cc: linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Thu, May 17, 2018 at 12:07 PM, Finn Thain <fthain@telegraphics.com.au> wrote:
> This avoids a WARNING splat when loading the macsonic or macmace driver.
> Please see commit 205e1b7f51e4 ("dma-mapping: warn when there is no
> coherent_dma_mask").
>
> This implementation of arch_setup_pdev_archdata() differs from the
> powerpc one, in that this one avoids clobbering a device dma mask
> which has already been initialized.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Greg Ungerer <gerg@linux-m68k.org>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks, applied and queued for v4.18.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
