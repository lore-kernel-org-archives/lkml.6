Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0355AC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE72D20874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE72D20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932734AbeFUA5t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:57:49 -0400
Received: from mout.gmx.net ([212.227.15.19]:37775 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932501AbeFUA5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:57:48 -0400
Received: from [192.168.123.89] ([95.223.128.184]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8eAd-1gQUw02bLv-00wBGB; Thu, 21
 Jun 2018 02:57:11 +0200
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: correct voltage selector
 Firefly-RK3399
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
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
 <6592028.l3WmXB2ndK@diego> <cd7447bc-1c3d-29ca-9671-144b1f474711@gmx.de>
Message-ID: <3b6e37c8-0ee2-1723-1aa8-499fcb30471c@gmx.de>
Date:   Thu, 21 Jun 2018 02:57:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <cd7447bc-1c3d-29ca-9671-144b1f474711@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lKAXo32hPaLoA0SMgy6zhiNw098Nf7WIxudHgfRoWHnY06Ni/HG
 n2sAzt8b82TLpxjWN/0IDuCaWxeRH8FcMHW5j5hEPwdwJ8X6mfKr4mzKsTOkR7iFKT4Jdlu
 LOKDhDoR+aavO0Mxz7il4TbIlU9YjiiS3Y/I95P6QObUxWM/UyiYjZh5JdAm6dxuCviXpn9
 1YaigL26OdNMyBuH+3Ugg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qlCijJbuyug=:2o0PRdVSKVqU4iy6mOwzKW
 euvRIZwwXJ/6VUxwy7JWtMXOV/UgTJKolZeHhb9lxXE/nrTxQjhVKEsuWB+bqhLUDhDsg2KPP
 XrwqWDg/6MfkI0BiD/ji2MupL/zCMtmipZ335fsapxdiGKdlycyZ6GxOk4JtZjkkApvYAaube
 9Ubf/eHynyTPNHe5EwRaHCxUkI84PdmQGKmkbTH038k5QChpDELwE2+hy3nru6qAaPmOoa7e0
 4wjfaGoaeLb/28SOLfeRcEYuy6OTv2wcv5DqPsJgQq+cSjgh3OIKov4VLdMQg7wKTmoqe2j6F
 0c1VR5WH1uZ0DUFa6/925apkk/TZC/rdFWs2regIWblhm7n0zrVY/le9D5UcIia3Qh4C5I9hx
 FIM0IFxnpvPRqM5qfE/uIEoHaMGHjJr+f3yqHmI1T5BFeugijJ0Cc12+92UKVCvCRg3wtMAQv
 uATta3ASM6HHDdxN1dCQOUz9m5HB4aVBvMWd7kD6egoPys4gl6R5CGFG0jVwvIkHkPqlQ44pQ
 8M5vS/SRE/BuQ0ZmOWd8w+J+08MCATOzrSOF3+YX804eXtfJBpODZZh+zAbB5Om9g/x1xVam/
 hhm/y63SNyFteyMIvmryGorfO7wqa69L4jMjsgLZZebdYwKUKUnVBrQQqCF2j91vju8XATPuF
 e8RwQRHBnBcTlycrIysQ+GBdjCPN5LeiOOthAcuY61pAfh3rRFNvjUvuVMlSPQHNRvaUCmL5H
 3exW2FkClGxHhCiY9WmtG7p4ikKzJUvWd4HJkTgwZvexP/lgMlJ4E92IR3bP1yb/I8Jr+Gx33
 n4bwtNx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 09:57 PM, Heinrich Schuchardt wrote:
> On 06/20/2018 11:15 AM, Heiko Stübner wrote:
>> Hi Heinrich,
>>
>> Am Mittwoch, 20. Juni 2018, 07:59:34 CEST schrieb Heinrich Schuchardt:
>>> On 06/20/2018 01:21 AM, Heiko Stuebner wrote:
>>>> Am Donnerstag, 14. Juni 2018, 14:55:27 CEST schrieb Heiko Stuebner:
>>>>> Am Montag, 4. Juni 2018, 19:15:23 CEST schrieb Heinrich Schuchardt:
>>>>>> Without this patch the Firefly-RK3399 board boot process hangs after
>>>>>> these
>>>>>>
>>>>>> lines:
>>>>>>    fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
>>>>>>    fan53555-reg: supplied by vcc_sys
>>>>>>    vcc1v8_s3: supplied by vcc_1v8
>>>>>>
>>>>>> Blacklisting driver fan53555 allows booting.
>>>>>>
>>>>>> The device tree uses a value of fcs,suspend-voltage-selector different
>>>>>> to
>>>>>> any other board.
>>>>>>
>>>>>> Changing this setting to the usual value is sufficient to enable
>>>>>> booting.
>>>>>>
>>>>>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>>>
>>>>> applied for 4.19.
>>>>
>>>> and dropped again.
>>>>
>>>> Sadly it looks like the patch causes conflicts with at least one firefly
>>>> board in a kernelci lab. My own is currently not ready to use, so I cannot
>>>> look myself right now.
>>>>
>>>> The issue kernelci people described sounded quite a lot like the one
>>>> in your commit message, so my current theory is that the
>>>> suspend-voltage-selector must in some form corespond to the
>>>> cpu_b_sleep_h gpio setting we're currently not handling at all, which
>>>> would therefore depend on how the bootloader sets this up.
>>>
>>> please, provide a link to the log displaying the issue and the contact
>>> who can provide the exact setup.
>>>
>>> I have been testing with U-Boot as boot loader.
>>
>> failing boot can be found on
>> https://kernelci.org/boot/id/5b2a053d59b514569079a872/
>>
>> As this board is sitting in the "lab-baylibre-seattle", I guess
>> Kevin Hilman (Cc'ed now) is the one that can say a bit more about the
>> board setup.
>>
>>
>> The more interesting question would be how to make sure we don't
>> die with possible different bootloader versions. As I don't really thing 
>> "upgrade your bootloader" is an always valid option.
>>
>>
>> Heiko
>>
> 
> Hi Kevin,
> 
> the RK3399-Firefly was booted on lab-baylibre-seattle with
> U-Boot 2017.05-rc3-00131-gf79fd58d5f5c-dirty
> 
> f79fd58d5f5c is not a commit in U-Boot master.
> The version number tells us it is 131 patches ahead of U-Boot 2017.05-rc3.
> Dirty means the source contained uncommitted changes.
> 
> Unfortunately this is not a reproducible test environment.
> Could you, please, provide the build recipe to reproduce the U-Boot
> BayLibre is using?
> Would it be possible to use mainline U-Boot in kernelci for this board?
> 
> Best regards
> 
> Heinrich
> 

I have now built the last available release of U-Boot (v2018.05)
according to the following recipe:

git clone https://github.com/xypron/u-boot-build.git
cd u-boot-build/
git checkout firefly-rk3399-rkloader
# commit 251b12fb4f0eabfff2d0552d0807d8ddc44ae2aa
# tag firefly-rk3399-rkloader-v2018.05
make
make install DESTDIR=foo
cd foo/usr/lib/u-boot/firefly-rk3399/
# be careful to specify your SD card as device!
./sd_fusing /dev/sdX

# in U-Boot 2018.05 (Jun 21 2018 - 02:33:12 +0200)
load mmc 1:1 ${fdt_addr_r} 2018-06-20/rk3399-firefly.dtb
load mmc 1:1 ${kernel_addr_r} 2018-06-20/Image
booti ${kernel_addr_r} - ${fdt_addr_r}

The error observed in kernelci when initializing the FAN53555 driver
does not occur.

The console log is here:
https://gist.github.com/xypron/34b6485deabfc8172f978b5a99705466

Best regards

Heinrich
