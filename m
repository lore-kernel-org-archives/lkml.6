Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZov08VD/l4CeOnbEpYwDySs5ur/sFmahRRrpKij+lnoglr2PpxMCrmzGltXSqrVMjDJbJnA
ARC-Seal: i=1; a=rsa-sha256; t=1525097329; cv=none;
        d=google.com; s=arc-20160816;
        b=0T059DEdyYQOh4/WdwAFf6Hl7Kx+1a7bRNS5WJbqILrh8IgSKcfDFigrFn8Fi7S/A/
         CtAh2CJNVYhQL0hsKf0MqEybUzW405zHvqgQg10bbkpOMgbnGk8bWc9+Q8gkujCg/WWW
         weePTEErmIyj7ulUcz+NDrSm07/mWeAvtm/hEDVwskeFfLUsBI5Bg1DSaA/pVrwbXBBC
         1/pMBV0L74Asma2IFDOJ6RytJo1UAijAhkli90xCBGfGosCYaR3HGl3Q5xIuRvfIp1lY
         N0BsWSfzdszVwWRVPskeM5OU2C6EZ7gAcdEDWk56LE/wzvxsAmJpCF/B2zZw/omBYM6D
         P3cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:to:subject:arc-authentication-results;
        bh=k5b/fFuZc9aabGvYPL3yQUzA9wcAlyWqyzJ47BwnxPg=;
        b=I9zs/kJgiVt3W6DWz45h0q9rxe/QHeJnFJQwlwUx44VoBvPaywqgUOTRm3CLi9/MxN
         iCCPaor2v49+oKDX/MmTi6xOS2X/dn/jGbgRV/YHCIu3mESC/JQLC80pYiUc0wdRc5cs
         rXUSa6iDYd3bG54WoCnA9MUXhCutOMrEGDBLv3KAnOxXnsyho8iUywg+jPZnu/CX1yMF
         UmJzHk+cnKdpPrKF8uK8kjSinaaOFFloiUWj22YOjp0XgzoHzb9tDqq4w2F6WJtRjQYd
         h6UHi9bagOTuFGl5Itw6PExahiQiPvIGQ3AkgvcCakmA/48k3IcdYgf5h5zi5YUCFvzV
         KgTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754111AbeD3OIs (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 30 Apr 2018 10:08:48 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:46698 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754090AbeD3OIr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Apr 2018 10:08:47 -0400
Subject: Re: kselftest archives etc.
To: Florian Weimer <fweimer@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <958d61ac-f70a-80b1-a657-59fe1fd1d369@infradead.org>
 <a407c7a0-add1-f9d2-95d4-bb80ff44d90a@redhat.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <28be9406-e1fb-7b4f-42e6-363c3267d7fb@kernel.org>
Date: Mon, 30 Apr 2018 08:08:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a407c7a0-add1-f9d2-95d4-bb80ff44d90a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598946970016814291?=
X-GMAIL-MSGID: =?utf-8?q?1599180456867645202?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/30/2018 03:15 AM, Florian Weimer wrote:
> On 04/28/2018 02:17 AM, Randy Dunlap wrote:
>> (2) for this patch:http://www.spinics.net/lists/linux-kselftest/msg03136.html
>>
>> [PATCH] selftests/x86: Detect -no-pie availability
>>
>> Acked-by: Randy Dunlap<rdunlap@infradead.org>
>> Tested-by: Randy Dunlap<rdunlap@infradead.org>
>>
>> What is the status of this patch?
> 
> Yours is the first reaction to it.  Shall I resubmit it, with your ack added?
> 
> Thanks,
> Florian
> 

Please do. For such patches, I usually wait for x86 maintainers to Ack it.
Resend and I will take it through.

thanks,
-- Shuah
