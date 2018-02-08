Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeBHOG0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:06:26 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35266 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeBHOGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:06:25 -0500
X-Google-Smtp-Source: AH8x227UDPcIRridOiVC9NaEAD4pTuwyxaPbyKRak7tM86pmbSdngLrFrwMLrPBM3eqXgYnFZQrYnQ==
Subject: Re: [PATCH] sched/cpufreq: Remove unused macro SUGOV_KTHREAD_PRIORITY
To: Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Vikram Mulukutla <markivx@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <1518097702-9665-1-git-send-email-leo.yan@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d1d26f1a-abd6-b271-2aa4-253074e337ff@linaro.org>
Date: Thu, 8 Feb 2018 15:06:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518097702-9665-1-git-send-email-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 14:48, Leo Yan wrote:
> Since schedutil kernel thread directly set priority to 0, the macro
> SUGOV_KTHREAD_PRIORITY is not used.  So remove it.
> 
> Cc: Vikram Mulukutla <markivx@codeaurora.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
