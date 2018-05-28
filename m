Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425285AbeE1QYP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:24:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55765 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940011AbeE1QYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 12:24:03 -0400
X-Google-Smtp-Source: ADUXVKLy4FyNDh8VlfI/sfo62+1jbF1zjedvqb8WF40rIghxfu47LSxPGGBHnlIfWoc2RZ4TJK9vmQ==
Date: Mon, 28 May 2018 09:24:42 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/268] 4.4.134-stable review
Message-ID: <20180528162442.GB6895@flashbox>
References: <20180528100202.045206534@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:59:34AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.134 release.
> There are 268 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May 30 10:00:40 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.134-rc1.gz
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

No initial issues noticed in general usage or dmesg.

Thanks!
Nathan
