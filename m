Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753054AbeFFA3q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 20:29:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54975 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752729AbeFFA3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 20:29:45 -0400
X-Google-Smtp-Source: ADUXVKLAnmvXXE3gG4AuK0nPN4bJTk+CX0RrFTyJyhVdzczJHwI/mgeLfUZGEuxswI3eNIU+zcMgoA==
Date: Tue, 5 Jun 2018 17:30:32 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/37] 4.4.136-stable review
Message-ID: <20180606003032.GA10046@flashbox>
References: <20180605170108.884872354@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605170108.884872354@linuxfoundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 07:01:05PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.136 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jun  7 17:00:49 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.136-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel 2 XL and
OnePlus 5.

No issues in general usage or dmesg (although I somehow didn't catch the
VTI issue in 4.4.134 so don't know how valuable this is anymore...)

Thanks!
Nathan
