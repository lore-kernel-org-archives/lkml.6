Return-Path: <gauravdhingra.gxyd@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523010577; cv=none;
        d=google.com; s=arc-20160816;
        b=HF5SPm5C1whxFozVkEldisg4R1CuUzzrNYjc7MvoJisMihBJuc/t6UmUMFK5Da1d78
         EFLovNHov6Zi1cb5UR9gef5ieiQ/oFShTFcfU348iV5dlUCfaXyfHSnykWYQD4uinCGj
         GyUbbuhkMOpALWjB7vKbP3OXvm6tyxfj42l+4y/V2Up+CZKBDjfHeSXWJZOE6FQ5U9bT
         EALyl18Jo6TWwW2YkRzErVKBfQCFS1r9EQ6LvDu3GDwhsktyHehT9Di/W1YoyqbsV68b
         8YaXsfISWW3Io1R7FKShbOfqZdBbpVU0QPFPbl85qnV65+JvrVX1O3wxrOKvnZSzr1C3
         oTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=iiSgUO67NZ3rc+zJE726TUAss39Nh649lOGPFR+S/18=;
        b=W5DE6brDVaGtgin9n6aOWW7AFENAuEaGw2R61Bi0W7UWrpZl1R+SXw1BJ6H50k00cH
         BT9GohtMVQuGZpAte8CIIcqckh3epVpSSv9+5Tufg+042RCP6Pql0F21wl2a0siGw72Q
         oZr92OR3OgPALIhkTKnWaetf1FzmsGMbZvj9r3sy6CDqTm1sfzFfCl3WIZL++bfor+RU
         a4AxfteJ26gLRUgnLEoFg73bWPRpOcklEKfeffCkUZDQJtM0JUU/it2vtXGoh0LAda1K
         XUyldub4eLZRZzIkI9ocAwyukZ2vQZ2rsfi4ku6njCLG3irl3HRdsRjW35ip4eTxT1Qk
         /d+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=X3jJQzZT;
       spf=pass (google.com: domain of gauravdhingra.gxyd@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=gauravdhingra.gxyd@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=X3jJQzZT;
       spf=pass (google.com: domain of gauravdhingra.gxyd@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=gauravdhingra.gxyd@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+CiVmtqMkzPFQqk6dxMb3UZiFiji33vPRAbMwi6WZl92yOu6SQLKf4El7QiySHU7HHC3Xe0A==
Subject: Re: [PATCH] staging: greybus: Fix warning to limit chars per line
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Greer <mgreer@animalcreek.com>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180403183246.GA23438@stallman>
 <20180405221941.GA21308@animalcreek.com>
 <CAOh2x==-Ayr40WhMNmABVEjaoFfSwQfyN8SH07mzmZTicLBh-A@mail.gmail.com>
 <4ef1ceb1-395d-753f-1ea2-9affcf682147@gmail.com>
 <20180406102517.GY3572@vireshk-i7> <20180406102638.GZ3572@vireshk-i7>
From: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
Message-ID: <78ba0852-4437-aa3c-6204-8b03fdb9c42d@gmail.com>
Date: Fri, 6 Apr 2018 15:59:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180406102638.GZ3572@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596750959468280779?=
X-GMAIL-MSGID: =?utf-8?q?1596992339042597378?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Friday 06 April 2018 03:56 PM, Viresh Kumar wrote:
> On 06-04-18, 15:55, Viresh Kumar wrote:
>> On 06-04-18, 15:47, Gaurav Dhingra wrote:
>>> I sent in an updated patchset. Though I forgot to add
>>> viresh.kumar@linaro.org to "To" in mail.
>> That's fine, but you still haven't sent it to all the relevant people.
>> You should have used the get_maintainer script (present in kernel
>> source) for that.
>>
>> $ scripts/get_maintainer.pl drivers/staging/greybus/audio_codec.h
>>
>> Vaibhav Agarwal <vaibhav.sr@gmail.com> (maintainer:GREYBUS AUDIO PROTOCOLS DRIVERS)
>> Mark Greer <mgreer@animalcreek.com> (maintainer:GREYBUS AUDIO PROTOCOLS DRIVERS)
>> Johan Hovold <johan@kernel.org> (maintainer:GREYBUS SUBSYSTEM)
>> Alex Elder <elder@kernel.org> (maintainer:GREYBUS SUBSYSTEM)
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (maintainer:GREYBUS SUBSYSTEM)
>> greybus-dev@lists.linaro.org (moderated list:GREYBUS SUBSYSTEM)
>> devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
>> linux-kernel@vger.kernel.org (open list)
> Actually your cc list in V2 is fine, it wasn't correct in v1.
Yes, I too think it is correct. In v1 I forgot to remove '--nol' from 
command shown on kernelnewbies/FirstKernelPatch webpage and that removed 
a few relevant mailing lists.

-- 
Gaurav Dhingra
(sent from Thunderbird email client)
