Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965923AbeE1KOs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936886AbeE1KOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:14:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 000/268] 4.4.134-stable review
Date: Mon, 28 May 2018 11:59:34 +0200
Message-Id: <20180528100202.045206534@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.134-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.134-rc1
X-KernelTest-Deadline: 2018-05-30T10:02+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.134 release.
There are 268 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed May 30 10:00:40 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.134-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.134-rc1

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/ftrace: use expoline for indirect branches

Randy Dunlap <rdunlap@infradead.org>
    kdb: make "mdr" command repeat

Larry Finger <Larry.Finger@lwfinger.net>
    Bluetooth: btusb: Add device ID for RTL8822BE

Sylwester Nawrocki <s.nawrocki@samsung.com>
    ASoC: samsung: i2s: Ensure the RCLK rate is properly determined

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    regulator: of: Add a missing 'of_node_put()' in an error handling path of 'of_regulator_match()'

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix frequency of Release WQE CQEs

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix soft lockup in lpfc worker thread during LIP testing

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix issue_lip if link is disabled

Richard Haines <richard_c_haines@btinternet.com>
    netlabel: If PF_INET6, check sk_buff ip header version

Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
    selftests/net: fixes psock_fanout eBPF test case

Jiri Olsa <jolsa@redhat.com>
    perf report: Fix memory corruption in --branch-history mode --branch-history

Jiri Olsa <jolsa@kernel.org>
    perf tests: Use arch__compare_symbol_names to compare symbols

Baoquan He <bhe@redhat.com>
    x86/apic: Set up through-local-APIC mode on the boot CPU if 'noapic' specified

Ørjan Eide <orjan.eide@arm.com>
    drm/rockchip: Respect page offset for PRIME mmap calls

Joe Perches <joe@perches.com>
    MIPS: Octeon: Fix logging messages with spurious periods after newlines

Richard Guy Briggs <rgb@redhat.com>
    audit: return on memory error to avoid null pointer dereference

Peter Robinson <pbrobinson@gmail.com>
    crypto: sunxi-ss - Add MODULE_ALIAS to sun4i-ss

Andrzej Hajda <a.hajda@samsung.com>
    clk: samsung: exynos3250: Fix PLL rates

Andrzej Hajda <a.hajda@samsung.com>
    clk: samsung: exynos5250: Fix PLL rates

Andrzej Hajda <a.hajda@samsung.com>
    clk: samsung: exynos5433: Fix PLL rates

Andrzej Hajda <a.hajda@samsung.com>
    clk: samsung: exynos5260: Fix PLL rates

Andrzej Hajda <a.hajda@samsung.com>
    clk: samsung: s3c2410: Fix PLL rates

Colin Ian King <colin.king@canonical.com>
    media: cx25821: prevent out-of-bounds read on array card

Jan Kara <jack@suse.cz>
    udf: Provide saner default for invalid uid / gid

Thomas Vincent-Cross <me@tvc.id.au>
    PCI: Add function 1 DMA alias quirk for Marvell 88SE9220

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: arc_uart: Fix out-of-bounds access through DT alias

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: fsl_lpuart: Fix out-of-bounds access through DT alias

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: imx: Fix out-of-bounds access through serial port index

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: mxs-auart: Fix out-of-bounds access through serial port index

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: samsung: Fix out-of-bounds access through serial port index

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: xuartps: Fix out-of-bounds access through DT alias

Colin Ian King <colin.king@canonical.com>
    rtc: tx4939: avoid unintended sign extension on a 24 bit shift

Colin Ian King <colin.king@canonical.com>
    staging: rtl8192u: return -ENOMEM on failed allocation of priv->oldaddr

lionel.debieve@st.com <lionel.debieve@st.com>
    hwrng: stm32 - add reset during probe

Govindarajulu Varadarajan <gvaradar@cisco.com>
    enic: enable rq before updating rq descriptors

Shawn Lin <shawn.lin@rock-chips.com>
    clk: rockchip: Prevent calculating mmc phase if clock rate is zero

Brad Love <brad@nextdimension.cc>
    media: em28xx: USB bulk packet size fix

Qi Hou <qi.hou@windriver.com>
    dmaengine: pl330: fix a race condition in case of threaded irqs

Arnd Bergmann <arnd@arndb.de>
    media: s3c-camif: fix out-of-bounds array access

Brad Love <brad@nextdimension.cc>
    media: cx23885: Set subdev host data to clk_freq pointer

Brad Love <brad@nextdimension.cc>
    media: cx23885: Override 888 ImpactVCBe crystal frequency

Takashi Iwai <tiwai@suse.de>
    ALSA: vmaster: Propagate slave error

Ivan Gorinov <ivan.gorinov@intel.com>
    x86/devicetree: Fix device IRQ settings in DT

Ivan Gorinov <ivan.gorinov@intel.com>
    x86/devicetree: Initialize device tree before using it

Chris Dickens <christopher.a.dickens@gmail.com>
    usb: gadget: composite: fix incorrect handling of OS desc requests

Wolfram Sang <wsa+renesas@sang-engineering.com>
    usb: gadget: udc: change comparison to bitshift when dealing with a mask

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Fix fallocate chunk size

Maurizio Lombardi <mlombard@redhat.com>
    cdrom: do not call check_disk_change() inside cdrom_open()

Guenter Roeck <linux@roeck-us.net>
    hwmon: (pmbus/adm1275) Accept negative page register values

Guenter Roeck <linux@roeck-us.net>
    hwmon: (pmbus/max8688) Accept negative page register values

Peter Zijlstra <peterz@infradead.org>
    perf/core: Fix perf_output_read_group()

Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    ASoC: topology: create TLV data for dapm widgets

Mathieu Malaterre <malat@debian.org>
    powerpc: Add missing prototype for arch_irq_work_raise()

Lars-Peter Clausen <lars@metafoo.de>
    usb: gadget: ffs: Execute copy_to_user() with USER_DS set

Lars-Peter Clausen <lars@metafoo.de>
    usb: gadget: ffs: Let setup() return USB_GADGET_DELAYED_STATUS

