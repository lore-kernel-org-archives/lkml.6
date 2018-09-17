Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C86BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0482086E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0482086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeIQPGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:06:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727012AbeIQPGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:06:16 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BA944BF644D29;
        Mon, 17 Sep 2018 17:39:37 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Mon, 17 Sep 2018
 17:39:34 +0800
Message-ID: <5B9F7654.3090603@huawei.com>
Date:   Mon, 17 Sep 2018 17:39:32 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <mingo@redhat.com>, <jikos@kernel.org>, <hpa@zytor.com>,
        <x86@kernel.org>, <rafael.j.wysocki@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/apm: Fix a unused function warning
References: <1537164066-39990-1-git-send-email-zhongjiang@huawei.com> <alpine.DEB.2.21.1809171123180.16580@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809171123180.16580@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/17 17:24, Thomas Gleixner wrote:
> On Mon, 17 Sep 2018, zhong jiang wrote:
>
>> Fix the following compile warning:
>>
>> arch/x86/kernel/apm_32.c:1643:12: warning: ?proc_apm_show? defined but not used [-Wunused-function]
>>  static int proc_apm_show(struct seq_file *m, void *v)
> Thanks for taking care, but it's already fixed the same way with:
>
>  002b87d2aace ("x86/APM: Fix build warning when PROC_FS is not enabled")
Fine.  Thanks for let me know that.  I has missed that.

Thanks,
zhong jiang
> Thanks,
>
> 	tglx
>
> .
>


