Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbeFEI2B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751049AbeFEI2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:28:00 -0400
Date: Tue, 5 Jun 2018 10:27:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kevin Hilman <khilman@baylibre.com>
Cc: "kernelci.org bot" <bot@kernelci.org>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/52] 4.14.48-stable review
Message-ID: <20180605082737.GC9155@kroah.com>
References: <20180604065606.532044490@linuxfoundation.org>
 <5b15302c.1c69fb81.bb82c.0d31@mx.google.com>
 <7h602ykv08.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7h602ykv08.fsf@baylibre.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 04:11:03PM -0700, Kevin Hilman wrote:
> kernelci.org bot <bot@kernelci.org> writes:
> 
> > Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-4.14.y/kernel/v4.14.47-53-g721adf61fde2/
> > Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.y/kernel/v4.14.47-53-g721adf61fde2/
> >
> > Tree: stable-rc
> > Branch: linux-4.14.y
> > Git Describe: v4.14.47-53-g721adf61fde2
> > Git Commit: 721adf61fde28b9a87a95e45ecf3f5a325e7c76f
> > Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > Tested: 56 unique boards, 23 SoC families, 14 builds out of 185
> >
> > Boot Regressions Detected:
> >
> > arm64:
> >
> >     defconfig:
> >         meson-gxl-s905x-khadas-vim:
> >             lab-baylibre: failing since 39 days (last pass: v4.14.26-140-g2a1700a4929f - first fail: v4.14.36-184-g3cd53e436ee2)
> >
> > Conflicting Boot Failure Detected: (These likely are not failures as other labs are reporting PASS. Needs review.)
> 
> TL;DR;  All is well.
> 
> The failing board is having a power supply issue and has been taken
> offline for repair.  Since the same board is passing fine in another
> lab, it can be ignored.

Thanks for the updates on this, and the 4.9 board breakage.

greg k-h