Grigor Tovmasyan <Grigor.Tovmasyan@synopsys.com>
    usb: dwc2: Fix interval type issue

Kamlakant Patel <kamlakant.patel@cavium.com>
    ipmi_ssif: Fix kernel panic at msg_done_handler

Rafael J. Wysocki <rjw@rjwysocki.net>
    PCI: Restore config space on runtime resume despite being unbound

Mathias Kresin <dev@kresin.me>
    MIPS: ath79: Fix AR724X_PLL_REG_PCIE_CONFIG offset

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: zero usb device slot_id member when disabling and freeing a xhci slot

Vitaly Kuznetsov <vkuznets@redhat.com>
    KVM: lapic: stop advertising DIRECTED_EOI when in-kernel IOAPIC is in use

Gregory CLEMENT <gregory.clement@bootlin.com>
    i2c: mv64xxx: Apply errata delay only in standard mode

Seunghun Han <kkamagui@gmail.com>
    ACPICA: acpi: acpica: fix acpi operand cache leak in nseval.c

Erik Schmauss <erik.schmauss@intel.com>
    ACPICA: Events: add a return on failure from acpi_hw_register_read

Coly Li <colyli@suse.de>
    bcache: quit dc->writeback_thread when BCACHE_DEV_DETACHING is set

Michael Schmitz <schmitzmic@gmail.com>
    zorro: Set up z->dev.dma_mask for the DMA API

Shawn Lin <shawn.lin@rock-chips.com>
    clk: Don't show the incorrect clock phase

Chunyu Hu <chuhu@redhat.com>
    cpufreq: cppc_cpufreq: Fix cppc_cpufreq_init() failure path

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: Update DWC_usb31 GTXFIFOSIZ reg fields

Philipp Puschmann <pp@emlix.com>
    arm: dts: socfpga: fix GIC PPI warning

Jay Vosburgh <jay.vosburgh@canonical.com>
    virtio-net: Fix operstate for virtio when no VIRTIO_NET_F_STATUS

Petr Vorel <pvorel@suse.cz>
    ima: Fallback to the builtin hash algorithm

Jiandi An <anjiandi@codeaurora.org>
    ima: Fix Kconfig to select TPM 2.0 CRB interface

Karthikeyan Periyasamy <periyasa@codeaurora.org>
    ath10k: Fix kernel panic while using worker (ath10k_sta_rc_update_wk)

Leon Romanovsky <leonro@mellanox.com>
    net/mlx5: Protect from command bit overflow

Michael Ellerman <mpe@ellerman.id.au>
    selftests: Print the test we're running to /dev/kmsg

Frank Asseg <frank.asseg@objecthunter.net>
    tools/thermal: tmon: fix for segfault

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/perf: Fix kernel address leak via sampling registers

Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
    powerpc/perf: Prevent kernel address leak to userspace via BHRB buffer

Alexandre Belloni <alexandre.belloni@bootlin.com>
    rtc: hctosys: Ensure system time doesn't overflow time_t

Guenter Roeck <linux@roeck-us.net>
    hwmon: (nct6775) Fix writing pwmX_mode

Helge Deller <deller@gmx.de>
    parisc/pci: Switch LBA PCI bus from Hard Fail to Soft Fail mode

Greg Ungerer <gerg@linux-m68k.org>
    m68k: set dma and coherent masks for platform FEC ethernets

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/mpic: Check if cpu_possible() in mpic_physmask()

Lenny Szubowicz <lszubowi@redhat.com>
    ACPI: acpi_pad: Fix memory leak in power saving threads

Dan Carpenter <dan.carpenter@oracle.com>
    xen/acpi: off by one in read_acpi_id()

Jeff Mahoney <jeffm@suse.com>
    btrfs: fix lockdep splat in btrfs_alloc_subvolume_writers

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix copy_items() return value when logging an inode

Qu Wenruo <wqu@suse.com>
    btrfs: tests/qgroup: Fix wrong tree backref level

Vicente Bergas <vicencb@gmail.com>
    Bluetooth: btusb: Add USB ID 7392:a611 for Edimax EW-7611ULB

Florian Fainelli <f.fainelli@gmail.com>
    net: bgmac: Fix endian access in bgmac_dma_tx_ring_free()

Bryan O'Donoghue <pure.logic@nexus-software.ie>
    rtc: snvs: Fix usage of snvs_rtc_enable

David S. Miller <davem@davemloft.net>
    sparc64: Make atomic_xchg() an inline function rather than a macro.

David Howells <dhowells@redhat.com>
    fscache: Fix hanging wait on page discarded by writeback

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: VMX: raise internal error for exception during invalid protected mode state

Davidlohr Bueso <dave@stgolabs.net>
    sched/rt: Fix rq->clock_update_flags < RQCF_ACT_SKIP warning

Jun Piao <piaojun@huawei.com>
    ocfs2/dlm: don't handle migrate lockres if already in shutdown

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix possible softlock on single core machines

Liu Bo <bo.liu@linux.alibaba.com>
    Btrfs: fix NULL pointer dereference in log_dir_items

Liu Bo <bo.liu@linux.alibaba.com>
    Btrfs: bail out on error during replay_dir_deletes

Huang Ying <ying.huang@intel.com>
    mm: fix races between address_space dereference and free in page_evicatable

Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
    mm/ksm: fix interaction with THP

Esben Haabendal <eha@deif.com>
    dp83640: Ensure against premature access to PHY registers after reset

Dave Carroll <david.carroll@microsemi.com>
    scsi: aacraid: Insure command thread is not recursively stopped

Shunyong Yang <shunyong.yang@hxt-semitech.com>
    cpufreq: CPPC: Initialize shared perf capabilities of CPUs

Carlos Maiolino <cmaiolino@redhat.com>
    Force log to disk before reading the AGF during a fstrim

Jens Axboe <axboe@kernel.dk>
    sr: get/drop reference to device in revalidate and check_events

Tom Abraham <tabraham@suse.com>
    swap: divide-by-zero when zero length swap file on ssd

