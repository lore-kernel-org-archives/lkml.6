Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752235AbeEKD3B (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:29:01 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39192 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeEKD27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:28:59 -0400
Date: Fri, 11 May 2018 13:28:57 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Michael Schmitz <schmitzmic@gmail.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH net] macmace: Set platform device coherent_dma_mask
In-Reply-To: <CAOmrzkLL0ZNzAh7rwiDy=BkNqqXgbqfv3vkN6K8CTF8VGbT8zA@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1805111221180.8@nippy.intranet>
References: <S1751632AbeECEYA/20180503042400Z+254@vger.kernel.org> <CAMuHMdUAxmVZLekekvVrnMbbL18oyY86sF9QX087idSqcKMiPQ@mail.gmail.com> <alpine.LNX.2.21.1805031801310.8@nippy.intranet> <CAMuHMdU1XBqt7hwEW6JTas64ZNGCGCMr5HMZwuLo0O-ZBCOWyA@mail.gmail.com>
 <alpine.LNX.2.21.1805091805130.72@nippy.intranet> <CAOmrzkKNPemq5RySvza+Y8_jgwg2fkUZodR794cgOxpQpfh+SA@mail.gmail.com> <alpine.LNX.2.21.1805110921020.8@nippy.intranet> <CAOmrzkLL0ZNzAh7rwiDy=BkNqqXgbqfv3vkN6K8CTF8VGbT8zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2018, Michael Schmitz wrote:

> > > Which begs the question: why can' you set up all Nubus bus devices' 
> > > DMA masks in nubus_device_register(), or nubus_add_board()?
> >
> > I am expecting to see the same WARNING from the nubus sonic driver but 
> > it hasn't happened yet, so I don't have a patch for it yet. In 
> > anycase, the nubus fix would be a lot like the zorro bus fix, so I 
> > don't see a problem.
> 
> That's odd. But what I meant to say is that by setting up 
> dma_coherent_mask in nubus_add_board(), and pointing dma_mask to that, 
> ypu won't need any patches to Nubus device drivers.

Right. I think I've already acknowledged that. But it's off-topic, because 
the patches under review are for platform drivers. Those patches fix an 
actual bug that I've observed. Whereas, the nubus driver dma mask issue 
that you raised is purely theoretical at this stage.

-- 
