Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754579AbeBBUES (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:04:18 -0500
Received: from mga02.intel.com ([134.134.136.20]:64512 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752865AbeBBUD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:03:59 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,450,1511856000";
   d="scan'208";a="28378584"
Date: Sat, 3 Feb 2018 04:03:02 +0800
From: kbuild test robot <lkp@intel.com>
To: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: kbuild-all@01.org, kvm@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>,
        Len Brown <len.brown@intel.com>, Kyle Huey <me@kylehuey.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@suse.de>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Kan Liang <Kan.liang@intel.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: Re: [PATCH v4 3/3] x86/kvm: Expose AMD Core Perf Extension flag to
 guests
Message-ID: <201802030310.MucL4Uiq%fengguang.wu@intel.com>
References: <f481ade083edd15c0f5850babaeef378ab06ffce.1517333237.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f481ade083edd15c0f5850babaeef378ab06ffce.1517333237.git.Janakarajan.Natarajan@amd.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janakarajan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on v4.15]
[cannot apply to kvm/linux-next next-20180202]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Janakarajan-Natarajan/Support-Perf-Extensions-on-AMD-KVM-guests/20180202-231344
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> arch/x86/kvm/cpuid.c:58:6: sparse: symbol 'perf_ext_supported' was not declared. Should it be

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