Danilo Krummrich <danilokrummrich@dk-develop.de>
    fs/proc/proc_sysctl.c: fix potential page fault while unregistering sysctl table

Joerg Roedel <joro@8bytes.org>
    x86/pgtable: Don't set huge PUD/PMD on non-leaf entries

Rich Felker <dalias@libc.org>
    sh: fix debug trap failure to process signals before return to user

Yelena Krivosheev <yelena@marvell.com>
    net: mvneta: fix enable of all initialized RXQs

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    net: Fix untag for vlan packets without ethernet header

Vinayak Menon <vinmenon@codeaurora.org>
    mm/kmemleak.c: wait for scan completion before disabling free

Cong Wang <xiyou.wangcong@gmail.com>
    llc: properly handle dev_queue_xmit() return value

Giuseppe Lippolis <giu.lippolis@gmail.com>
    net-usb: add qmi_wwan if on lte modem wistron neweb d18q1

Torsten Hilbrich <torsten.hilbrich@secunet.com>
    net/usb/qmi_wwan.c: Add USB id for lt4120 modem

Pawel Dembicki <paweldembicki@gmail.com>
    net: qmi_wwan: add BroadMobi BM806U 2020:2033

Jinbum Park <jinb.park7@gmail.com>
    ARM: 8748/1: mm: Define vdso_start, vdso_end as array

Linus Lüssing <linus.luessing@c0d3.blue>
    batman-adv: fix packet loss for broadcasted DHCP packets to a server

Linus Lüssing <linus.luessing@c0d3.blue>
    batman-adv: fix multicast-via-unicast transmission with AP isolation

Masami Hiramatsu <mhiramat@kernel.org>
    selftests: ftrace: Add a testcase for probepoint

Masami Hiramatsu <mhiramat@kernel.org>
    selftests: ftrace: Add a testcase for string type with kprobe_event

Masami Hiramatsu <mhiramat@kernel.org>
    selftests: ftrace: Add probe event argument syntax testcase

Yisheng Xie <xieyisheng1@huawei.com>
    mm/mempolicy.c: avoid use uninitialized preferred_node

Chien Tin Tung <chien.tin.tung@intel.com>
    RDMA/ucma: Correct option size check using optlen

Song Liu <songliubraving@fb.com>
    perf/cgroup: Fix child event counting bug

Stefano Brivio <sbrivio@redhat.com>
    vti4: Don't override MTU passed on link creation via IFLA_MTU

Stefano Brivio <sbrivio@redhat.com>
    vti4: Don't count header length twice on tunnel setup

Matthias Schiffer <mschiffer@universe-factory.net>
    batman-adv: fix header size check in batadv_dbg_arp()

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    net: Fix vlan untag for bridge and vlan_dev with reorder_hdr off

Rob Herring <robh@kernel.org>
    microblaze: switch to NO_BOOTMEM

Cathy Zhou <Cathy.Zhou@Oracle.COM>
    sunvnet: does not support GSO for sctp

Sabrina Dubroca <sd@queasysnail.net>
    ipv4: lock mtu in fnhe when received PMTU < net.ipv4.route.min_pmtu

Arvind Yadav <arvind.yadav.cs@gmail.com>
    workqueue: use put_device() instead of kfree()

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Check valid VNIC ID in bnxt_hwrm_vnic_set_tpa().

Florian Westphal <fw@strlen.de>
    netfilter: ebtables: fix erroneous reject of last rule

Fredrik Noring <noring@nocrew.org>
    USB: OHCI: Fix NULL dereference in HCDs using HCD_LOCAL_MEM

Arvind Yadav <arvind.yadav.cs@gmail.com>
    xen: xenbus: use put_device() instead of kfree()

Peter Malone <peter.malone@gmail.com>
    fbdev: Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in sbusfb_ioctl_helper().

Jeremy Cline <jeremy@jcline.org>
    scsi: sd: Keep disk read-only when re-reading partition

Hannes Reinecke <hare@suse.de>
    scsi: mpt3sas: Do not mark fw_event workqueue as WQ_MEM_RECLAIM

Merlijn Wajer <merlijn@wizzup.org>
    usb: musb: call pm_runtime_{get,put}_sync before reading vbus registers

Pierre-Yves Kerbrat <pkerbrat@kalray.eu>
    e1000e: allocate ring descriptors with dma_zalloc_coherent

Benjamin Poirier <bpoirier@suse.com>
    e1000e: Fix check_for_link return value with autoneg off

Igor Pylypiv <igor.pylypiv@gmail.com>
    watchdog: f71808e_wdt: Fix magic close handling

Paul Mackerras <paulus@ozlabs.org>
    KVM: PPC: Book3S HV: Fix VRMA initialization with 2MB or 1GB memory backing

Michael Ellerman <mpe@ellerman.id.au>
    selftests/powerpc: Skip the subpage_prot tests if the syscall is unavailable

Filipe Manana <fdmanana@suse.com>
    Btrfs: send, fix issuing write op when processing hole in no data mode

Roger Pau Monne <roger.pau@citrix.com>
    xen/pirq: fix error path cleanup when binding MSIs

Joey Pabalinas <joeypabalinas@gmail.com>
    net/tcp/illinois: replace broken algorithm reference link

Claudiu Manoil <claudiu.manoil@nxp.com>
    gianfar: Fix Rx byte accounting for ndev stats

Xin Long <lucien.xin@gmail.com>
    sit: fix IFLA_MTU ignored on NEWLINK

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: fix kcrashes with fio in RAID5 backend dev

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    dmaengine: rcar-dmac: fix max_chunk_size for R-Car Gen3

Dave Airlie <airlied@redhat.com>
    virtio-gpu: fix ioctl and expose the fixed status to userspace.

Eric Dumazet <edumazet@google.com>
    r8152: fix tx packets accounting

Colin Ian King <colin.king@canonical.com>
    clocksource/drivers/fsl_ftm_timer: Fix error return checking

Jianchao Wang <jianchao.w.wang@oracle.com>
    nvme-pci: Fix nvme queue cleanup if IRQ setup fails

Florian Westphal <fw@strlen.de>
    netfilter: ebtables: convert BUG_ONs to WARN_ONs

