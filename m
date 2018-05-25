Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967278AbeEYQjX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:39:23 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:46009 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967157AbeEYQjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:39:22 -0400
Date: Fri, 25 May 2018 09:39:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/92] 4.4.133-stable review
Message-ID: <20180525163919.GA2703@roeck-us.net>
References: <20180524093159.286472249@linuxfoundation.org>
 <20180524173208.GB11172@roeck-us.net>
 <20180524194742.GE4413@kroah.com>
 <20180525141145.GA14120@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525141145.GA14120@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 04:11:45PM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 24, 2018 at 09:47:42PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, May 24, 2018 at 10:32:08AM -0700, Guenter Roeck wrote:
> > > On Thu, May 24, 2018 at 11:37:37AM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.4.133 release.
> > > > There are 92 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Sat May 26 09:31:28 UTC 2018.
> > > > Anything received after that time might be too late.
> > > > 
> > > Build results:
> > > 	total: 146 pass: 145 fail: 1
> > > Failed builds: 
> > > 	s390:allmodconfig 
> > > Qemu test results:
> > > 	total: 127 pass: 127 fail: 0
> > > 
> > > Build error (s390:allmodconfig):
> > > 
> > > arch/s390/built-in.o: In function `__s390x_indirect_jump_r1use_r1':
> > > (.text.__s390x_indirect_jump_r1use_r1[__s390x_indirect_jump_r1use_r1]+0x2):
> > > 			undefined reference to `_LC_BR_R1'
> > 
> > I'll look into the s390 stuff in the morning, I think I know what I
> > messed up there...
> 
> Nope, I don't think this was my fault :)
> 
> Oddly 'defconfig' worked for s390 with the offending patch, but not
> allmodconfig.  I've now dropped the patch I think was causing the
> problem and pushed out a -rc2.
> 
Confirmed to build with v4.4.132-92-g8330f2b.

Guenter
