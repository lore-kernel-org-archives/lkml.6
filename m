Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934111AbeBMKnG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:43:06 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43938 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933986AbeBMKnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:43:03 -0500
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: add cdn-dp node for rk3399.
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Brian Norris <briannorris@chromium.org>, groeck@chromium.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chris Zhong <zyw@rock-chips.com>
References: <20180207163150.16332-1-enric.balletbo@collabora.com>
 <20180207163150.16332-2-enric.balletbo@collabora.com>
 <6229682.fDmaELEjz4@phil>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <d8ec2613-b773-9bab-cb4c-1f58eb1c1356@collabora.com>
Date: Tue, 13 Feb 2018 11:42:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6229682.fDmaELEjz4@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 10/02/18 17:16, Heiko Stuebner wrote:
> Hi Enric,
> 
> Am Mittwoch, 7. Februar 2018, 17:31:49 CET schrieb Enric Balletbo i Serra:
>> From: Chris Zhong <zyw@rock-chips.com>
>>
>> Add a node for the cdn DP controller which is embedded in the rk3399
>> SoC.
>>
>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 50 ++++++++++++++++++++++++++++++++
> 
> It looks like there is no binding document at all for cdn-dp? At least
> I couldn't find one and the original series also didn't seem to include one.
> 
> And while I don't see anything problematic right with the used properties
> right now, I'd think we should really have a binding and give dt-maintainers
> a chance to complain, before adding devicetree nodes based on it.
> 
> I'd guess a mostly usable binding doc should already sit in the chromeos
> tree, which you could base a v2 of this series on?
> 
> 

Sure, I'll send a v2 for this series. Thanks.

  Enric

> Thanks
> Heiko
> 
