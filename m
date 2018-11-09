Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996A3C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD342081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD342081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeKJHZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:25:21 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50418 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727181AbeKJHZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:25:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TCdMYTF_1541799747;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TCdMYTF_1541799747)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 10 Nov 2018 05:42:29 +0800
Subject: Re: ODEBUG: Out of memory. ODEBUG disabled
To:     Qian Cai <cai@gmx.us>, open list <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Zhong Jiang <zhongjiang@huawei.com>
References: <54B1AA39-2C58-4B0C-B8A8-9F85EBA7C963@gmx.us>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <5c3b1cf4-1d83-c0a5-4243-28fde66b5cd9@linux.alibaba.com>
Date:   Fri, 9 Nov 2018 13:42:24 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <54B1AA39-2C58-4B0C-B8A8-9F85EBA7C963@gmx.us>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/18 1:36 PM, Qian Cai wrote:
> It is a bit annoying on this aarch64 server with 64 CPUs that is
> booting the latest mainline (3541833fd1f2) causes object debugging
> always running out of memory.

May you please paste the detail failure log?

>
> I have to boot the kernel with only 16 CPUs instead (nr_cpus=16)
> to make it work. Is it expected that object debugging is not going
> to work with large machines?

I don't think so. I'm supposed it works well with large CPU number on x86.

Thanks,
Yang


