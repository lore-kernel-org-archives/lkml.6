Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeBWOQZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:16:25 -0500
Received: from lucky1.263xmail.com ([211.157.147.133]:53908 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeBWOQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:16:24 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 220.200.59.233
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <83ba301f6ffc7ca1d298e26214da2a82>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
        devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: dw_mmc-k3: Fix out-of-bounds access through DT
 alias
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <1519389859-14947-1-git-send-email-geert+renesas@glider.be>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <0a25cd94-e395-8ebd-a610-f006fcb253b1@rock-chips.com>
Date: Fri, 23 Feb 2018 22:07:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1519389859-14947-1-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/2/23 20:44, Geert Uytterhoeven wrote:
> The hs_timing_cfg[] array is indexed using a value derived from the
> "mshcN" alias in DT, which may lead to an out-of-bounds access.


Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

-- 
Best Regards
Shawn Lin
