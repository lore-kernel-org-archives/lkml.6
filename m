Return-Path: <jcm@jonmasters.org>
X-Google-Smtp-Source: AH8x2267fePyX3bJSBtmjw6dyadAOOrtQQBqUSROIhrPA7VEcEZtSqKQ3ARufcxhXESGEiUAGHpV
ARC-Seal: i=1; a=rsa-sha256; t=1519084636; cv=none;
        d=google.com; s=arc-20160816;
        b=TfX8h092vMJKo3jALfqbh92CqH/AZzkycN0CLF2cXOiRXTSXr8R4oQGC4bWvnr17EC
         Xmy/HkNDfdakoGa9MdE3+x9M+4c90RTm8gX+TzqSL564dI11JQx02WFKGcRAAxm4xhNF
         Izu2VH62b2EKrHe1FpgJXjB09++Uzdsysz8laHa0wSXIoiuLs6H3CHX8jkIhfnNlIAOS
         bJK/Cc44xeVXAY64VejkjRqB07qxniKJvlVY5TQPp+74urrfc2Y4SXO6h1rGTBtB2lIv
         Uv134Nzpf9eCbkKxD0IW8mTjjvVAWAV527cfOOL9CxD4EWx2Os9t3dH2nHFBVND2oCk1
         c0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:message-id:organization:from
         :references:cc:to:arc-authentication-results;
        bh=4k/02LCjDh4asMG5Zi5W36aca5Z6lt4MHrKlJ1UfduY=;
        b=ao9/wW7c6INCksk5huF65HaD0VxMw7xB6P+EAQpbAiByPS4XOfu5v3PUTADzRCKq4u
         VCSt6HSE6ZP0TtiyGX7wBUc2gDXRl/1fTtwyZuZ7lJ0hLvs9dTgivMJ/d0r/Fbe4H8n0
         La1Scb1z94DDERnaSIwhjxnNgDjh2pBqyK9KFvKwVZ6epG5weHdOP1m7RQUdoKGZm1+4
         LGrlsWmroQhEcK97/t6ZvknQ+5g5twyIrHdT9JWQVoeoTCHuDTEK6O/s8A358293olZL
         79sHHRwzzk7mtuARgg0OdK7WudtuaTdFpLs+xrwLVwSgeIwggJ558Q/jlIQu/0tFDWOl
         Fckg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jcm@jonmasters.org designates 173.255.233.168 as permitted sender) smtp.mailfrom=jcm@jonmasters.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jcm@jonmasters.org designates 173.255.233.168 as permitted sender) smtp.mailfrom=jcm@jonmasters.org
To: Timur Tabi <timur@codeaurora.org>, lkml <linux-kernel@vger.kernel.org>
Cc: Shanker Donthineni <shankerd@codeaurora.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org,
 stable-commits@vger.kernel.org
References: <1518616386206238@kroah.com>
 <CAOZdJXWZV4TDZchsYeHE_Oh+s1y3yjXE9NxVY9wz-vCkZVhN4w@mail.gmail.com>
From: Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation Of Broken Dreams
Message-ID: <5be20f44-b750-7250-76a8-03b6c39bb2fe@jonmasters.org>
Date: Mon, 19 Feb 2018 18:57:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAOZdJXWZV4TDZchsYeHE_Oh+s1y3yjXE9NxVY9wz-vCkZVhN4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 82.111.139.164
X-SA-Exim-Mail-From: jcm@jonmasters.org
Subject: Re: Patch "[Variant 2/Spectre-v2] arm64: Implement branch predictor
 hardening for Falkor" has been added to the 4.14-stable tree
X-SA-Exim-Version: 4.2.1 (built Sun, 08 Nov 2009 07:31:22 +0000)
X-SA-Exim-Scanned: Yes (on edison.jonmasters.org)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1592384775145883169?=
X-GMAIL-MSGID: =?utf-8?q?1592875691663758684?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/14/2018 11:16 AM, Timur Tabi wrote:
> On Wed, Feb 14, 2018 at 7:53 AM,  <gregkh@linuxfoundation.org> wrote:
>>
>> This is a note to let you know that I've just added the patch titled
>>
>>     [Variant 2/Spectre-v2] arm64: Implement branch predictor hardening for Falkor
>>
>> to the 4.14-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      arm64-implement-branch-predictor-hardening-for-falkor.patch
>> and it can be found in the queue-4.14 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
> 
> Please note that there is a follow-on patch, also from Shanker, that
> fixes this patch (it was slightly mangled when merged into 4.16-rc1):
> 
> https://www.spinics.net/lists/arm-kernel/msg633726.html
> 
> I would love for it to be included in 4.14.20, but it hasn't been
> merged into Linus' tree yet.  I will send a patch request when it does
> land in 4.16-rc2.

That has now landed in Linus's tree.

Jon.
