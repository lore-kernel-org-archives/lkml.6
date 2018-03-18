Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754132AbeCRNvV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 09:51:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44482 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753919AbeCRNvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 09:51:17 -0400
Subject: Re: [PATCHv2 4/5] arm64: dts: allwinner: a64: Add pwm device
To: Rob Herring <robh@kernel.org>, Harald Geyer <harald@ccbib.org>
References: <20180315162510.11669-1-harald@ccbib.org>
 <20180315162510.11669-5-harald@ccbib.org>
 <20180318032309.dys4p5gth5fvyawn@rob-hp-laptop>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        info@olimex.com
From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <1d6ba3e9-e2e7-c121-dc6d-7d4b867316ab@arm.com>
Date: Sun, 18 Mar 2018 13:51:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180318032309.dys4p5gth5fvyawn@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/18 12:52, Rob Herring wrote:
> On Thu, Mar 15, 2018 at 04:25:09PM +0000, Harald Geyer wrote:
>> This device is compatible with A13, so no new driver is needed.
>> A new compatible string is reserved in the binding documentation, to be
>> used together with the proper fall back. Tested on Teres-I.
>>
>> Signed-off-by: Harald Geyer <harald@ccbib.org>
>> ---
>> changes since v1:
>>  * add and use an A64 specific compatible string
>>  * claim the full memory range
>>
>> I saw that Andre Przywara has been working on A64 pwm too and has
>> submitted some patches a few days ago. I think his patches are functionally
>> equivalent to this one here, but clean up things a bit and additionally
>> add support for r_pwm and thus are preferable. See:
>>
>> https://groups.google.com/forum/#!topic/linux-sunxi/hQFeteP591k
>>
>> I'm including my patch here mostly to have a consistent series for others
>> to test. OTOH you might merge the device tree changes here and pick up
>> the cleanup patches from him. Either way should work fine.
> 
> I would sync up with Andre and send out a combined series. Don't make 
> the maintainer(s) have to sort this out.

I have something ready, but need to test it. Will try to send an updated
series later tonight.

Thanks,
Andre.

> 
>>  Documentation/devicetree/bindings/pwm/pwm-sun4i.txt |  1 +
>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi       | 14 ++++++++++++++
>>  2 files changed, 15 insertions(+)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
