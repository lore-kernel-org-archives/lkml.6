Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521483635; cv=none;
        d=google.com; s=arc-20160816;
        b=0VPfejPfqRJXyDKMnB08ATfBOVazieN2Y6bWDhbpxmPhl4gVv65/PTmNBSF//K1Yo+
         6nks3GW2JKFsLe1y9YQ6i4EKWi13I+Oq9x9fXj/X3f+JdwjUNeAu0DUh4Es4hs9fZ7g1
         zM6HbtSU7PAbP90BcQjEQBnMxbKLTrWO7kzqsjVH19ciAy/XFdzBxxMB+D5IXxYJxTbO
         QptqCbSZ0YPqaukjicn+zM313W5UsSqXvUCsLPPffOtjjLQsntHA4LFLnL9oLxl9fAFg
         EdzL9FaYLJFgCWFn/sQtLyOiyL1f8prYwetc53xOVXlSF1Y6HEC9KqHPPTUdaurl6Nbm
         xpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=AvUSgtx3c3AETqaATNkiomDZ6+mdmHPYZeqVMpXp/RA=;
        b=j0NmOgT0nWLVQIuxSTZvJxyD1jCHik7so475ONXTgwjtLHDTylTtSExwM8jjISg4r+
         0mzMceLREb2EB3/HRwLYBg9Yj17Oylr70Nj163R0jEojatwHuM+DwWbqHs1YfV+dTFJU
         oCzgn4cf9vHt6ieyY0xCSTcB2kO4qTgFquWXZ0KejmZwCbbmA6q9qJuq/6na2F+YJ0tO
         //1iZg2OCkC/JoUhyteA2QuD4pJ07Wyy3pL3ljOBVp0Eunu342j3/6O6gePPRsIeNn8a
         KI/4rauQjn+Yz35SvfcS5TQs7+oX5kA4J/4SXiAsRYSRWF4IkIND2DC3DhAQ/t3vlwUO
         ASpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rCZG3I2H;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rCZG3I2H;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AG47ELsw09p4qU4+N0Eo/sykjLiY5ctLFoRVbRB8Ml9NzTougwAzm6FQn2T9hyKoM7yBjWN39w6Xhw==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Mar 2018 11:20:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kash Pande <kash@tripleback.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuahkh@osg.samsung.com,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/109] 4.14.28-stable review
Message-ID: <20180319182032.GA23774@roeck-us.net>
References: <20180316152329.844663293@linuxfoundation.org>
 <7ec4a6aa-72cb-9fb6-5168-d1c4d49f1a6c@tripleback.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ec4a6aa-72cb-9fb6-5168-d1c4d49f1a6c@tripleback.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595109030771020666?=
X-GMAIL-MSGID: =?utf-8?q?1595391224646631517?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 02:13:23PM -0400, Kash Pande wrote:
> On 2018-03-16 11:22 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.28 release.
> > There are 109 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun Mar 18 15:22:53 UTC 2018.
> > Anything received after that time might be too late.
> 
> Any chance to get the k10temp change for Threadripper 1900X offset
> reporting included [https://patchwork.kernel.org/patch/10175457/]?
> 
Ryzen and Threadripper are only supported in v4.15+.

Guenter
