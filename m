Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3685798-1521491223-2-7949658224222832140
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
    t=1521491221; b=fJyDihmP78mlq54EEsyxLOO780ZiKlHfqzqNI32XDazbzda
    H/EvboXEJ5ndiX91kv92ZviIcKiHNLXEoqSIot4YuM3ohmDz4kb62SRUWITpitdf
    UQntrELJIGtRvl4yC8sqPQ4+/7HrqWbKyJ4VhbELJLAlDNv84TIc7fMeALsyndgN
    qPFWMM9bW0alDAX1NK3gtjaIAmHtJ2e579/hJ5AqpPWl4Sf1TsbUamO1EjyU8GO3
    Ijk4qk0p+KKrgh1V3j4NHZzj4Ns0l+/bQX+v64quA4T0sklCaLKc64AmIkYUpIEW
    TK9RMkmL1y357UHvrom6pRLji2VVJaSh4Osk1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1521491221; bh=vVIE4Qc1vHLVLbwHdS2SquaeH0
    8MKmjEZevCMNxrqb4=; b=vZ7lbcoTa+WD5YHiB9EmlROUXdnJRWXQe30Ec5F1Z/
    n+ZWUp/uWX5SO1u9zuRYqp7BDBYSrdy1GPp8wxZ27YhWtwmpF9zEGhP3qWw4hNeP
    iRjzyTk7JpnxL63mY33I/XlHNwVkx80B6d2dzuqIArXZ20jKglYUuzeVv3z1k7cJ
    x0HtIpr8V0Wt9idlHI2+pr8CdCxcOsH7INn0+a9gD+ISVKDpOCBO0AkxSt+YwlFL
    HoUUGMyNGlbWxttuTjJlankAl+GyK1uf3QMlxVaBd8cxTToXEP0zv1s+XOHXWMWU
    ROKIMK5ONNh9rxBmNYXRJtsO8AZvAnTEYgR78z23y/Rw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddufeejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffogggftgfgshhpjeesthekfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepvdehtddtjeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddufeejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffogggftgfgshhpjeesthekfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepvdehtddtjeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965561AbeCSU1A (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 16:27:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43694 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030403AbeCSSNh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:13:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 000/134] 4.4.123-stable review
Date: Mon, 19 Mar 2018 19:04:43 +0100
Message-Id: <20180319171849.024066323@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.123-rc1
X-KernelTest-Deadline: 2018-03-21T17:19+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.123 release.
There are 134 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Mar 21 17:18:04 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.123-rc1

Jann Horn <jannh@google.com>
    bpf: fix incorrect sign extension in check_alu_op()

Srinath Mannam <srinath.mannam@broadcom.com>
    usb: gadget: bdc: 64-bit pointer capability check

Wei Yongjun <weiyongjun1@huawei.com>
    USB: gadget: udc: Add missing platform_device_put() on error in bdc_pci_probe()

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix use-after-free when cleaning up fs_devs with a single stale device

Hans van Kranenburg <hans.van.kranenburg@mendix.com>
    btrfs: alloc_chunk: fix DUP stripe size handling

Adam Ford <aford173@gmail.com>
    ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: sg: only check for dxfer_len greater than 256M

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: sg: fix static checker warning in sg_is_valid_dxfer

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: sg: fix SG_DXFER_FROM_DEV transfers

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    irqchip/gic-v3-its: Ensure nr_ites >= nr_lpis

Tejun Heo <tj@kernel.org>
    fs/aio: Use RCU accessors for kioctx_table->table[]

Tejun Heo <tj@kernel.org>
    fs/aio: Add explicit RCU grace period when freeing kioctx

Al Viro <viro@zeniv.linux.org.uk>
    lock_parent() needs to recheck if dentry got __dentry_kill'ed under it

Eric W. Biederman <ebiederm@xmission.com>
    fs: Teach path_connected to handle nfs filesystems with multiple roots.

