Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6CEC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A4620936
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A4620936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbeGKBjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:39:03 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:4372 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732330AbeGKBjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:39:03 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42089610"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Jul 2018 09:37:11 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 4710C4B445CB;
        Wed, 11 Jul 2018 09:37:11 +0800 (CST)
Received: from [10.167.226.45] (10.167.226.45) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.399.0; Wed, 11 Jul 2018 09:37:12 +0800
Subject: Re: [PATCH 0/3] fix selftests compiling errors and warnings
To:     Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <anders.roxell@linaro.org>
References: <1530503634-32241-1-git-send-email-lizhijian@cn.fujitsu.com>
 <e8ac4e1d-e923-6f78-005c-e8267463a9c9@cn.fujitsu.com>
 <f3800c8a-0a7a-02ce-a285-5b65c20f626c@kernel.org>
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
Organization: fnst-ulinux
Message-ID: <e32d3755-8a27-75f8-da65-c863eb31a756@cn.fujitsu.com>
Date:   Wed, 11 Jul 2018 09:37:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f3800c8a-0a7a-02ce-a285-5b65c20f626c@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.167.226.45]
X-yoursite-MailScanner-ID: 4710C4B445CB.A815D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/10/2018 10:08 PM, Shuah Khan wrote:
> On 07/10/2018 02:38 AM, Li Zhijian wrote:
>> ping
>>
>>
>> On 07/02/2018 11:53 AM, Li Zhijian wrote:
>>> Li Zhijian (3):
>>>     selftests/android: fix compiling error
>>>     selftests/android: initialize heap_type to avoid compiling warning
>>>     selftests/gpio: unset OUTPUT for build tools/gpio
>>>
>>>    tools/testing/selftests/android/ion/Makefile        | 5 ++++-
>>>    tools/testing/selftests/android/ion/ionapp_export.c | 7 +++++++
>>>    tools/testing/selftests/gpio/Makefile               | 2 +-
>>>    3 files changed, 12 insertions(+), 2 deletions(-)
>>>
>>
>>
> I was away on vacation all of last week. I will review the series.
> Anders Roxell is working on making the change at the main Makefile
> level to handle the headers dependency.

Good to know this, looking forward it


>   I have been waiting to hear
> from Maintainers to Ack it.
>
> Once Anders patch goes in, is the first and third patches in this series
> needed?

I will have a check once his patch is merged


Thanks

>
> No problems with the second one. I can get that in soon.
>
> thanks,
> -- Shuah
>
>
> .
>


