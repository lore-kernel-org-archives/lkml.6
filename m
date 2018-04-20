Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754607AbeDTKrC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:47:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:36911 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754559AbeDTKrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:47:00 -0400
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes and one header update for 4.17-rc2
Date: Fri, 20 Apr 2018 12:46:57 +0200
Message-Id: <20180420104657.7640-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.17-rc2-tag

xen: fixes and one header update for 4.17-rc2

It contains some fixes of kmalloc() flags, one fix of the xenbus driver
and an update of the pv sound driver interface needed for a driver
which will go through the sound tree.

Thanks.

Juergen

 drivers/xen/xen-pciback/conf_space_quirks.c |   2 +-
 drivers/xen/xen-pciback/pci_stub.c          |   8 +-
 drivers/xen/xenbus/xenbus_dev_frontend.c    |   3 +-
 include/xen/interface/io/sndif.h            | 322 ++++++++++++++++++++++++++--
 4 files changed, 313 insertions(+), 22 deletions(-)

Jia-Ju Bai (5):
      xen: xen-pciback: Replace GFP_ATOMIC with GFP_KERNEL in pcistub_probe
      xen: xen-pciback: Replace GFP_ATOMIC with GFP_KERNEL in pcistub_init_device
      xen: xen-pciback: Replace GFP_ATOMIC with GFP_KERNEL in pcistub_device_alloc
      xen: xen-pciback: Replace GFP_ATOMIC with GFP_KERNEL in xen_pcibk_config_quirks_init
      xen: xen-pciback: Replace GFP_ATOMIC with GFP_KERNEL in pcistub_reg_add

Oleksandr Andrushchenko (1):
      xen/sndif: Sync up with the canonical definition in Xen

Simon Gaiser (1):
      xen: xenbus_dev_frontend: Really return response string
