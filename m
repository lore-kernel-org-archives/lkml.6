Return-Path: <viresh.linux@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522992138; cv=none;
        d=google.com; s=arc-20160816;
        b=tgTRhKDm6GBjos7T+dkKTvYLJcj9ZPUUzWyIfJI8EGXYbV/ITNx7pCfgIUeUt9hxoo
         fitCVZTKyR9Ui0cyaOXhrDz5GBtRJJ6mMavX+OJMabv060S3Kq9JsaPAuu3mF7k6nBxh
         yGWlFfOnCwz6le/UB9JbxvvFUkWDvwAtvEhsBghf+7d6++ah+WooKuovOJIzyFv98n7T
         M88ugWgTN+0fRfvRB9+W0ztdcSPUPBXi2Tc7USc07IeGxxrg3+1Z2RM1FvPQ2MgqLPDl
         aiWWKG2uqJf+tJCCElyu00pZKVhz+KMAJcioYm9CKq/tl2aDop+BtgjwGA/s5MvNUt4Y
         VH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=SRcD5/N/pejz5DpVeqAGLtEIpjSqc4wRh7pvDIrI4Dc=;
        b=hbKp7sITwyvyxIj7PrUi6S3JJLsm8V1bSEfFu0dVWqBGqmg205l1y5tsLR+w1LK3BZ
         tyEBvfwZVkJiOVx8EoEmwfGY1NzPoeWjJl2YX5O5z1Car++xi6/bIfPb3QlSZQotDBb1
         nJuRpQMoV6BrDwIIPdAeaocXblvRyRG6jv9Y5C3D412HBypgqUwOAO0P7Qmr0VOQLFSS
         E7q76tCGWbP/tWnvGsWtxU5dAG6uqlu9hiha92YqKxDXseZ6JGhg6xSYMRQBPfxNUXCw
         Ai70coCfo1XYCDL8fhuRh9jINIQez2yazD7LcqFkHJQKxohRqQ3rle9j4emcygXQOzZ5
         hQ9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oklF5Fdg;
       dkim=pass header.i=@linaro.org header.s=google header.b=bLi4MIu4;
       spf=pass (google.com: domain of viresh.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=viresh.linux@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oklF5Fdg;
       dkim=pass header.i=@linaro.org header.s=google header.b=bLi4MIu4;
       spf=pass (google.com: domain of viresh.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=viresh.linux@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx497EGEii0LjdqqwZ6BA6INJobfhJCbYTRgdHolz5F6Kq//jc1ZDuCuVybGe1N+WJTfOolAa46I08J4oyFOAPBo=
MIME-Version: 1.0
Sender: viresh.linux@gmail.com
In-Reply-To: <20180405221941.GA21308@animalcreek.com>
References: <20180403183246.GA23438@stallman> <20180405221941.GA21308@animalcreek.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 6 Apr 2018 10:52:17 +0530
X-Google-Sender-Auth: Sr-oundReDTK23xph4lxRV6mCtc
Message-ID: <CAOh2x==-Ayr40WhMNmABVEjaoFfSwQfyN8SH07mzmZTicLBh-A@mail.gmail.com>
Subject: Re: [PATCH] staging: greybus: Fix warning to limit chars per line
To: Mark Greer <mgreer@animalcreek.com>
Cc: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596750959468280779?=
X-GMAIL-MSGID: =?utf-8?q?1596973004988744122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 6, 2018 at 3:49 AM, Mark Greer <mgreer@animalcreek.com> wrote:
> On Wed, Apr 04, 2018 at 12:02:46AM +0530, Gaurav Dhingra wrote:
>> Wrap comment to fix warning "prefer a maximum 75 chars per line"
>>
>> Signed-off-by: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
>> ---
>>  drivers/staging/greybus/audio_codec.h | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/greybus/audio_codec.h b/drivers/staging/greybus/audio_codec.h
>> index a1d5440..01838d9 100644
>> --- a/drivers/staging/greybus/audio_codec.h
>> +++ b/drivers/staging/greybus/audio_codec.h
>> @@ -23,7 +23,9 @@ enum {
>>       NUM_CODEC_DAIS,
>>  };
>>
>> -/* device_type should be same as defined in audio.h (Android media layer) */
>> +/* device_type should be same as defined in audio.h

This isn't the right way to write a multi-line comment. It should be like:

/*
 * XXXX
 * XXXX
 */

>> + * (Android media layer)
>> + */
>>  enum {
>>       GBAUDIO_DEVICE_NONE                     = 0x0,
>>       /* reserved bits */
>> --
>> 1.9.1
>
> Hi Gaurav.
>
> Thank you for the patch, it looks fine to me.
>
> Reviewed-by: Mark Greer <mgreer@animalcreek.com>
