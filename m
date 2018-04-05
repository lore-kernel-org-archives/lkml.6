Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeDEEtr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 00:49:47 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:46998 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeDEEtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 00:49:45 -0400
X-Google-Smtp-Source: AIpwx4/jNIeb8WIseolWbXcCEYvJabx4h66zF3NQQBAsUZivzdZRZb0cck3zG+2gOkSankOV3MfMdA==
Date: Thu, 5 Apr 2018 10:19:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
Message-ID: <20180405044941.GK3572@vireshk-i7>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <1519226968-19821-7-git-send-email-daniel.lezcano@linaro.org>
 <20180223073432.GF26947@vireshk-i7>
 <faaf027c-e01c-6801-9a0c-ab7e0ba669a1@linaro.org>
 <20180226043021.GK26947@vireshk-i7>
 <78504a65-d21a-eea0-d8af-6e12d5747b87@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78504a65-d21a-eea0-d8af-6e12d5747b87@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-04-18, 10:50, Daniel Lezcano wrote:
> Mmh, that sounds very complex. May be it is simpler to count the number
> of cluster and initialize the idle_cdev for each cluster and then go for
> this loop with the cluster cpumask.

Maybe not sure. I have had such code in the past and it was quite
straight forward to understand :)

You can go with whichever version you like.

-- 
viresh
