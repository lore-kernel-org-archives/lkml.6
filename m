Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeFERCK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:02:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751819AbeFERCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:02:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/37] 4.4.136-stable review
Date: Tue,  5 Jun 2018 19:01:05 +0200
Message-Id: <20180605170108.884872354@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.136-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.136-rc1
X-KernelTest-Deadline: 2018-06-07T17:01+00:00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.136 release.
There are 37 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Jun  7 17:00:49 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.136-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.136-rc1

David S. Miller <davem@davemloft.net>
    sparc64: Fix build warnings with gcc 7.

David S. Miller <davem@davemloft.net>
    sparc64: Don't clibber fixed registers in __multi4.

David S. Miller <davem@davemloft.net>
    sparc64: Add __multi3 for gcc 7.x and later.

Hugh Dickins <hughd@google.com>
    mm: fix the NULL mapping case in __isolate_lru_page()

Al Viro <viro@zeniv.linux.org.uk>
    fix io_destroy()/aio_complete() race

Arnd Bergmann <arnd@arndb.de>
    Kbuild: change CC_OPTIMIZE_FOR_SIZE definition

Ondrej Zary <linux@rainbow-software.org>
    drm/i915: Disable LVDS on Radiant P845

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    hwtracing: stm: fix build error on some arches

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    stm class: Use vmalloc for the master map

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: scsi_transport_srp: Fix shost to rport translation

Maciej W. Rozycki <macro@mips.com>
    MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE requests

Maciej W. Rozycki <macro@mips.com>
    MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs

Martin Kelly <mkelly@xevo.com>
    iio:kfifo_buf: check for uint overflow

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    dmaengine: usb-dmac: fix endless loop in usb_dmac_chan_terminate_all()

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: rcar: revoke START request early

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: rcar: check master irqs before slave irqs

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: rcar: don't issue stop when HW does it automatically

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: rcar: init new messages in irq

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: rcar: refactor setup of a msg

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: rcar: remove spinlock

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: rcar: remove unused IOERROR state

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: rcar: rework hw init

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: rcar: make sure clocks are on when doing clock calculation

Eric Dumazet <edumazet@google.com>
    tcp: avoid integer overflows in tcp_rcv_space_adjust()

Arnd Bergmann <arnd@arndb.de>
    irda: fix overly long udelay()

Colin Ian King <colin.king@canonical.com>
    ASoC: Intel: sst: remove redundant variable dma_dev_name

Matthias Kaehlcke <mka@chromium.org>
    rtlwifi: rtl8192cu: Remove variable self-assignment in rf.c

Eric Biggers <ebiggers@google.com>
    cfg80211: further limit wiphy names to 64 bytes

Sachin Grover <sgrover@codeaurora.org>
    selinux: KASAN: slab-out-of-bounds in xattr_getsecurity

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix crash when freeing instances with event triggers

Benjamin Tissoires <benjamin.tissoires@redhat.com>
    Input: elan_i2c_smbus - fix corrupted stack

Mimi Zohar <zohar@linux.vnet.ibm.com>
    Revert "ima: limit file hash setting by user to fix and log modes"

Brian Foster <bfoster@redhat.com>
    xfs: detect agfl count corruption and reset agfl

Yoshinori Sato <ysato@users.sourceforge.jp>
    sh: New gcc support

Geert Uytterhoeven <geert@linux-m68k.org>
    USB: serial: cp210x: use tcflag_t to fix incompatible pointer type

Michael Neuling <mikey@neuling.org>
    powerpc/64s: Clear PCR on boot

Will Deacon <will.deacon@arm.com>
    arm64: lse: Add early clobbers to some input/output asm operands


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm64/include/asm/atomic_lse.h                |  14 +-
 arch/mips/kernel/process.c                         |   4 +
 arch/mips/kernel/ptrace.c                          |   2 +-
 arch/mips/kernel/ptrace32.c                        |   2 +-
 arch/powerpc/kernel/cpu_setup_power.S              |   4 +
 arch/sh/kernel/sh_ksyms_32.c                       |   3 +
 arch/sh/lib/ashlsi3.S                              |  35 +++-
 arch/sh/lib/ashrsi3.S                              |  33 +++-
 arch/sh/lib/lshrsi3.S                              |  34 +++-
 arch/sparc/kernel/ds.c                             |   2 +-
 arch/sparc/lib/Makefile                            |   1 +
 arch/sparc/lib/multi3.S                            |  35 ++++
 drivers/dma/sh/usb-dmac.c                          |   4 +-
 drivers/gpu/drm/i915/intel_lvds.c                  |   8 +
 drivers/hwtracing/stm/core.c                       |   7 +-
 drivers/i2c/busses/i2c-rcar.c                      | 202 +++++++++------------
 drivers/iio/buffer/kfifo_buf.c                     |   7 +
 drivers/input/mouse/elan_i2c_smbus.c               |  22 +--
 drivers/net/irda/w83977af_ir.c                     |   4 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/rf.c    |   3 -
 drivers/scsi/scsi_transport_srp.c                  |  22 ++-
 drivers/usb/serial/cp210x.c                        |   9 +-
 fs/aio.c                                           |   3 +-
 fs/xfs/libxfs/xfs_alloc.c                          |  94 ++++++++++
 fs/xfs/xfs_mount.h                                 |   1 +
 fs/xfs/xfs_trace.h                                 |   9 +-
 include/linux/tcp.h                                |   2 +-
 include/uapi/linux/nl80211.h                       |   2 +-
 init/Kconfig                                       |  13 ++
 kernel/trace/trace_events_trigger.c                |   5 +-
 mm/vmscan.c                                        |   2 +-
 net/ipv4/tcp_input.c                               |  10 +-
 security/integrity/ima/ima_appraise.c              |   8 +-
 security/selinux/ss/services.c                     |   2 +-
 sound/soc/intel/common/sst-firmware.c              |   2 -
 36 files changed, 410 insertions(+), 204 deletions(-)
