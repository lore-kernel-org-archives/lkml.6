Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D74C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE1A2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE1A2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753906AbeFTGAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:00:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:50875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751092AbeFTGAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:00:21 -0400
Received: from [192.168.123.75] ([95.223.128.184]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LosFD-1g73xo2taN-00goCs; Wed, 20
 Jun 2018 07:59:39 +0200
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: correct voltage selector
 Firefly-RK3399
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
 <19360053.2ABrQ075F2@phil> <10782218.jfpm9omiT7@phil>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <459cb125-a3e2-8f1e-b960-011020d41b3c@gmx.de>
Date:   Wed, 20 Jun 2018 07:59:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <10782218.jfpm9omiT7@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RQAhDW2tAnAPfk1SlKWnCUDXnYYLV/BkOhmZN4eY1pYOfQNO2Vv
 Wbm7lOuRPxv08DqaPTjPrm43wJMTE4iQoICBJz7SGY6/7vMfRMkb83jMDzt604eNOqmSXcY
 fhY/4RI1o6IcQdc9MZ5MCFu3FNO1Mm3MveOhPndVbqZ2RSV79lxdLVMoC6n9VTaDVyh71jC
 /EhPuanPubIOEYOCsheGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lOZNng23o3U=:B7etnm4y7Z9mQD3htLxSHy
 CflHHImqsEtrfVUcG2AsWkzc4maSk3if71pYLytkVyKkdULoi4ow7IUiOxlhcK0sEtCfobQZc
 6UolTYYCtM9jEM+tjUsfooRpm8h/2J8QEcU6MceSlwwlIpLiODAhLVXxGVbs+qykdjkVW1xH7
 dMEE+0nL8UcOifLD3c33OFQFbkgu/fG5b6yzV1MLbtUbcE9y5AgfhGolrXB4b4us6fcedQeZ6
 sKGcPh3GqBQOH/PmwbYkzxY1IDGKzXK7fkAKuIlUAJgkH/BB58eB7LKz0lcfqao3kzVySmoKP
 9hhqeVgJNjF7XZiwqmGr7ZC9+XAw5JdyE1+vqR1lCU8KO0+erF8ooWEL9fJ3PNawPd6iJSskZ
 6QOeFdOZbemUKZpQxPm+wOlzIT5baxhIF5BKeUbpAW2YuFvmaUq3x88aFBR3fYRXN+CZ5l22/
 9lMWcKY0q+fUYe4P5oBhO0oN/Ufx+qPvxxCHppEYHXwQ3hTHFBA8EFM+ZQgyOvp2g+sS0PmBR
 COeQG3msKKbEtYyKc/x25mdTrzegYfKKvJNP/S/mUZEqnGK5XNTldwNbtGv8LdgeK5u224dP4
 29A5xef+w7m6PG4IBXZdgh7NqRcsO7CiNP50WnIcdjIv6rYp7n/ZCdIlO0xTCmRxNx9LWyaZm
 4xTX7Q/BgquWM/B54HGQoE6OSVzaIno7odM/tl7Ml60tE74pwlAdnDB0qPV9Xh6wLmZx5SkDj
 nksfMvFIbMW6LwezhB//St1Q+QYgUKy1axHSvsoguQKwh7N1203qQTL/AqdnpERZ8goa18Xj1
 D+v5alQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 01:21 AM, Heiko Stuebner wrote:
> Hi Heinrich,
> 
> Am Donnerstag, 14. Juni 2018, 14:55:27 CEST schrieb Heiko Stuebner:
>> Am Montag, 4. Juni 2018, 19:15:23 CEST schrieb Heinrich Schuchardt:
>>> Without this patch the Firefly-RK3399 board boot process hangs after these
>>> lines:
>>>
>>>    fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
>>>    fan53555-reg: supplied by vcc_sys
>>>    vcc1v8_s3: supplied by vcc_1v8
>>>
>>> Blacklisting driver fan53555 allows booting.
>>>
>>> The device tree uses a value of fcs,suspend-voltage-selector different to
>>> any other board.
>>>
>>> Changing this setting to the usual value is sufficient to enable booting.
>>>
>>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>
>> applied for 4.19.
> 
> and dropped again.
> 
> Sadly it looks like the patch causes conflicts with at least one firefly
> board in a kernelci lab. My own is currently not ready to use, so I cannot
> look myself right now.
> 
> The issue kernelci people described sounded quite a lot like the one
> in your commit message, so my current theory is that the
> suspend-voltage-selector must in some form corespond to the
> cpu_b_sleep_h gpio setting we're currently not handling at all, which
> would therefore depend on how the bootloader sets this up.
> 

Hi Heiko,

please, provide a link to the log displaying the issue and the contact
who can provide the exact setup.

I have been testing with U-Boot as boot loader.

Best regards

Heinrich
