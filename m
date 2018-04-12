Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752951AbeDLR6M (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 13:58:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:33926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752917AbeDLR6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 13:58:11 -0400
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes for 4.17-rc1
Date: Thu, 12 Apr 2018 19:58:08 +0200
Message-Id: <20180412175808.13613-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.17-rc1-tag

xen: fixes for 4.17-rc1

It contains only a few fixes of Xen related core code and drivers.

Thanks.

Juergen

 arch/x86/xen/enlighten_pv.c              |  8 ++++----
 arch/x86/xen/xen-head.S                  |  4 +++-
 drivers/acpi/processor_perflib.c         | 11 +++++------
 drivers/xen/xen-acpi-processor.c         | 30 +++++++++++++++++++++++++++---
 drivers/xen/xenbus/xenbus_dev_frontend.c | 16 ++++++++++++----
 drivers/xen/xenbus/xenbus_xs.c           |  4 +++-
 include/acpi/processor.h                 |  2 ++
 include/xen/interface/features.h         | 23 +++++++++++++++++++++++
 8 files changed, 79 insertions(+), 19 deletions(-)

Boris Ostrovsky (1):
      xen/pvh: Indicate XENFEAT_linux_rsdp_unrestricted to Xen

Dan Carpenter (1):
      xen/acpi: off by one in read_acpi_id()

Jason Andryuk (1):
      x86/xen: Delay get_cpu_cap until stack canary is established

Joao Martins (1):
      xen/acpi: upload _PSD info for non Dom0 CPUs too

Simon Gaiser (3):
      xen: xenbus_dev_frontend: Fix XS_TRANSACTION_END handling
      xen: xenbus: Catch closing of non existent transactions
      xen: xenbus_dev_frontend: Verify body of XS_TRANSACTION_END
