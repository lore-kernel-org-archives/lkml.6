Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeC0IV1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:21:27 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34835 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbeC0IVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:21:25 -0400
X-Google-Smtp-Source: AG47ELvE0E8xSHJC25lujHdRm9kGzHb1PQogLCNScqqH80iZMIb9aTFwvOML1y9Ml1yN5lKDA2X9zasijoU+Ad5Utfk=
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1803270944490.1726@schleppi>
References: <alpine.LFD.2.21.1803270944490.1726@schleppi>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Mar 2018 10:21:24 +0200
X-Google-Sender-Auth: _TEWqBwS_CK4hAjZIFl8xE3xSqU
Message-ID: <CAMuHMdX_aTqi=8FmBR07K6-C=ycCrPQ+dT=ujXzNTcekdXB5ag@mail.gmail.com>
Subject: Re: dma_zalloc_coherent broken with 57bf5a8963f80fb3828c46c3e3a5b2dd790e09a7
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Tue, Mar 27, 2018 at 10:12 AM, Sebastian Ott
<sebott@linux.vnet.ibm.com> wrote:
> commit 57bf5a8963f80fb3828c46c3e3a5b2dd790e09a7 broke usage of dma
> allocations specifying __GFP_ZERO by silently removing that flag.

How did it break? The flag is now always added.

> Why should "the memory returned [] always be zeroed."?

To avoid leaking information.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
