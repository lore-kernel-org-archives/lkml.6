Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeE1FUo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:20:44 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36374 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753170AbeE1FUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:20:42 -0400
X-Google-Smtp-Source: AB8JxZrbRT1Xmqbnf76+F9O6vKzGKnm+SFmjgWT/lfz+2k1h6OrdP7d+OBf2tX0lBo2he5/fp9ES/A==
Subject: Re: [RFC PATCH] m68k: set dma and coherent masks for Macintosh SONIC
 based ethernet
To: Finn Thain <fthain@telegraphics.com.au>
References: <1527378785-13326-1-git-send-email-linux@roeck-us.net>
 <alpine.LNX.2.21.1805271212480.9@nippy.intranet>
 <55c1c33b-4a34-bd72-57de-577ce8d95e0b@gmail.com>
 <alpine.LNX.2.21.1805271547090.9@nippy.intranet>
Cc: Guenter Roeck <linux@roeck-us.net>, Joshua Thompson <funaho@jurai.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <2ffd0de6-e8d6-6449-7c05-cbbfd8a99a97@gmail.com>
Date: Mon, 28 May 2018 17:20:33 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1805271547090.9@nippy.intranet>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 27.05.2018 um 17:49 schrieb Finn Thain:
> On Sun, 27 May 2018, Michael Schmitz wrote:
> 
>> That should have fixed the warning already ...
> 
> It's still not fixed (hence my "acked-by" for Geunter's patch).
> 

Odd - does link order still matter even though the
arch_setup_dev_archdata() function from the core platform code is
declared as a weak symbol?

I'll see what I can find out on elgar ...

Cheers,

	Michael
