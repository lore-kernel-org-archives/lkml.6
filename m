Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbeBJRcb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 12:32:31 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:33167 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbeBJRca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 12:32:30 -0500
Subject: Re: [PATCH] MAINTAINERS: auxdisplay: remove obsolete webpages
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20180210095651.y7kvf3oqp6pzvh33@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <634edbaa-f877-8f61-b61c-79e060edf8b5@infradead.org>
Date: Sat, 10 Feb 2018 09:32:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180210095651.y7kvf3oqp6pzvh33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2018 01:56 AM, Miguel Ojeda wrote:
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Are you merging this directly to Linus?  or what?

Thanks.

> ---
>  MAINTAINERS | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e6c26cb47d02..01e302f7967e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2484,8 +2484,6 @@ F:	kernel/audit*
>  
>  AUXILIARY DISPLAY DRIVERS
>  M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> -W:	http://miguelojeda.es/auxdisplay.htm
> -W:	http://jair.lab.fi.uva.es/~migojed/auxdisplay.htm
>  S:	Maintained
>  F:	drivers/auxdisplay/
>  F:	include/linux/cfag12864b.h
> @@ -3373,16 +3371,12 @@ F:	include/linux/usb/wusb*
>  
>  CFAG12864B LCD DRIVER
>  M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> -W:	http://miguelojeda.es/auxdisplay.htm
> -W:	http://jair.lab.fi.uva.es/~migojed/auxdisplay.htm
>  S:	Maintained
>  F:	drivers/auxdisplay/cfag12864b.c
>  F:	include/linux/cfag12864b.h
>  
>  CFAG12864BFB LCD FRAMEBUFFER DRIVER
>  M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> -W:	http://miguelojeda.es/auxdisplay.htm
> -W:	http://jair.lab.fi.uva.es/~migojed/auxdisplay.htm
>  S:	Maintained
>  F:	drivers/auxdisplay/cfag12864bfb.c
>  F:	include/linux/cfag12864b.h
> @@ -7866,8 +7860,6 @@ F:	kernel/kprobes.c
>  
>  KS0108 LCD CONTROLLER DRIVER
>  M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> -W:	http://miguelojeda.es/auxdisplay.htm
> -W:	http://jair.lab.fi.uva.es/~migojed/auxdisplay.htm
>  S:	Maintained
>  F:	Documentation/auxdisplay/ks0108
>  F:	drivers/auxdisplay/ks0108.c
> 


-- 
~Randy
