Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZqAJsz36eIOuBvikwR1hbWHzvmVT9RrhMKua6nLEjTi/Vb7zjzFdOEa6OlBxC3y/YC1Yip2
ARC-Seal: i=1; a=rsa-sha256; t=1524863126; cv=none;
        d=google.com; s=arc-20160816;
        b=Y3Gkykdvn6X7rkdyIRjdTxqBP6NOHKcCsQJJogEkY/B7Z3mOQEBfcjMk25vJF9vBU1
         9NJUTuWamfTpftxHJ4dKkQm8W5wBrGBc2XCNH//0sAFMQJJc80x/ksBFuGi0lYbKZAy8
         aB4i43Djf8Ke2ipSvJT6Vz4OVVfbCnHP+7rCafodEoVpNPgq9LIIUWnX+WQC6Sw2+tFV
         QGw2x6LXaEaohTDTrfGljIBEb5+ICG61BxxA5j7XpNQIC/hDa+yCm1JsGk+fyP3E1jML
         DJKoRz/7OriJu0tHBb08nRHB/8qk6wlx59b6vN+EcrtBMLk6HNVtqpENhA4O+dCtScsu
         Z2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:autocrypt:openpgp:from:references:cc:to:subject:reply-to
         :arc-authentication-results;
        bh=UP2bY78DJanKKXka1ll/tbRGc6Xfm0gno5Z5H+A9NdI=;
        b=fHllq9clczvE/zZWFNwWF0JHPAM8WUxoj9MilKDmAaiCRqWt0LmbunJ9Up0yVPuI7/
         Ldsm6tN/1T0YtiLu/1iQFRKdTr0hBptx97OQAPNxmlQ7T+WaYaMImdX9GoXJYKl5uR+L
         iQM1LINZK4JUxcZt17k/6/lkFsd56YSB4TEUxU9wt4XfnJMcaYV9LJcsYG2aUXIEDDaN
         gWSXdQNf3BDcWeELAXXAmbRryld8ETqC33orIhsIaZlH9lChdbQj7RHFaW2Tg9gJG3t4
         X4xU9Vj6dB5B9IpvUhAqLsUQftzTXqPFQjuYKxRhHVzx3lje5QDWQi/E3mopHhuRkQf1
         hGAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757592AbeD0VF0 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 27 Apr 2018 17:05:26 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:53771 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759215AbeD0VFZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Apr 2018 17:05:25 -0400
Reply-To: shuah@kernel.org
Subject: Re: [PATCH 1/1] selftests: Fix lib.mk run_tests target shell script
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuahkh@osg.samsung.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <20171028134639.16811-1-mathieu.desnoyers@efficios.com>
 <44e3d6b0-6e0d-4482-fa7e-d8dac8619d4e@osg.samsung.com>
 <1490563551.1701.1509574972486.JavaMail.zimbra@efficios.com>
 <1717349402.1702.1509575073204.JavaMail.zimbra@efficios.com>
 <c1575990-8bb7-9997-0c0a-8a5b78b347c6@osg.samsung.com>
 <740429490.6175.1524860259330.JavaMail.zimbra@efficios.com>
 <670cba49-7419-5506-de06-05267f0493e9@kernel.org>
