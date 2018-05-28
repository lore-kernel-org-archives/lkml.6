Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeE1F0i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:26:38 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:35548 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeE1F0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:26:36 -0400
Date: Mon, 28 May 2018 15:26:39 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Michael Schmitz <schmitzmic@gmail.com>
cc: Guenter Roeck <linux@roeck-us.net>, Joshua Thompson <funaho@jurai.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] m68k: set dma and coherent masks for Macintosh SONIC
 based ethernet
In-Reply-To: <2ffd0de6-e8d6-6449-7c05-cbbfd8a99a97@gmail.com>
Message-ID: <alpine.LNX.2.21.1805281521420.10@nippy.intranet>
References: <1527378785-13326-1-git-send-email-linux@roeck-us.net> <alpine.LNX.2.21.1805271212480.9@nippy.intranet> <55c1c33b-4a34-bd72-57de-577ce8d95e0b@gmail.com> <alpine.LNX.2.21.1805271547090.9@nippy.intranet>
 <2ffd0de6-e8d6-6449-7c05-cbbfd8a99a97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2018, Michael Schmitz wrote:

> Hi Finn,
> 
> Am 27.05.2018 um 17:49 schrieb Finn Thain:
> > On Sun, 27 May 2018, Michael Schmitz wrote:
> > 
> >> That should have fixed the warning already ...
> > 
> > It's still not fixed (hence my "acked-by" for Geunter's patch).
> > 
> 
> Odd - does link order still matter even though the 
> arch_setup_dev_archdata() function from the core platform code is 
> declared as a weak symbol?
> 
> I'll see what I can find out on elgar ...
> 

Any one of the numerous patches/rfcs/suggestions that I sent will avoid 
the WARN splat.

When I said "it's still not fixed", what I meant to say was, "it's still 
not fixed in mainline and no proposed fix was accepted to the best of my 
knowledge".

-- 

> Cheers,
> 
> 	Michael
> 
