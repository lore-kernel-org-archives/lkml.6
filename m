Return-Path: <vinod.koul@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525870042; cv=none;
        d=google.com; s=arc-20160816;
        b=ANn31fb8YwToOUr9hxiPwdCi/jqZQX8R8MsbPtdPyYo7FEAlVsu+CC4xZvZ+r1IM81
         iYdSs9r0eOwVbR8wrXtp1Tq7Ge5OfHLtpXDpa5VFERHUQezNKM9O8pL/stwcQupbpKs7
         QWMqmExK9Mslu8LGM0ERO0jQCeq4NElu3UZ+bbUvBpFvOVOV48A4VzeqCqDVBWopE8cn
         X4BaF5gjl00NxjMECDeEfmzFwYtaTETxdgBG8iuWlh86UssMydmnxoGSnVGnw045FS2S
         5vxlWven+Nc9f/nAlFakHXwvBWSyuh1acVCWNHzuh+NYPglGjTaLqSbv4ekpHIm1Y0SC
         ZDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Emtg5xhJTtLtyfF/v9YS/8QPSCmBruHWP+RDZVkSK/Q=;
        b=hlmJCoFgvUXZA+rzDO01ogl6eVrkDeFu89inVo55ENFujPWZSugxs5jEOpKD2Ai436
         mhLuXvu/EFFUuASx7s7A6uQO5XRNbu7Y2MpVqP6PNZL1IYoi7+RXxdz9ugYriMG+QW9U
         AwBAkgbJKLxMazgZ4B/IVRVNBCa68smbj2L9KIQbYVhTgGS8B4/LHJPuYG+dYnNB7FmO
         S4Xfm+kjtcdcYL5n1c1obxncOB6e3HyU4xVMTbA9ygYditNGZncWJBdk3/L0S4rTOFqG
         ggEJOJgOZbgmhfVbDJFZSjK5jBc7zX3PFlk0xlCB2i5X4B6MYrMqeqtJdNCFx5EY1nuX
         eTeg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Ko4fKCCQ;
       spf=pass (google.com: domain of vinod.koul@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=vinod.koul@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Ko4fKCCQ;
       spf=pass (google.com: domain of vinod.koul@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=vinod.koul@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrlzCu7U79QLdScplqNX1VOrBSXPTLcqJ7ng8IKKUMDyX/LQDarhbnvoInyKig0XUqtHYiZDQ==
Date: Wed, 9 May 2018 18:17:19 +0530
From: Vinod Koul <vinod.koul@linaro.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180509124719.GH7985@vkoul-mobl>
References: <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk>
 <20180503230905.GA98604@atomide.com>
 <CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
 <20180509084440.GW13402@sirena.org.uk>
 <CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
 <20180509090346.GY13402@sirena.org.uk>
 <20180509204727.7ff38021@canb.auug.org.au>
 <20180509105534.GE7985@vkoul-mobl>
 <20180509224313.5e5fe381@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509224313.5e5fe381@canb.auug.org.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599990705458136322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09-05-18, 22:43, Stephen Rothwell wrote:
> Hi Vinod,
> 
> On Wed, 9 May 2018 16:25:34 +0530 Vinod Koul <vinod.koul@linaro.org> wrote:
> > > 
> > > I currently have 44 such fixes branches.  More welcome!  
> > 
> > Great so do you want us to send fixes branch or scan the existing trees and add
> > them.
> 
> The former.
> 
> > In case of former please do add slave-dma/fixes as well
> 
> Done.  Should I switch your contact address to your kernel.org one
> (from your Intel one)?

Yes please, that is no longer valid.

-- 
~Vinod
