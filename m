Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7FCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971F121900
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394483AbfBOMId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:08:33 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:51864 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbfBOMId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:08:33 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-04.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gucI4-0005MC-Ol from Akash_Gajjar@mentor.com ; Fri, 15 Feb 2019 04:08:24 -0800
Received: from [10.105.24.52] (137.202.0.90) by SVR-IES-MBX-04.mgc.mentorg.com
 (139.181.222.4) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 15 Feb
 2019 12:08:18 +0000
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: rockpro64 dts remove unused
 node
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Shohei Maruyama <cheat.sc.linux@outlook.com>,
        Levin Du <djw@t-chip.com.cn>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190213170651.3210-1-Akash_Gajjar@mentor.com>
 <20190213170651.3210-3-Akash_Gajjar@mentor.com> <4653141.o6ZdamfZ6d@diego>
From:   agajjar <Akash_Gajjar@mentor.com>
Message-ID: <ac22440d-3b64-1cf2-205c-52ea7c1c23f9@mentor.com>
Date:   Fri, 15 Feb 2019 17:38:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <4653141.o6ZdamfZ6d@diego>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/15/2019 2:48 PM, Heiko Stübner wrote:
> Am Mittwoch, 13. Februar 2019, 18:06:38 CET schrieb Akash Gajjar:
>> lcd panel pinmux and vcc1v8_s3 regulator is redundant and has a no impact,
>> so removing it.
>>
>> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
Hi Heiko,
> vcc1v8_s3 is actually also a emmc supply, so I'd like to keep it around
> for completenes sake.

Emmc module is supplied by PMIC vcc3v3_s3 (SWITCH_REG1) and vcc_1v8 
(DCD_REG4).

So I believe removing vcc1v8_s3 has no impact on emmc supply line.


Thanks,
Akash

>
> I've now dropped the regulator portions so that only the lcd-pinmux
> gets removed and reworded the commit message accordingly
> and applied the result for 5.1
>
> Thanks
> Heiko
>
>
>