Michel Dänzer <michel.daenzer@amd.com>
    drm/amdgpu/dce: Don't turn off DP sink when disconnected

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Clear client entry before deleting else at closing

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix possible UAF in snd_seq_check_queue()

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Revert power_save option default value

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix UAF in snd_pcm_oss_get_formats()

Toshi Kani <toshi.kani@hpe.com>
    x86/mm: Fix vmalloc_fault to use pXd_large

Andy Lutomirski <luto@kernel.org>
    x86/vm86/32: Fix POPF emulation

Andy Lutomirski <luto@kernel.org>
    selftests/x86/entry_from_vm86: Add test cases for POPF

Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
    selftests/x86: Add tests for the STR and SLDT instructions

Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
    selftests/x86: Add tests for User-Mode Instruction Prevention

Andy Lutomirski <luto@kernel.org>
    selftests/x86/entry_from_vm86: Exit with 1 if we fail

Mimi Zohar <zohar@linux.vnet.ibm.com>
    ima: relax requiring a file signature for new files with zero length

SeongJae Park <sj38.park@gmail.com>
    rcutorture/configinit: Fix build directory error message

Mahesh Bandewar <maheshb@google.com>
    ipvlan: add L2 check for packets arriving via virtual devices

Dan Carpenter <dan.carpenter@oracle.com>
    ASoC: nuc900: Fix a loop timeout test

Luca Coelho <luciano.coelho@intel.com>
    mac80211: remove BUG() when interface type is invalid

Adiel Aloni <adiel.aloni@intel.com>
    mac80211_hwsim: enforce PS_MANUAL_POLL to be set after PS_ENABLED

Chris Wilson <chris@chris-wilson.co.uk>
    agp/intel: Flush all chipset writes after updating the GGTT

Yong Zhao <yong.zhao@amd.com>
    drm/amdkfd: Fix memory leaks in kfd topology

Stephen Hemminger <stephen@networkplumber.org>
    veth: set peer GSO values

Dan Carpenter <dan.carpenter@oracle.com>
    media: cpia2: Fix a couple off by one bugs

Xose Vazquez Perez <xose.vazquez@gmail.com>
    scsi: dh: add new rdac devices

Xose Vazquez Perez <xose.vazquez@gmail.com>
    scsi: devinfo: apply to HP XP the same flags as Hitachi VSP

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: core: scsi_get_device_flags_keyed(): Always return device flags

Tobias Jordan <Tobias.Jordan@elektrobit.com>
    spi: sun6i: disable/unprepare clocks on remove

Julien BOIBESSOT <julien.boibessot@armadeus.com>
    tools/usbip: fixes build with musl libc toolchain

Ben Greear <greearb@candelatech.com>
    ath10k: fix invalid STS_CAP_OFFSET_MASK

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    clk: qcom: msm8916: fix mnd_width for codec_digcodec

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    cpufreq: Fix governor module removal race

Manikanta Pubbisetty <mpubbise@qti.qualcomm.com>
    ath10k: update tdls teardown state to target

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

Luis R. Rodriguez <mcgrof@kernel.org>
    test_firmware: fix setting old custom fw path back on exit

Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    sched: Stop resched_cpu() from sending IPIs to offline CPUs

Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    sched: Stop switched_to_rt() from sending IPIs to offline CPUs

Simon Shields <simon@lineageos.org>
    ARM: dts: exynos: Correct Trats2 panel reset line

Jiri Kosina <jkosina@suse.cz>
    HID: elo: clear BTN_LEFT mapping

Ville Syrjälä <ville.syrjala@linux.intel.com>
    video/hdmi: Allow "empty" HDMI infoframes

Jani Nikula <jani.nikula@intel.com>
    drm/edid: set ELD connector type in drm_edid_to_eld()

Dedy Lansky <qca_dlansky@qca.qualcomm.com>
    wil6210: fix memory access violation in wil_memcpy_from/toio_32

Laxman Dewangan <ldewangan@nvidia.com>
    pwm: tegra: Increase precision in PWM rate calculation

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

