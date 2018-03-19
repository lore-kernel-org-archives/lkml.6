Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521492206-3-18144336115868281482
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521492205; b=eMkvq3HVotrANQkLAGpF82fcGfZvm4wtsWLweCaTYLtRn7Q
    gdkkIJbUPEQ/wzsuCa2LBDooQ+Ni4udoit3EzKZuXBE/i9BwPt8mRn/Lo+CyCSg+
    3eAH25sl+gSG3V/EL9VuTnxrv/J7bXvsQFpD1fXuVmBFUlH/urQOzfRNGfBiszVM
    SSgMj9ZJ7EV1xvzwL9N4mUD+kbWiRlu5A5QOVH2CEgpm0O67tRc5k85g5vH4Reon
    Mjp1lHkNEJkZ1HxF27I+j+ut/B+2Iy7dm7aFn2sGjR398OVUzJwo4qHz/4HvncQo
    yMqwTfuUgWosjgkJEidyB8jSgl9+ZH7rAWCvsVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1521492205; bh=zO9ZsKo7t3tVi/dVa7gxurV+AI
    WhBMepcsHqbPmtzL4=; b=byW9AbP+Fo8SMvJZkH4dYx7fiX8nRtCalLUBMUVCsn
    hozQ9U5n1Wl4umJu+lKQ+N4SAHlQwQ1Gwt3i3SoF8MqN8skob/3qyBvAhBhBUU+L
    S6AckdXhOpnOTWmxBExABd++9LD2EDrR24W68oZQbJ6BbNegl04x5AiCBB2B2p2b
    J1/LcfxFsU5HNqkQp9/r0djlyNb1AWuArKhjz3qJxN3ntoVOnZEr6b0b7xnnjQgp
    rI982tKy2mt1CirhEdpeRdZDdubGWq6HKL8HHBgbD368KVJPlIfYNzB6cPgLZWbx
    nJewlKZxho9b0S5w6ZBbU+klaRkm4YoM83mZHp0X8Vyw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffogggftgfgshhpjeesthekfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudegvdejjeenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffogggftgfgshhpjeesthekfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudegvdejjeenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032061AbeCSUma (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 16:42:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41934 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965618AbeCSSKc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:10:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/68] 3.18.101-stable review
Date: Mon, 19 Mar 2018 19:05:38 +0100
Message-Id: <20180319171827.899658615@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.101-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.101-rc1
X-KernelTest-Deadline: 2018-03-21T17:18+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.18.101 release.
There are 68 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Mar 21 17:17:59 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.101-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.101-rc1

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: sg: only check for dxfer_len greater than 256M

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: sg: fix static checker warning in sg_is_valid_dxfer

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: sg: fix SG_DXFER_FROM_DEV transfers

Tejun Heo <tj@kernel.org>
    fs/aio: Use RCU accessors for kioctx_table->table[]

Tejun Heo <tj@kernel.org>
    fs/aio: Add explicit RCU grace period when freeing kioctx

Al Viro <viro@zeniv.linux.org.uk>
    lock_parent() needs to recheck if dentry got __dentry_kill'ed under it

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Clear client entry before deleting else at closing

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix possible UAF in snd_seq_check_queue()

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix UAF in snd_pcm_oss_get_formats()

Mimi Zohar <zohar@linux.vnet.ibm.com>
    ima: relax requiring a file signature for new files with zero length

SeongJae Park <sj38.park@gmail.com>
    rcutorture/configinit: Fix build directory error message

Dan Carpenter <dan.carpenter@oracle.com>
    ASoC: nuc900: Fix a loop timeout test

Luca Coelho <luciano.coelho@intel.com>
    mac80211: remove BUG() when interface type is invalid

Stephen Hemminger <stephen@networkplumber.org>
    veth: set peer GSO values

Dan Carpenter <dan.carpenter@oracle.com>
    media: cpia2: Fix a couple off by one bugs

Xose Vazquez Perez <xose.vazquez@gmail.com>
    scsi: devinfo: apply to HP XP the same flags as Hitachi VSP

Tobias Jordan <Tobias.Jordan@elektrobit.com>
    spi: sun6i: disable/unprepare clocks on remove

Julien BOIBESSOT <julien.boibessot@armadeus.com>
    tools/usbip: fixes build with musl libc toolchain

Jagdish Gediya <jagdish.gediya@nxp.com>
    mtd: nand: ifc: update bufnum mask for ver >= 2.0.0

Andrew F. Davis <afd@ti.com>
    ARM: dts: omap3-n900: Fix the audio CODEC's reset pin

Andrew F. Davis <afd@ti.com>
    ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin

Miquel Raynal <miquel.raynal@free-electrons.com>
    mtd: nand: fix interpretation of NAND_CMD_NONE in nand_command[_lp]()

