Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2452C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE3A204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE3A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeGIMEl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:04:41 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11931 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932528AbeGIMEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:04:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b434f530000>; Mon, 09 Jul 2018 05:04:35 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 09 Jul 2018 05:04:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 09 Jul 2018 05:04:40 -0700
Received: from [10.21.132.122] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 9 Jul
 2018 12:04:38 +0000
Subject: Re: [GIT PULL] RTC for 4.18
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180610221645.GA26123@piout.net>
 <ff6d048a-c683-56e0-13f9-1627cdfd0ea9@nvidia.com>
 <20180626161536.GH4207@piout.net>
 <522c3fc8-a4cc-bd83-d034-b5c690e541d0@nvidia.com>
 <20180626213138.GI4207@piout.net>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <7fab97df-9cd9-fa57-47a8-883a717dd96c@nvidia.com>
Date:   Mon, 9 Jul 2018 13:04:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626213138.GI4207@piout.net>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 26/06/18 22:31, Alexandre Belloni wrote:
> On 26/06/2018 17:54:57+0100, Jon Hunter wrote:
>>
>> On 26/06/18 17:15, Alexandre Belloni wrote:
>>> Hi,
>>>
>>> On 26/06/2018 16:51:40+0100, Jon Hunter wrote:
>>>>>       rtc: tps6586x: let the core handle rtc range
>>>>
>>>> Sorry I am missing the original mail with the above change, but I
>>>> have noticed on v4.18-rc1 that rtc wake-ups from suspend are no
>>>> longer working on one of our Tegra boards. The bisect points to the
>>>> above change and reverting it fixes the problem. I have not had
>>>> chance to dig further, but if you have any thoughts, please let me
>>>> know.
>>>
>>>
>>> Thanks for the report, does the following patch fix the issue:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/patch/?id=1b287f23b0a1fcb2b502dae981a8024be379391e
>>
>> Thanks. I gave the above a test, but still not waking-up from suspend.
>>
> 
> Ok, I probably found the issue but the fix is not immediate. I'll try to
> post something tomorrow.

Sorry if I missed it, but did you send a fix for this?

Cheers
Jon

-- 
nvpublic
