Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeCNSZw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:25:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:55038 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751679AbeCNSZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:25:51 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NV-DIMM Mailing List <linux-nvdimm@lists.01.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 0/3] Introduce module_nd_driver
Date: Wed, 14 Mar 2018 19:25:05 +0100
Message-Id: <20180314182508.10351-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a module_nd_driver() wrapper and move over the appliccable
drivers nd_pmem.ko and dax_pmem.ko.

Johannes Thumshirn (3):
  libnvdimm: provide module_nd_driver wrapper
  libnvdimm, pmem: use module_nd_driver
  device-dax: use module_nd_driver

 drivers/dax/pmem.c    | 12 +-----------
 drivers/nvdimm/pmem.c | 12 +-----------
 include/linux/nd.h    |  6 ++++++
 3 files changed, 8 insertions(+), 22 deletions(-)

-- 
2.13.6