Lorenzo Colitti <lorenzo@google.com>
    net: xfrm: allow clearing socket xfrm policies.

Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    sched: Stop resched_cpu() from sending IPIs to offline CPUs

Jiri Kosina <jkosina@suse.cz>
    HID: elo: clear BTN_LEFT mapping

Dedy Lansky <qca_dlansky@qca.qualcomm.com>
    wil6210: fix memory access violation in wil_memcpy_from/toio_32

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes/x86: Set kprobes pages read-only

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes/x86: Fix kprobe-booster not to boost far call instructions

Hannes Reinecke <hare@suse.de>
    scsi: sg: close race condition in sg_remove_sfp_usercontext()

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: sg: check for valid direction before starting the request

David Carrillo-Cisneros <davidcc@google.com>
    perf session: Don't rely on evlist in pipe mode

David Carrillo-Cisneros <davidcc@google.com>
    perf inject: Copy events when reordering events in pipe mode

Yuyang Du <yuyang.du@intel.com>
    usb: gadget: dummy_hcd: Fix wrong power status bit clear/reset in dummy_hub_control()

Vincent Stehlé <vincent.stehle@laposte.net>
    regulator: isl9305: fix array size

David Daney <david.daney@cavium.com>
    MIPS: BPF: Quit clobbering callee saved registers in JIT code.

Christopher James Halse Rogers <christopher.halse.rogers@canonical.com>
    drm/radeon: Fail fb creation from imported dma-bufs.

Liam Beguin <lbeguin@tycoint.com>
    video: ARM CLCD: fix dma allocation size

Nate Watterson <nwatters@codeaurora.org>
    iommu/iova: Fix underflow bug in __alloc_and_insert_iova_range

John Johansen <john.johansen@canonical.com>
    apparmor: Make path_max parameter readonly

Phil Turnbull <phil.turnbull@oracle.com>
    fm10k: correctly check if interface is removed

Jan Kara <jack@suse.cz>
    reiserfs: Make cancel_old_flush() reliable

Andrew Lunn <andrew@lunn.ch>
    net/faraday: Add missing include of of.h

Anton Blanchard <anton@samba.org>
    powerpc: Avoid taking a data miss on every userspace instruction miss

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: r8a7791: Correct parent of SSI[0-9] clocks

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: r8a7790: Correct parent of SSI[0-9] clocks

Samuel Thibault <samuel.thibault@ens-lyon.org>
    braille-console: Fix value returned by _braille_console_setup

Roger Quadros <rogerq@ti.com>
    ARM: DRA7: hwmod_data: Prevent wait_target_disable error for usb_otg_ss

Shaohua Li <shli@fb.com>
    blk-throttle: make sure expire time isn't too big

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    mm: Fix false-positive VM_BUG_ON() in page_cache_{get,add}_speculative()

Gao Feng <fgao@ikuai8.com>
    tcp: sysctl: Fix a race to avoid unexpected 0 window from space

Akinobu Mita <akinobu.mita@gmail.com>
    spi: omap2-mcspi: poll OMAP2_MCSPI_CHSTAT_RXS for PIO transfer

Davide Caratti <dcaratti@redhat.com>
    sched: act_csum: don't mangle TCP and UDP GSO packets

David Engraf <david.engraf@sysgo.com>
    timers, sched_clock: Update timeout for clock wrap

Janusz Krzysztofik <jmkrzyszt@gmail.com>
    media: i2c/soc_camera: fix ov6650 sensor getting wrong clock

Brian King <brking@linux.vnet.ibm.com>
    scsi: ipr: Fix missed EH wakeup

Rob Herring <robh@kernel.org>
    of: fix of_device_get_modalias returned length when truncating buffers

Andreas Pape <APape@phoenixcontact.com>
    batman-adv: handle race condition for claims between gateways

Linus Walleij <linus.walleij@linaro.org>
    ARM: dts: Adjust moxart IRQ controller and flags

Tomasz Kramkowski <tk@the-tk.com>
    HID: clamp input to logical range if no null state

Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
    ath10k: disallow DFS simulation if DFS channel is not enabled

Chris Wilson <chris@chris-wilson.co.uk>
    drm: Defer disabling the vblank IRQ until the next interrupt (for instant-off)

Quan Nguyen <qnguyen@apm.com>
    drivers: net: xgene: Fix hardware checksum setting

Stephane Eranian <eranian@google.com>
    perf tools: Make perf_event__synthesize_mmap_events() scale

Alexander Potapenko <glider@google.com>
    selinux: check for address length in selinux_socket_bind()

Prarit Bhargava <prarit@redhat.com>
    PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()

Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
    net: mvpp2: set dma mask and coherent dma mask on PPv2.2

Valtteri Heikkilä <rnd@nic.fi>
    HID: reject input outside logical range only if null state is set