Mark Rutland <mark.rutland@arm.com>
    drivers/perf: arm_pmu: handle no platform_device

Yuyang Du <yuyang.du@intel.com>
    usb: gadget: dummy_hcd: Fix wrong power status bit clear/reset in dummy_hub_control()

John Stultz <john.stultz@linaro.org>
    usb: dwc2: Make sure we disconnect the gadget state

NeilBrown <neilb@suse.com>
    md/raid6: Fix anomily when recovering a single device in RAID6.

Vincent Stehlé <vincent.stehle@laposte.net>
    regulator: isl9305: fix array size

Aleksandar Markovic <aleksandar.markovic@imgtec.com>
    MIPS: r2-on-r6-emu: Clear BLTZALL and BGEZALL debugfs counters

Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
    MIPS: r2-on-r6-emu: Fix BLEZL and BGTZL identification

David Daney <david.daney@cavium.com>
    MIPS: BPF: Fix multiple problems in JIT skb access helpers.

David Daney <david.daney@cavium.com>
    MIPS: BPF: Quit clobbering callee saved registers in JIT code.

Mike Leach <mike.leach@linaro.org>
    coresight: Fixes coresight DT parse to get correct output port ID.

Christopher James Halse Rogers <christopher.halse.rogers@canonical.com>
    drm/amdgpu: Fail fb creation from imported dma-bufs. (v2)

Christopher James Halse Rogers <christopher.halse.rogers@canonical.com>
    drm/radeon: Fail fb creation from imported dma-bufs.

Liam Beguin <lbeguin@tycoint.com>
    video: ARM CLCD: fix dma allocation size

Nate Watterson <nwatters@codeaurora.org>
    iommu/iova: Fix underflow bug in __alloc_and_insert_iova_range

John Johansen <john.johansen@canonical.com>
    apparmor: Make path_max parameter readonly

Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
    scsi: ses: don't get power status of SES device slot on probe

Phil Turnbull <phil.turnbull@oracle.com>
    fm10k: correctly check if interface is removed

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-digi00x: handle all MIDI messages on streaming packets

Jan Kara <jack@suse.cz>
    reiserfs: Make cancel_old_flush() reliable

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: koelsch: Correct clock frequency of X2 DU clock input

Andrew Lunn <andrew@lunn.ch>
    net/faraday: Add missing include of of.h

Anton Blanchard <anton@samba.org>
    powerpc: Avoid taking a data miss on every userspace instruction miss

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: r8a7791: Correct parent of SSI[0-9] clocks

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: r8a7790: Correct parent of SSI[0-9] clocks

Dan Carpenter <dan.carpenter@oracle.com>
    NFC: nfcmrvl: double free on error path

Tobias Klauser <tklauser@distanz.ch>
    NFC: nfcmrvl: Include unaligned.h instead of access_ok.h

Felix Manlunas <felix.manlunas@cavium.com>
    vxlan: vxlan dev should inherit lowerdev's gso_max_size

Sinclair Yeh <syeh@vmware.com>
    drm/vmwgfx: Fixes to vmwgfx_fb

Samuel Thibault <samuel.thibault@ens-lyon.org>
    braille-console: Fix value returned by _braille_console_setup

Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
    powerpc/mm/hugetlb: Filter out hugepage size not supported by page table layout

Eric Dumazet <edumazet@google.com>
    bonding: refine bond_fold_stats() wrap detection

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: relax node version check for victim data in gc

Roger Quadros <rogerq@ti.com>
    ARM: DRA7: hwmod_data: Prevent wait_target_disable error for usb_otg_ss

Shaohua Li <shli@fb.com>
    blk-throttle: make sure expire time isn't too big

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    mm: Fix false-positive VM_BUG_ON() in page_cache_{get,add}_speculative()

Shikhar Dogra <shidogra@cisco.com>
    driver: (adm1275) set the m,b and R coefficients correctly for power

Jiada Wang <jiada_wang@mentor.com>
    dmaengine: imx-sdma: add 1ms delay to ensure SDMA channel is stopped

