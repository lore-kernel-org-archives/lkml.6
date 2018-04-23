Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932659AbeDWXjx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 19:39:53 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56850 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932574AbeDWXjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 19:39:51 -0400
Date: Tue, 24 Apr 2018 09:39:37 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
cc: Sam Creasey <sammy@sammy.net>, linux-m68k@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] m68k: Fix off-by-one calendar month
In-Reply-To: <CAK8P3a2Qt3AO_FF_J8px9KoCoNGkPrn-+k1aj-xrySb-0wYx0Q@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1804240850340.8@nippy.intranet>
References: <S1753929AbeDWBDQ/20180423010320Z+1320@vger.kernel.org> <CAK8P3a2Qt3AO_FF_J8px9KoCoNGkPrn-+k1aj-xrySb-0wYx0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018, Arnd Bergmann wrote:

> 
> This clashes with a patch I had planned to submit today, but otherwise
> looks correct and. I'll respin my patch on top of yours. Since I've taken
> a good look at your changes in the meantime
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 

Thanks, Arnd.

Geert, let me know if I should re-send this with the "reviewed-by" from 
Arnd and "cc" to stable...

-- 

>       Arnd