H. Nikolaus Schaller <hns@goldelico.com>
    Input: tsc2007 - check for presence and power down tsc2007 during probe


-------------

Diffstat:

 Makefile                                           |  4 +--
 arch/arm/boot/dts/am335x-pepper.dts                |  2 +-
 arch/arm/boot/dts/moxart-uc7112lx.dts              |  2 +-
 arch/arm/boot/dts/moxart.dtsi                      | 17 ++++-----
 arch/arm/boot/dts/omap3-n900.dts                   |  4 +--
 arch/arm/boot/dts/r8a7790.dtsi                     |  7 ++--
 arch/arm/boot/dts/r8a7791.dtsi                     |  7 ++--
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  2 ++
 arch/mips/net/bpf_jit.c                            | 16 ++++++---
 arch/powerpc/mm/fault.c                            |  2 +-
 arch/x86/kernel/kprobes/core.c                     |  6 ++++
 arch/x86/kernel/kprobes/opt.c                      |  3 ++
 block/blk-throttle.c                               | 11 ++++++
 drivers/gpu/drm/drm_irq.c                          | 14 ++++++--
 drivers/gpu/drm/radeon/radeon_display.c            |  6 ++++
 drivers/hid/hid-elo.c                              |  6 ++++
 drivers/hid/hid-input.c                            | 20 +++++++----
 drivers/input/touchscreen/tsc2007.c                |  8 +++++
 drivers/iommu/iova.c                               |  2 +-
 drivers/media/i2c/soc_camera/ov6650.c              |  2 +-
 drivers/media/usb/cpia2/cpia2_v4l.c                |  4 +--
 drivers/mtd/nand/fsl_ifc_nand.c                    |  7 ++++
 drivers/mtd/nand/nand_base.c                       |  9 +++--
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c     |  1 +
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h     |  1 +
 drivers/net/ethernet/faraday/ftgmac100.c           |  1 +
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c   |  2 +-
 drivers/net/ethernet/marvell/mvpp2.c               | 14 ++++++++
 drivers/net/veth.c                                 |  3 ++
 drivers/net/wireless/ath/ath10k/debug.c            |  9 +++++
 drivers/net/wireless/ath/wil6210/main.c            | 20 +++++++++--
 drivers/of/device.c                                |  2 +-
 drivers/pci/pci-driver.c                           |  2 --
 drivers/scsi/ipr.c                                 | 16 ++++++---
 drivers/scsi/scsi_devinfo.c                        |  2 +-
 drivers/scsi/sg.c                                  | 36 +++++++++++--------
 drivers/spi/spi-omap2-mcspi.c                      |  9 ++---
 drivers/spi/spi-sun6i.c                            |  2 +-
 drivers/usb/gadget/udc/dummy_hcd.c                 | 20 +++++------
 drivers/video/fbdev/amba-clcd.c                    |  4 +--
 fs/aio.c                                           | 42 +++++++++++++++-------
 fs/dcache.c                                        | 11 ++++--
 fs/reiserfs/journal.c                              |  2 +-
 fs/reiserfs/reiserfs.h                             |  1 +
 fs/reiserfs/super.c                                | 21 +++++++----
 include/linux/pagemap.h                            |  4 +--
 include/linux/platform_data/isl9305.h              |  2 +-
 include/net/tcp.h                                  |  8 +++--
 kernel/printk/braille.c                            | 15 ++++----
 kernel/printk/braille.h                            | 13 +++++--
 kernel/sched/core.c                                |  3 +-
 kernel/time/sched_clock.c                          |  5 +++
 net/batman-adv/bridge_loop_avoidance.c             | 20 ++++++++---
 net/mac80211/iface.c                               |  2 +-
 net/sched/act_csum.c                               | 12 +++++++
 net/xfrm/xfrm_policy.c                             |  2 +-
 net/xfrm/xfrm_state.c                              |  7 ++++
 security/apparmor/lsm.c                            |  2 +-
 security/integrity/ima/ima_appraise.c              |  3 +-
 security/selinux/hooks.c                           |  8 +++++
 sound/core/oss/pcm_oss.c                           | 10 +++---
 sound/core/seq/seq_clientmgr.c                     |  4 +--
 sound/core/seq/seq_prioq.c                         | 28 +++++++--------
 sound/core/seq/seq_prioq.h                         |  6 ++--
 sound/core/seq/seq_queue.c                         | 28 +++++----------
 sound/soc/nuc900/nuc900-ac97.c                     |  4 +--
 tools/perf/util/event.c                            |  4 +--
 tools/perf/util/ordered-events.c                   |  3 +-
 tools/perf/util/session.c                          | 17 +++++++--
 .../testing/selftests/rcutorture/bin/configinit.sh |  2 +-
 tools/usb/usbip/src/usbipd.c                       |  2 +-
 71 files changed, 413 insertions(+), 183 deletions(-)
