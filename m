Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755552AbeCHLiW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:38:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:3483 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934653AbeCHLiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:38:20 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,440,1515484800";
   d="scan'208";a="35610237"
Date: Thu, 8 Mar 2018 19:37:29 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: kbuild-all@01.org, Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [linux-next:master 6182/6533] net/rds/message.c:70:27: sparse:
 symbol 'rds_info_from_znotifier' was not declared. Should it be static?
Message-ID: <201803081946.adQaZcK5%fengguang.wu@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   c6f1a8c953479b390458e36fb838d96199a5f466
commit: 9426bbc6de99b8649d897b94e8f5916b58195643 [6182/6533] rds: use list structure to track information for zerocopy completion notification
reproduce:
        # apt-get install sparse
        git checkout 9426bbc6de99b8649d897b94e8f5916b58195643
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> net/rds/message.c:70:27: sparse: symbol 'rds_info_from_znotifier' was not declared. Should it be static?
   net/rds/message.c:358:5: sparse: symbol 'rds_message_zcopy_from_user' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
