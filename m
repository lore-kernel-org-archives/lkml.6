Return-Path: <viresh.kumar@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523010400; cv=none;
        d=google.com; s=arc-20160816;
        b=ZLkwJHsC/t8xEnMMO39GSlbRp8O8Yzk/bJP2zGBApEMQknBS91me5NnRtXjjav80Wb
         RsozVGERJNENJ2jPcc0bcj4+mdOmaEZzW7Az/tB094hKCoheYdzOGRq49L7RFlIlgkhf
         pMcdLasvv2U4QQYOyvkSiQBFkyLAbwUoVokP6JgR/z7VpHBU3FDL2PycC+uSbNRljIuJ
         dEyZadOVNBFFNn88BmZGlpPvgFIr/2JxMX1wj3jAealcTCDakJWvTpXKf7enU3RTM1RC
         aW2ZNKNQcmYsfU7zVSJ1n9IalWurbwsZwQmWjJWnz4zpA7aWoP2sGsnMv5wL426kYdM6
         LdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=/8/19riwaPQAkWWuyDSp4itHTdalbBzzumU0svNazxE=;
        b=FJsDSJGWaAq1b68P6iKiQe0OyfaATzB/DapzYu1oQ2dccgMfBKx+li5jtRHxuhu7Tx
         NFGXZIcddY3WtK+L1ymbX55wRL3YQAmyA0bj3H1C5L2MRF8ISVxxvE3jxVyH0/k2ya0d
         lAWxxUmyDUwt4w9aW/OLwVJF4xznRnnDWzud0cax/guT6v+1rldBhN9LSV16KIP1AqbO
         AT5/6bhTJAQ2fKt7KJXEDAXUH0stIUCWSbcI4iUKumH+4igO0HqMsv8PwtrXTDHy/PkI
         0oft0iSxN4Cm+vrxcdA+q7Yo+RnAQttDhoL7xWKu4P9ZDFVrXwJxihYDYgcWxrujqNDS
         nkzw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=A+6CsDQ0;
       spf=pass (google.com: domain of viresh.kumar@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=viresh.kumar@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=A+6CsDQ0;
       spf=pass (google.com: domain of viresh.kumar@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=viresh.kumar@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4+RjNLc3lN+lZ55tJgowOwuOU6JvieNsG9P2AAgurFEvIp9bstRLxnv38Q7vT+WCasX87mX1A==
Date: Fri, 6 Apr 2018 15:56:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
Cc: Mark Greer <mgreer@animalcreek.com>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: greybus: Fix warning to limit chars per line
Message-ID: <20180406102638.GZ3572@vireshk-i7>
References: <20180403183246.GA23438@stallman>
 <20180405221941.GA21308@animalcreek.com>
 <CAOh2x==-Ayr40WhMNmABVEjaoFfSwQfyN8SH07mzmZTicLBh-A@mail.gmail.com>
 <4ef1ceb1-395d-753f-1ea2-9affcf682147@gmail.com>
 <20180406102517.GY3572@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406102517.GY3572@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596750959468280779?=
X-GMAIL-MSGID: =?utf-8?q?1596992154356528833?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 06-04-18, 15:55, Viresh Kumar wrote:
> On 06-04-18, 15:47, Gaurav Dhingra wrote:
> > I sent in an updated patchset. Though I forgot to add
> > viresh.kumar@linaro.org to "To" in mail.
> 
> That's fine, but you still haven't sent it to all the relevant people.
> You should have used the get_maintainer script (present in kernel
> source) for that.
> 
> $ scripts/get_maintainer.pl drivers/staging/greybus/audio_codec.h
> 
> Vaibhav Agarwal <vaibhav.sr@gmail.com> (maintainer:GREYBUS AUDIO PROTOCOLS DRIVERS)
> Mark Greer <mgreer@animalcreek.com> (maintainer:GREYBUS AUDIO PROTOCOLS DRIVERS)
> Johan Hovold <johan@kernel.org> (maintainer:GREYBUS SUBSYSTEM)
> Alex Elder <elder@kernel.org> (maintainer:GREYBUS SUBSYSTEM)
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (maintainer:GREYBUS SUBSYSTEM)
> greybus-dev@lists.linaro.org (moderated list:GREYBUS SUBSYSTEM)
> devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
> linux-kernel@vger.kernel.org (open list)

Actually your cc list in V2 is fine, it wasn't correct in v1.

-- 
viresh