Gao Feng <fgao@ikuai8.com>
    tcp: sysctl: Fix a race to avoid unexpected 0 window from space

Akinobu Mita <akinobu.mita@gmail.com>
    spi: omap2-mcspi: poll OMAP2_MCSPI_CHSTAT_RXS for PIO transfer

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: rcar: ssi: don't set SSICR.CKDV = 000 with SSIWSR.CONT

Davide Caratti <dcaratti@redhat.com>
    sched: act_csum: don't mangle TCP and UDP GSO packets

Javier Martinez Canillas <javier@osg.samsung.com>
    Input: qt1070 - add OF device ID table

Tom Hromatka <tom.hromatka@oracle.com>
    sysrq: Reset the watchdog timers while displaying high-resolution timers

David Engraf <david.engraf@sysgo.com>
    timers, sched_clock: Update timeout for clock wrap

Janusz Krzysztofik <jmkrzyszt@gmail.com>
    media: i2c/soc_camera: fix ov6650 sensor getting wrong clock

Brian King <brking@linux.vnet.ibm.com>
    scsi: ipr: Fix missed EH wakeup

Anton Sviridenko <anton@corp.bluecherry.net>
    solo6x10: release vb2 buffers in solo_stop_streaming()

Rob Herring <robh@kernel.org>
    of: fix of_device_get_modalias returned length when truncating buffers

Andreas Pape <APape@phoenixcontact.com>
    batman-adv: handle race condition for claims between gateways

Linus Walleij <linus.walleij@linaro.org>
    ARM: dts: Adjust moxart IRQ controller and flags

Andrey Vagin <avagin@openvz.org>
    net/8021q: create device with all possible features in wanted_features

Tomasz Kramkowski <tk@the-tk.com>
    HID: clamp input to logical range if no null state

Kefeng Wang <wangkefeng.wang@huawei.com>
    perf probe: Return errno when not hitting any event

Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
    ath10k: disallow DFS simulation if DFS channel is not enabled

Chris Wilson <chris@chris-wilson.co.uk>
    drm: Defer disabling the vblank IRQ until the next interrupt (for instant-off)

Quan Nguyen <qnguyen@apm.com>
    drivers: net: xgene: Fix hardware checksum setting

Stephane Eranian <eranian@google.com>
    perf tools: Make perf_event__synthesize_mmap_events() scale

Lihong Yang <lihong.yang@intel.com>
    i40e: fix ethtool to get EEPROM data from X722 interface

Aaron Salter <aaron.k.salter@intel.com>
    i40e: Acquire NVM lock before reads on all devices

Changbin Du <changbin.du@intel.com>
    perf sort: Fix segfault with basic block 'cycles' sort dimension

Alexander Potapenko <glider@google.com>
    selinux: check for address length in selinux_socket_bind()

Prarit Bhargava <prarit@redhat.com>
    PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()

Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
    net: mvpp2: set dma mask and coherent dma mask on PPv2.2

Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
    ath10k: fix a warning during channel switch with multiple vaps

Gabriel Krisman Bertazi <krisman@collabora.co.uk>
    drm: qxl: Don't alloc fbdev if emulation is not supported

Valtteri Heikkilä <rnd@nic.fi>
    HID: reject input outside logical range only if null state is set

Colin Ian King <colin.king@canonical.com>
    staging: wilc1000: add check for kmalloc allocation failure.

Varsha Rao <rvarsha016@gmail.com>
    staging: speakup: Replace BUG_ON() with WARN_ON().

H. Nikolaus Schaller <hns@goldelico.com>
    Input: tsc2007 - check for presence and power down tsc2007 during probe

