Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeECTdZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 15:33:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:35638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751178AbeECTdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 15:33:22 -0400
Date: Thu, 3 May 2018 21:33:19 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Greg Thelen <gthelen@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: mark memcg1_events static const
Message-ID: <20180503193319.GK4535@dhcp22.suse.cz>
References: <20180503192940.94971-1-gthelen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503192940.94971-1-gthelen@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-05-18 12:29:40, Greg Thelen wrote:
> Mark memcg1_events static: it's only used by memcontrol.c.
> And mark it const: it's not modified.
> 
> Signed-off-by: Greg Thelen <gthelen@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2bd3df3d101a..c9c7e5ea0e2f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3083,7 +3083,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
>  #endif /* CONFIG_NUMA */
>  
>  /* Universal VM events cgroup1 shows, original sort order */
> -unsigned int memcg1_events[] = {
> +static const unsigned int memcg1_events[] = {
>  	PGPGIN,
>  	PGPGOUT,
>  	PGFAULT,
> -- 
> 2.17.0.441.gb46fe60e1d-goog

-- 
Michal Hocko
SUSE Labs
