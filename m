Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965724AbeBMUM0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:12:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:64631 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965574AbeBMUMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:12:24 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="203843832"
Date: Wed, 14 Feb 2018 04:12:14 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Martin Brandenburg <martin@omnibond.com>
Cc: kbuild-all@01.org, Mike Marshall <hubcap@omnibond.com>,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org
Subject: [martinbrandenburg:for-next 13/13] fs/orangefs/super.c:153:5:
 sparse: symbol 'orangefs_write_inode' was not declared. Should it be static?
Message-ID: <201802140422.EQO7RreI%fengguang.wu@intel.com>
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
head:   525e7273bc80995f5bcfdc2780b870aa3ab37a18
commit: 525e7273bc80995f5bcfdc2780b870aa3ab37a18 [13/13] orangefs: let setattr write to cached inode
reproduce:
        # apt-get install sparse
        git checkout 525e7273bc80995f5bcfdc2780b870aa3ab37a18
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> fs/orangefs/super.c:153:5: sparse: symbol 'orangefs_write_inode' was not declared. Should it be

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
