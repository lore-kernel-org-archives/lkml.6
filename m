Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4C6C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E021D2077B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E021D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=monom.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753949AbeGFOWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:22:22 -0400
Received: from mail.monom.org ([188.138.9.77]:38728 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753450AbeGFOWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:22:20 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 3C2305008FD;
        Fri,  6 Jul 2018 16:22:18 +0200 (CEST)
Received: from helium.monom.org (ppp-93-104-177-179.dynamic.mnet-online.de [93.104.177.179])
        by mail.monom.org (Postfix) with ESMTPSA id 64883500844;
        Fri,  6 Jul 2018 16:22:17 +0200 (CEST)
Subject: Re: hrtimer become inaccurate with RT patch
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        gengdongjiu <gengdongjiu@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        anna-maria@linutronix.de, john.stultz@linaro.org,
        Hangaohuai <hangaohuai@huawei.com>,
        "zhangjianwei (D)" <zhangjianwei8@huawei.com>,
        yangchuanlong@huawei.com,
        "Zhangbin (EulerOS)" <zhangbin46@huawei.com>,
        liupeifeng3@huawei.com
References: <12e6da4e-7681-771f-38d3-3c1abf943c24@huawei.com>
 <43d78927-3955-acde-a2d1-d2b82932a7a6@huawei.com>
 <20180702101420.rskzwqrdyws5fl6m@breakpoint.cc>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <bce8b710-a57b-fb7b-f784-b13d415aa451@monom.org>
Date:   Fri, 6 Jul 2018 16:22:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702101420.rskzwqrdyws5fl6m@breakpoint.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 12:14 PM, Sebastian Andrzej Siewior wrote:
> On 2018-07-02 17:34:34 [+0800], gengdongjiu wrote:
>>    The Linux kernel version is v4.1.46, and the preempt_rt patch is
>> patch-4.1.46-rt52.patch.
> 
> the 4.1 series is no longer supported (neither RT wise nor non-RT,
> https://www.kernel.org/category/releases.html). I suggest to move away.
> If you notice this problem now it is hardly a long running project.

Who can edit this page:

https://wiki.linuxfoundation.org/realtime/preempt_rt_versions

? It still lists 4.1-rt as supported.
