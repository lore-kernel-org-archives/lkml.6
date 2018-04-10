Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbeDJHGl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:06:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38812 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbeDJHGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:06:30 -0400
X-Google-Smtp-Source: AIpwx4/sSZffZwIf8OzjjQdymewC5jQ8JhSVgRp1OGB1KzJ6ESIytWsG4/XIbvnwTXcMyTrvgRSm3Q==
Date: Tue, 10 Apr 2018 09:06:26 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: akpm@linux-foundation.org, tglx@linutronix.de, keescook@chromium.org,
        pombredanne@nexb.com, bp@suse.de, abbotti@mev.co.uk,
        rdunlap@infradead.org, bhe@redhat.com, yamada.masahiro@socionext.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux/kernel.h: Fix minor type in comment
Message-ID: <20180410070626.u27zsu2kgkojax5l@gmail.com>
References: <20180410065734.4883-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410065734.4883-1-yuval.shaia@oracle.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yuval Shaia <yuval.shaia@oracle.com> wrote:

> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>  include/linux/kernel.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index ce51455e2adf..a5b4ba3bdb61 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -651,7 +651,7 @@ do {									\
>   * your code. (Extra memory is used for special buffers that are
>   * allocated when trace_printk() is used.)
>   *
> - * A little optization trick is done here. If there's only one
> + * A little optimization trick is done here. If there's only one
>   * argument, there's no need to scan the string for printf formats.
>   * The trace_puts() will suffice. But how can we take advantage of
>   * using trace_puts() when trace_printk() has only one argument?

Please also fix the typo in the title ;-)

Thanks,

	Ingo
