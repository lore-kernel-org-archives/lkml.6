Return-Path: <linux@roeck-us.net>
X-Google-Smtp-Source: AB8JxZrloWQgxi88eVhdELvaOcLmfqp+qeruggDgyVHXmoVs+bWRQlSIl5onmqfD0dGxEhrGvV8d
ARC-Seal: i=1; a=rsa-sha256; t=1524667272; cv=none;
        d=google.com; s=arc-20160816;
        b=pe+3s8lVMh+Xj1z3JleJcJeE/a87A0CN4BEXzB+ALVqNzsMGgb8Gi7t2JW3gscxep2
         cN8yVWrMspQYBhiQ1/DeRBHntuOHadMM9kYTu7KkAB1ssc6gAE300FflH14fWMggOLp1
         cFxP9ps6DHjPt+6jUcvtocR/1FLsTOiuC0gP5bKRuGXaf1hh2ZrlfaS6sVx5cpGa5VYJ
         i9z+9WHxay02v0khlp1UHQ1RZwJXi6bA1vJUBNx4WnfxU8x+4q3M7OSUSXvzHhyYpIVW
         c6hPbhT7LZmjH/+XYeQRXij+8LdttsQ4PVSaqLqDp5fM8otlRm4cb7wH6THFXOztwfjI
         6/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=/cVKU/lqAxT6ETnbmJ3HPhLM0NTvRukpA6/Z5qinUYc=;
        b=PxTLFOO4Hyn+3nwUl6Ua/YwMKy9Otp4k5xE3hDKRAkud4bcNjDaIQLbceEZFhhCV7M
         I1jAva9x37HtsUEs9okl1fLrl6T4KE2s5c9Q+1RcnjXPqnex2YXEWlquYSclePEYxv0H
         NcRriNLCg5uAUVpQqC9EYG+m0rBY9DkCXuiTdBy+bgpG3qcrtBmnnhopFqICceoImkGo
         Dh/uECCScjV6pcTj6zH8U5bkBVe6Dm6z8Ol51uyrD5+OkCAnM2asznIhxYJ1bIKYjDvJ
         HPHYXbC+OpPx1Rmsuq7wQRAnT4+oA5mKf7lDLuY8aBQWGdy1BYwcvH8cMECAD4XzfwVB
         3GGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=XAQ+btna;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=XAQ+btna;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Date: Wed, 25 Apr 2018 07:41:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/183] 4.14.37-stable review
Message-ID: <20180425144110.GA12890@roeck-us.net>
References: <20180425103242.532713678@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598714220036977205?=
X-GMAIL-MSGID: =?utf-8?q?1598729509902367111?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 12:33:40PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.37 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Apr 27 10:32:04 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 146 pass: 145 fail: 1
Failed builds: 
	powerpc:allmodconfig
Qemu test results:
	total: 141 pass: 141 fail: 0

arch/powerpc/kernel/eeh_driver.c: In function 'eeh_report_resume':
arch/powerpc/kernel/eeh_driver.c:395:13: error: 'struct eeh_ops' has no member named 'notify_resume'

Details are available at http://kerneltests.org/builders/.

Guenter
