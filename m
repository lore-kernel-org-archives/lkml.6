Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01BBC65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55396204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55396204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbeLJHuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:50:25 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51419 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726210AbeLJHuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:50:25 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 53C677816CEB0;
        Mon, 10 Dec 2018 15:50:22 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Mon, 10 Dec 2018
 15:50:22 +0800
Subject: Re: Disable RT_GROUP_SCHED in PREEMPT_RT_FULL
To:     zhang jianwei <jianwei_z@foxmail.com>, tglx <tglx@linutronix.de>,
        efault <efault@gmx.de>, <linux-rt-users@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <tencent_4E2198ADDEAE31C784F2AD886A44A9E3C605@qq.com>
From:   gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <194aa1b6-0d98-d4ef-397a-a6ddca02cc6a@huawei.com>
Date:   Mon, 10 Dec 2018 15:50:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <tencent_4E2198ADDEAE31C784F2AD886A44A9E3C605@qq.com>
Content-Type: text/plain; charset="gb18030"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loop RT kernel Mailing lists.


On 2018/12/10 1:04, zhang jianwei wrote:
> hi Thomas and Mike，
> i say you disabled the RT_GROUP_SCHED in RT kernel because of strange cpu stall was observed. currently, in my projects, I need enable RT_GROUP_SCHED in RT kernel. I’d like to know how to reproduce the strange cpu stall in order to fix this bug. can you guys give me some advice  about how to fix this problem.
> Thanks in advance!
> 
> 
> patched mentioned 
> https://lore.kernel.org/patchwork/patch/313215/
> 
> 

