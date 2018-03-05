Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933659AbeCEJdk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 04:33:40 -0500
Received: from lucky1.263xmail.com ([211.157.147.134]:58375 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeCEJdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 04:33:39 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <50ae7843605415c56e8635f1b9cfbabc>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc: linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-rockchip@lists.infradead.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: rockchip: power-domain: Add a sanity check on
 pd->num_clks
To: Jeffy Chen <jeffy.chen@rock-chips.com>
References: <20180305091722.22246-1-jeffy.chen@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <d0a0c26a-885e-72fb-3ce9-96944f137227@rock-chips.com>
Date: Mon, 5 Mar 2018 17:33:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305091722.22246-1-jeffy.chen@rock-chips.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffy,

On 2018/3/5 17:17, Jeffy Chen wrote:
> The of_count_phandle_with_args() can fail and return error(for example,
> rk3399 pd_vio doesn't have clocks). That would break the pd probe.
> 
> Add a sanity check on pd->num_clks to avoid that.
> 
> Fixes: 65084121d59d ("soc: rockchip: power-domain: use clk_bulk APIs")
> Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
