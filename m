Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbeCRECm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 00:02:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:1606 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbeCRECk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 00:02:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,323,1517904000";
   d="scan'208";a="212601922"
Date: Sun, 18 Mar 2018 12:02:16 +0800
From: kbuild test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: kbuild-all@01.org, linux-nvdimm@lists.01.org, Jan Kara <jack@suse.com>,
        david@fromorbit.com, hch@lst.de, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, jack@suse.cz,
        ross.zwisler@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/15] ext2, dax: introduce ext2_dax_aops
Message-ID: <201803181114.Pvmn8NON%fengguang.wu@intel.com>
References: <152112911591.24669.7494781212673308769.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152112911591.24669.7494781212673308769.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc5 next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dan-Williams/dax-fix-dma-vs-truncate-hole-punch/20180318-050250
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> fs/ext2/inode.c:992:39: sparse: symbol 'ext2_dax_aops' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
