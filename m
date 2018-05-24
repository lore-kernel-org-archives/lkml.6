Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971160AbeEXTrA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967011AbeEXTq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:46:57 -0400
Date: Thu, 24 May 2018 21:46:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harsh Shandilya <harsh@prjkt.io>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/45] 3.18.110-stable review
Message-ID: <20180524194639.GC4413@kroah.com>
References: <20180524093120.599252450@linuxfoundation.org>
 <AE7DD3E7-A563-40D9-937D-D33053C4EC52@prjkt.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AE7DD3E7-A563-40D9-937D-D33053C4EC52@prjkt.io>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 08:14:17PM +0530, Harsh Shandilya wrote:
> On 24 May 2018 3:08:08 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >This is the start of the stable review cycle for the 3.18.110 release.
> >There are 45 patches in this series, all will be posted as a response
> >to this one.  If anyone has any issues with these being applied, please
> >let me know.
> >
> >Responses should be made by Sat May 26 09:30:59 UTC 2018.
> >Anything received after that time might be too late.
> >
> >The whole patch series can be found in one patch at:
> >	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.110-rc1.gz
> >or in the git tree and branch at:
> >	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >linux-3.18.y
> >and the diffstat can be found below.
> 
> Cleanly merges, builds and boots on the OnePlus 3T, no immediate regressions noticed. Thanks for the update!
> -- 
> Harsh Shandilya, PRJKT Development LLC.

Thanks for testing and letting me know.

greg k-h
