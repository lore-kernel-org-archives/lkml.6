Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932891AbeE2DX6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 23:23:58 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32928 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932475AbeE2DXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 23:23:49 -0400
X-Google-Smtp-Source: AB8JxZq0/RElQt/Ibwj2jl934O2woJTwplQ5b8Hi4Mb/9+5ixhnHadDprhgT7gMP0gSfWirAq/FrAQ==
Subject: Re: [RFC PATCH] m68k: set dma and coherent masks for Macintosh SONIC
 based ethernet
To: Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <1527378785-13326-1-git-send-email-linux@roeck-us.net>
 <alpine.LNX.2.21.1805271212480.9@nippy.intranet>
 <55c1c33b-4a34-bd72-57de-577ce8d95e0b@gmail.com>
 <alpine.LNX.2.21.1805271547090.9@nippy.intranet>
 <2ffd0de6-e8d6-6449-7c05-cbbfd8a99a97@gmail.com>
 <alpine.LNX.2.21.1805281521420.10@nippy.intranet>
 <CAMuHMdWXnP96p9swox6FXg2-2doeNGK+G9eQyZ-td+xWGSKKoQ@mail.gmail.com>
 <alpine.LNX.2.21.1805291047230.13@nippy.intranet>
Cc: Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>,
        Joshua Thompson <funaho@jurai.org>, Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Michael Schmitz <schmitzmic@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <b4f0d2d7-fcd5-b68f-0bc6-cd41c353aba7@gmail.com>
Date: Tue, 29 May 2018 15:23:39 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1805291047230.13@nippy.intranet>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 29.05.2018 um 14:15 schrieb Finn Thain:
> 
> Since an arch gets to apply limits in the dma ops it implements, why would 
> arch code also have to set a limit in the form of default platform device 
> masks? Powerpc seems to be the only arch that does this.

One of Christoph's recent patches removed most of arches' dma ops,
replacing them by one generic implementation instead. m68k was one of
the affected arches. I concede his patch series is experimental still
and not in mainline, but may be included at some time.

Otherwise - your patches, so if you prefer to have each driver handle
this on an as-needed basis, I'm not objecting.

Cheers,

	Michael
