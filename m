Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbeC0Ivs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:51:48 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:38678 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbeC0Ivq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:51:46 -0400
X-Google-Smtp-Source: AG47ELv9ZUTwX8lrjvka2CDAuCPb3nUDKVFaw10c59PuaPvc8Ly6/7alB2SbzRlxkEN1B0u3d4wTWeaXXH+CulVCRnI=
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1803271037410.1726@schleppi>
References: <alpine.LFD.2.21.1803270944490.1726@schleppi> <CAMuHMdX_aTqi=8FmBR07K6-C=ycCrPQ+dT=ujXzNTcekdXB5ag@mail.gmail.com>
 <alpine.LFD.2.21.1803271037410.1726@schleppi>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Mar 2018 10:51:45 +0200
X-Google-Sender-Auth: UFCMjJnhujdbFk6tGRNySzDadbY
Message-ID: <CAMuHMdWidUxYNBVcDn7WxYb9V2bOnh_jwSuT2gYJ=-w1GnEoRg@mail.gmail.com>
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

On Tue, Mar 27, 2018 at 10:41 AM, Sebastian Ott
<sebott@linux.vnet.ibm.com> wrote:
> On Tue, 27 Mar 2018, Geert Uytterhoeven wrote:
>> On Tue, Mar 27, 2018 at 10:12 AM, Sebastian Ott
>> <sebott@linux.vnet.ibm.com> wrote:
>> > commit 57bf5a8963f80fb3828c46c3e3a5b2dd790e09a7 broke usage of dma
>> > allocations specifying __GFP_ZERO by silently removing that flag.
>>
>> How did it break? The flag is now always added.
>
> +       flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM | __GFP_ZERO);
>
> I read that as a removal. But maybe I need more coffee..

Sorry, you're right.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
