Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02848C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22192083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22192083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755100AbeFTT6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:58:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:58347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755087AbeFTT60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:58:26 -0400
Received: from [192.168.123.75] ([95.223.128.184]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MdXSC-1fqgxb1XSO-00PPVd; Wed, 20
 Jun 2018 21:57:47 +0200
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: correct voltage selector
 Firefly-RK3399
To:     khilman@baylibre.com
Cc:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Vagrant Cascadian <vagrant@debian.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180604171523.28454-1-xypron.glpk@gmx.de>
 <10782218.jfpm9omiT7@phil> <459cb125-a3e2-8f1e-b960-011020d41b3c@gmx.de>
 <6592028.l3WmXB2ndK@diego>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <cd7447bc-1c3d-29ca-9671-144b1f474711@gmx.de>
Date:   Wed, 20 Jun 2018 21:57:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6592028.l3WmXB2ndK@diego>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9Uc4LVn18UpNJMehHUP2qrH9b2oIyrxKJo7JDzBmooSZXNLMkx3
 fWBA9bQ40UyHHAxGfw7fopZnlmLDThUoPk0HEBCFydSGFAuDYJtzgwdytPFqJn/Im3FjWRz
 mFiI309laSnrk1M/TWd1Zcr4B3DORpHfO849/ppkWRZCy5alQ3KOy9j5U5zX8C+LnLoqCdP
 jcudCOcQRt5cl4RnmErdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E21+rBdGZO0=:xy0zc4Cm0DhLdqwTDvyhFC
 Ev9lU3NwwRekXiaHE/idnvorLf2HIo88Ahj8hL3xZmX2ziExDkppfXDPmCPBJoYK1q7NX3SLZ
 B7Y4KsqSHCUSfnXXH/a+NGA9GNqKMOu7S+fTQbXa9FxiXA9LL5HoxGCA8AmA6Abf3tPwu0jiz
 MSZoJgRjxuJm3bz0f3gdURyXkU6dG0MyaoEMvGykA9szieCan7XAbNvLEELP8BmMp1f4iWxUx
 Q030xDUCAgkRBsgaIaWGjvQKT2qiZDoPHpkUsxptEVkIMG9i3bUUqLZjOFy2X9O3fCbUacFrj
 uiYSLb5IjoOcJ+mEiNYh22YYfL1iUwVGsAeJcdUngIaI/KiuF0C4Wo2UKZAqgxE3Dda6+jrjJ
 UILXx68B80JAQD/X5KXctvPlHpqOHJnNDhmhty0uzJsDJUhjaQrL4nTkgn5ls007pOCgPuKZl
 q3XkmKRKKUsScdWPfZdtgzzgxepVF0EKIwQylVGgvh4dYWFozP11KNQ/LeYc8/U9jj1gy67TA
 hKfRuAo9U5SyjkP2plz4dMZcTZ5esO5LMx49ISk5UpgnRRlyxC4bcKIQ3y1hhbAwURR/lfd9F
 do0hjd0QmlhObn1pbYcvu/3eRydb2cOvV2ETN0yKRXMLS0EdQ7fE4mfzdQ4RRKFd2BAtKsDqx
 h1QHsa6FeXk+5lmkxdVyssD3l0oQUxLdcBzxX/RCwSups1/zSHnigsORZQCuJRrpbJCzRIGBt
 +/O3ccH6jylfOLGS244BvCEg0NdPDLPSIjhySFGXcuTN369l5kMxoDWlUPdGOkjyz4i/Q3NXo
 Ie38jqp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 11:15 AM, Heiko Stübner wrote:
> Hi Heinrich,
> 
> Am Mittwoch, 20. Juni 2018, 07:59:34 CEST schrieb Heinrich Schuchardt:
>> On 06/20/2018 01:21 AM, Heiko Stuebner wrote:
>>> Am Donnerstag, 14. Juni 2018, 14:55:27 CEST schrieb Heiko Stuebner:
>>>> Am Montag, 4. Juni 2018, 19:15:23 CEST schrieb Heinrich Schuchardt:
>>>>> Without this patch the Firefly-RK3399 board boot process hangs after
>>>>> these
>>>>>
>>>>> lines:
>>>>>    fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
>>>>>    fan53555-reg: supplied by vcc_sys
>>>>>    vcc1v8_s3: supplied by vcc_1v8
>>>>>
>>>>> Blacklisting driver fan53555 allows booting.
>>>>>
>>>>> The device tree uses a value of fcs,suspend-voltage-selector different
>>>>> to
>>>>> any other board.
>>>>>
>>>>> Changing this setting to the usual value is sufficient to enable
>>>>> booting.
>>>>>
>>>>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>>
>>>> applied for 4.19.
>>>
>>> and dropped again.
>>>
>>> Sadly it looks like the patch causes conflicts with at least one firefly
>>> board in a kernelci lab. My own is currently not ready to use, so I cannot
>>> look myself right now.
>>>
>>> The issue kernelci people described sounded quite a lot like the one
>>> in your commit message, so my current theory is that the
>>> suspend-voltage-selector must in some form corespond to the
>>> cpu_b_sleep_h gpio setting we're currently not handling at all, which
>>> would therefore depend on how the bootloader sets this up.
>>
>> please, provide a link to the log displaying the issue and the contact
>> who can provide the exact setup.
>>
>> I have been testing with U-Boot as boot loader.
> 
> failing boot can be found on
> https://kernelci.org/boot/id/5b2a053d59b514569079a872/
> 
> As this board is sitting in the "lab-baylibre-seattle", I guess
> Kevin Hilman (Cc'ed now) is the one that can say a bit more about the
> board setup.
> 
> 
> The more interesting question would be how to make sure we don't
> die with possible different bootloader versions. As I don't really thing 
> "upgrade your bootloader" is an always valid option.
> 
> 
> Heiko
> 

Hi Kevin,

the RK3399-Firefly was booted on lab-baylibre-seattle with
U-Boot 2017.05-rc3-00131-gf79fd58d5f5c-dirty

f79fd58d5f5c is not a commit in U-Boot master.
The version number tells us it is 131 patches ahead of U-Boot 2017.05-rc3.
Dirty means the source contained uncommitted changes.

Unfortunately this is not a reproducible test environment.
Could you, please, provide the build recipe to reproduce the U-Boot
BayLibre is using?
Would it be possible to use mainline U-Boot in kernelci for this board?

Best regards

Heinrich
