Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeEPMsM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:48:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:23360 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751395AbeEPMsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:48:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="42260611"
Date: Wed, 16 May 2018 20:47:21 +0800
From: kbuild test robot <lkp@intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        qla2xxx-upstream@qlogic.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <mawilcox@microsoft.com>
Subject: Re: [PATCH 1/2] Convert target drivers to use sbitmap
Message-ID: <201805162035.EWoS94Oq%fengguang.wu@intel.com>
References: <20180515160043.27044-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515160043.27044-2-willy@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17-rc5 next-20180516]
[cannot apply to target/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox/Use-sbitmap-instead-of-percpu_ida/20180516-143658
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/target/iscsi/iscsi_target_util.c:150:5: sparse: symbol 'iscsit_wait_for_tag' was not declared. Should it be static?
   drivers/target/iscsi/iscsi_target_util.c:1174:31: sparse: expression using sizeof(void)
   drivers/target/iscsi/iscsi_target_util.c:1174:31: sparse: expression using sizeof(void)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
