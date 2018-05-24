Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034481AbeEXTIb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034424AbeEXTIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:08:24 -0400
Date: Thu, 24 May 2018 21:08:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, ben.hutchings@codethink.co.uk,
        stable@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net
Subject: Re: [PATCH 4.4 00/92] 4.4.133-stable review
Message-ID: <20180524190806.GE31019@kroah.com>
References: <20180524093159.286472249@linuxfoundation.org>
 <20180524180652.7bqyquqfe2nqdxfg@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180524180652.7bqyquqfe2nqdxfg@xps>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 01:06:52PM -0500, Dan Rue wrote:
> On Thu, May 24, 2018 at 11:37:37AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.133 release.
> > There are 92 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat May 26 09:31:28 UTC 2018.
> > Anything received after that time might be too late.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.
> 
> Summary
> ------------------------------------------------------------------------
> 
> kernel: 4.4.133-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> git branch: linux-4.4.y
> git commit: 915a3d7cdea9daa9e9fb6b855f10c1312e6910c4
> git describe: v4.4.132-93-g915a3d7cdea9
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.132-93-g915a3d7cdea9
> 
> 
> No regressions (compared to build v4.4.132-71-g180635995c36)

It should have gotten better, as there was a fix in here for at least 2
LTP tests that we previously were not passing.  I don't know why you all
were not reporting that in the past, it took someone else randomly
deciding to run LTP to report it to me...

Why did an improvement in results not show up?

thanks,

greg k-h
