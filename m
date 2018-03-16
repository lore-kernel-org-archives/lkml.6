Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbeCPIQX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:16:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:19329 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbeCPIQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:16:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,313,1517904000";
   d="scan'208";a="211875742"
Date: Fri, 16 Mar 2018 16:15:33 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Martin Brandenburg <martin@omnibond.com>
Cc: kbuild-all@01.org, Mike Marshall <hubcap@omnibond.com>,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org
Subject: [martinbrandenburg:for-next 20/24] fs/orangefs/file.c:586:5: sparse:
 symbol 'orangefs_flush' was not declared. Should it be static?
Message-ID: <201803161633.LJb0owl8%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/martinbrandenburg/linux for-next
head:   f73753424e408389a77bcfa9b04beb41f0f6b2f8
commit: 27dd09ddfeca4937da105e89ded1ba3d35e1038e [20/24] orangefs: implement writepage
reproduce:
        # apt-get install sparse
        git checkout 27dd09ddfeca4937da105e89ded1ba3d35e1038e
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   fs/orangefs/file.c:428:35: sparse: symbol 'orangefs_file_vm_ops' was not declared. Should it be static?
>> fs/orangefs/file.c:586:5: sparse: symbol 'orangefs_flush' was not declared. Should it be static?
--
>> fs/orangefs/inode.c:88:5: sparse: symbol 'orangefs_write_end' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