Hou Tao <houtao1@huawei.com>
    blkcg: fix double free of new_blkg in blkcg_init_queue


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/am335x-pepper.dts                |   2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |   2 +-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |   8 ++
 arch/arm/boot/dts/moxart-uc7112lx.dts              |   2 +-
 arch/arm/boot/dts/moxart.dtsi                      |  17 +--
 arch/arm/boot/dts/omap3-n900.dts                   |   4 +-
 arch/arm/boot/dts/r8a7790.dtsi                     |   7 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   2 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |   7 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |   2 +
 arch/mips/kernel/mips-r2-to-r6-emul.c              |  16 ++-
 arch/mips/net/bpf_jit.c                            |  16 ++-
 arch/mips/net/bpf_jit_asm.S                        |  23 ++--
 arch/powerpc/mm/fault.c                            |   2 +-
 arch/powerpc/mm/hugetlbpage.c                      |  18 ++++
 arch/x86/kernel/kprobes/core.c                     |   6 ++
 arch/x86/kernel/kprobes/opt.c                      |   3 +
 arch/x86/kernel/vm86_32.c                          |   3 +-
 arch/x86/mm/fault.c                                |   6 +-
 block/blk-cgroup.c                                 |   4 +-
 block/blk-throttle.c                               |  11 ++
 drivers/char/agp/intel-gtt.c                       |   2 +
 drivers/clk/qcom/gcc-msm8916.c                     |   1 +
 drivers/cpufreq/cpufreq.c                          |   6 ++
 drivers/dma/imx-sdma.c                             |  17 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |  31 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |   6 ++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  10 ++
 drivers/gpu/drm/drm_edid.c                         |   9 +-
 drivers/gpu/drm/drm_irq.c                          |  14 ++-
 drivers/gpu/drm/qxl/qxl_fb.c                       |   9 +-
 drivers/gpu/drm/radeon/radeon_display.c            |   6 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                 |   4 +-
 drivers/hid/hid-elo.c                              |   6 ++
 drivers/hid/hid-input.c                            |  20 ++--
 drivers/hwmon/pmbus/adm1275.c                      |   4 +-
 drivers/hwtracing/coresight/of_coresight.c         |   2 +-
 drivers/input/keyboard/qt1070.c                    |   9 ++
 drivers/input/touchscreen/tsc2007.c                |   8 ++
 drivers/iommu/iova.c                               |   2 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   9 +-
 drivers/md/raid5.c                                 |  13 ++-
 drivers/media/i2c/soc_camera/ov6650.c              |   2 +-
 drivers/media/pci/solo6x10/solo6x10-v4l2.c         |  11 ++
 drivers/media/usb/cpia2/cpia2_v4l.c                |   4 +-
 drivers/misc/enclosure.c                           |   7 +-
 drivers/mtd/nand/fsl_ifc_nand.c                    |   7 ++
 drivers/mtd/nand/nand_base.c                       |   9 +-
 drivers/net/bonding/bond_main.c                    |  11 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c     |   1 +
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h     |   1 +
 drivers/net/ethernet/faraday/ftgmac100.c           |   1 +
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c   |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   5 +
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |  12 +--
 drivers/net/ethernet/marvell/mvpp2.c               |  14 +++
 drivers/net/ipvlan/ipvlan_core.c                   |   4 +
 drivers/net/veth.c                                 |   3 +
 drivers/net/vxlan.c                                |   5 +
 drivers/net/wireless/ath/ath10k/debug.c            |   9 ++
 drivers/net/wireless/ath/ath10k/mac.c              |  12 ++-
 drivers/net/wireless/ath/ath10k/wmi.h              |   3 +-
 drivers/net/wireless/ath/wil6210/main.c            |  20 +++-
 drivers/net/wireless/mac80211_hwsim.c              |  17 +--
 drivers/nfc/nfcmrvl/fw_dnld.c                      |   2 +-
 drivers/nfc/nfcmrvl/spi.c                          |   5 +-
 drivers/of/device.c                                |   2 +-
 drivers/pci/pci-driver.c                           |   2 -
 drivers/perf/arm_pmu.c                             |  12 ++-
 drivers/pwm/pwm-tegra.c                            |   7 +-
 drivers/scsi/ipr.c                                 |  16 ++-
 drivers/scsi/scsi_devinfo.c                        |   9 +-
 drivers/scsi/scsi_dh.c                             |   5 +-
 drivers/scsi/ses.c                                 |   1 -
 drivers/scsi/sg.c                                  |  35 +++---
 drivers/spi/spi-omap2-mcspi.c                      |   9 +-
 drivers/spi/spi-sun6i.c                            |   2 +-
 drivers/staging/speakup/kobjects.c                 |   8 +-
 drivers/staging/wilc1000/host_interface.c          |   2 +
 drivers/usb/dwc2/hcd.c                             |   1 +
 drivers/usb/gadget/udc/bdc/bdc_core.c              |   2 +-
 drivers/usb/gadget/udc/bdc/bdc_pci.c               |   1 +
 drivers/usb/gadget/udc/dummy_hcd.c                 |  20 ++--
 drivers/video/fbdev/amba-clcd.c                    |   4 +-
 drivers/video/hdmi.c                               |  51 +++++----
 fs/aio.c                                           |  44 +++++---
 fs/btrfs/volumes.c                                 |  12 ++-
 fs/dcache.c                                        |  11 +-
 fs/f2fs/gc.c                                       |   6 +-
 fs/namei.c                                         |   5 +-
 fs/nfs/super.c                                     |   2 +
 fs/reiserfs/journal.c                              |   2 +-
 fs/reiserfs/reiserfs.h                             |   1 +
 fs/reiserfs/super.c                                |  21 ++--
 include/linux/fs.h                                 |   1 +
 include/linux/pagemap.h                            |   4 +-
 include/linux/platform_data/isl9305.h              |   2 +-
 include/net/tcp.h                                  |   8 +-
 kernel/bpf/verifier.c                              |   3 +-
 kernel/printk/braille.c                            |  15 +--
 kernel/printk/braille.h                            |  13 ++-
 kernel/sched/core.c                                |   3 +-
 kernel/sched/rt.c                                  |   2 +-
 kernel/time/sched_clock.c                          |   5 +
 kernel/time/timer_list.c                           |   6 ++
 net/8021q/vlan_dev.c                               |   3 +-
 net/batman-adv/bridge_loop_avoidance.c             |  20 +++-
 net/mac80211/iface.c                               |   2 +-
 net/sched/act_csum.c                               |  12 +++
 net/xfrm/xfrm_policy.c                             |   2 +-
 net/xfrm/xfrm_state.c                              |   7 ++
 security/apparmor/lsm.c                            |   2 +-
 security/integrity/ima/ima_appraise.c              |   3 +-
 security/selinux/hooks.c                           |   8 ++
 sound/core/oss/pcm_oss.c                           |  10 +-
 sound/core/seq/seq_clientmgr.c                     |   4 +-
 sound/core/seq/seq_prioq.c                         |  28 ++---
 sound/core/seq/seq_prioq.h                         |   6 +-
 sound/core/seq/seq_queue.c                         |  28 ++---
 sound/firewire/digi00x/amdtp-dot.c                 |  55 ++++++----
 sound/pci/hda/hda_intel.c                          |   9 +-
 sound/soc/nuc900/nuc900-ac97.c                     |   4 +-
 sound/soc/sh/rcar/ssi.c                            |   9 ++
 tools/perf/builtin-probe.c                         |   6 +-
 tools/perf/util/event.c                            |   4 +-
 tools/perf/util/ordered-events.c                   |   3 +-
 tools/perf/util/session.c                          |  17 ++-
 tools/perf/util/sort.c                             |   5 +
 tools/testing/selftests/firmware/fw_filesystem.sh  |   5 +-
 .../testing/selftests/rcutorture/bin/configinit.sh |   2 +-
 tools/testing/selftests/x86/entry_from_vm86.c      | 117 ++++++++++++++++++++-
 tools/usb/usbip/src/usbipd.c                       |   2 +-
 133 files changed, 910 insertions(+), 338 deletions(-)
