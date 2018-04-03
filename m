Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbeDCN1R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:27:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:57885 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751000AbeDCN1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:27:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,401,1517904000";
   d="scan'208";a="40343165"
Date: Tue, 3 Apr 2018 21:27:13 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/45] C++: Set compilation as C++ for .c files
Message-ID: <20180403132713.cffx5mpfrnwuokeh@wfg-t540p.sh.intel.com>
References: <201804021242.NgXgixG7%fengguang.wu@intel.com>
 <152261524532.30503.16094079179209557382.stgit@warthog.procyon.org.uk>
 <18231.1522761410@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <18231.1522761410@warthog.procyon.org.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 02:16:50PM +0100, David Howells wrote:
>kbuild test robot <lkp@intel.com> wrote:
>
>>    scripts/Makefile.kasan:17: Cannot use CONFIG_KASAN: -fsanitize=kernel-address is not supported by compiler
>>    cc1: warning: command line option '-fno-rtti' is valid for C++/ObjC++ but not for C
>>    cc1: warning: command line option '-fpermissive' is valid for C++/ObjC++ but not for C
>
>It would need to use g++-8 to compile it ;-)

Awesome! :)

Cheers,
Fengguang
