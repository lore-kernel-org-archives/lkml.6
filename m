Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeBHTQd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 14:16:33 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49114 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBHTQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 14:16:32 -0500
Subject: Re: [PATCH] mm/swap.c: make functions and their kernel-doc agree
 (again)
To: Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <1518116946-20947-1-git-send-email-rppt@linux.vnet.ibm.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <931229b3-cf82-0999-ac85-c19578a6ee2a@infradead.org>
Date: Thu, 8 Feb 2018 11:16:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1518116946-20947-1-git-send-email-rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2018 11:09 AM, Mike Rapoport wrote:
> There was a conflict between the commit e02a9f048ef7 ("mm/swap.c: make
> functions and their kernel-doc agree") and the commit f144c390f905 ("mm:
> docs: fix parameter names mismatch") that both tried to fix mismatch
> betweeen pagevec_lookup_entries() parameter names and their description.
> 
> Since nr_entries is a better name for the parameter, fix the description
> again.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Thanks, I hadn't noticed.

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  mm/swap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 567a7b96e41d..6d7b8bc58003 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -913,7 +913,7 @@ EXPORT_SYMBOL(__pagevec_lru_add);
>   * @pvec:	Where the resulting entries are placed
>   * @mapping:	The address_space to search
>   * @start:	The starting entry index
> - * @nr_pages:	The maximum number of pages
> + * @nr_entries:	The maximum number of pages
>   * @indices:	The cache indices corresponding to the entries in @pvec
>   *
>   * pagevec_lookup_entries() will search for and return a group of up
> 


-- 
~Randy
