Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48sc4xwnoMIDH00kAa49j2z2ZntLUBb0JgZYhuYLuKXqbwZnyr+cTM6XHAXmfVxkmO2uuXR
ARC-Seal: i=1; a=rsa-sha256; t=1522345639; cv=none;
        d=google.com; s=arc-20160816;
        b=FMtzy2Asna0QlQHDDY03GGS+Sz/1cr4Lw+ZWa7H5atEbcVWCcFI5pjEsuzMvvWWJp0
         Ob0HnmPkacBSiYC/Y2IPGZXbL1KkPacKMv487tXKsaMJsRvn9CeLF+wrZYSAuyXKjMFj
         jhRYtOqxpGD5NoTigspQHTiJGcLV/EHs89MA0H6etZp21yQwOlpbqIuK1NemjpNNj3EV
         kAoDBNy7H78YGLcrHyJba4HiEvtIs2XbYw9tQk8Pz8RnqoUsXfEUK1nI1sXQytCfpwum
         PBRbr1JZH5xi5LGySxtsidzbS4LvvVs7gNYrlCwJ6W/ZE7nf+923gQu1YU6fy7vJfUs2
         h3Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:autocrypt:openpgp:from:references:cc:to:subject
         :arc-authentication-results;
        bh=eVzXYVpfs3ZOKekmvp5eUSikLYBaDEeU95fUoQM8too=;
        b=fD76lLXLpEYt/6KnS/IwQrecoiOXN7L3R5mV4frGVqM9ygTutEC4zJIv6bf55qKI9v
         cCrXis756ypCzGgaVFgzMcRUNh3wLGTF3aDQ2uDj0h1vHvD6H1P6sYMfu8o5/YW4o1qo
         k8K0odafuzzoKg7/391sCqSQsCkBttbzVG1IdhSXy1s8ktNA7hXjL68CjouMFSXj4Jjt
         QfpcizLQSp64Kb8M8eFtnho35ALWD0jnw68dwE0P9eaYAmK4gKdMta+SQXPcmFGWMoqV
         MUKd+nUUNcOHogmVHxXp57KqC3tV5SC8vva5tBPICh8OjE7CqXXfb8F4QoajUf0H4h3+
         e4TA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbeC2RrS (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 29 Mar 2018 13:47:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47889 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbeC2RrR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Mar 2018 13:47:17 -0400
Subject: Re: [PATCH] selftests/ftrace: fix spelling mistake: "tiggers" ->
 "triggers"
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180329172431.8171-1-colin.king@canonical.com>
 <20180329133102.6061ba66@gandalf.local.home>
From: Colin Ian King <colin.king@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=colin.king@canonical.com; keydata=
 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
Message-ID: <48be730c-2a15-d3ad-d1aa-7d57fe7db6ca@canonical.com>
Date: Thu, 29 Mar 2018 18:47:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329133102.6061ba66@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596293672950856020?=
X-GMAIL-MSGID: =?utf-8?q?1596295101315885116?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 29/03/18 18:31, Steven Rostedt wrote:
> On Thu, 29 Mar 2018 18:24:31 +0100
> Colin King <colin.king@canonical.com> wrote:
> 
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Trivial fix to spelling mistake in message text
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
>> index c5ef8b9d02b3..1b8faf4c318c 100644
>> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
>> @@ -35,7 +35,7 @@ do_reset
>>  
>>  reset_trigger
>>  
>> -echo "Test histogram multiple tiggers"
> 
> Oh Pooh! (/me wonders who gets that)

Just a smackerel of folk.

