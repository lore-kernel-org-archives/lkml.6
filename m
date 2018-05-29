Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754820AbeE2HHf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:07:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754668AbeE2HHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:07:32 -0400
Date: Tue, 29 May 2018 09:07:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 000/272] 4.16.13-stable review
Message-ID: <20180529070711.GA20225@kroah.com>
References: <20180528100240.256525891@linuxfoundation.org>
 <b1529156-a65e-1aa6-43e4-88c895befefc@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1529156-a65e-1aa6-43e4-88c895befefc@roeck-us.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 05:46:26PM -0700, Guenter Roeck wrote:
> On 05/28/2018 03:00 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.16.13 release.
> > There are 272 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed May 30 10:01:02 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 143 pass: 143 fail: 0
> Qemu test results:
> 	total: 141 pass: 141 fail: 0
> 
> Details are available at http://kerneltests.org/builders.

Wonderful, everything passed.  Thanks for testing all of these and
letting me know.

greg k-h
