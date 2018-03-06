Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753667AbeCFO2I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:28:08 -0500
Received: from lucky1.263xmail.com ([211.157.147.133]:34942 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeCFO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:28:06 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: vladimir_zapolskiy@mentor.com
X-SENDER-IP: 220.200.58.142
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <19c388a2931be0557130b71bd559ac66>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc: ulf.hansson@linaro.org, linus.walleij@linaro.org,
        adrian.hunter@intel.com, avri.altman@wdc.com,
        andriy.shevchenko@linux.intel.com, shawn.lin@rock-chips.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir_Zapolskiy@mentor.com
Subject: Re: [PATCH v5] mmc: Export host capabilities to debugfs.
To: Harish Jenny K N <harish_kandiga@mentor.com>
References: <1520344425-13131-1-git-send-email-harish_kandiga@mentor.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <6d51c3b3-abd3-82a8-ec7b-da063a9e5aaa@rock-chips.com>
Date: Tue, 6 Mar 2018 22:27:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520344425-13131-1-git-send-email-harish_kandiga@mentor.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/3/6 21:53, Harish Jenny K N wrote:
> This patch exports the host capabilities to debugfs
> 
> This idea of sharing host capabilities over debugfs
> came up from Abbas Raza <Abbas_Raza@mentor.com>
> Earlier discussions:
> https://lkml.org/lkml/2018/3/5/357
> https://www.spinics.net/lists/linux-mmc/msg48219.html
> 
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> ---
> 
> Changes in v5:
> - Added parser logic in kernel by using debugfs_create_file
>   for caps and caps2 instead of debugfs_create_x32

I'm fine with your method if Ulf likes it, but could you use
DEFINE_SHOW_ATTRIBUTE instead? :)



-- 
Best Regards
Shawn Lin
