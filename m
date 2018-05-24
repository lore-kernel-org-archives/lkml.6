Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965355AbeEXI1n (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:27:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:34537 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964864AbeEXI1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:27:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,436,1520924400";
   d="scan'208";a="43824536"
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 0/2] stm class/intel_th: Fixes for v4.17
Date: Thu, 24 May 2018 11:27:25 +0300
Message-Id: <20180524082727.28990-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

These are 2 fixes I have for this release cycle, pretty straightforward.
Static checkers approve. Individual patches follow. Please consider pulling
or applying. Thanks!

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/stm-intel_th-fixes-for-greg-20180524

for you to fetch changes up to 3ce35db3ff05400e5676d0155cf261cc6bd3d351:

  intel_th: Use correct device when freeing buffers (2018-05-24 10:55:03 +0300)

----------------------------------------------------------------
stm class/intel_th: Fixes for v4.17-rc1

These are 2 fixes, both backportable to stable:
  * stm master array allocation moved to vmalloc
  * intel_th/msu dma buffer deallocation fix.

----------------------------------------------------------------
Alexander Shishkin (2):
      stm class: Use vmalloc for the master map
      intel_th: Use correct device when freeing buffers

 drivers/hwtracing/intel_th/msu.c | 6 +++---
 drivers/hwtracing/stm/core.c     | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.17.0
