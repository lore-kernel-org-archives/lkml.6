Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbeCTQgg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:36:36 -0400
Received: from foss.arm.com ([217.140.101.70]:42744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeCTQgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:36:33 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: prevent accessing rate_discrete
 uninitialized
To: Anders Roxell <anders.roxell@linaro.org>
References: <20180316114442.9536-1-anders.roxell@linaro.org>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <2f747a8a-3649-b78a-e4f3-4bd8fba66e60@arm.com>
Date: Tue, 20 Mar 2018 16:36:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316114442.9536-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders,

On 16/03/18 11:44, Anders Roxell wrote:
> gcc-5.3 and earlier warns that rate_discrete maybe-uninitialized
>     ../drivers/firmware/arm_scmi/clock.c:185:5: warning: 'rate_discrete'
>         may be used uninitialized in this function [-Wmaybe-uninitialized]
>       if (rate_discrete)
>          ^
>     ../drivers/firmware/arm_scmi/clock.c:128:7: note:
>         'rate_discrete' was declared here
>       bool rate_discrete;
>            ^
> 
Thanks for the fix, applied.

-- 
Regards,
Sudeep
