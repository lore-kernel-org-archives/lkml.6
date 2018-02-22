Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeBVCLv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 21:11:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:6918 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751802AbeBVCLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 21:11:50 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,376,1515484800";
   d="scan'208";a="29739008"
Date: Thu, 22 Feb 2018 10:11:45 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>, LKP <lkp@intel.com>
Subject: Re: [RFC PATCH tip] x86/acpi: u64_x86_init_noop() can be static
Message-ID: <20180222021145.ngy7l5mu2dgtn333@wfg-t540p.sh.intel.com>
References: <201802202043.UzW7iu9d%fengguang.wu@intel.com>
 <20180220123819.GA20499@lkp-wsm-ep1>
 <20180221085148.rs3t7zad73wbpktm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180221085148.rs3t7zad73wbpktm@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 09:51:48AM +0100, Ingo Molnar wrote:
>
>* kbuild test robot <fengguang.wu@intel.com> wrote:
>
>>
>> Fixes: 62d8b7fba8d3 ("x86/acpi: Add a new x86_init_acpi structure to x86_init_ops")
>> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
>> ---
>>  0 files changed
>
>-ENOPATCH?

Ah the script crashed when it tries to indent the new code, since it
assumes

        func_name()
        {
        }

while here it's

        func_name() { }

I'll fix it up.

Thanks,
Fengguang
