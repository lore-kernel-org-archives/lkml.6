Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967370AbeEYQus (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967219AbeEYQur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:50:47 -0400
Date: Fri, 25 May 2018 18:50:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/92] 4.4.133-stable review
Message-ID: <20180525165029.GA8405@kroah.com>
References: <20180524093159.286472249@linuxfoundation.org>
 <20180524173208.GB11172@roeck-us.net>
 <20180524194742.GE4413@kroah.com>
 <20180525141145.GA14120@kroah.com>
 <20180525163919.GA2703@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525163919.GA2703@roeck-us.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 09:39:19AM -0700, Guenter Roeck wrote:
> On Fri, May 25, 2018 at 04:11:45PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, May 24, 2018 at 09:47:42PM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, May 24, 2018 at 10:32:08AM -0700, Guenter Roeck wrote:
> > > > On Thu, May 24, 2018 at 11:37:37AM +0200, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 4.4.133 release.
> > > > > There are 92 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > > 
> > > > > Responses should be made by Sat May 26 09:31:28 UTC 2018.
> > > > > Anything received after that time might be too late.
> > > > > 
> > > > Build results:
> > > > 	total: 146 pass: 145 fail: 1
> > > > Failed builds: 
> > > > 	s390:allmodconfig 
> > > > Qemu test results:
> > > > 	total: 127 pass: 127 fail: 0
> > > > 
> > > > Build error (s390:allmodconfig):
> > > > 
> > > > arch/s390/built-in.o: In function `__s390x_indirect_jump_r1use_r1':
> > > > (.text.__s390x_indirect_jump_r1use_r1[__s390x_indirect_jump_r1use_r1]+0x2):
> > > > 			undefined reference to `_LC_BR_R1'
> > > 
> > > I'll look into the s390 stuff in the morning, I think I know what I
> > > messed up there...
> > 
> > Nope, I don't think this was my fault :)
> > 
> > Oddly 'defconfig' worked for s390 with the offending patch, but not
> > allmodconfig.  I've now dropped the patch I think was causing the
> > problem and pushed out a -rc2.
> > 
> Confirmed to build with v4.4.132-92-g8330f2b.

Wonderful, thanks for testing and letting me know.

greg k-h
