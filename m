Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF06C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B19F215FA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B19F215FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeHHMsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:48:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53384 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726680AbeHHMsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:48:15 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A887A2B91FEBC;
        Wed,  8 Aug 2018 18:29:08 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Wed, 8 Aug 2018
 18:29:04 +0800
Subject: Re: [PATCH] arm64: dts: hisilicon: Add missing clocks property for
 CPUs
To:     Viresh Kumar <viresh.kumar@linaro.org>
References: <6de0dde994326b3fdc2b746e22fdf1afe18067d2.1532315177.git.viresh.kumar@linaro.org>
 <20180731072414.vymng6k5uamgmyhi@vireshk-i7>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B6AC5EB.3030808@hisilicon.com>
Date:   Wed, 8 Aug 2018 11:28:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180731072414.vymng6k5uamgmyhi@vireshk-i7>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 2018/7/31 8:24, Viresh Kumar wrote:
> On 23-07-18, 08:36, Viresh Kumar wrote:
>> The clocks property should either be present for all the CPUs of a
>> cluster or none. If these are present only for a subset of CPUs of a
>> cluster then things will start falling apart as soon as the CPUs are
>> brought online in a different order. For example, this will happen
>> because the operating system looks for such properties in the CPU node
>> it is trying to bring up, so that it can register a cooling device.
>>
>> Add missing clocks property.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 7 +++++++
>>  1 file changed, 7 insertions(+)
> 
> @Wei: Can you please apply this one as well ?

Sorry for the late reply!
I will apply it after 4.19-rc1 released.
Thanks!

Best Regards,
Wei

