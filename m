Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeDDTYn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 15:24:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeDDTYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 15:24:41 -0400
Subject: Re: [PATCH] prctl: Deprecate non PR_SET_MM_MAP operations
To: Cyrill Gorcunov <gorcunov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20180404185523.GG15783@uranus.lan>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6c784c94-e7a3-7dad-20bc-179a8720e98c@infradead.org>
Date: Wed, 4 Apr 2018 12:24:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180404185523.GG15783@uranus.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/04/2018 11:55 AM, Cyrill Gorcunov wrote:

> ---
>  kernel/sys.c |  146 -----------------------------------------------------------
>  1 file changed, 2 insertions(+), 144 deletions(-)
> 
> Index: linux-ml.git/kernel/sys.c
> ===================================================================
> --- linux-ml.git.orig/kernel/sys.c
> +++ linux-ml.git/kernel/sys.c

> +	pr_warn_once("Non PR_SET_MM_MAP operations are deprecated\n");
> +	return -EINVAL;
>  }

I'm not against removing such functionality, but I think that it's more than
"deprecated."  It's gone.

-- 
~Randy
