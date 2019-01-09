Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C5EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69AC20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfAIKUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:20:15 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54474 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730184AbfAIKUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:20:14 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 80CD6139428BCF27773E;
        Wed,  9 Jan 2019 18:20:12 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Wed, 9 Jan 2019
 18:20:05 +0800
Subject: Re: [PATCH v2 0/4] add support for MBIGEN generating message based
 SPIs
To:     Yang Yingliang <yangyingliang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <marc.zyngier@arm.com>, <tglx@linutronix.de>,
        Linuxarm <linuxarm@huawei.com>
References: <1540540280-26612-1-git-send-email-yangyingliang@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <08646b86-8228-4920-00cb-6c3f44c4484b@huawei.com>
Date:   Wed, 9 Jan 2019 18:18:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1540540280-26612-1-git-send-email-yangyingliang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Sorry for ping you...

On 2018/10/26 15:51, Yang Yingliang wrote:
> Now MBIGENs have pins that used to generate SPIs,
> with
> 5052875 ("irqchip/gic-v3: Add support for Message Based Interrupts as an MSI controller"),
> we can support MBIGEN to generate message based SPIs by writing
> GICD_SETSPIR. This patchset add support for MBIGEN generating
> message based SPIs and a bugfix for MBI driver.

What's you suggestion for this patch set? We would like your input
for next steps.

> 
> 
> Patch #1 is a bugfix for MBI driver.

At least this patch can be merged first as it's an obvious bug,
without this patch, the MBI dirver can't work I think because
the mutex lock is not initialized.

Thanks
Hanjun

