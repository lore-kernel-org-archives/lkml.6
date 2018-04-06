Return-Path: <gauravdhingra.gxyd@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523009847; cv=none;
        d=google.com; s=arc-20160816;
        b=zNeepOIMXlVIuoSvQ83kam+N/00xBt8Mal4UY5PWs5xOPzSUgR1xq89scGElqPatoh
         B2AbFcDp+t7lpTVt+b5XCldm126PO/KewpELi3buAneiugpmTgUbAHOxsOQA4Z++Qt+1
         6lgzMwAEoYb2WelGpNReLJHAAVec72KHirxGfsIzw7SCMi2YztnHtZOQ6zL0/XeRXXN+
         XhE58XFcpTQthD1kyFZB/zcdT9jDuFsnBs1MMJ1IuTC/qvdHZ3ZFLbNky6h5AbbJIMQL
         yCcn+vuF/RAwO4WMWnRhPmF67Z5QqrsvIAQa/yuVTYlyipywUMHxuTxNsR4RbdsTXRCF
         fhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=dQD+qpYBYikS7KS3kfecxWvwZ9d7RrTDT+7Ka55dbSQ=;
        b=xVZbPP+OMt732a5dG9BA/QS6wnAEo+wxZ4LFW/fyxq8mkp+RrdJKYExPL10xmK+8Ug
         1Y8i1eEEaKhH4N4zW+GNAJrnObeEQFWX3BCEVE532yHpi/fwXtyu60UEaybdkvnjMW1E
         eK3vNZ+HbkSYhoi26AmRtva0zdd+nvOnbmV//HSwZfe/4kstVZnJVGayoJsM9Dt5yhGT
         05xHIX1x8KuM4J/9S7bFmI6A2OnutGwT8olWZKZLpUFqry55IoXzOzy0ozJqqRjhrt0h
         aPViKayx1+4UMZk7YxKn7jkDdfDS+2fPQOFH1IudH6nxHjkQKwZ/UZ6WZjsU6Ynyzanx
         jMbw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FCZyeUOj;
       spf=pass (google.com: domain of gauravdhingra.gxyd@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=gauravdhingra.gxyd@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FCZyeUOj;
       spf=pass (google.com: domain of gauravdhingra.gxyd@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=gauravdhingra.gxyd@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49VxEZz5lYyUB2II+qa6hG6K848bsqd2mJF6AUDjlyihOgSw/LksohgF4hIich+eYzTTcefvQ==
Subject: Re: [PATCH] staging: greybus: Fix warning to limit chars per line
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Mark Greer <mgreer@animalcreek.com>
Cc: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180403183246.GA23438@stallman>
 <20180405221941.GA21308@animalcreek.com>
 <CAOh2x==-Ayr40WhMNmABVEjaoFfSwQfyN8SH07mzmZTicLBh-A@mail.gmail.com>
From: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
Message-ID: <4ef1ceb1-395d-753f-1ea2-9affcf682147@gmail.com>
Date: Fri, 6 Apr 2018 15:47:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAOh2x==-Ayr40WhMNmABVEjaoFfSwQfyN8SH07mzmZTicLBh-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596750959468280779?=
X-GMAIL-MSGID: =?utf-8?q?1596991573754915535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Thanks for reviewing the patch.


On Friday 06 April 2018 10:52 AM, Viresh Kumar wrote:
> On Fri, Apr 6, 2018 at 3:49 AM, Mark Greer <mgreer@animalcreek.com> wrote:
>> On Wed, Apr 04, 2018 at 12:02:46AM +0530, Gaurav Dhingra wrote:
>>> Wrap comment to fix warning "prefer a maximum 75 chars per line"
>>>
>>> Signed-off-by: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
>>> ---
>>>   drivers/staging/greybus/audio_codec.h | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/staging/greybus/audio_codec.h b/drivers/staging/greybus/audio_codec.h
>>> index a1d5440..01838d9 100644
>>> --- a/drivers/staging/greybus/audio_codec.h
>>> +++ b/drivers/staging/greybus/audio_codec.h
>>> @@ -23,7 +23,9 @@ enum {
>>>        NUM_CODEC_DAIS,
>>>   };
>>>
>>> -/* device_type should be same as defined in audio.h (Android media layer) */
>>> +/* device_type should be same as defined in audio.h
> This isn't the right way to write a multi-line comment. It should be like:
>
> /*
>   * XXXX
>   * XXXX
>   */
I sent in an updated patchset. Though I forgot to add 
viresh.kumar@linaro.org to "To" in mail. I tried to follow instructions 
described on https://kernelnewbies.org/FirstKernelPatch for updating my 
patch. Do you think I followed the instructions correctly? I was 
thinking may be I need to update the already sent patch by adding *new 
commit* to my already existing commit on that git branch, but instead I 
tried to do what I understood from the website I mentioned above.
>>> + * (Android media layer)
>>> + */
>>>   enum {
>>>        GBAUDIO_DEVICE_NONE                     = 0x0,
>>>        /* reserved bits */
>>> --
>>> 1.9.1
>> Hi Gaurav.
>>
>> Thank you for the patch, it looks fine to me.
>>
>> Reviewed-by: Mark Greer <mgreer@animalcreek.com>

-- 
Gaurav Dhingra
(sent from Thunderbird email client)
