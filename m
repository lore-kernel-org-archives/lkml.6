Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C98C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58D7208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58D7208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933544AbeGJOIg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:08:36 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:50875 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933330AbeGJOIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:08:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id D85774178B;
        Tue, 10 Jul 2018 14:08:33 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o-RgfMsVrZ0R; Tue, 10 Jul 2018 14:08:33 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id DD80A41386;
        Tue, 10 Jul 2018 14:08:27 +0000 (UTC)
Subject: Re: [PATCH 0/3] fix selftests compiling errors and warnings
To:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        anders.roxell@linaro.org, Shuah Khan <shuah@kernel.org>
References: <1530503634-32241-1-git-send-email-lizhijian@cn.fujitsu.com>
 <e8ac4e1d-e923-6f78-005c-e8267463a9c9@cn.fujitsu.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <f3800c8a-0a7a-02ce-a285-5b65c20f626c@kernel.org>
Date:   Tue, 10 Jul 2018 08:08:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e8ac4e1d-e923-6f78-005c-e8267463a9c9@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 02:38 AM, Li Zhijian wrote:
> ping
> 
> 
> On 07/02/2018 11:53 AM, Li Zhijian wrote:
>> Li Zhijian (3):
>>    selftests/android: fix compiling error
>>    selftests/android: initialize heap_type to avoid compiling warning
>>    selftests/gpio: unset OUTPUT for build tools/gpio
>>
>>   tools/testing/selftests/android/ion/Makefile        | 5 ++++-
>>   tools/testing/selftests/android/ion/ionapp_export.c | 7 +++++++
>>   tools/testing/selftests/gpio/Makefile               | 2 +-
>>   3 files changed, 12 insertions(+), 2 deletions(-)
>>
> 
> 
> 

I was away on vacation all of last week. I will review the series.
Anders Roxell is working on making the change at the main Makefile
level to handle the headers dependency. I have been waiting to hear
from Maintainers to Ack it.

Once Anders patch goes in, is the first and third patches in this series
needed?

No problems with the second one. I can get that in soon.

thanks,
-- Shuah
