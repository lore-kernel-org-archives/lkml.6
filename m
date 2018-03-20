Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeCTXZB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 19:25:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCTXY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 19:24:58 -0400
Date: Tue, 20 Mar 2018 16:24:53 -0700
From: Darren Hart <dvhart@infradead.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Mario Limonciello <mario.limonciello@dell.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/platform/x86/dell-smbios-smm.c:99: undefined reference
 to `dcdbas_smi_request'
Message-ID: <20180320232453.GA24376@fury>
References: <201803201222.K37oCZ9Z%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201803201222.K37oCZ9Z%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 12:47:24PM +0800, kbuild test robot wrote:
> Hi Mario,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1b5f3ba415fe4cf8b8b39c8d104ed44cde330658
> commit: 25d47027e1003546bfd8964b4423cb39bc2d53e9 platform/x86: dell-smbios: Link all dell-smbios-* modules together

For completeness:

This is a known warning at this commit, which is addressed in future commits now
merged, specifically:

75073a64a98c platform/x86: dell-smbios: Resolve dependency error on ACPI_WMI
32d7b19bad96 platform/x86: dell-smbios: Resolve dependency error on DCDBAS
329d58b890be platform/x86: Allow for SMBIOS backend defaults

Thanks,

-- 
Darren Hart
VMware Open Source Technology Center
