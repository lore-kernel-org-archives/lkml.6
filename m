Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077C7C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20AA24D4E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20AA24D4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbeFZQzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:55:04 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12287 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752489AbeFZQzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:55:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b326fe50000>; Tue, 26 Jun 2018 09:55:01 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Jun 2018 09:55:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Jun 2018 09:55:01 -0700
Received: from [10.21.132.122] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Jun
 2018 16:54:59 +0000
Subject: Re: [GIT PULL] RTC for 4.18
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180610221645.GA26123@piout.net>
 <ff6d048a-c683-56e0-13f9-1627cdfd0ea9@nvidia.com>
 <20180626161536.GH4207@piout.net>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <522c3fc8-a4cc-bd83-d034-b5c690e541d0@nvidia.com>
Date:   Tue, 26 Jun 2018 17:54:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626161536.GH4207@piout.net>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/06/18 17:15, Alexandre Belloni wrote:
> Hi,
> 
> On 26/06/2018 16:51:40+0100, Jon Hunter wrote:
>>>       rtc: tps6586x: let the core handle rtc range
>>
>> Sorry I am missing the original mail with the above change, but I
>> have noticed on v4.18-rc1 that rtc wake-ups from suspend are no
>> longer working on one of our Tegra boards. The bisect points to the
>> above change and reverting it fixes the problem. I have not had
>> chance to dig further, but if you have any thoughts, please let me
>> know.
> 
> 
> Thanks for the report, does the following patch fix the issue:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/patch/?id=1b287f23b0a1fcb2b502dae981a8024be379391e

Thanks. I gave the above a test, but still not waking-up from suspend.

Cheers
Jon

-- 
nvpublic
