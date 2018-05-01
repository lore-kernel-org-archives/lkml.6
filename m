Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753879AbeEAJdh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:33:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50823 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbeEAJde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:33:34 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        djkurtz@chromium.org, Alexander.Deucher@amd.com,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: APD: Add AMD misc clock handler support
Date: Tue, 01 May 2018 11:33:17 +0200
Message-ID: <2276656.jNytOrKoqF@aspire.rjw.lan>
In-Reply-To: <096a504f-1d86-afc8-c6db-6ee1073a755c@amd.com>
References: <1525072206-17956-1-git-send-email-akshu.agrawal@amd.com> <201804301633.FxGiqS4Z%fengguang.wu@intel.com> <096a504f-1d86-afc8-c6db-6ee1073a755c@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 30, 2018 11:40:08 AM CEST Agrawal, Akshu wrote:
> 
> On 4/30/2018 2:23 PM, kbuild test robot wrote:
> > Hi Akshu,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on pm/linux-next]
> > [also build test ERROR on v4.17-rc3 next-20180426]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Akshu-Agrawal/ACPI-APD-Add-AMD-misc-clock-handler-support/20180430-152810
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> > config: x86_64-acpi-redef (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> > reproduce:
> >          # save the attached .config to linux build tree
> >          make ARCH=x86_64
> > 
> > All errors (new ones prefixed by >>):
> > 
> >>> drivers//acpi/acpi_apd.c:14:10: fatal error: linux/platform_data/clk-st.h: No such file or directory
> >      #include <linux/platform_data/clk-st.h>
> >               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     compilation terminated.
> > 
> 
> This patch is dependent on https://patchwork.kernel.org/patch/10370955/
> The above patch adds the required include file.

So please resend it when the requisite patch is merged and add the dependency
information to its changelog.

Thanks,
Rafael
