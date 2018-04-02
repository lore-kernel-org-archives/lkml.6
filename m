Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754115AbeDBB5W (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 21:57:22 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46995 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754037AbeDBB5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 21:57:21 -0400
X-Google-Smtp-Source: AIpwx4+oAjwDuQktc9QnumZiTyWec1VSWeXUkxG6TohkyoWy8sLGsqLjdWHm/oL6u/gAJ8qlcKKd7A==
Date: Mon, 2 Apr 2018 10:57:16 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        pantelis.antoniou@konsulko.com, mark.rutland@arm.com, pmladek@suse.com,
        andriy.shevchenko@linux.intel.com, joe@perches.com, corbet@lwn.net,
        me@tobin.cc, sergey.senozhatsky@gmail.com
Subject: Re: [PATCH 0/2] cowsay support
Message-ID: <20180402015716.GB3795@jagdpanzerIV>
References: <20180401085622.7754-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180401085622.7754-1-richard@nod.at>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/01/18 10:56), Richard Weinberger wrote:
> As the printk subsystem gains more and more popularity it is time to add
> the final missing feature to make it perfect, namely cowsay output.
> Currently only one type of cow is supported and the only user is kmsg,
> but I can see more use cases for it and the need for different cow types.
> 
> Example of /dev/kmsg usage:
> [    1.309561]   _________________________________________
> [    1.309561] < systemd[1]: Detected architecture x86-64. >
> [    1.309561]   -----------------------------------------
> [    1.309561]                     \   ^__^
> [    1.309561]                      \  (oo)\_______
> [    1.309561]                         (__)\       )\/\
> [    1.309561]                             ||----w |
> [    1.309561]                             ||     ||
> 
> Richard Weinberger (2):
>   lib: vsprintf: Implement %pCOW
>   printk: Use %pCOW for kmsg
> 

   ___________________________________________________________
 < Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com> >
   -----------------------------------------------------------
                     \   ^__^
                      \  (oo)\_______
                         (__)\       )\/\
                             ||----w |
                             ||     ||

	-ss
