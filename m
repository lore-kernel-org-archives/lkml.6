Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbeDYGbI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 02:31:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:37341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbeDYGbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 02:31:05 -0400
Message-ID: <1524637829.5725.2.camel@gmx.de>
Subject: Re: [PATCH] sched: fix typo in error message
From: Mike Galbraith <efault@gmx.de>
To: Li Bin <huawei.libin@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, guohanjun@huawei.com
Date: Wed, 25 Apr 2018 08:30:29 +0200
In-Reply-To: <1524634900-1861-1-git-send-email-huawei.libin@huawei.com>
References: <1524634900-1861-1-git-send-email-huawei.libin@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5CsA3wqxuZ1p+kNmlubJtoT+NHE+TfS0H9KThbnlX1hG23WgOzJ
 tdlKQ9prVeLDfZX3AD+no9tpcypyg0Le+DJ5wsDEO7tPwZGrCpzImXK+6zR1TwOa0LR5tBH
 a/DnnccMx/PdVP4v1mxyIjTh5eq/jPKHu9Fe0fieRl4gS2PTFB4BJaP0fu95x0LZAHBxiMT
 wZuQ32VC0Q01CkLZOInbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ci41RGNdZ50=:jbr4Ge1o4VEdJudnj3ToY6
 k5np9NwgnuFsNoIMg750gLZjdIqvi6bB+Xdg+FsuO339rsSeSbmIrhSXjqu0RHY8Y+ooT/xY7
 4QwXZevNWJjbRbrhVJQG5mk26XhfGwC51XT6O5Qua4thtIB+w/ET9AAPM06jRRytcq1JwB2KX
 Qf1X+TCgMx6wYIX9wQe/PoP8LolAozU0IA3/amhngu8BI2Am6hidmUI+edMgmeztL7paHi+JS
 Y3Bl2LUueXz+nn76tMUtMCdwRui0dIAH+PsrAyy0j0JNNlVW0pI/U5AoVYKfLmovmZ89zqcEH
 PuHvwCv1q0KnAgEaNO7DNsZR0mg0ov4CmMBjb+Y0XHu5QFBHB1rXLkuyEvwwMt3dBQb7BkQMs
 1eznVM+RCn9lja9H/emCCnerDnsFwcQNKXZSlMwvEdkstnPMq+6BqmKpR4LAgrVCZLzSdB5EE
 W/8ukcF1h2djRDOkw5dRIeDNQbeLIHVZXFYypZ/xFI84EBDMQwpXFrsMLSx0cQcjdcT81FWDb
 Is4UhADCrDDbmvPO/tz5nR5L+95WZVTv6x7OOxIMoaE6Wxdc2mZCj7b66/L/nNBDx4BokNfB6
 BIbWBD9WJM8VEw4mTgSn92IgLDy9CjCLAF5r1kIhek7QmjGBetlSdSv/3QYkfjbagH9M2bphk
 N8MlEFU5nCkyvPsK5uOWMteFvsP5C5dXdcWnGPhVqZhd3vrQoXUxcetkBgMtlBVf4y6sIPVKt
 M5ebYnHN+KfCR9Mq8zzpAlXVZz/CJLc8jiHYW529L9fhj9pxxGk0puDCcjAKODJ49w3wDsX3C
 csPoLL6Mb6Ss5z92Z89d0cHo4xawVtIZFH1QRQlonK5vNhJoY0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 13:41 +0800, Li Bin wrote:
> Signed-off-by: Li Bin <huawei.libin@huawei.com>
> ---
>  kernel/sched/topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 64cc564..cf15c1c 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1618,7 +1618,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
>  
>  		if (!cpumask_subset(sched_domain_span(child),
>  				    sched_domain_span(sd))) {
> -			pr_err("BUG: arch topology borken\n");
> +			pr_err("BUG: arch topology broken\n");

That's not a typo, it's a kernel-speak synonym, as are "borked",
b0rked", "b0rken", "busted", "hosed", and lord knows how many other
colorful variants.  Non-native English speakers beware.

	-Mike
