Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932088AbeE2HIh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751444AbeE2HIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:08:36 -0400
Date: Tue, 29 May 2018 09:08:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, dave@stgolabs.net
Subject: Re: [PATCH 4.16 000/272] 4.16.13-stable review
Message-ID: <20180529070815.GB20225@kroah.com>
References: <20180528100240.256525891@linuxfoundation.org>
 <CA+G9fYu1NuW6vB+bHEsYSmyJAB27kw8vP=0uwhVR962Yq4C43g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYu1NuW6vB+bHEsYSmyJAB27kw8vP=0uwhVR962Yq4C43g@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:55:34AM +0530, Naresh Kamboju wrote:
> On 28 May 2018 at 15:30, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.16.13 release.
> > There are 272 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed May 30 10:01:02 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.13-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.
> 
> NOTE:
> The failed LTP test case "cve-2017-5669" is a waiver here.

Thanks for figuring that one out :)

Also, thanks for testing all of these and letting me know.

greg k-h
