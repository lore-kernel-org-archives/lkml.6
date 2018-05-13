Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeEMUxO convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 16:53:14 -0400
Received: from gloria.sntech.de ([95.129.55.99]:36964 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751438AbeEMUxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 16:53:13 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Tao Huang <huangtao@rock-chips.com>
Cc: Elaine Zhang <zhangqing@rock-chips.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org, khilman@kernel.org,
        xxx@rock-chips.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, xf@rock-chips.com,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        Finley Xiao <finley.xiao@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, wxt@rock-chips.com
Subject: Re: [PATCH v1 11/13] dt-bindings: power: add PX30 SoCs header for power-domain
Date: Sun, 13 May 2018 22:53:00 +0200
Message-ID: <1550439.0mAU4944n0@diego>
In-Reply-To: <9c9606f0-5c97-1a6e-a3c5-f6380c16fea4@rock-chips.com>
References: <1526009458-28579-1-git-send-email-zhangqing@rock-chips.com> <508694354.7btLQf7nsA@phil> <9c9606f0-5c97-1a6e-a3c5-f6380c16fea4@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Sonntag, 13. Mai 2018, 17:18:12 CEST schrieb Tao Huang:
> Hi Heiko:
> 
> On 2018年05月12日 06:11, Heiko Stuebner wrote:
> > Here I have a naming question. When looking at the vendor kernel
> > it looks like the px30 is largely related to the rk3326.
> > (rk3326.dtsi includeing the px30.dtsi)
> > 
> > What is the reason for basing the naming on the px30 this time? And could
> > we possibly keep to rkXXXX names for the basic things in the kernel, thus
> > keeping the pxXX as second name, like with the other px-variants before?
> 
> PX30 and RK3326 are different chips. PX30 has more features. You can simply
> think that RK3326 is a subset of PX30. The RK3326 is more like a PX30
> derivative chip. This is not the same as the previous chips. So we use PX30
> instead of RK3326 for name, and the opening document is only for PX30, we
> think this is more convenient for developers.

ok, sounds reasonable :-) ... So we'll stay with the PX30.


Heiko
