Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvXW3SrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B752B601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbeFFNcV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752035AbeFFNcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:32:19 -0400
Date: Wed, 6 Jun 2018 15:31:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/37] 4.4.136-stable review
Message-ID: <20180606133155.GA27333@kroah.com>
References: <20180605170108.884872354@linuxfoundation.org>
 <965820e9-cf8a-a1f0-e23d-0b2ba910d613@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <965820e9-cf8a-a1f0-e23d-0b2ba910d613@roeck-us.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 06:28:39AM -0700, Guenter Roeck wrote:
> On 06/05/2018 10:01 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.136 release.
> > There are 37 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Jun  7 17:00:49 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 148 pass: 146 fail: 2
> Failed builds:
> 	sparc64:allmodconfig
> 	sparc64:allnoconfig
> Qemu test results:
> 	total: 128 pass: 124 fail: 4
> Failed tests:
> 	sparc64:sun4u:smp:sparc64_defconfig
> 	sparc64:sun4v:smp:sparc64_defconfig
> 	sparc64:sun4u:nosmp:sparc64_defconfig
> 	sparc64:sun4v:nosmp:sparc64_defconfig
> 
> Failure caused by 'sparc64: Add __multi3 for gcc 7.x and later'. Please drop it
> as well as 'sparc64: Don't clibber fixed registers in __multi4.'. gcc 7/8 support
> for sparc in v4.4 will need more work. Sorry for the mess-up.

Not a problem, I've pushed out a -rc2 with those two patches now
dropped.

thanks,

greg k-h
