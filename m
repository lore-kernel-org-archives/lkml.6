Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbeDDHmw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:42:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:7633 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750711AbeDDHmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:42:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,405,1517904000";
   d="scan'208";a="30571168"
Date: Wed, 4 Apr 2018 15:42:27 +0800
From: kbuild test robot <lkp@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dave Hansen <dave.hansen@linux.intel.com>, aarcange@redhat.com,
        luto@kernel.org, torvalds@linux-foundation.org, keescook@google.com,
        hughd@google.com, jgross@suse.com, x86@kernel.org, namit@vmware.com
Subject: Re: [PATCH 11/11] x86/pti: leave kernel text global for !PCID
Message-ID: <201804041545.zhtcp6gi%fengguang.wu@intel.com>
References: <20180404011011.82027E0C@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404011011.82027E0C@viggo.jf.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/auto-latest]
[also build test WARNING on next-20180403]
[cannot apply to tip/x86/core v4.16]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dave-Hansen/Use-global-pages-with-PTI/20180404-135611
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> arch/x86/mm/pti.c:286:1: sparse: symbol 'pti_clone_pmds' was not declared. Should it be static?
   arch/x86/mm/pti.c:439:6: sparse: symbol 'pti_set_kernel_image_nonglobal' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