From: Shuah Khan <shuah@kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=shuah@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3fa8c84a-6587-dfca-2e93-5cfe15f42c81@kernel.org>
Date: Fri, 27 Apr 2018 15:05:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <670cba49-7419-5506-de06-05267f0493e9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1582509238172680386?=
X-GMAIL-MSGID: =?utf-8?q?1598934877864960334?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 02:42 PM, Shuah Khan wrote:
> On 04/27/2018 02:17 PM, Mathieu Desnoyers wrote:
>> ----- On Nov 1, 2017, at 6:28 PM, Shuah Khan shuahkh@osg.samsung.com wrote:
>>
>>> On 11/01/2017 04:24 PM, Mathieu Desnoyers wrote:
>>>> ----- On Nov 1, 2017, at 6:22 PM, Mathieu Desnoyers
>>>> mathieu.desnoyers@efficios.com wrote:
>>>>
>>>>> ----- On Nov 1, 2017, at 5:33 PM, Shuah Khan shuahkh@osg.samsung.com wrote:
>>>>>
>>>>>> On 10/28/2017 07:46 AM, Mathieu Desnoyers wrote:
>>>>>>> Within run_tests target, the whole script needs to be executed within
>>>>>>> the same shell and not as separate subshells, so the initial test_num
>>>>>>> variable set to 0 is still present when executing "test_num=`echo
>>>>>>> $$test_num+1 | bc`;".
>>>>>>>
>>>>>>> Demonstration of the issue (make run_tests):
>>>>>>>
>>>>>>> TAP version 13
>>>>>>> (standard_in) 1: syntax error
>>>>>>> selftests: basic_test
>>>>>>> ========================================
>>>>>>> ok 1.. selftests: basic_test [PASS]
>>>>>>> (standard_in) 1: syntax error
>>>>>>> selftests: basic_percpu_ops_test
>>>>>>> ========================================
>>>>>>> ok 1.. selftests: basic_percpu_ops_test [PASS]
>>>>>>> (standard_in) 1: syntax error
>>>>>>> selftests: param_test
>>>>>>> ========================================
>>>>>>> ok 1.. selftests: param_test [PASS]
>>>>>>
>>>>>> Hi Mathieu,
>>>>>>
>>>>>> Odd. I don't see the error. I am curious if this specific to
>>>>>> env. Can you reproduce this with one of the existing tests,
>>>>>> kcmp or breakpoints
>>>>>
>>>>> Yes, it reproduces:
>>>>>
>>>>> cd tools/testing/selftests/kcmp
>>>>> make run_tests
>>>>> gcc -I../../../../usr/include/    kcmp_test.c  -o
>>>>> /home/efficios/git/linux-rseq/tools/testing/selftests/kcmp/kcmp_test
>>>>> TAP version 13
>>>>> (standard_in) 1: syntax error
>>>>> selftests: kcmp_test
>>>>> ========================================
>>>>> ok 1.. selftests: kcmp_test [PASS]
>>>>>
>>>>> cd tools/testing/selftests/breakpoints
>>>>> make run_tests
>>>>> gcc     step_after_suspend_test.c  -o
>>>>> /home/efficios/git/linux-rseq/tools/testing/selftests/breakpoints/step_after_suspend_test
>>>>> gcc     breakpoint_test.c  -o
>>>>> /home/efficios/git/linux-rseq/tools/testing/selftests/breakpoints/breakpoint_test
>>>>> TAP version 13
>>>>> (standard_in) 1: syntax error
>>>>> selftests: step_after_suspend_test
>>>>> ========================================
>>>>> not ok 1.. selftests:  step_after_suspend_test [FAIL]
>>>>> (standard_in) 1: syntax error
>>>>> selftests: breakpoint_test
>>>>> ========================================
>>>>> ok 1.. selftests: breakpoint_test [PASS]
>>>>>
>>>>
>>>> The version of "make" on that machine is:
>>>>
>>>> make --version
>>>> GNU Make 3.81
>>>> Copyright (C) 2006  Free Software Foundation, Inc.
>>>> This is free software; see the source for copying conditions.
>>>> There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
>>>> PARTICULAR PURPOSE.
>>>>
>>>> This program built for x86_64-pc-linux-gnu
>>>>
>>>> (if it helps reproducing)
>>>>
>>>
>>> Yup that's it. I have
>>>
>>> GNU Make 4.1
>>> Built for x86_64-pc-linux-gnu
>>> Copyright (C) 1988-2014 Free Software Foundation, Inc.
>>> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
>>> This is free software: you are free to change and redistribute it.
>>> There is NO WARRANTY, to the extent permitted by law.
>>>
>>> I will test with your patch and see what happens in my env.
>>
>> Hi,
>>
>> I still see the problem with v4.17-rc2. Did you have time to
>> consider merging my fix ?
>>
>> Thanks,
>>
>> Mathieu
> 
> Sorry for the delay. It slipped through. I will queue this for the next rc. Thanks for
> the ping. Hope it applies :)
> 
> thanks,
> -- Shuah
> 
> 

Now I remember why I didn't pull this in. With your patch, I see the same
failures you are seeing in my env. with 

GNU Make 4.1
Built for x86_64-pc-linux-gnu
Copyright (C) 1988-2014 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

I will have to figure out a different way to fix the problem.

thanks,
-- Shuah
