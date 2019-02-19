Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D7DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB1E2183E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfBSQrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:47:13 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:37489 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbfBSQrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:47:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TKabDau_1550594825;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TKabDau_1550594825)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Feb 2019 00:47:07 +0800
Subject: Re: [PATCH] doc: cgroup: correct the wrong information about measure
 of memory pressure
To:     Tejun Heo <tj@kernel.org>
Cc:     hannes@cmpxchg.org, corbet@lwn.net, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1550278564-81540-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190218210504.GT50184@devbig004.ftw2.facebook.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <79dc6298-a062-51e0-64d0-9696dc602767@linux.alibaba.com>
Date:   Tue, 19 Feb 2019 08:47:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190218210504.GT50184@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/19 1:05 PM, Tejun Heo wrote:
> On Sat, Feb 16, 2019 at 08:56:04AM +0800, Yang Shi wrote:
>> Since PSI has implemented some kind of measure of memory pressure, the
>> statement about lack of such measure is not true anymore.
>>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 7bf3f12..9a92013 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -1310,8 +1310,7 @@ network to a file can use all available memory but can also operate as
>>   performant with a small amount of memory.  A measure of memory
>>   pressure - how much the workload is being impacted due to lack of
>>   memory - is necessary to determine whether a workload needs more
>> -memory; unfortunately, memory pressure monitoring mechanism isn't
>> -implemented yet.
>> +memory.
> Maybe refer to PSI?

I thought so too, but the above "memory.pressure" has already referred 
to PSI. So, I was not sure if we should duplicate PSI information.

Thanks,
Yang

>
> Thanks.
>

