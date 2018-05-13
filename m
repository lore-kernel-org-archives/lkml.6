Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeEMPSa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 11:18:30 -0400
Received: from regular1.263xmail.com ([211.150.99.131]:34294 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbeEMPS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 11:18:28 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: huangtao@rock-chips.com
X-FST-TO: huangtao@rock-chips.com
X-SENDER-IP: 110.90.96.23
X-LOGIN-NAME: huangtao@rock-chips.com
X-UNIQUE-TAG: <d31b5fe9abac2ef1539f56b195c1405d>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 7
Subject: Re: [PATCH v1 11/13] dt-bindings: power: add PX30 SoCs header for
 power-domain
To: Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, khilman@kernel.org, xxx@rock-chips.com,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, xf@rock-chips.com,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        Finley Xiao <finley.xiao@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, wxt@rock-chips.com
References: <1526009458-28579-1-git-send-email-zhangqing@rock-chips.com>
 <1526009672-2097-1-git-send-email-zhangqing@rock-chips.com>
 <508694354.7btLQf7nsA@phil>
From: Tao Huang <huangtao@rock-chips.com>
Message-ID: <9c9606f0-5c97-1a6e-a3c5-f6380c16fea4@rock-chips.com>
Date: Sun, 13 May 2018 23:18:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <508694354.7btLQf7nsA@phil>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko:
On 2018年05月12日 06:11, Heiko Stuebner wrote:
> Here I have a naming question. When looking at the vendor kernel
> it looks like the px30 is largely related to the rk3326.
> (rk3326.dtsi includeing the px30.dtsi)
>
> What is the reason for basing the naming on the px30 this time? And could
> we possibly keep to rkXXXX names for the basic things in the kernel, thus
> keeping the pxXX as second name, like with the other px-variants before?
>
PX30 and RK3326 are different chips. PX30 has more features. You can simply think that RK3326 is a subset of PX30. The RK3326 is more like a PX30 derivative chip. This is not the same as the previous chips.
So we use PX30 instead of RK3326 for name, and the opening document is only for PX30, we think this is more convenient for developers.

Best Regards,
Tao Huang
