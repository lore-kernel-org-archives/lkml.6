Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbeBHTRg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 14:17:36 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49136 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeBHTRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 14:17:35 -0500
Subject: Re: [PATCH] mm/zpool: zpool_evictable: fix mismatch in parameter name
 and kernel-doc
To: Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
References: <1518116984-21141-1-git-send-email-rppt@linux.vnet.ibm.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1a8a3fb7-3061-d9e7-a42c-53ae96c8ca29@infradead.org>
Date: Thu, 8 Feb 2018 11:17:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1518116984-21141-1-git-send-email-rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2018 11:09 AM, Mike Rapoport wrote:
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
>  mm/zpool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/zpool.c b/mm/zpool.c
> index f8cb83e7699b..9d53a1ef8f1e 100644
> --- a/mm/zpool.c
> +++ b/mm/zpool.c
> @@ -360,7 +360,7 @@ u64 zpool_get_total_size(struct zpool *zpool)
>  
>  /**
>   * zpool_evictable() - Test if zpool is potentially evictable
> - * @pool	The zpool to test
> + * @zpool	The zpool to test

  + * @zpool:	The zpool to test

>   *
>   * Zpool is only potentially evictable when it's created with struct
>   * zpool_ops.evict and its driver implements struct zpool_driver.shrink.
> 


-- 
~Randy
