Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971206AbeEXTsR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966483AbeEXTsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:48:15 -0400
Date: Thu, 24 May 2018 21:47:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 000/161] 4.16.12-stable review
Message-ID: <20180524194756.GF4413@kroah.com>
References: <20180524093018.331893860@linuxfoundation.org>
 <20180524173441.GE11172@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524173441.GE11172@roeck-us.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 10:34:41AM -0700, Guenter Roeck wrote:
> On Thu, May 24, 2018 at 11:37:05AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.16.12 release.
> > There are 161 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat May 26 09:29:22 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 143 pass: 143 fail: 0
> Qemu test results:
> 	total: 139 pass: 139 fail: 0
> 
> Details are available at http://kerneltests.org/builders/.

Thanks for testing all of these and letting me know.

greg k-h
