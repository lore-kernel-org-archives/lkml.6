Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbeBWCWR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 21:22:17 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:65354 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750916AbeBWCWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 21:22:16 -0500
X-UUID: a67e4de9560d471395065d743ec05193-20180223
Message-ID: <1519352530.9025.63.camel@mtkswgap22>
Subject: Re: [PATCH] cpufreq: mediatek: Convert pr_warn() to pr_debug()
From: Sean Wang <sean.wang@mediatek.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: Rafael Wysocki <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date: Fri, 23 Feb 2018 10:22:10 +0800
In-Reply-To: <5bc4db542fa521c32d295f490a1ad1dadf715098.1519278976.git.viresh.kumar@linaro.org>
References: <5bc4db542fa521c32d295f490a1ad1dadf715098.1519278976.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-22 at 11:26 +0530, Viresh Kumar wrote:
> With multi-platform build images, this shows a message on non mediatek
> platforms, which is unnecessary. Convert pr_warn() to pr_debug() here.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 8c04dddd3c28..84d658d57029 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -578,7 +578,7 @@ static int __init mtk_cpufreq_driver_init(void)
>  	match = of_match_node(mtk_cpufreq_machines, np);
>  	of_node_put(np);
>  	if (!match) {
> -		pr_warn("Machine is not compatible with mtk-cpufreq\n");
> +		pr_debug("Machine is not compatible with mtk-cpufreq\n");
>  		return -ENODEV;
>  	}
>  

Acked-by: Sean Wang <sean.wang@mediatek.com>