Matthias Schiffer <mschiffer@universe-factory.net>
    batman-adv: invalidate checksum on fragment reassembly

Matthias Schiffer <mschiffer@universe-factory.net>
    batman-adv: fix packet checksum in receive path

Yufen Yu <yuyufen@huawei.com>
    md/raid1: fix NULL pointer dereference

Mauro Carvalho Chehab <mchehab@s-opensource.com>
    media: dmxdev: fix error code for invalid ioctls

Samuel Neves <sneves@dei.uc.pt>
    x86/topology: Update the 'cpu cores' field in /proc/cpuinfo correctly across CPU hotplug operations

Andrea Parri <parri.andrea@gmail.com>
    locking/xchg/alpha: Fix xchg() and cmpxchg() memory ordering bugs

Johannes Berg <johannes.berg@intel.com>
    regulatory: add NUL to request alpha2

Eric Dumazet <edumazet@google.com>
    smsc75xx: fix smsc75xx_set_features()

Tony Lindgren <tony@atomide.com>
    ARM: OMAP: Fix dmtimer init for omap1

Sebastian Ott <sebott@linux.vnet.ibm.com>
    s390/cio: clear timer when terminating driver I/O

Sebastian Ott <sebott@linux.vnet.ibm.com>
    s390/cio: fix return code after missing interrupt

Mark Lord <mlord@pobox.com>
    powerpc/bpf/jit: Fix 32-bit JIT for seccomp_data access

David Rientjes <rientjes@google.com>
    kernel/relay.c: limit kmalloc size to KMALLOC_MAX_SIZE

Arnd Bergmann <arnd@arndb.de>
    md: raid5: avoid string overflow warning

Andrea Parri <parri.andrea@gmail.com>
    locking/xchg/alpha: Add unconditional memory barrier to cmpxchg()

Andreas Kemnade <andreas@kemnade.info>
    usb: musb: fix enumeration after resume

Markus Elfring <elfring@users.sourceforge.net>
    drm/exynos: g2d: Delete an error message for a failed memory allocation in two functions

Wolfram Sang <wsa+renesas@sang-engineering.com>
    drm/exynos: fix comparison to bitshift when dealing with a mask

Yufen Yu <yuyufen@huawei.com>
    md raid10: fix NULL deference in handle_write_completed()

Felix Fietkau <nbd@nbd.name>
    mac80211: round IEEE80211_TX_STATUS_HEADROOM up to multiple of 4

Kees Cook <keescook@chromium.org>
    NFC: llcp: Limit size of SDP URI

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: OMAP1: clock: Fix debugfs_create_*() usage

Tony Lindgren <tony@atomide.com>
    ARM: OMAP3: Fix prm wake interrupt for resume

Qi Hou <qi.hou@windriver.com>
    ARM: OMAP2+: timer: fix a kmemleak caused in omap_get_timer_dt

Manish Rangankar <manish.rangankar@cavium.com>
    scsi: qla4xxx: skip error recovery in case of register disconnect.

Meelis Roos <mroos@linux.ee>
    scsi: aacraid: fix shutdown crash when init fails

Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
    scsi: storvsc: Increase cmd_per_lun for higher speed devices

Anders Roxell <anders.roxell@linaro.org>
    selftests: memfd: add config fragment for fuse

Vardan Mikayelyan <mvardan@synopsys.com>
    usb: dwc2: Fix dwc2_hsotg_core_init_disconnected()

Stefan Agner <stefan@agner.ch>
    usb: gadget: fsl_udc_core: fix ep valid checks

John Keeping <john@metanate.com>
    usb: gadget: f_uac2: fix bFirstInterface in composite gadget

Ulf Magnusson <ulfalizer@gmail.com>
    ARC: Fix malformed ARC_EMUL_UNALIGNED default

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: qla2xxx: Avoid triggering undefined behavior in qla2x00_mbx_completion()

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: mptfusion: Add bounds check in mptctl_hp_targetinfo()

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: sym53c8xx_2: iterator underflow in sym_getsync()

Chad Dupuis <chad.dupuis@cavium.com>
    scsi: bnx2fc: Fix check in SCSI completion handler for timed out request

Sujit Reddy Thumma <sthumma@codeaurora.org>
    scsi: ufs: Enable quirk to ignore sending WRITE_SAME command

Mark Salter <msalter@redhat.com>
    irqchip/gic-v3: Change pr_debug message to pr_devel

Will Deacon <will.deacon@arm.com>
    locking/qspinlock: Ensure node->count is updated before initialising node

Jesper Dangaard Brouer <brouer@redhat.com>
    tools/libbpf: handle issues with bpf ELF objects containing .eh_frames

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: return attach error when no cache set exist

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: fix for data collapse after re-attaching an attached device

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: fix for allocator and register thread race

Coly Li <colyli@suse.de>
    bcache: properly set task state in bch_writeback_thread()

Arnd Bergmann <arnd@arndb.de>
    cifs: silence compiler warnings showing up with gcc-8.0.0

