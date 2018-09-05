Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16681C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01BD20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01BD20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeIEVUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:20:14 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:57071 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIEVUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:20:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 128BB40123;
        Wed,  5 Sep 2018 16:49:13 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bXFt33L1sr-y; Wed,  5 Sep 2018 16:49:13 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 7A99440C8C;
        Wed,  5 Sep 2018 16:49:06 +0000 (UTC)
Subject: Re: [PATCH] sysctl: kselftests: add test_core to .gitignore
To:     lei yang <lei.yang@windriver.com>, claudiozumbo@gmail.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <1536115175-10864-1-git-send-email-Lei.Yang@windriver.com>
 <78c85cee-7af9-75fc-14c7-6565a7080008@windriver.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <2adb1f15-24dd-5744-a091-343d4617801e@kernel.org>
Date:   Wed, 5 Sep 2018 10:49:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <78c85cee-7af9-75fc-14c7-6565a7080008@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 09:08 PM, lei yang wrote:
> sorry, the title should be :"cgroup: kselftests: add test_core to .gitignore"
> 
> Lei
> 
> 
> 
> On 2018年09月05日 10:39, Lei Yang wrote:
>> Update .gitignore files.
>>
>> Signed-off-by: Lei Yang <Lei.Yang@windriver.com>
>> ---
>>   tools/testing/selftests/cgroup/.gitignore | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
>> index 95eb3a5..adacda5 100644
>> --- a/tools/testing/selftests/cgroup/.gitignore
>> +++ b/tools/testing/selftests/cgroup/.gitignore
>> @@ -1 +1,2 @@
>>   test_memcontrol
>> +test_core
> 
> 

Please resend with the correct summary.

thanks,
-- Shuah
