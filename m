Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751137AbeCIKG6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:06:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:25803 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751088AbeCIKG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:06:56 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,444,1515484800";
   d="scan'208";a="40535605"
Date: Fri, 9 Mar 2018 12:06:51 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jeremy McNicoll <jmcnicol@redhat.com>,
        Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Subject: Re: [PATCH v3 00/18] thunderbolt: Add support for Intel Titan Ridge
Message-ID: <20180309100651.GB2703@lahna.fi.intel.com>
References: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 03:38:34PM +0300, Mika Westerberg wrote:
> Mika Westerberg (13):
>   thunderbolt: Resume control channel after hibernation image is created
>   thunderbolt: Serialize PCIe tunnel creation with PCI rescan
>   thunderbolt: Handle connecting device in place of host properly
>   thunderbolt: Do not overwrite error code when domain adding fails
>   thunderbolt: Wait a bit longer for root switch config space
>   thunderbolt: Wait a bit longer for ICM to authenticate the active NVM
>   thunderbolt: Handle rejected Thunderbolt devices
>   thunderbolt: Factor common ICM add and update operations out
>   thunderbolt: Add tb_switch_get()
>   thunderbolt: Add constant for approval timeout
>   thunderbolt: Move driver ready handling to struct icm
>   thunderbolt: Add support for preboot ACL
>   thunderbolt: Introduce USB only (SL4) security level
> 
> Radion Mirchevsky (4):
>   thunderbolt: Correct function name in kernel-doc comment
>   thunderbolt: Add tb_switch_find_by_route()
>   thunderbolt: Add tb_xdomain_find_by_route()
>   thunderbolt: Add support for Intel Titan Ridge
> 
> Yehezkel Bernat (1):
>   thunderbolt: Add 'boot' attribute for devices

Whole series applied to thunderbolt.git/next.
