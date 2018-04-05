Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeDELjE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:39:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:44736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751376AbeDELjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:39:02 -0400
Date: Thu, 5 Apr 2018 13:39:01 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] trivial for 4.17
Message-ID: <nycvar.YFH.7.76.1804051334380.28129@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git for-linus

to receive trivial patch queue for 4.17.

Thanks.

----------------------------------------------------------------
Frank Asseg (1):
      tools/thermal: tmon: fix for segfault

Geert Uytterhoeven (1):
      net: Spelling s/stucture/structure/

Jaak Ristioja (1):
      Documentation: Fix early-microcode.txt references after file rename

Joe Perches (1):
      treewide: Align function definition open/close braces

Johannes Thumshirn (1):
      edd: don't spam log if no EDD information is present

Markus Elfring (1):
      GenWQE: Fix a typo in two comments

Martin Kelly (1):
      kfifo: fix inaccurate comment

Masanari Iida (1):
      treewide: Fix typos in printk

Rohit Visavalia (1):
      tracing: Block comments should align the * on each line

 Documentation/x86/00-INDEX                            |  4 ++--
 arch/x86/Kconfig                                      |  2 +-
 arch/x86/include/asm/atomic64_32.h                    |  2 +-
 arch/x86/kernel/cpu/microcode/amd.c                   |  2 +-
 drivers/acpi/custom_method.c                          |  2 +-
 drivers/acpi/fan.c                                    |  2 +-
 drivers/firmware/edd.c                                |  8 +++-----
 drivers/fmc/fmc-core.c                                |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c             |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c              |  2 +-
 drivers/gpu/drm/i915/intel_cdclk.c                    |  4 ++--
 drivers/media/i2c/msp3400-kthreads.c                  |  2 +-
 drivers/message/fusion/mptsas.c                       |  2 +-
 drivers/misc/genwqe/card_utils.c                      |  4 ++--
 drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c  |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_int.c             |  2 +-
 drivers/net/ethernet/ti/tlan.c                        |  2 +-
 drivers/net/wireless/ath/ath9k/xmit.c                 |  2 +-
 drivers/net/wireless/atmel/atmel.c                    |  2 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  2 +-
 drivers/platform/x86/eeepc-laptop.c                   |  2 +-
 drivers/rtc/rtc-ab-b5ze-s3.c                          |  2 +-
 drivers/scsi/aacraid/src.c                            |  4 ++--
 drivers/scsi/dpt_i2o.c                                |  2 +-
 drivers/scsi/qedi/qedi_fw.c                           |  2 +-
 drivers/scsi/sym53c8xx_2/sym_glue.c                   |  2 +-
 fs/locks.c                                            |  2 +-
 fs/ocfs2/stack_user.c                                 |  2 +-
 fs/orangefs/orangefs-utils.c                          |  2 +-
 fs/xfs/xfs_export.c                                   |  2 +-
 include/net/iw_handler.h                              |  2 +-
 kernel/audit.c                                        |  6 +++---
 kernel/trace/trace.c                                  |  2 +-
 kernel/trace/trace_printk.c                           |  4 ++--
 lib/kfifo.c                                           |  2 +-
 lib/raid6/sse2.c                                      | 14 +++++++-------
 net/socket.c                                          |  2 +-
 sound/soc/fsl/fsl_dma.c                               |  2 +-
 tools/thermal/tmon/sysfs.c                            | 12 +++++++-----
 tools/thermal/tmon/tmon.c                             |  1 -
 40 files changed, 60 insertions(+), 61 deletions(-)

-- 
Jiri Kosina
SUSE Labs
