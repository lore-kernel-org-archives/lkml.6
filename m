Return-Path: <viresh.kumar@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523010320; cv=none;
        d=google.com; s=arc-20160816;
        b=Wtpy2ceyZEj68avEBRNsMA9dsV0vIjAmQyghsufz+nz1N+k24/Ah7VBijHb/J4E+AQ
         7LH0TpAPO+3ZCoEqquyxVhJO9xDdXz8QwqiPt0DCw83pZSZYZ7KbvJ4Zzy13VxnAkETu
         0FY+IStFSiZkrArxfUJ7SOYq2D6B6OuJgVnpu2f3+0yRMbYiNSN0JChYOV4ph8/hX14V
         q7c2BDQQ/eT+D9iagcyZ44qW3O5DUFBzQmMvXvvLwG+BWzUXSp9e+0rGEN+D159TV12E
         /6uSfjrnCYKyEXN6G9/ftDhlhQ1xwzWRpcdbFmSEune9hwMC/jukkNGfErwNTIrb7jfz
         lYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=cDMxMpHvmBlBsbpM//SQSPmGCI2so8IPvudgEga1S8E=;
        b=yIy2mp1Q1SokbxVUqPXmNlqQSLwb0tNlcbmtW6DxB1mI8SIFGQZtaTlh5pPNG/KJv5
         yU/XNws5g0R4U3iZU05AiJC7Otp7HPwJpYMX6uKV06j4Vsp8pmXM9bUnjFs0dUsZ30nQ
         fgyNnE3djYKqlaEYEGzYNL6tJGS12mPeCxuaVCY3g+NrRUI8e0yUp52HJ61PKWrKMAcP
         3DG492aBRJQvtAUcrfYxBB73XEYD9ShFq5OT31dOlFcGOdakduDUqnlrO/kInTbpAtU7
         8eIY9y74UTxLz2iH+7ysesUuTabzXIeEjiPgWExsSPM6AFGyViHTkCystlXOkIea6uJg
         bT6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=khlY8obt;
       spf=pass (google.com: domain of viresh.kumar@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=viresh.kumar@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=khlY8obt;
       spf=pass (google.com: domain of viresh.kumar@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=viresh.kumar@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx496rjn3gSTyWKwLj8ho082P4AWfoBFdFUch/TQd8WSLvpqbs+c7UAozzDDF745AWKDhNqVS3g==
Date: Fri, 6 Apr 2018 15:55:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
Cc: Mark Greer <mgreer@animalcreek.com>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: greybus: Fix warning to limit chars per line
Message-ID: <20180406102517.GY3572@vireshk-i7>
References: <20180403183246.GA23438@stallman>
 <20180405221941.GA21308@animalcreek.com>
 <CAOh2x==-Ayr40WhMNmABVEjaoFfSwQfyN8SH07mzmZTicLBh-A@mail.gmail.com>
 <4ef1ceb1-395d-753f-1ea2-9affcf682147@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ef1ceb1-395d-753f-1ea2-9affcf682147@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596750959468280779?=
X-GMAIL-MSGID: =?utf-8?q?1596992069655122444?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 06-04-18, 15:47, Gaurav Dhingra wrote:
> I sent in an updated patchset. Though I forgot to add
> viresh.kumar@linaro.org to "To" in mail.

That's fine, but you still haven't sent it to all the relevant people.
You should have used the get_maintainer script (present in kernel
source) for that.

$ scripts/get_maintainer.pl drivers/staging/greybus/audio_codec.h

Vaibhav Agarwal <vaibhav.sr@gmail.com> (maintainer:GREYBUS AUDIO PROTOCOLS DRIVERS)
Mark Greer <mgreer@animalcreek.com> (maintainer:GREYBUS AUDIO PROTOCOLS DRIVERS)
Johan Hovold <johan@kernel.org> (maintainer:GREYBUS SUBSYSTEM)
Alex Elder <elder@kernel.org> (maintainer:GREYBUS SUBSYSTEM)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (maintainer:GREYBUS SUBSYSTEM)
greybus-dev@lists.linaro.org (moderated list:GREYBUS SUBSYSTEM)
devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

> I tried to follow instructions
> described on https://kernelnewbies.org/FirstKernelPatch for updating my
> patch. Do you think I followed the instructions correctly?

Mostly yes, you did it fine.

> I was thinking
> may be I need to update the already sent patch by adding *new commit* to my
> already existing commit on that git branch, but instead I tried to do what I
> understood from the website I mentioned above.

Sorry, I find it difficult to understand what you wrote ;)

-- 
viresh