Alexey Dobriyan <adobriyan@gmail.com>
    proc: fix /proc/*/map_files lookup

Will Deacon <will.deacon@arm.com>
    arm64: spinlock: Fix theoretical trylock() A-B-A with LSE atomics

Guanglei Li <guanglei.li@oracle.com>
    RDS: IB: Fix null pointer issue

Ross Lagerwall <ross.lagerwall@citrix.com>
    xen/grant-table: Use put_page instead of free_page

Ross Lagerwall <ross.lagerwall@citrix.com>
    xen-netfront: Fix race between device setup and open

Matt Redfearn <matt.redfearn@mips.com>
    MIPS: TXx9: use IS_BUILTIN() for CONFIG_LEDS_CLASS

Yonghong Song <yhs@fb.com>
    bpf: fix selftests/bpf test_kmod.sh failure when CONFIG_BPF_JIT_ALWAYS_ON=y

Chen Yu <yu.c.chen@intel.com>
    ACPI: processor_perflib: Do not send _PPC change notification if not ready

Jean Delvare <jdelvare@suse.de>
    firmware: dmi_scan: Fix handling of empty DMI strings

Arnd Bergmann <arnd@arndb.de>
    x86/power: Fix swsusp_arch_resume prototype

Alex Estrin <alex.estrin@intel.com>
    IB/ipoib: Fix for potential no-carrier state

Mel Gorman <mgorman@techsingularity.net>
    mm: pin address_space before dereferencing it while isolating an LRU page

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    asm-generic: provide generic_pmdp_establish()

Yisheng Xie <xieyisheng1@huawei.com>
    mm/mempolicy: add nodes_empty check in SYSC_migrate_pages

Yisheng Xie <xieyisheng1@huawei.com>
    mm/mempolicy: fix the check of nodemask from user

piaojun <piaojun@huawei.com>
    ocfs2: return error when we attempt to access a dirty bh in jbd2

piaojun <piaojun@huawei.com>
    ocfs2/acl: use 'ip_xattr_sem' to protect getting extended attribute

piaojun <piaojun@huawei.com>
    ocfs2: return -EROFS to mount.ocfs2 if inode block is invalid

Logan Gunthorpe <logang@deltatee.com>
    ntb_transport: Fix bug with max_mw_size parameter

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Avoid memory leak in case of XRCD dealloc failure

Michael Bringmann <mwb@linux.vnet.ibm.com>
    powerpc/numa: Ensure nodes initialized for hotplug

Michael Bringmann <mwb@linux.vnet.ibm.com>
    powerpc/numa: Use ibm,max-associativity-domains to discover possible nodes

Jake Daryll Obina <jake.obina@gmail.com>
    jffs2: Fix use-after-free bug in jffs2_iget()'s error handling path

Dan Carpenter <dan.carpenter@oracle.com>
    HID: roccat: prevent an out of bounds read in kovaplus_profile_activated()

Arnd Bergmann <arnd@arndb.de>
    scsi: fas216: fix sense buffer initialization

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix scrub to repair raid6 corruption

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix out of bounds access in btrfs_search_slot

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: set plug for fsync

Wei Yongjun <weiyongjun1@huawei.com>
    ipmi/powernv: Fix error return code in ipmi_powernv_probe()

weiyongjun (A) <weiyongjun1@huawei.com>
    mac80211_hwsim: fix possible memory leak in hwsim_new_radio_nl()

Ulf Magnusson <ulfalizer@gmail.com>
    kconfig: Fix expr_free() E_NOT leak

Ulf Magnusson <ulfalizer@gmail.com>
    kconfig: Fix automatic menu creation mem leak

Ulf Magnusson <ulfalizer@gmail.com>
    kconfig: Don't leak main menus during parsing

Guenter Roeck <linux@roeck-us.net>
    watchdog: sp5100_tco: Fix watchdog disable bit

Jan Chochol <jan@chochol.info>
    nfs: Do not convert nfs_idmap_cache_timeout to jiffies

mulhern <amulhern@redhat.com>
    dm thin: fix documentation relative to low water mark threshold

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tools lib traceevent: Fix get_field_str() for dynamic strings

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf callchain: Fix attr.sample_max_stack setting

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tools lib traceevent: Simplify pointer print logic and fix %pF

Alex Williamson <alex.williamson@redhat.com>
    PCI: Add function 1 DMA alias quirk for Marvell 9128

Anna-Maria Gleixner <anna-maria@linutronix.de>
    tracing/hrtimer: Fix tracing bugs by taking all clock bases and modes into account

Paolo Bonzini <pbonzini@redhat.com>
    kvm: x86: fix KVM_XEN_HVM_CONFIG ioctl

Dan Carpenter <dan.carpenter@oracle.com>
    ASoC: au1x: Fix timeout tests in au1xac97c_ac97_read()

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Use IS_REACHABLE() for dependency on input

NeilBrown <neilb@suse.com>
    NFSv4: always set NFS_LOCK_LOST when a lock is lost.

Hector Martin <marcan@marcan.st>
    firewire-ohci: work around oversized DMA reads on JMicron controllers

Al Viro <viro@zeniv.linux.org.uk>
    do d_instantiate/unlock_new_inode combinations safely

Brian Foster <bfoster@redhat.com>
    xfs: remove racy hasattr check from attr ops

zhongjiang <zhongjiang@huawei.com>
    kernel/signal.c: avoid undefined behaviour in kill_something_info

Gustavo A. R. Silva <gustavo@embeddedor.com>
    kernel/sys.c: fix potential Spectre v1 issue

David Hildenbrand <david@redhat.com>
    kasan: fix memory hotplug during boot

Davidlohr Bueso <dave@stgolabs.net>
    ipc/shm: fix shmat() nil address after round-down when remapping

Davidlohr Bueso <dave@stgolabs.net>
    Revert "ipc/shm: Fix shmat mmap nil-page protection"

Joe Jin <joe.jin@oracle.com>
    xen-swiotlb: fix the check condition for xen_swiotlb_free_coherent

Sudip Mukherjee <sudipm.mukherjee@gmail.com>
    libata: blacklist Micron 500IT SSD with MU01 firmware

Tejun Heo <tj@kernel.org>
    libata: Blacklist some Sandisk SSDs for NCQ

Corneliu Doban <corneliu.doban@broadcom.com>
    mmc: sdhci-iproc: fix 32bit writes for TRANSFER_MODE register

Ben Hutchings <ben.hutchings@codethink.co.uk>
    ALSA: timer: Fix pause event notification

Al Viro <viro@zeniv.linux.org.uk>
    aio: fix io_destroy(2) vs. lookup_ioctx() race

Al Viro <viro@zeniv.linux.org.uk>
    affs_lookup(): close a race with affs_remove_link()

Colin Ian King <colin.king@canonical.com>
    KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"

Maciej W. Rozycki <macro@mips.com>
    MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR accesses to o32 FGRs

Maciej W. Rozycki <macro@mips.com>
    MIPS: ptrace: Expose FIR register through FP regset


-------------

Diffstat:

 Documentation/device-mapper/thin-provisioning.txt  |  8 +-
 Makefile                                           |  4 +-
 arch/alpha/include/asm/xchg.h                      | 30 +++++--
 arch/arc/Kconfig                                   |  1 -
 arch/arm/boot/dts/socfpga.dtsi                     |  2 +-
 arch/arm/include/asm/vdso.h                        |  2 -
 arch/arm/kernel/vdso.c                             | 12 +--
 arch/arm/mach-omap1/clock.c                        |  6 +-
 arch/arm/mach-omap2/pm.c                           |  4 +-
 arch/arm/mach-omap2/timer.c                        | 19 +++--
 arch/arm/plat-omap/dmtimer.c                       |  7 +-
 arch/arm64/include/asm/spinlock.h                  |  4 +-
 arch/m68k/coldfire/device.c                        | 12 ++-
 arch/microblaze/Kconfig                            |  1 +
 arch/microblaze/mm/init.c                          | 56 ++-----------
 arch/mips/cavium-octeon/octeon-irq.c               | 10 +--
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h     |  2 +-
 arch/mips/kernel/ptrace.c                          | 22 ++++-
 arch/mips/kernel/ptrace32.c                        |  4 +-
 arch/mips/kvm/mips.c                               |  2 +-
 arch/mips/txx9/rbtx4939/setup.c                    |  4 +-
 arch/powerpc/include/asm/irq_work.h                |  1 +
 arch/powerpc/kvm/book3s_hv.c                       | 12 +--
 arch/powerpc/mm/numa.c                             | 78 ++++++++++++++---
 arch/powerpc/net/bpf_jit_comp.c                    |  3 +
 arch/powerpc/perf/core-book3s.c                    | 25 ++++++
 arch/powerpc/sysdev/mpic.c                         |  2 +-
 arch/s390/include/asm/nospec-insn.h                | 13 +++
 arch/s390/kernel/asm-offsets.c                     |  1 +
 arch/s390/kernel/mcount.S                          | 14 ++--
 arch/sh/kernel/entry-common.S                      |  2 +-
 arch/sparc/include/asm/atomic_64.h                 |  6 +-
 arch/x86/kernel/apic/apic.c                        |  2 +-
 arch/x86/kernel/devicetree.c                       | 21 +++--
 arch/x86/kernel/smpboot.c                          |  1 +
 arch/x86/kvm/lapic.c                               | 10 ++-
 arch/x86/kvm/vmx.c                                 | 20 +++--
 arch/x86/kvm/x86.c                                 |  7 +-
 arch/x86/mm/pgtable.c                              |  9 ++
 arch/x86/power/hibernate_32.c                      |  2 +-
 arch/x86/power/hibernate_64.c                      |  2 +-
 drivers/acpi/acpi_pad.c                            |  3 +
 drivers/acpi/acpica/evevent.c                      |  9 +-
 drivers/acpi/acpica/nseval.c                       |  8 ++
 drivers/acpi/processor_perflib.c                   |  2 +-
 drivers/ata/libata-core.c                          |  6 ++
 drivers/block/paride/pcd.c                         |  2 +
 drivers/bluetooth/btusb.c                          |  6 ++
 drivers/cdrom/cdrom.c                              |  3 -
 drivers/cdrom/gdrom.c                              |  3 +
 drivers/char/hw_random/stm32-rng.c                 |  9 ++
 drivers/char/ipmi/ipmi_powernv.c                   |  5 +-
 drivers/char/ipmi/ipmi_ssif.c                      |  4 +-
 drivers/clk/clk.c                                  |  3 +
 drivers/clk/rockchip/clk-mmc-phase.c               | 23 +++++
 drivers/clk/samsung/clk-exynos3250.c               |  4 +-
 drivers/clk/samsung/clk-exynos5250.c               |  8 +-
 drivers/clk/samsung/clk-exynos5260.c               |  2 +-
 drivers/clk/samsung/clk-exynos5433.c               | 12 +--
 drivers/clk/samsung/clk-s3c2410.c                  | 16 ++--
 drivers/clocksource/fsl_ftm_timer.c                |  2 +-
 drivers/cpufreq/cppc_cpufreq.c                     | 23 ++++-
 drivers/crypto/sunxi-ss/sun4i-ss-core.c            |  1 +
 drivers/dma/pl330.c                                |  6 +-
 drivers/dma/sh/rcar-dmac.c                         |  2 +-
 drivers/firewire/ohci.c                            |  8 +-
 drivers/firmware/dmi_scan.c                        | 22 ++---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |  6 +-
 drivers/gpu/drm/exynos/regs-fimc.h                 |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |  7 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             | 17 ++--
 drivers/hid/hid-roccat-kovaplus.c                  |  2 +
 drivers/hwmon/nct6775.c                            | 10 +--
 drivers/hwmon/pmbus/adm1275.c                      |  4 +-
 drivers/hwmon/pmbus/max8688.c                      |  2 +-
 drivers/i2c/busses/i2c-mv64xxx.c                   |  8 +-
 drivers/ide/ide-cd.c                               |  2 +
 drivers/infiniband/core/ucma.c                     |  2 +-
 drivers/infiniband/hw/mlx5/qp.c                    |  5 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |  3 +
 drivers/irqchip/irq-gic-v3.c                       |  2 +-
 drivers/md/bcache/alloc.c                          |  4 +-
 drivers/md/bcache/bcache.h                         |  2 +-
 drivers/md/bcache/btree.c                          |  9 +-
 drivers/md/bcache/request.c                        |  2 +-
 drivers/md/bcache/super.c                          | 23 +++--
 drivers/md/bcache/sysfs.c                          | 11 ++-
 drivers/md/bcache/writeback.c                      | 27 ++++--
 drivers/md/raid1.c                                 | 11 +++
 drivers/md/raid10.c                                |  6 +-
 drivers/md/raid5.c                                 |  7 +-
 drivers/media/dvb-core/dmxdev.c                    |  2 +-
 drivers/media/pci/cx23885/cx23885-cards.c          |  4 +
 drivers/media/pci/cx23885/cx23885-core.c           | 10 +++
 drivers/media/pci/cx25821/cx25821-core.c           |  7 +-
 drivers/media/platform/s3c-camif/camif-capture.c   |  7 +-
 drivers/media/usb/em28xx/em28xx.h                  |  2 +-
 drivers/message/fusion/mptctl.c                    |  2 +
 drivers/mmc/host/sdhci-iproc.c                     | 30 +++++--
 drivers/net/ethernet/broadcom/bgmac.c              |  3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  3 +
 drivers/net/ethernet/cisco/enic/enic_main.c        | 10 ++-
 drivers/net/ethernet/freescale/gianfar.c           |  7 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |  2 +-
 drivers/net/ethernet/intel/e1000e/mac.c            |  2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |  4 +-
 drivers/net/ethernet/marvell/mvneta.c              |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |  2 +-
 drivers/net/ethernet/sun/sunvnet.c                 |  2 +-
 drivers/net/phy/dp83640.c                          | 18 ++++
 drivers/net/usb/qmi_wwan.c                         |  5 ++
 drivers/net/usb/r8152.c                            |  2 +-
 drivers/net/usb/smsc75xx.c                         |  7 +-
 drivers/net/virtio_net.c                           |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c              | 10 +++
 drivers/net/wireless/mac80211_hwsim.c              |  4 +-
 drivers/net/xen-netfront.c                         | 46 +++++-----
 drivers/ntb/ntb_transport.c                        |  3 +
 drivers/nvme/host/pci.c                            |  5 +-
 drivers/parisc/lba_pci.c                           | 20 ++++-
 drivers/pci/pci-driver.c                           | 17 ++--
 drivers/pci/quirks.c                               |  5 ++
 drivers/regulator/of_regulator.c                   |  1 +
 drivers/rtc/hctosys.c                              |  5 ++
 drivers/rtc/rtc-snvs.c                             | 15 +++-
 drivers/rtc/rtc-tx4939.c                           |  6 +-
 drivers/s390/cio/device_fsm.c                      |  7 +-
 drivers/s390/cio/io_sch.h                          |  1 +
 drivers/scsi/aacraid/commsup.c                     |  4 +-
 drivers/scsi/aacraid/linit.c                       |  5 +-
 drivers/scsi/arm/fas216.c                          |  2 +-
 drivers/scsi/bnx2fc/bnx2fc_io.c                    |  1 +
 drivers/scsi/lpfc/lpfc_attr.c                      |  5 ++
 drivers/scsi/lpfc/lpfc_hbadisc.c                   |  5 +-
 drivers/scsi/lpfc/lpfc_sli.c                       |  2 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |  2 +-
 drivers/scsi/qla2xxx/qla_isr.c                     |  6 +-
 drivers/scsi/qla4xxx/ql4_def.h                     |  2 +
 drivers/scsi/qla4xxx/ql4_os.c                      | 46 ++++++++++
 drivers/scsi/sd.c                                  |  3 +-
 drivers/scsi/sr.c                                  | 21 ++++-
 drivers/scsi/storvsc_drv.c                         |  2 +-
 drivers/scsi/sym53c8xx_2/sym_hipd.c                |  2 +-
 drivers/scsi/ufs/ufshcd.c                          |  2 +
 drivers/staging/rtl8192u/r8192U_core.c             |  2 +
 drivers/tty/serial/arc_uart.c                      |  5 ++
 drivers/tty/serial/fsl_lpuart.c                    |  4 +
 drivers/tty/serial/imx.c                           |  6 ++
 drivers/tty/serial/mxs-auart.c                     |  4 +
 drivers/tty/serial/samsung.c                       |  4 +
 drivers/tty/serial/xilinx_uartps.c                 |  2 +-
 drivers/usb/dwc2/core.h                            |  2 +-
 drivers/usb/dwc2/gadget.c                          | 12 +--
 drivers/usb/dwc3/core.h                            |  2 +
 drivers/usb/gadget/composite.c                     | 40 +++++----
 drivers/usb/gadget/function/f_fs.c                 |  6 +-
 drivers/usb/gadget/function/f_uac2.c               |  2 +
 drivers/usb/gadget/udc/fsl_udc_core.c              |  4 +-
 drivers/usb/gadget/udc/goku_udc.h                  |  2 +-
 drivers/usb/host/ohci-hcd.c                        |  3 +-
 drivers/usb/host/xhci-mem.c                        |  2 +
 drivers/usb/musb/musb_core.c                       |  5 +-
 drivers/video/fbdev/sbuslib.c                      |  4 +-
 drivers/watchdog/f71808e_wdt.c                     |  3 +-
 drivers/watchdog/sp5100_tco.h                      |  2 +-
 drivers/xen/events/events_base.c                   |  4 +-
 drivers/xen/grant-table.c                          |  4 +-
 drivers/xen/swiotlb-xen.c                          |  2 +-
 drivers/xen/xen-acpi-processor.c                   |  6 +-
 drivers/xen/xenbus/xenbus_probe.c                  |  5 +-
 drivers/zorro/zorro.c                              | 12 +++
 fs/affs/namei.c                                    | 10 ++-
 fs/aio.c                                           |  4 +-
 fs/btrfs/ctree.c                                   | 12 ++-
 fs/btrfs/disk-io.c                                 |  2 +-
 fs/btrfs/extent-tree.c                             |  1 +
 fs/btrfs/file.c                                    |  9 ++
 fs/btrfs/inode.c                                   | 16 +---
 fs/btrfs/raid56.c                                  | 18 +++-
 fs/btrfs/send.c                                    |  3 +
 fs/btrfs/tests/qgroup-tests.c                      |  2 +-
 fs/btrfs/tree-log.c                                | 12 ++-
 fs/btrfs/volumes.c                                 |  9 +-
 fs/cifs/cifssmb.c                                  |  4 +-
 fs/dcache.c                                        | 22 +++++
 fs/ecryptfs/inode.c                                |  3 +-
 fs/ext2/namei.c                                    |  6 +-
 fs/ext4/namei.c                                    |  6 +-
 fs/f2fs/namei.c                                    | 12 +--
 fs/fscache/page.c                                  | 13 ++-
 fs/gfs2/file.c                                     |  5 +-
 fs/gfs2/quota.h                                    |  2 +
 fs/jffs2/dir.c                                     | 12 +--
 fs/jffs2/fs.c                                      |  1 -
 fs/jfs/namei.c                                     | 12 +--
 fs/nfs/nfs4proc.c                                  | 12 ++-
 fs/nfs/nfs4state.c                                 |  5 +-
 fs/nfs/nfs4sysctl.c                                |  2 +-
 fs/nilfs2/namei.c                                  |  6 +-
 fs/ocfs2/acl.c                                     |  6 ++
 fs/ocfs2/dlm/dlmdomain.c                           | 14 ----
 fs/ocfs2/dlm/dlmdomain.h                           | 25 +++++-
 fs/ocfs2/dlm/dlmrecovery.c                         |  9 ++
 fs/ocfs2/journal.c                                 | 23 ++---
 fs/ocfs2/super.c                                   |  5 +-
 fs/ocfs2/xattr.c                                   |  2 +
 fs/proc/base.c                                     | 29 ++++++-
 fs/proc/proc_sysctl.c                              |  3 +
 fs/reiserfs/namei.c                                | 12 +--
 fs/udf/namei.c                                     |  6 +-
 fs/udf/super.c                                     |  5 +-
 fs/ufs/namei.c                                     |  6 +-
 fs/xfs/libxfs/xfs_attr.c                           |  6 --
 fs/xfs/xfs_discard.c                               | 14 ++--
 include/asm-generic/pgtable.h                      | 15 ++++
 include/linux/dcache.h                             |  1 +
 include/linux/suspend.h                            |  2 +
 include/linux/usb/composite.h                      |  3 +
 include/net/ip.h                                   | 11 ++-
 include/net/ip_fib.h                               |  1 +
 include/net/llc_conn.h                             |  2 +-
 include/net/mac80211.h                             |  2 +-
 include/net/regulatory.h                           |  2 +-
 include/net/route.h                                |  3 +-
 include/trace/events/timer.h                       | 20 ++++-
 include/uapi/drm/virtgpu_drm.h                     |  1 +
 include/uapi/linux/if_ether.h                      |  1 +
 ipc/shm.c                                          | 19 +++--
 kernel/audit.c                                     |  2 +
 kernel/debug/kdb/kdb_main.c                        | 27 ++++--
 kernel/events/core.c                               | 24 ++++--
 kernel/locking/qspinlock.c                         |  8 ++
 kernel/power/power.h                               |  3 -
 kernel/relay.c                                     |  2 +-
 kernel/sched/rt.c                                  |  2 +
 kernel/signal.c                                    |  4 +
 kernel/sys.c                                       |  3 +
 kernel/workqueue.c                                 |  2 +-
 lib/test_bpf.c                                     | 31 +++++--
 mm/kasan/kasan.c                                   |  2 +-
 mm/kmemleak.c                                      | 12 +--
 mm/ksm.c                                           | 28 +++++++
 mm/mempolicy.c                                     | 36 ++++++--
 mm/swapfile.c                                      |  4 +
 mm/vmscan.c                                        | 22 ++++-
 net/batman-adv/distributed-arp-table.c             |  2 +-
 net/batman-adv/fragmentation.c                     |  3 +-
 net/batman-adv/gateway_client.c                    |  3 +
 net/batman-adv/multicast.c                         |  4 +-
 net/batman-adv/soft-interface.c                    |  8 +-
 net/bridge/netfilter/ebtables.c                    | 33 +++++---
 net/core/skbuff.c                                  |  9 +-
 net/ipv4/ip_vti.c                                  |  2 -
 net/ipv4/route.c                                   | 26 ++++--
 net/ipv4/tcp_illinois.c                            |  2 +-
 net/ipv4/xfrm4_policy.c                            |  1 +
 net/ipv6/sit.c                                     |  7 ++
 net/llc/llc_c_ac.c                                 | 15 ++--
 net/llc/llc_conn.c                                 | 32 +++++--
 net/netlabel/netlabel_unlabeled.c                  | 10 +++
 net/nfc/llcp_commands.c                            |  4 +
 net/nfc/netlink.c                                  |  3 +-
 net/rds/ib.c                                       |  3 +-
 scripts/kconfig/expr.c                             |  2 +-
 scripts/kconfig/menu.c                             |  1 +
 scripts/kconfig/zconf.y                            | 33 ++++++--
 security/integrity/ima/Kconfig                     |  1 +
 security/integrity/ima/ima_crypto.c                |  2 +
 security/integrity/ima/ima_main.c                  | 13 +++
 sound/core/timer.c                                 |  4 +-
 sound/core/vmaster.c                               |  5 +-
 sound/pci/hda/Kconfig                              |  1 -
 sound/pci/hda/patch_realtek.c                      |  5 ++
 sound/soc/au1x/ac97c.c                             |  6 +-
 sound/soc/samsung/i2s.c                            | 13 ++-
 sound/soc/soc-topology.c                           |  3 +
 tools/lib/bpf/libbpf.c                             | 26 ++++++
 tools/lib/traceevent/event-parse.c                 | 17 ++--
 tools/lib/traceevent/parse-filter.c                | 10 ++-
 tools/perf/tests/vmlinux-kallsyms.c                |  2 +-
 tools/perf/util/evsel.c                            |  8 +-
 tools/perf/util/hist.c                             |  4 +-
 tools/perf/util/hist.h                             |  1 -
 tools/testing/selftests/Makefile                   |  1 +
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     | 46 ++++++++++
 .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     | 97 ++++++++++++++++++++++
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   | 43 ++++++++++
 tools/testing/selftests/memfd/config               |  1 +
 tools/testing/selftests/net/psock_fanout.c         |  3 +-
 tools/testing/selftests/powerpc/mm/subpage_prot.c  | 14 ++++
 tools/thermal/tmon/sysfs.c                         | 12 +--
 tools/thermal/tmon/tmon.c                          |  1 -
 292 files changed, 1883 insertions(+), 687 deletions(-)
