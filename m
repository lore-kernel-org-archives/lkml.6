Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeDJJp5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:45:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:23869 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbeDJJp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:45:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,431,1517904000";
   d="scan'208";a="42141203"
Date: Tue, 10 Apr 2018 17:45:53 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, Philip Li <philip.li@intel.com>
Subject: Re: [PATCH 05/45] C++: Set compilation as C++ for .c files
Message-ID: <20180410094553.6psva5rntlizm6pz@wfg-t540p.sh.intel.com>
References: <20180403132713.cffx5mpfrnwuokeh@wfg-t540p.sh.intel.com>
 <201804021242.NgXgixG7%fengguang.wu@intel.com>
 <152261524532.30503.16094079179209557382.stgit@warthog.procyon.org.uk>
 <18231.1522761410@warthog.procyon.org.uk>
 <19628.1523349854@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <19628.1523349854@warthog.procyon.org.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, Apr 10, 2018 at 09:44:14AM +0100, David Howells wrote:
>Hi Fengguang,
>
>There's another kbuild test that's probably worth adding if you don't do it
>already: create a c++ source file that just #includes all the exported UAPI
>headers and then try to build it.  This should catch words like "private"
>cropping up in structs.

That's a good idea! And it looks straightforward to do.
CC Philip (current LKP maintainer) for possible plans.

Thanks,
Fengguang
