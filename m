Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbeBSDoc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 22:44:32 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34154 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeBSDoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 22:44:30 -0500
X-Google-Smtp-Source: AH8x227AbiwIAZ5lirGpgTXQx3VrZTLwTzWrk5kqQ/oGB2FlOz5dSAe4+BL74qaZWosl72FDPabKAA==
Date: Mon, 19 Feb 2018 09:14:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: powernow-k8: Delete an unnecessary return
 statement in two functions
Message-ID: <20180219034427.GK28462@vireshk-i7>
References: <4dd36236-fc39-19e6-c1a7-a094cf13469c@users.sourceforge.net>
 <f673f072-86f3-ed72-e715-bed883551be4@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f673f072-86f3-ed72-e715-bed883551be4@users.sourceforge.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-02-18, 20:30, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 15 Feb 2018 20:14:32 +0100
> 
> The script "checkpatch.pl" pointed information out like the following.
> 
> WARNING: void function return statements are not generally useful
> 
> Thus remove such a statement in the affected functions.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/cpufreq/powernow-k8.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index 460bf22a8a2b..782a8c2a359d 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -122,14 +122,12 @@ static int query_current_values_with_pending_wait(struct powernow_k8_data *data)
>  static void count_off_irt(struct powernow_k8_data *data)
>  {
>  	udelay((1 << data->irt) * 10);
> -	return;
>  }
>  
>  /* the voltage stabilization time */
>  static void count_off_vst(struct powernow_k8_data *data)
>  {
>  	udelay(data->vstable * VST_UNITS_20US);
> -	return;
>  }
>  
>  /* need to init the control msr to a safe value (for each cpu) */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
