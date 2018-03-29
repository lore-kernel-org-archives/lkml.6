Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48A1eeVcMl9cbUhvbW4N0V4goUNGh5XymrwQwNFUDzpwHWUxgj1BYvkZoWwe+CUyUHhHiUJ
ARC-Seal: i=1; a=rsa-sha256; t=1522346094; cv=none;
        d=google.com; s=arc-20160816;
        b=HY175tvh2M3Aye/or6KXchTzyZ/Jk4HHbBkrSSZUKohct8itdds8w+RAjWaM/Wxw2d
         CzLR78spcuKEE/W5IggTr8kbjpRIPHLjNQC+53oa/DsDsEWO7cwVxHUHqk7t8ETjcvOn
         ujwSBnq4JHh2hD6F0dlCjgDTAldx6VPuK4Jl34D7AFg1MnxQ9ejxld4C5gujj+kfEEiL
         /ZuVCg4H28DYf9KzuOzc8eP3N1msYleGVvmSJsoqyhHXH1zBI1NIpNqlu/oXIy+WuBb0
         IeKV7FOvfjqJHqW7JHnqu+/yOMrmiWejdxTWIlJvG/gUSye5j+6BgKSiaYzw8HwrfRDF
         CtPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=2UmaLktexAlu1Wo5O+9NdaHLD4z35vm6POnUCz7yuEc=;
        b=HUg+Wo5SupOEEcjwqOAkOJAfp9TUUvMcoUeEssGjSTjIM9ViMSGkHqSYtEBqSDWl+3
         hX9C1WyW9DpsZqQMlYkbzep+wMOBCJdde+UUGhjGwm2UFVM5fT94QSkYM1emq4KWspgX
         65fhcYQdbYjPr/5oKiLBGpAAd6vzc2voewuxlctVsiQpjxdWei4gbZ1SHchH64dyGhCz
         Whks/NRfD5nCZyQ8sFwT+fR/36l297vn7/CQ3aZe+6jUzMgmlUuybJFY8jNMakEPFjLa
         DE02TQq8wEZ5k4ATG4x600Fn7G9n7YPPzCqX5lW7yhemXCMA7NLmeBwB/hyl+FJX1pS1
         kZ6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeC2Ryy (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 29 Mar 2018 13:54:54 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:34462 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeC2Ryx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Mar 2018 13:54:53 -0400
Subject: Re: [PATCH] selftests/ftrace: fix spelling mistake: "tiggers" ->
 "triggers"
To: Colin Ian King <colin.king@canonical.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180329172431.8171-1-colin.king@canonical.com>
 <20180329133102.6061ba66@gandalf.local.home>
 <48be730c-2a15-d3ad-d1aa-7d57fe7db6ca@canonical.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <56713d51-0954-e7a8-cf7a-7a6bfedf58f3@kernel.org>
Date: Thu, 29 Mar 2018 11:54:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <48be730c-2a15-d3ad-d1aa-7d57fe7db6ca@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596293672950856020?=
X-GMAIL-MSGID: =?utf-8?q?1596295578573270239?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/29/2018 11:47 AM, Colin Ian King wrote:
> On 29/03/18 18:31, Steven Rostedt wrote:
>> On Thu, 29 Mar 2018 18:24:31 +0100
>> Colin King <colin.king@canonical.com> wrote:
>>
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> Trivial fix to spelling mistake in message text
>>>
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> ---
>>>  tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
>>> index c5ef8b9d02b3..1b8faf4c318c 100644
>>> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
>>> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
>>> @@ -35,7 +35,7 @@ do_reset
>>>  
>>>  reset_trigger
>>>  
>>> -echo "Test histogram multiple tiggers"
>>
>> Oh Pooh! (/me wonders who gets that)
> 
> Just a smackerel of folk.
> 
>

 
t-i-double-guh-er! that spells tigger!

I will pick this up with your Ack Steve, unless you want include
it in your pull request.

Acked-by: Shuah Khan <shuahkh@osg.samsung.com>

thanks,
-- Shuah

thanks,
-- Shuah


