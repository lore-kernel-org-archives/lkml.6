Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbeD1E2V (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 00:28:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbeD1E2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 00:28:20 -0400
Date: Fri, 27 Apr 2018 21:28:11 -0700
From: Darren Hart <dvhart@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Mario.Limonciello@dell.com, lkp@intel.com, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/platform/x86/dell-smbios-wmi.c:66: undefined reference
 to `wmidev_evaluate_method'
Message-ID: <20180428042811.GA91552@localhost.localdomain>
References: <201804272139.CYzGSbEr%fengguang.wu@intel.com>
 <0ccd04a5-2461-61b3-93b1-90ca4e96440d@infradead.org>
 <c354e68ba5f54d8e891631fae3cfa877@ausx13mpc120.AMER.DELL.COM>
 <7e56091f-18a1-0b18-4584-0142c44bc95b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e56091f-18a1-0b18-4584-0142c44bc95b@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 02:57:21PM -0700, Randy Dunlap wrote:
> On 04/27/2018 11:01 AM, Mario.Limonciello@dell.com wrote:
...
> DELL_SMBIOS depends on ACPI_WMI so when ACPI_WMI=m, DELL_SMBIOS should never =y.
> Your DELL_LAPTOP Kconfig patch does fix this, I believe, because when DELL_LAPTOP=y,
> its select DELL_SMBIOS incorrectly makes DELL_SMBIOS=y.
> 
> 
> so if we can get your patch merged, we can see if any more breakage happens... :)

Sorry, comms fail on my part. This will be merged to for-next by tomorrow.

-- 
Darren Hart
VMware Open Source Technology Center
