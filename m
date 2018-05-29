Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966664AbeE2UKt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 16:10:49 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42534 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966179AbeE2UKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 16:10:46 -0400
X-Google-Smtp-Source: ADUXVKKGbyDvb4k9U7+R/So51UihkbajGTb2/fYRnDT+V/BZyUT8cIDE0VIEj8TXR7r+3rl7GCdOe97ReL/7vGMJwHU=
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1805291524080.16@nippy.intranet>
References: <1527378785-13326-1-git-send-email-linux@roeck-us.net>
 <alpine.LNX.2.21.1805271212480.9@nippy.intranet> <55c1c33b-4a34-bd72-57de-577ce8d95e0b@gmail.com>
 <alpine.LNX.2.21.1805271547090.9@nippy.intranet> <2ffd0de6-e8d6-6449-7c05-cbbfd8a99a97@gmail.com>
 <alpine.LNX.2.21.1805281521420.10@nippy.intranet> <CAMuHMdWXnP96p9swox6FXg2-2doeNGK+G9eQyZ-td+xWGSKKoQ@mail.gmail.com>
 <alpine.LNX.2.21.1805291047230.13@nippy.intranet> <b4f0d2d7-fcd5-b68f-0bc6-cd41c353aba7@gmail.com>
 <alpine.LNX.2.21.1805291524080.16@nippy.intranet>
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Wed, 30 May 2018 08:10:45 +1200
Message-ID: <CAOmrzkJeKwMfr3CMpGW9QjVhBN71Ap31Ahan_XbsQfLdyBOvHw@mail.gmail.com>
Subject: Re: [RFC PATCH] m68k: set dma and coherent masks for Macintosh SONIC
 based ethernet
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>,
        Joshua Thompson <funaho@jurai.org>, Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Tue, May 29, 2018 at 5:38 PM, Finn Thain <fthain@telegraphics.com.au> wrote:
> I found some patches here,
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-dma-noncoherent.2

That's the most recent IIRC. Haven't begun looking at that yet - still stuck at

git://git.infradead.org/users/hch/misc.git

and waiting for a SCSI disk to be installed on elgar.

Christoph - any merit in testing that old repo?

Cheers,

  Michael
