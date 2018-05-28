Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937563AbeE1KnA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:43:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937533AbeE1Kmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:42:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/496] 4.14.45-stable review
Date: Mon, 28 May 2018 11:56:25 +0200
Message-Id: <20180528100319.498712256@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.45-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.45-rc1
X-KernelTest-Deadline: 2018-05-30T10:03+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.45 release.
There are 496 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed May 30 10:00:57 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.45-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.45-rc1

Deepak Rawat <drawat@vmware.com>
    drm/vmwgfx: Set dmabuf_size when vmw_dmabuf_init is successful

Randy Dunlap <rdunlap@infradead.org>
    kdb: make "mdr" command repeat

Jan Kundrát <jan.kundrat@cesnet.cz>
    pinctrl: mcp23s08: spi: Fix regmap debugfs entries

Bjorn Andersson <bjorn.andersson@linaro.org>
    pinctrl: msm: Use dynamic GPIO numbering

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    regulator: of: Add a missing 'of_node_put()' in an error handling path of 'of_regulator_match()'

Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
    ARM: dts: porter: Fix HDMI output routing

Aapo Vienamo <aapo@tuxera.com>
    ARM: dts: imx7d: cl-som-imx7: fix pinctrl_enet

Filip Sadowski <filip.sadowski@intel.com>
    i40e: Add delay after EMP reset for firmware to recover

Charles Keepax <ckeepax@opensource.cirrus.com>
    regmap: Correct comparison in regmap_cached

Peter Rosin <peda@axentia.se>
    ARM: dts: at91: tse850: use the correct compatible for the eeprom

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    drm: rcar-du: lvds: Fix LVDS startup on R-Car Gen2

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    drm: rcar-du: lvds: Fix LVDS startup on R-Car Gen3

Richard Haines <richard_c_haines@btinternet.com>
    netlabel: If PF_INET6, check sk_buff ip header version

Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
    selftests/net: fixes psock_fanout eBPF test case

Jiri Olsa <jolsa@kernel.org>
    perf tests: Fix dwarf unwind for stripped binaries

Jiri Olsa <jolsa@redhat.com>
    perf report: Fix memory corruption in --branch-history mode --branch-history

Jiri Olsa <jolsa@kernel.org>
    perf tests: Use arch__compare_symbol_names to compare symbols

Jin Yao <yao.jin@linux.intel.com>
    perf report: Fix wrong jump arrow

Thomas Richter <tmricht@linux.vnet.ibm.com>
    perf test: Fix test case inet_pton to accept inlines.

Baoquan He <bhe@redhat.com>
    x86/apic: Set up through-local-APIC mode on the boot CPU if 'noapic' specified

Ørjan Eide <orjan.eide@arm.com>
    drm/rockchip: Respect page offset for PRIME mmap calls

Joe Perches <joe@perches.com>
    MIPS: Octeon: Fix logging messages with spurious periods after newlines

Jake Moroni <mail@jakemoroni.com>
    dpaa_eth: fix pause capability advertisement logic

Takeshi Kihara <takeshi.kihara.df@renesas.com>
    pinctrl: sh-pfc: r8a7796: Fix MOD_SEL register pin assignment for SSI pins group

Tejun Heo <tj@kernel.org>
    rcu: Call touch_nmi_watchdog() while printing stall warnings

Niklas Cassel <niklas.cassel@axis.com>
    net: stmmac: call correct function in stmmac_mac_config_rx_queues_routing()

Richard Guy Briggs <rgb@redhat.com>
    audit: return on memory error to avoid null pointer dereference

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PCMCIA / PM: Avoid noirq suspend aborts during suspend-to-idle

Henry Zhang <henryzhang62@gmail.com>
    ARM: dts: bcm283x: Fix pin function of JTAG pins

Stefan Wahren <stefan.wahren@i2se.com>
    ARM: dts: bcm283x: Fix probing of bcm2835-i2s

Ladislav Michl <ladis@linux-mips.org>
    power: supply: ltc2941-battery-gauge: Fix temperature units

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    sh_eth: fix TSU init on SH7734/R8A7740

Jacob Keller <jacob.e.keller@intel.com>
    ixgbe: prevent ptp_rx_hang from running when in FILTER_ALL mode

Jan Kara <jack@suse.cz>
    udf: Provide saner default for invalid uid / gid

Thomas Vincent-Cross <me@tvc.id.au>
    PCI: Add function 1 DMA alias quirk for Marvell 88SE9220

Madalin Bucur <madalin.bucur@nxp.com>
    dpaa_eth: fix SG mapping

Viresh Kumar <viresh.kumar@linaro.org>
    cpufreq: Reorder cpufreq_online() error code path

Niklas Cassel <niklas.cassel@axis.com>
    net: stmmac: ensure that the MSS desc is the last desc to set the own bit

Niklas Cassel <niklas.cassel@axis.com>
    net: stmmac: ensure that the device has released ownership before reading data

Monk Liu <Monk.Liu@amd.com>
    drm/amdgpu: adjust timeout for ib_ring_tests(v2)

Monk Liu <Monk.Liu@amd.com>
    drm/amdgpu: disable GFX ring and disable PQ wptr in hw_fini

Ravikumar Kattekola <rk@ti.com>
    ARM: dts: dra71-evm: Correct evm_sd regulator max voltage

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    drm: omapdrm: dss: Move initialization code from component bind to probe

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    dmaengine: qcom: bam_dma: get num-channels and num-ees from dt

Cornelia Huck <cohuck@redhat.com>
    vfio-ccw: fence off transport mode

Niklas Cassel <niklas.cassel@axis.com>
    pinctrl: artpec6: dt: add missing pin group uart5nocts

Richard Fitzgerald <rf@opensource.cirrus.com>
    pinctrl: devicetree: Fix dt_to_map_one_config handling of hogs

lionel.debieve@st.com <lionel.debieve@st.com>
    hwrng: stm32 - add reset during probe

Alexey Khoroshilov <khoroshilov@ispras.ru>
    watchdog: asm9260_wdt: fix error handling in asm9260_wdt_probe()

Govindarajulu Varadarajan <gvaradar@cisco.com>
    enic: enable rq before updating rq descriptors

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    dmaengine: rcar-dmac: Check the done lists in rcar_dmac_chan_get_residue()

Qi Hou <qi.hou@windriver.com>
    dmaengine: pl330: fix a race condition in case of threaded irqs

Ming Lei <ming.lei@redhat.com>
    block: null_blk: fix 'Invalid parameters' when loading module

Dexuan Cui <decui@microsoft.com>
    tools: hv: fix compiler warnings about major/target_fname

Linus Walleij <linus.walleij@linaro.org>
    drm/bridge: sii902x: Retry status read after DDI I2C

Vivek Gautam <vivek.gautam@codeaurora.org>
    phy: qcom-qmp: Fix phy pipe clock gating

Takashi Iwai <tiwai@suse.de>
    ALSA: vmaster: Propagate slave error

Shawn Lin <shawn.lin@rock-chips.com>
    phy: rockchip-emmc: retry calpad busy trimming

Ivan Gorinov <ivan.gorinov@intel.com>
    x86/devicetree: Fix device IRQ settings in DT

Ivan Gorinov <ivan.gorinov@intel.com>
    x86/devicetree: Initialize device tree before using it

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Fix fallocate chunk size

Bjorn Andersson <bjorn.andersson@linaro.org>
    soc: qcom: wcnss_ctrl: Fix increment in NV upload

Ilia Lin <ilialin@codeaurora.org>
    arm64: dts: qcom: Fix SPI5 config on MSM8996

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel: Fix event update for auto-reload

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel: Fix large period handling on Broadwell CPUs

Mark Rutland <mark.rutland@arm.com>
    efi/arm*: Only register page tables when they exist

Maurizio Lombardi <mlombard@redhat.com>
    cdrom: do not call check_disk_change() inside cdrom_open()

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel: Properly save/restore the PMU state in the NMI handler

Guenter Roeck <linux@roeck-us.net>
    hwmon: (pmbus/adm1275) Accept negative page register values

Guenter Roeck <linux@roeck-us.net>
    hwmon: (pmbus/max8688) Accept negative page register values

Eric Anholt <eric@anholt.net>
    drm/panel: simple: Fix the bus format for the Ontat panel

Peter Zijlstra <peterz@infradead.org>
    perf/core: Fix perf_output_read_group()

Pierre Bourdon <delroth@google.com>
    max17042: propagate of_node to power supply device

leilei.lin <leilei.lin@alibaba-inc.com>
    perf/core: Fix installing cgroup events on CPU

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to check extent cache in f2fs_drop_extent_tree

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to clear CP_TRIMMED_FLAG

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to set KEEP_SIZE bit in f2fs_zero_range

Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
    cxl: Check if PSL data-cache is available before issue flush request

Alistair Popple <alistair@popple.id.au>
    powerpc/powernv/npu: Fix deadlock in mmio_invalidate()

Mathieu Malaterre <malat@debian.org>
    powerpc: Add missing prototype for arch_irq_work_raise()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    drm/meson: Fix an un-handled error path in 'meson_drv_bind_master()'

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    drm/meson: Fix some error handling paths in 'meson_drv_bind_master()'

Kamlakant Patel <kamlakant.patel@cavium.com>
    ipmi_ssif: Fix kernel panic at msg_done_handler

Milton Miller <miltonm@us.ibm.com>
    watchdog: aspeed: Fix translation of reset mode to ctrl register

Brian Norris <briannorris@chromium.org>
    watchdog: dw: RMW the control register

Rafael J. Wysocki <rjw@rjwysocki.net>
    PCI: Restore config space on runtime resume despite being unbound

Mathias Kresin <dev@kresin.me>
    MIPS: ath79: Fix AR724X_PLL_REG_PCIE_CONFIG offset

Ursula Braun <ubraun@linux.vnet.ibm.com>
    net/smc: pay attention to MAX_ORDER for CQ entries

Christophe Jaillet <christophe.jaillet@wanadoo.fr>
    spi: bcm-qspi: fIX some error handling paths

Christophe Jaillet <christophe.jaillet@wanadoo.fr>
    regulator: gpio: Fix some error handling paths in 'gpio_regulator_probe()'

Leo Yan <leo.yan@linaro.org>
    coresight: Use %px to print pcsr instead of %p

Oded Gabbay <oded.gabbay@gmail.com>
    drm/amdkfd: add missing include of mm.h

Parav Pandit <parav@mellanox.com>
    IB/core: Honor port_num while resolving GID for IB link layer

Thomas Richter <tmricht@linux.vnet.ibm.com>
    perf stat: Fix core dump when flag T is used

Yisheng Xie <xieyisheng1@huawei.com>
    perf top: Fix top.call-graph config option reading

Vitaly Kuznetsov <vkuznets@redhat.com>
    KVM: lapic: stop advertising DIRECTED_EOI when in-kernel IOAPIC is in use

Gregory CLEMENT <gregory.clement@bootlin.com>
    i2c: mv64xxx: Apply errata delay only in standard mode

Arjun Vynipadath <arjun@chelsio.com>
    cxgb4: Fix queue free path of ULD drivers

Seunghun Han <kkamagui@gmail.com>
    ACPICA: acpi: acpica: fix acpi operand cache leak in nseval.c

Bob Moore <robert.moore@intel.com>
    ACPICA: Fix memory leak on unusual memory leak

Erik Schmauss <erik.schmauss@intel.com>
    ACPICA: Events: add a return on failure from acpi_hw_register_read

Icenowy Zheng <icenowy@aosc.io>
    dt-bindings: add device tree binding for Allwinner H6 main CCU

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    remoteproc: imx_rproc: Fix an error handling path in 'imx_rproc_probe()'

Coly Li <colyli@suse.de>
    bcache: quit dc->writeback_thread when BCACHE_DEV_DETACHING is set

Michael Schmitz <schmitzmic@gmail.com>
    zorro: Set up z->dev.dma_mask for the DMA API

Honggang Li <honli@redhat.com>
    IB/mlx5: Set the default active rate and width to QDR and 4X

Chunyu Hu <chuhu@redhat.com>
    cpufreq: cppc_cpufreq: Fix cppc_cpufreq_init() failure path

Yong Wu <yong.wu@mediatek.com>
    iommu/mediatek: Fix protect memory setting

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Unpin the screen object backup buffer when not used

Eric Sandeen <sandeen@redhat.com>
    ext4: don't complain about incorrect features when probing

Philipp Puschmann <pp@emlix.com>
    arm: dts: socfpga: fix GIC PPI warning

Jay Vosburgh <jay.vosburgh@canonical.com>
    virtio-net: Fix operstate for virtio when no VIRTIO_NET_F_STATUS

Milton Miller <miltonm@us.ibm.com>
    watchdog: aspeed: Allow configuring for alternate boot

Petr Vorel <pvorel@suse.cz>
    ima: Fallback to the builtin hash algorithm

Jiandi An <anjiandi@codeaurora.org>
    ima: Fix Kconfig to select TPM 2.0 CRB interface

Arjun Vynipadath <arjun@chelsio.com>
    cxgb4: Setup FW queues before registering netdev

Sebastian Gottschall <s.gottschall@dd-wrt.com>
    ath9k: fix crash in spectral scan

Jarosław Janik <jaroslaw.janik@gmail.com>
    nvme-pci: disable APST for Samsung NVMe SSD 960 EVO + ASUS PRIME Z370-A

Karthikeyan Periyasamy <periyasa@codeaurora.org>
    ath10k: Fix kernel panic while using worker (ath10k_sta_rc_update_wk)

Alexey Khoroshilov <khoroshilov@ispras.ru>
    watchdog: davinci_wdt: fix error handling in davinci_wdt_probe()

Leon Romanovsky <leonro@mellanox.com>
    net/mlx5: Protect from command bit overflow

Michael Ellerman <mpe@ellerman.id.au>
    selftests: Print the test we're running to /dev/kmsg

Frank Asseg <frank.asseg@objecthunter.net>
    tools/thermal: tmon: fix for segfault

Amitkumar Karwar <amit.karwar@redpinesignals.com>
    rsi: fix kernel panic observed on 64bit machine

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/perf: Fix kernel address leak via sampling registers

Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
    powerpc/perf: Prevent kernel address leak to userspace via BHRB buffer

Guenter Roeck <linux@roeck-us.net>
    hwmon: (nct6775) Fix writing pwmX_mode

Helge Deller <deller@gmx.de>
    parisc/pci: Switch LBA PCI bus from Hard Fail to Soft Fail mode

Luca Coelho <luciano.coelho@intel.com>
    iwlwifi: mvm: check if mac80211_queue is valid in iwl_mvm_disable_txq

Greg Ungerer <gerg@linux-m68k.org>
    m68k: set dma and coherent masks for platform FEC ethernets

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    intel_th: Use correct method of finding hub

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    iommu/amd: Take into account that alloc_dev_data() may return NULL

Anilkumar Kolli <akolli@codeaurora.org>
    ath10k: advertize beacon_int_min_gcd

Harry Morris <h.morris@cascoda.com>
    ieee802154: ca8210: fix uninitialised data read

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/mpic: Check if cpu_possible() in mpic_physmask()

Lenny Szubowicz <lszubowi@redhat.com>
    ACPI: acpi_pad: Fix memory leak in power saving threads

Aaro Koskinen <aaro.koskinen@iki.fi>
    drivers: macintosh: rack-meter: really fix bogus memsets

Dan Carpenter <dan.carpenter@oracle.com>
    xen/acpi: off by one in read_acpi_id()

David Howells <dhowells@redhat.com>
    rxrpc: Don't treat call aborts as conn aborts

David Howells <dhowells@redhat.com>
    rxrpc: Fix Tx ring annotation after initial Tx failure

Qu Wenruo <wqu@suse.com>
    btrfs: qgroup: Fix root item corruption when multiple same source snapshots are created with quota enabled

Jeff Mahoney <jeffm@suse.com>
    btrfs: fix lockdep splat in btrfs_alloc_subvolume_writers

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix copy_items() return value when logging an inode

Qu Wenruo <wqu@suse.com>
    btrfs: tests/qgroup: Fix wrong tree backref level

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: sreset panic if there is no debugger or crash dump handlers

Florian Fainelli <f.fainelli@gmail.com>
    net: bgmac: Correctly annotate register space

Florian Fainelli <f.fainelli@gmail.com>
    net: bgmac: Fix endian access in bgmac_dma_tx_ring_free()

David S. Miller <davem@davemloft.net>
    sparc64: Make atomic_xchg() an inline function rather than a macro.

David Howells <dhowells@redhat.com>
    fscache: Fix hanging wait on page discarded by writeback

Alexander Graf <agraf@suse.de>
    lan78xx: Connect phy early

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: VMX: raise internal error for exception during invalid protected mode state

Sai Praneeth <sai.praneeth.prakhya@intel.com>
    x86/mm: Fix bogus warning during EFI bootup, use boot_cpu_has() instead of this_cpu_has() in build_cr3_noflush()

Davidlohr Bueso <dave@stgolabs.net>
    sched/rt: Fix rq->clock_update_flags < RQCF_ACT_SKIP warning

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s/idle: Fix restore of AMOR on POWER9 after deep sleep

Jun Piao <piaojun@huawei.com>
    ocfs2/dlm: don't handle migrate lockres if already in shutdown

Mikhail Malygin <mikhail@malygin.me>
    IB/rxe: Fix for oops in rxe_register_device on ppc64le arch

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix possible softlock on single core machines

Liu Bo <bo.liu@linux.alibaba.com>
    Btrfs: fix NULL pointer dereference in log_dir_items

Liu Bo <bo.liu@linux.alibaba.com>
    Btrfs: bail out on error during replay_dir_deletes

Yang Shi <yang.shi@linux.alibaba.com>
    mm: thp: fix potential clearing to referenced flag in page_idle_clear_pte_refs_one()

Huang Ying <ying.huang@intel.com>
    mm: fix races between address_space dereference and free in page_evicatable

Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
    mm/ksm: fix interaction with THP

Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
    ibmvnic: Zero used TX descriptor counter on reset

Esben Haabendal <eha@deif.com>
    dp83640: Ensure against premature access to PHY registers after reset

Sandipan Das <sandipan@linux.vnet.ibm.com>
    perf clang: Add support for recent clang versions

Sandipan Das <sandipan@linux.vnet.ibm.com>
    perf tools: Fix perf builds with clang support

Anshuman Khandual <khandual@linux.vnet.ibm.com>
    powerpc/fscr: Enable interrupts earlier before calling get_user()

Shunyong Yang <shunyong.yang@hxt-semitech.com>
    cpufreq: CPPC: Initialize shared perf capabilities of CPUs

Carlos Maiolino <cmaiolino@redhat.com>
    Force log to disk before reading the AGF during a fstrim

Jens Axboe <axboe@kernel.dk>
    sr: get/drop reference to device in revalidate and check_events

Xidong Wang <wangxidong_97@163.com>
    z3fold: fix memory leak

Tom Abraham <tabraham@suse.com>
    swap: divide-by-zero when zero length swap file on ssd

Danilo Krummrich <danilokrummrich@dk-develop.de>
    fs/proc/proc_sysctl.c: fix potential page fault while unregistering sysctl table

Dave Hansen <dave.hansen@linux.intel.com>
    x86/mm: Do not forbid _PAGE_RW before init for __ro_after_init

Joerg Roedel <joro@8bytes.org>
    x86/pgtable: Don't set huge PUD/PMD on non-leaf entries

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix loss of prealloc extents past i_size after fsync log replay

Liu Bo <bo.liu@linux.alibaba.com>
    Btrfs: clean up resources during umount after trans is aborted

Johannes Thumshirn <jthumshirn@suse.de>
    nvme: don't send keep-alives to the discovery controller

Jean Delvare <jdelvare@suse.de>
    firmware: dmi_scan: Fix UUID length safety check

Rich Felker <dalias@libc.org>
    sh: fix debug trap failure to process signals before return to user

Yelena Krivosheev <yelena@marvell.com>
    net: mvneta: fix enable of all initialized RXQs

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    vlan: Fix vlan insertion for packets without ethernet header

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    net: Fix untag for vlan packets without ethernet header

Manish Chopra <manish.chopra@cavium.com>
    qede: Do not drop rx-checksum invalidated packets.

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: enable multicast if necessary

Vinayak Menon <vinmenon@codeaurora.org>
    mm/kmemleak.c: wait for scan completion before disabling free

Steven J. Hill <steven.hill@cavium.com>
    mm/vmstat.c: fix vmstat_update() preemption BUG

Maninder Singh <maninder1.s@samsung.com>
    mm/page_owner: fix recursion bug after changing skip entries

Shakeel Butt <shakeelb@google.com>
    mm, slab: memcg_link the SLAB's kmem_cache

Manish Chopra <manish.chopra@cavium.com>
    qede: Fix barrier usage after tx doorbell write.

Jan Kiszka <jan.kiszka@siemens.com>
    builddeb: Fix header package regarding dtc source links

Cong Wang <xiyou.wangcong@gmail.com>
    llc: properly handle dev_queue_xmit() return value

Alexey Dobriyan <adobriyan@gmail.com>
    x86/alternatives: Fixup alternative_call_2

Stephane Eranian <eranian@google.com>
    perf/x86/intel: Fix linear IP of PEBS real_ip on Haswell and later CPUs

Or Gerlitz <ogerlitz@mellanox.com>
    net/mlx5: Make eswitch support to depend on switchdev

Sean Wang <sean.wang@mediatek.com>
    net: dsa: mt7530: fix module autoloading for OF platform drivers

Xin Long <lucien.xin@gmail.com>
    bonding: fix the err path for dev hwaddr sync in bond_enslave

Pawel Dembicki <paweldembicki@gmail.com>
    net: qmi_wwan: add BroadMobi BM806U 2020:2033

Raghuram Chary J <raghuramchary.jallipalli@microchip.com>
    lan78xx: Set ASD in MAC_CR when EEE is enabled.

Jinbum Park <jinb.park7@gmail.com>
    ARM: 8748/1: mm: Define vdso_start, vdso_end as array

Linus Lüssing <linus.luessing@c0d3.blue>
    batman-adv: fix packet loss for broadcasted DHCP packets to a server

Linus Lüssing <linus.luessing@c0d3.blue>
    batman-adv: fix multicast-via-unicast transmission with AP isolation

Felix Kuehling <Felix.Kuehling@amd.com>
    drm/amdkfd: Fix scratch memory with HWS enabled

Masami Hiramatsu <mhiramat@kernel.org>
    selftests: ftrace: Add a testcase for probepoint

Masami Hiramatsu <mhiramat@kernel.org>
    selftests: ftrace: Add a testcase for string type with kprobe_event

Masami Hiramatsu <mhiramat@kernel.org>
    selftests: ftrace: Add probe event argument syntax testcase

Steffen Klassert <steffen.klassert@secunet.com>
    xfrm: Fix transport mode skb control buffer usage.

David Rientjes <rientjes@google.com>
    mm, thp: do not cause memcg oom for thp

Yisheng Xie <xieyisheng1@huawei.com>
    mm/mempolicy.c: avoid use uninitialized preferred_node

Y.C. Chen <yc_chen@aspeedtech.com>
    drm/ast: Fixed 1280x800 Display Issue

Dan Carpenter <dan.carpenter@oracle.com>
    macsec: missing dev_put() on error in macsec_newlink()

Florian Fainelli <f.fainelli@gmail.com>
    net: dsa: Fix functional dsa-loop dependency on FIXED_PHY

Davide Caratti <dcaratti@redhat.com>
    net/sched: fix idr leak in the error path of tcf_skbmod_init()

Davide Caratti <dcaratti@redhat.com>
    net/sched: fix idr leak in the error path of __tcf_ipt_init()

Davide Caratti <dcaratti@redhat.com>
    net/sched: fix idr leak in the error path of tcp_pedit_init()

Davide Caratti <dcaratti@redhat.com>
    net/sched: fix idr leak in the error path of tcf_act_police_init()

Davide Caratti <dcaratti@redhat.com>
    net/sched: fix idr leak in the error path of tcf_simp_init()

Davide Caratti <dcaratti@redhat.com>
    net/sched: fix idr leak on the error path of tcf_bpf_init()

Kalderon, Michal <Michal.Kalderon@cavium.com>
    RDMA/qedr: Fix QP state initialization race

Kalderon, Michal <Michal.Kalderon@cavium.com>
    RDMA/qedr: Fix rc initialization on CNQ allocation failure

Kalderon, Michal <Michal.Kalderon@cavium.com>
    RDMA/qedr: fix QP's ack timeout configuration

Chien Tin Tung <chien.tin.tung@intel.com>
    RDMA/ucma: Correct option size check using optlen

Nicolas Pitre <nicolas.pitre@linaro.org>
    kbuild: make scripts/adjust_autoksyms.sh robust against timestamp races

Stefan Wahren <stefan.wahren@i2se.com>
    brcmfmac: Fix check for ISO3166 code

Song Liu <songliubraving@fb.com>
    perf/cgroup: Fix child event counting bug

Thierry Reding <treding@nvidia.com>
    drm/tegra: Shutdown on driver unbind

Avraham Stern <avraham.stern@intel.com>
    iwlwifi: mvm: fix array out of bounds reference

Avraham Stern <avraham.stern@intel.com>
    iwlwifi: mvm: make sure internal station has a valid id

Avraham Stern <avraham.stern@intel.com>
    iwlwifi: mvm: clear tx queue id when unreserving aggregation queue

Andrei Otcheretianski <andrei.otcheretianski@intel.com>
    iwlwifi: mvm: Increase session protection time after CS

Stefano Brivio <sbrivio@redhat.com>
    vti6: Fix dev->max_mtu setting

Stefano Brivio <sbrivio@redhat.com>
    vti4: Don't override MTU passed on link creation via IFLA_MTU

Stefano Brivio <sbrivio@redhat.com>
    ip_tunnel: Clamp MTU to bounds on new link

Stefano Brivio <sbrivio@redhat.com>
    vti4: Don't count header length twice on tunnel setup

Sven Eckelmann <sven@narfation.org>
    batman-adv: Fix skbuff rcsum on packet reroute

Davide Caratti <dcaratti@redhat.com>
    net/sched: fix NULL dereference in the error path of tcf_sample_init()

Matthias Schiffer <mschiffer@universe-factory.net>
    batman-adv: fix header size check in batadv_dbg_arp()

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    vlan: Fix out of order vlan headers with reorder header off

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    net: Fix vlan untag for bridge and vlan_dev with reorder_hdr off

Rob Herring <robh@kernel.org>
    microblaze: switch to NO_BOOTMEM

Johannes Berg <johannes.berg@intel.com>
    iwlwifi: mvm: fix error checking for multi/broadcast sta

Beni Lev <beni.lev@intel.com>
    iwlwifi: mvm: Correctly set IGTK for AP

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    iwlwifi: mvm: set the correct tid when we flush the MCAST sta

Taehee Yoo <ap420073@gmail.com>
    xfrm: fix rcu_read_unlock usage in xfrm_local_error

Karol Herbst <kherbst@redhat.com>
    drm/nouveau/bl: fix backlight regression

Lucas Stach <l.stach@pengutronix.de>
    drm/imx: move arming of the vblank event to atomic_flush

Arnd Bergmann <arnd@arndb.de>
    gpu: ipu-v3: prg: avoid possible array underflow

Andre Przywara <andre.przywara@arm.com>
    KVM: arm/arm64: vgic: Add missing irq_lock to vgic_mmio_read_pending

Cathy Zhou <Cathy.Zhou@Oracle.COM>
    sunvnet: does not support GSO for sctp

Sabrina Dubroca <sd@queasysnail.net>
    ipv4: lock mtu in fnhe when received PMTU < net.ipv4.route.min_pmtu

Arvind Yadav <arvind.yadav.cs@gmail.com>
    workqueue: use put_device() instead of kfree()

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Check valid VNIC ID in bnxt_hwrm_vnic_set_tpa().

Bich HEMON <bich.hemon@st.com>
    can: m_can: select pinctrl state in each suspend/resume function

Wolfram Sang <wsa+renesas@sang-engineering.com>
    can: m_can: change comparison to bitshift when dealing with a mask

Florian Westphal <fw@strlen.de>
    netfilter: ebtables: fix erroneous reject of last rule

Gregory CLEMENT <gregory.clement@bootlin.com>
    dmaengine: mv_xor_v2: Fix clock resource by adding a register clock

Luis R. Rodriguez <mcgrof@kernel.org>
    lib/test_kmod.c: fix limit check on number of test devices created

Li Zhijian <zhijianx.li@intel.com>
    selftests/vm/run_vmtests: adjust hugetlb size according to nr_cpus

Marc Zyngier <marc.zyngier@arm.com>
    arm64: Relax ARM_SMCCC_ARCH_WORKAROUND_1 discovery

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    ARM: davinci: fix the GPIO lookup for omapl138-hawk

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: fix locking during VF setup

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: fix locking for rx_mode

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: fix filter flags

Arvind Yadav <arvind.yadav.cs@gmail.com>
    xen: xenbus: use put_device() instead of kfree()

Bhavesh Davda <bhavesh.davda@oracle.com>
    xen-blkfront: move negotiate_mq to cover all cases of new VBDs

Ganesh Goudar <ganeshgr@chelsio.com>
    cxgb4: do not set needs_free_netdev for mgmt dev's

Parav Pandit <parav@mellanox.com>
    IB/core: Fix possible crash to access NULL netdev

Jeremy Linton <jeremy.linton@arm.com>
    net: smsc911x: Fix unload crash when link is up

Hemanth Puranik <hpuranik@codeaurora.org>
    net: qcom/emac: Use proper free methods during TX

Michal Kalderon <Michal.Kalderon@cavium.com>
    qed: Free RoCE ILT Memory on rmmod qedr

Denis Kirjanov <kda@linux-powerpc.org>
    fsl/fman: avoid sleeping in atomic context while adding an address

Peter Malone <peter.malone@gmail.com>
    fbdev: Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in sbusfb_ioctl_helper().

Dan Carpenter <dan.carpenter@oracle.com>
    IB/mlx5: Fix an error code in __mlx5_ib_modify_qp()

Jack M <jackm@dev.mellanox.co.il>
    IB/mlx4: Include GID type when deleting GIDs from HW table under RoCE

Jack Morgenstein <jackm@dev.mellanox.co.il>
    IB/mlx4: Fix corruption of RoCEv2 IPv4 GIDs

Kalderon, Michal <Michal.Kalderon@cavium.com>
    RDMA/qedr: Fix iWARP write and send with immediate

Kalderon, Michal <Michal.Kalderon@cavium.com>
    RDMA/qedr: Fix kernel panic when running fio over NFSoRDMA

Davidlohr Bueso <dave@stgolabs.net>
    ia64/err-inject: Use get_user_pages_fast()

Pierre-Yves Kerbrat <pkerbrat@kalray.eu>
    e1000e: allocate ring descriptors with dma_zalloc_coherent

Benjamin Poirier <bpoirier@suse.com>
    e1000e: Fix check_for_link return value with autoneg off

Jiri Olsa <jolsa@kernel.org>
    perf record: Fix crash in pipe mode

Rob Herring <robh@kernel.org>
    ARM: dts: rockchip: Add missing #sound-dai-cells on rk3288

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: propagate rx filters to VF

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: filter multicast/broadcast

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: use napi_schedule_irqoff

Linus Lüssing <linus.luessing@c0d3.blue>
    batman-adv: Fix multicast packet loss with a single WANT_ALL_IPV4/6 flag

Jayachandran C <jnair@caviumnetworks.com>
    watchdog: sbsa: use 32-bit read for WCV

Igor Pylypiv <igor.pylypiv@gmail.com>
    watchdog: f71808e_wdt: Fix magic close handling

Ka-Cheong Poon <ka-cheong.poon@oracle.com>
    rds: Incorrect reference counting in TCP socket creation

Ilan Peer <ilan.peer@intel.com>
    iwlwifi: mvm: Correctly set the tid for mcast queue

Ilan Peer <ilan.peer@intel.com>
    iwlwifi: mvm: Direct multicast frames to the correct station

Sara Sharon <sara.sharon@intel.com>
    iwlwifi: mvm: fix "failed to remove key" message

Shaul Triebitz <shaul.triebitz@intel.com>
    iwlwifi: avoid collecting firmware dump if not loaded

Sara Sharon <sara.sharon@intel.com>
    iwlwifi: mvm: fix assert 0x2B00 on older FWs

Andrei Otcheretianski <andrei.otcheretianski@intel.com>
    iwlwifi: mvm: Fix channel switch for count 0 and 1

Sara Sharon <sara.sharon@intel.com>
    iwlwifi: mvm: fix TX of CCMP 256

Edward Cree <ecree@solarflare.com>
    net: ethtool: don't ignore return from driver get_fecparam method

Hannes Reinecke <hare@suse.de>
    scsi: core: return BLK_STS_OK for DID_OK in __scsi_error_from_host_byte()

Michael Ellerman <mpe@ellerman.id.au>
    selftests/powerpc: Skip the subpage_prot tests if the syscall is unavailable

Ming Lei <ming.lei@redhat.com>
    nvme: pci: pass max vectors as num_possible_cpus() to pci_alloc_irq_vectors

Wen Xiong <wenxiong@linux.vnet.ibm.com>
    nvme-pci: Fix EEH failure on ppc

Jiufei Xue <jiufei.xue@linux.alibaba.com>
    block: display the correct diskname for bio

Chengguang Xu <cgxu519@icloud.com>
    ceph: fix potential memory leak in init_caches()

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix log replay failure after linking special file and fsync

Filipe Manana <fdmanana@suse.com>
    Btrfs: send, fix issuing write op when processing hole in no data mode

Jeff Mahoney <jeffm@suse.com>
    btrfs: use kvzalloc to allocate btrfs_fs_info

Giulio Benetti <giulio.benetti@micronovasrl.com>
    drm/sun4i: Fix dclk_set_phase

Douglas Anderson <dianders@chromium.org>
    arm64: dts: rockchip: Fix rk3399-gru-* s2r (pinctrl hogs, wifi reset)

Steffen Klassert <steffen.klassert@secunet.com>
    xfrm: Fix ESN sequence number handling for IPsec GSO packets.

Tom St Denis <tom.stdenis@amd.com>
    drm/amd/amdgpu: Correct VRAM width for APUs with GMC9

Roger Pau Monne <roger.pau@citrix.com>
    xen/pirq: fix error path cleanup when binding MSIs

Selvin Xavier <selvin.xavier@broadcom.com>
    RDMA/bnxt_re: Fix the ib_reg failure cleanup

Devesh Sharma <devesh.sharma@broadcom.com>
    RDMA/bnxt_re: Fix incorrect DB offset calculation

Devesh Sharma <devesh.sharma@broadcom.com>
    RDMA/bnxt_re: Unconditionly fence non wire memory operations

Moni Shoua <monis@mellanox.com>
    IB/mlx: Set slid to zero in Ethernet completion struct

Julian Anastasov <ja@ssi.bg>
    ipvs: remove IPS_NAT_MASK check to fix passive FTP

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARC: setup cpu possible mask according to possible-cpus dts property

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARC: mcip: update MCIP debug mask when the new cpu came online

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARC: mcip: halt GFRC counter when ARC cores halt

Ido Schimmel <idosch@mellanox.com>
    spectrum: Reference count VLAN entries

Ido Schimmel <idosch@mellanox.com>
    mlxsw: spectrum: Treat IPv6 unregistered multicast as broadcast

Jiri Pirko <jiri@mellanox.com>
    mlxsw: core: Fix flex keys scratchpad offset conflict

Karsten Graul <kgraul@linux.vnet.ibm.com>
    net/smc: use link_id of server in confirm link reply

Max Gurtovoy <maxg@mellanox.com>
    nvmet: fix PSDT field check in command format

Joey Pabalinas <joeypabalinas@gmail.com>
    net/tcp/illinois: replace broken algorithm reference link

Claudiu Manoil <claudiu.manoil@nxp.com>
    gianfar: Fix Rx byte accounting for ndev stats

Felix Fietkau <nbd@nbd.name>
    clocksource/drivers/mips-gic-timer: Use correct shift count to extract data

Guenter Roeck <linux@roeck-us.net>
    powerpc/boot: Fix random libfdt related build errors

Stefan Wahren <stefan.wahren@i2se.com>
    ARM: dts: bcm283x: Fix unit address of local_intc

Florian Fainelli <f.fainelli@gmail.com>
    ARM: dts: NSP: Fix amount of RAM on BCM958625HR

Gustavo A. R. Silva <gustavo@embeddedor.com>
    nbd: fix return value in error handling path

Xin Long <lucien.xin@gmail.com>
    sit: fix IFLA_MTU ignored on NEWLINK

Xin Long <lucien.xin@gmail.com>
    ip6_tunnel: fix IFLA_MTU ignored on NEWLINK

Xin Long <lucien.xin@gmail.com>
    ip_gre: fix IFLA_MTU ignored on NEWLINK

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: fix kcrashes with fio in RAID5 backend dev

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    dmaengine: rcar-dmac: fix max_chunk_size for R-Car Gen3

Dave Airlie <airlied@redhat.com>
    virtio-gpu: fix ioctl and expose the fixed status to userspace.

Eric Dumazet <edumazet@google.com>
    r8152: fix tx packets accounting

Daniel Díaz <daniel.diaz@linaro.org>
    selftests/futex: Fix line continuation in Makefile

Ramon Fried <rfried@codeaurora.org>
    qrtr: add MODULE_ALIAS macro to smd

David S. Miller <davem@davemloft.net>
    ARM: orion5x: Revert commit 4904dbda41c8.

Colin Ian King <colin.king@canonical.com>
    xen/pvcalls: fix null pointer dereference on map->sock

Chengguang Xu <cgxu519@icloud.com>
    ceph: fix dentry leak when failing to init debugfs

Chengguang Xu <cgxu519@icloud.com>
    libceph, ceph: avoid memory leak when specifying same option several times

Colin Ian King <colin.king@canonical.com>
    clocksource/drivers/fsl_ftm_timer: Fix error return checking

Jianchao Wang <jianchao.w.wang@oracle.com>
    nvme-pci: Fix nvme queue cleanup if IRQ setup fails

Sven Eckelmann <sven@narfation.org>
    batman-adv: Fix netlink dumping of BLA backbones

Sven Eckelmann <sven@narfation.org>
    batman-adv: Fix netlink dumping of BLA claims

Sven Eckelmann <sven.eckelmann@openmesh.com>
    batman-adv: Ignore invalid batadv_v_gw during netlink send

Sven Eckelmann <sven.eckelmann@openmesh.com>
    batman-adv: Ignore invalid batadv_iv_gw during netlink send

Florian Westphal <fw@strlen.de>
    netfilter: ebtables: convert BUG_ONs to WARN_ONs

Florian Westphal <fw@strlen.de>
    netfilter: ipt_CLUSTERIP: put config instead of freeing it

Florian Westphal <fw@strlen.de>
    netfilter: ipt_CLUSTERIP: put config struct if we can't increment ct refcount

Matthias Schiffer <mschiffer@universe-factory.net>
    batman-adv: invalidate checksum on fragment reassembly

Matthias Schiffer <mschiffer@universe-factory.net>
    batman-adv: fix packet checksum in receive path

Yufen Yu <yuyufen@huawei.com>
    md/raid1: fix NULL pointer dereference

BingJing Chang <bingjingc@synology.com>
    md: fix a potential deadlock of raid5/raid10 reshape

Will Deacon <will.deacon@arm.com>
    fs: dcache: Use READ_ONCE when accessing i_dir_seq

Will Deacon <will.deacon@arm.com>
    fs: dcache: Avoid livelock between d_alloc_parallel and __d_add

Shyam Saini <shyam@amarulasolutions.com>
    ARM: dts: imx6dl: Include correct dtsi file for Engicam i.CoreM6 DualLite/Solo RQS

Sebastian Ott <sebott@linux.vnet.ibm.com>
    kvm: fix warning for CONFIG_HAVE_KVM_EVENTFD builds

Chao Gao <chao.gao@intel.com>
    KVM: nVMX: Don't halt vcpu when L1 is injecting events to L2

Alexey Kodanev <alexey.kodanev@oracle.com>
    macvlan: fix use-after-free in macvlan_common_newlink()

Pratyush Anand <panand@redhat.com>
    arm64: fix unwind_frame() for filtered out fn for function graph tracing

Felix Fietkau <nbd@nbd.name>
    mac80211: drop frames with unexpected DS bits from fast-rx to slow path

Samuel Neves <sneves@dei.uc.pt>
    x86/topology: Update the 'cpu cores' field in /proc/cpuinfo correctly across CPU hotplug operations

Andrea Parri <parri.andrea@gmail.com>
    locking/xchg/alpha: Fix xchg() and cmpxchg() memory ordering bugs

Wang Hui <john.wanghui@huawei.com>
    x86/intel_rdt: Fix incorrect returned value when creating rdgroup sub-directory in resctrl file system

Randy Dunlap <rdunlap@infradead.org>
    integrity/security: fix digsig.c build error with header file

Johannes Berg <johannes.berg@intel.com>
    regulatory: add NUL to request alpha2

Eric Dumazet <edumazet@google.com>
    smsc75xx: fix smsc75xx_set_features()

Tony Lindgren <tony@atomide.com>
    ARM: OMAP: Fix dmtimer init for omap1

Bill.Baker@oracle.com <Bill.Baker@oracle.com>
    nfs: system crashes after NFS4ERR_MOVED recovery

Rob Herring <robh@kernel.org>
    arm64: dts: cavium: fix PCI bus dtc warnings

Eric Biggers <ebiggers@google.com>
    PKCS#7: fix direct verification of SignerInfo signature

Li Zhijian <zhijianx.li@intel.com>
    selftests/bpf/test_maps: exit child process without error in ENOMEM case

Sebastian Ott <sebott@linux.vnet.ibm.com>
    s390/cio: clear timer when terminating driver I/O

Sebastian Ott <sebott@linux.vnet.ibm.com>
    s390/cio: fix return code after missing interrupt

Sebastian Ott <sebott@linux.vnet.ibm.com>
    s390/cio: fix ccw_device_start_timeout API

Mark Lord <mlord@pobox.com>
    powerpc/bpf/jit: Fix 32-bit JIT for seccomp_data access

Stefan Agner <stefan@agner.ch>
    soc: imx: gpc: de-register power domains only if initialized

Tycho Andersen <tycho@tycho.ws>
    seccomp: add a selftest for get_metadata

Anders Roxell <anders.roxell@linaro.org>
    selftests/memfd: add run_fuse_test.sh to TEST_FILES

Arnd Bergmann <arnd@arndb.de>
    bug.h: work around GCC PR82365 in BUG()

David Rientjes <rientjes@google.com>
    kernel/relay.c: limit kmalloc size to KMALLOC_MAX_SIZE

Jesper Dangaard Brouer <brouer@redhat.com>
    virtio_net: fix XDP code path in receive_small()

Arnd Bergmann <arnd@arndb.de>
    md: raid5: avoid string overflow warning

Andrea Parri <parri.andrea@gmail.com>
    locking/xchg/alpha: Add unconditional memory barrier to cmpxchg()

Or Gerlitz <ogerlitz@mellanox.com>
    net/mlx5e: Return error if prio is specified when offloading eswitch vlan push

Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
    ibmvnic: Check for NULL skb's in NAPI poll routine

Selvin Xavier <selvin.xavier@broadcom.com>
    RDMA/bnxt_re: Fix system crash during load/unload

Devesh Sharma <devesh.sharma@broadcom.com>
    RDMA/bnxt_re: Unpin SQ and RQ memory if QP create fails

Mark Rutland <mark.rutland@arm.com>
    arm64: perf: correct PMUVer probing

Neil Armstrong <narmstrong@baylibre.com>
    drm/meson: fix vsync buffer update

Markus Elfring <elfring@users.sourceforge.net>
    drm/exynos: g2d: Delete an error message for a failed memory allocation in two functions

Wolfram Sang <wsa+renesas@sang-engineering.com>
    drm/exynos: fix comparison to bitshift when dealing with a mask

Arnd Bergmann <arnd@arndb.de>
    drm/exynos: g2d: use monotonic timestamps

Yufen Yu <yuyufen@huawei.com>
    md raid10: fix NULL deference in handle_write_completed()

Tobias Jordan <Tobias.Jordan@elektrobit.com>
    gpu: ipu-v3: prg: fix device node leak in ipu_prg_lookup_by_phandle

Tobias Jordan <Tobias.Jordan@elektrobit.com>
    gpu: ipu-v3: pre: fix device node leak in ipu_pre_lookup_by_phandle

Ilan Peer <ilan.peer@intel.com>
    mac80211: Fix sending ADDBA response for an ongoing session

Ilan Peer <ilan.peer@intel.com>
    mac80211: Do not disconnect on invalid operating class

Avraham Stern <avraham.stern@intel.com>
    cfg80211: clear wep keys after disconnection

Sara Sharon <sara.sharon@intel.com>
    mac80211: fix calling sleeping function in atomic context

Sara Sharon <sara.sharon@intel.com>
    mac80211: fix a possible leak of station stats

Felix Fietkau <nbd@nbd.name>
    mac80211: round IEEE80211_TX_STATUS_HEADROOM up to multiple of 4

Xin Long <lucien.xin@gmail.com>
    xfrm: do not call rcu_read_unlock when afinfo is NULL in xfrm_get_tos

Stefan Haberland <sth@linux.vnet.ibm.com>
    s390/dasd: fix handling of internal requests

Heinz Mauelshagen <heinzm@redhat.com>
    md: fix md_write_start() deadlock w/o metadata devices

Xiao Ni <xni@redhat.com>
    MD: Free bioset when md_run fails

David Howells <dhowells@redhat.com>
    rxrpc: Work around usercopy check

Kees Cook <keescook@chromium.org>
    NFC: llcp: Limit size of SDP URI

Naftali Goldstein <naftali.goldstein@intel.com>
    iwlwifi: mvm: always init rs with 20mhz bandwidth rates

Sara Sharon <sara.sharon@intel.com>
    iwlwifi: mvm: fix IBSS for devices that support station type API

Sara Sharon <sara.sharon@intel.com>
    iwlwifi: mvm: fix security bug in PN checking

Robin Murphy <robin.murphy@arm.com>
    ARM: dts: rockchip: Fix DWMMC clocks

Robin Murphy <robin.murphy@arm.com>
    arm64: dts: rockchip: Fix DWMMC clocks

Jason Gunthorpe <jgg@mellanox.com>
    IB/uverbs: Fix unbalanced unlock on error path for rdma_explicit_destroy

Matan Barak <matanb@mellanox.com>
    IB/uverbs: Fix possible oops with duplicate ioctl attributes

Matan Barak <matanb@mellanox.com>
    IB/uverbs: Fix method merging in uverbs_ioctl_merge

Joe Lee <asmt.swfae@gmail.com>
    xhci: workaround for AMD Promontory disabled ports wakeup

Boris Pismenny <borisp@mellanox.com>
    tls: retrun the correct IV in getsockopt

Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
    ibmvnic: Clean RX pool buffers during device close

Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
    ibmvnic: Free RX socket buffer in case of adapter error

Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
    ibmvnic: Wait until reset is complete to set carrier on

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: OMAP1: clock: Fix debugfs_create_*() usage

Tony Lindgren <tony@atomide.com>
    ARM: OMAP2+: Fix sar_base inititalization for HS omaps

Tony Lindgren <tony@atomide.com>
    ARM: OMAP3: Fix prm wake interrupt for resume

Qi Hou <qi.hou@windriver.com>
    ARM: OMAP2+: timer: fix a kmemleak caused in omap_get_timer_dt

Anders Roxell <anders.roxell@linaro.org>
    selftests: memfd: add config fragment for fuse

Naresh Kamboju <naresh.kamboju@linaro.org>
    selftests: pstore: Adding config fragment CONFIG_PSTORE_RAM=m

Dominik Brodowski <linux@dominikbrodowski.net>
    selftest/vDSO: fix O=

Anders Roxell <anders.roxell@linaro.org>
    selftests: sync: missing CFLAGS while compiling

Dong Bo <dongbo4@huawei.com>
    libata: Fix compile warning with ATA_DEBUG enabled

Shawn Lin <shawn.lin@rock-chips.com>
    arm64: dts: rockchip: correct ep-gpios for rk3399-sapphire

Kamil Trzciński <ayufan@ayufan.eu>
    arm64: dts: rockchip: fix rock64 gmac2io stability issues

Jason Wang <jasowang@redhat.com>
    ptr_ring: prevent integer overflow when calculating size

Ulf Magnusson <ulfalizer@gmail.com>
    ARC: Fix malformed ARC_EMUL_UNALIGNED default

Peter Oh <peter.oh@bowerswilkins.com>
    mac80211: mesh: fix wrong mesh TTL offset calculation

James Hogan <jhogan@kernel.org>
    MIPS: generic: Fix machine compatible matching

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Add support for a store forwarding barrier at kernel entry/exit

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Fix section mismatch warnings from setup_rfi_flush()

Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
    powerpc/pseries: Restore default security feature flags on setup

Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
    powerpc: Move default security feature flags

Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
    powerpc/pseries: Fix clearing of security feature flags

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Wire up cpu_show_spectre_v2()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Wire up cpu_show_spectre_v1()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/pseries: Use the security flags in pseries_setup_rfi_flush()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/powernv: Use the security flags in pnv_setup_rfi_flush()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Enhance the information in cpu_show_meltdown()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Move cpu_show_meltdown()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/powernv: Set or clear security feature flags

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/pseries: Set or clear security feature flags

Michael Ellerman <mpe@ellerman.id.au>
    powerpc: Add security feature flags for Spectre/Meltdown

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/pseries: Add new H_GET_CPU_CHARACTERISTICS flags

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/rfi-flush: Call setup_rfi_flush() after LPM migration

Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
    powerpc/rfi-flush: Differentiate enabled and patched flush types

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/rfi-flush: Always enable fallback flush on pseries

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/rfi-flush: Make it possible to call setup_rfi_flush() again

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/rfi-flush: Move the logic to avoid a redo into the debugfs code

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/powernv: Support firmware disable of RFI flush

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/pseries: Support firmware disable of RFI flush

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Improve RFI L1-D cache flush fallback

David Vrabel <david.vrabel@nutanix.com>
    x86/kvm: fix LAPIC timer drift when guest uses periodic mode

Jim Mattson <jmattson@google.com>
    kvm: x86: IA32_ARCH_CAPABILITIES is always supported

Wei Huang <wei@redhat.com>
    KVM: x86: Update cpuid properly when CR4.OSXAVE or CR4.PKE is changed

David Hildenbrand <david@redhat.com>
    KVM: s390: vsie: fix < 8k check for the itdba

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    KVM/VMX: Expose SSBD properly to guests

Gustavo A. R. Silva <gustavo@embeddedor.com>
    kernel/sys.c: fix potential Spectre v1 issue

David Hildenbrand <david@redhat.com>
    kasan: fix memory hotplug during boot

David Hildenbrand <david@redhat.com>
    kasan: free allocated shadow memory on MEM_CANCEL_ONLINE

Andrey Ryabinin <aryabinin@virtuozzo.com>
    mm/kasan: don't vfree() nonexistent vm_area

Davidlohr Bueso <dave@stgolabs.net>
    ipc/shm: fix shmat() nil address after round-down when remapping

Davidlohr Bueso <dave@stgolabs.net>
    Revert "ipc/shm: Fix shmat mmap nil-page protection"

Matthew Wilcox <mawilcox@microsoft.com>
    idr: fix invalid ptr dereference on item delete

Jens Axboe <axboe@kernel.dk>
    sr: pass down correctly sized SCSI sense buffer

Lidong Chen <jemmy858585@gmail.com>
    IB/umem: Use the correct mm during ib_umem_release

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Use after free race condition in send context error path

Michael Neuling <mikey@neuling.org>
    powerpc/64s: Clear PCR on boot

Will Deacon <will.deacon@arm.com>
    arm64: lse: Add early clobbers to some input/output asm operands

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Fix 32-bit VMW_PORT_HB_[IN|OUT] macros

Joe Jin <joe.jin@oracle.com>
    xen-swiotlb: fix the check condition for xen_swiotlb_free_coherent

Sudip Mukherjee <sudipm.mukherjee@gmail.com>
    libata: blacklist Micron 500IT SSD with MU01 firmware

Tejun Heo <tj@kernel.org>
    libata: Blacklist some Sandisk SSDs for NCQ

Corneliu Doban <corneliu.doban@broadcom.com>
    mmc: sdhci-iproc: add SDHCI_QUIRK2_HOST_OFF_CARD_ON for cygnus

Corneliu Doban <corneliu.doban@broadcom.com>
    mmc: sdhci-iproc: fix 32bit writes for TRANSFER_MODE register

Srinath Mannam <srinath.mannam@broadcom.com>
    mmc: sdhci-iproc: remove hard coded mmc cap 1.8v

Al Viro <viro@zeniv.linux.org.uk>
    do d_instantiate/unlock_new_inode combinations safely

Ben Hutchings <ben.hutchings@codethink.co.uk>
    ALSA: timer: Fix pause event notification

Al Viro <viro@zeniv.linux.org.uk>
    aio: fix io_destroy(2) vs. lookup_ioctx() race

Dave Chinner <dchinner@redhat.com>
    fs: don't scan the inode cache before SB_BORN is set

Al Viro <viro@zeniv.linux.org.uk>
    affs_lookup(): close a race with affs_remove_link()

Colin Ian King <colin.king@canonical.com>
    KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"

Maciej W. Rozycki <macro@mips.com>
    MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR accesses to o32 FGRs

Maciej W. Rozycki <macro@mips.com>
    MIPS: ptrace: Expose FIR register through FP regset

NeilBrown <neil@brown.name>
    MIPS: c-r4k: Fix data corruption related to cache coherence


-------------

Diffstat:

 .../devicetree/bindings/clock/sunxi-ccu.txt        |   4 +
 .../devicetree/bindings/dma/mv-xor-v2.txt          |   6 +-
 .../bindings/pinctrl/axis,artpec6-pinctrl.txt      |   5 +-
 Makefile                                           |   4 +-
 arch/alpha/include/asm/xchg.h                      |  30 ++-
 arch/arc/Kconfig                                   |   1 -
 arch/arc/include/asm/bug.h                         |   3 +-
 arch/arc/kernel/mcip.c                             |  74 ++++++-
 arch/arc/kernel/smp.c                              |  50 ++++-
 arch/arm/boot/dts/at91-tse850-3.dts                |   2 +-
 arch/arm/boot/dts/bcm2836.dtsi                     |   2 +-
 arch/arm/boot/dts/bcm2837.dtsi                     |   2 +-
 arch/arm/boot/dts/bcm283x.dtsi                     |   6 +-
 arch/arm/boot/dts/bcm958625hr.dts                  |   2 +-
 arch/arm/boot/dts/dra71-evm.dts                    |   4 +-
 arch/arm/boot/dts/imx6dl-icore-rqs.dts             |   2 +-
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts            |  52 ++---
 arch/arm/boot/dts/r8a7791-porter.dts               |   2 +-
 arch/arm/boot/dts/rk3036.dtsi                      |   4 +-
 arch/arm/boot/dts/rk322x.dtsi                      |   6 +-
 arch/arm/boot/dts/rk3288.dtsi                      |   2 +
 arch/arm/boot/dts/socfpga.dtsi                     |   2 +-
 arch/arm/include/asm/vdso.h                        |   2 -
 arch/arm/kernel/vdso.c                             |  12 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c        |   4 +-
 arch/arm/mach-omap1/clock.c                        |   6 +-
 arch/arm/mach-omap2/omap-wakeupgen.c               |   4 +-
 arch/arm/mach-omap2/pm.c                           |   4 +-
 arch/arm/mach-omap2/timer.c                        |  19 +-
 arch/arm/mach-orion5x/Kconfig                      |   3 -
 arch/arm/mach-orion5x/dns323-setup.c               |  53 ++++-
 arch/arm/mach-orion5x/tsx09-common.c               |  49 ++++-
 arch/arm/plat-omap/dmtimer.c                       |   7 +-
 arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi      |   3 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   4 +-
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |   5 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |   6 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |  16 +-
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi  |   2 +-
 arch/arm64/include/asm/atomic_lse.h                |  24 +--
 arch/arm64/include/asm/stacktrace.h                |   2 +-
 arch/arm64/kernel/cpu_errata.c                     |   4 +-
 arch/arm64/kernel/perf_event.c                     |   4 +-
 arch/arm64/kernel/stacktrace.c                     |   5 +
 arch/arm64/kernel/time.c                           |   2 +-
 arch/cris/include/arch-v10/arch/bug.h              |  11 +-
 arch/ia64/include/asm/bug.h                        |   6 +-
 arch/ia64/kernel/err_inject.c                      |   2 +-
 arch/m68k/coldfire/device.c                        |  12 +-
 arch/m68k/include/asm/bug.h                        |   3 +
 arch/microblaze/Kconfig                            |   1 +
 arch/microblaze/mm/init.c                          |  56 +----
 arch/mips/cavium-octeon/octeon-irq.c               |  10 +-
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h     |   2 +-
 arch/mips/include/asm/machine.h                    |   2 +-
 arch/mips/kernel/ptrace.c                          |  22 +-
 arch/mips/kernel/ptrace32.c                        |   4 +-
 arch/mips/kvm/mips.c                               |   2 +-
 arch/mips/mm/c-r4k.c                               |   9 +-
 arch/powerpc/boot/Makefile                         |   3 +-
 arch/powerpc/include/asm/exception-64s.h           |  29 +++
 arch/powerpc/include/asm/feature-fixups.h          |  19 ++
 arch/powerpc/include/asm/hvcall.h                  |   3 +
 arch/powerpc/include/asm/irq_work.h                |   1 +
 arch/powerpc/include/asm/paca.h                    |   3 +-
 arch/powerpc/include/asm/security_features.h       |  85 ++++++++
 arch/powerpc/include/asm/setup.h                   |   2 +-
 arch/powerpc/kernel/Makefile                       |   2 +-
 arch/powerpc/kernel/asm-offsets.c                  |   3 +-
 arch/powerpc/kernel/cpu_setup_power.S              |   6 +
 arch/powerpc/kernel/dt_cpu_ftrs.c                  |   1 +
 arch/powerpc/kernel/exceptions-64s.S               |  95 +++++----
 arch/powerpc/kernel/idle_book3s.S                  |   2 +
 arch/powerpc/kernel/security.c                     | 237 +++++++++++++++++++++
 arch/powerpc/kernel/setup_64.c                     |  48 ++---
 arch/powerpc/kernel/traps.c                        |  47 ++--
 arch/powerpc/kernel/vmlinux.lds.S                  |  14 ++
 arch/powerpc/lib/feature-fixups.c                  | 124 ++++++++++-
 arch/powerpc/net/bpf_jit_comp.c                    |   3 +
 arch/powerpc/perf/core-book3s.c                    |  25 +++
 arch/powerpc/platforms/powernv/npu-dma.c           | 229 ++++++++++++--------
 arch/powerpc/platforms/powernv/setup.c             |  92 +++++---
 arch/powerpc/platforms/pseries/mobility.c          |   3 +
 arch/powerpc/platforms/pseries/pseries.h           |   2 +
 arch/powerpc/platforms/pseries/setup.c             |  81 +++++--
 arch/powerpc/sysdev/mpic.c                         |   2 +-
 arch/powerpc/xmon/xmon.c                           |   2 +
 arch/s390/kvm/vsie.c                               |   2 +-
 arch/sh/kernel/entry-common.S                      |   2 +-
 arch/sparc/include/asm/atomic_64.h                 |   6 +-
 arch/sparc/include/asm/bug.h                       |   6 +-
 arch/x86/events/core.c                             |  15 +-
 arch/x86/events/intel/core.c                       |  12 +-
 arch/x86/events/intel/ds.c                         | 117 ++++++++--
 arch/x86/events/perf_event.h                       |   2 +-
 arch/x86/include/asm/alternative.h                 |   4 +-
 arch/x86/include/asm/tlbflush.h                    |   7 +-
 arch/x86/kernel/apic/apic.c                        |   2 +-
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c           |   1 +
 arch/x86/kernel/devicetree.c                       |  21 +-
 arch/x86/kernel/smpboot.c                          |   1 +
 arch/x86/kvm/cpuid.c                               |   9 +-
 arch/x86/kvm/lapic.c                               |  26 ++-
 arch/x86/kvm/vmx.c                                 |  27 ++-
 arch/x86/kvm/x86.c                                 |   5 +-
 arch/x86/mm/pageattr.c                             |   6 +-
 arch/x86/mm/pgtable.c                              |   9 +
 block/partition-generic.c                          |   6 +
 crypto/asymmetric_keys/pkcs7_trust.c               |   1 +
 drivers/acpi/acpi_pad.c                            |   3 +
 drivers/acpi/acpica/evevent.c                      |   9 +-
 drivers/acpi/acpica/nseval.c                       |   8 +
 drivers/acpi/acpica/psargs.c                       |   4 +
 drivers/ata/libata-core.c                          |   6 +
 drivers/ata/libata-scsi.c                          |   2 +-
 drivers/base/regmap/regmap.c                       |   2 +-
 drivers/block/nbd.c                                |   2 +-
 drivers/block/null_blk.c                           |  46 ++--
 drivers/block/paride/pcd.c                         |   2 +
 drivers/block/xen-blkfront.c                       |  17 +-
 drivers/cdrom/cdrom.c                              |   3 -
 drivers/cdrom/gdrom.c                              |   3 +
 drivers/char/hw_random/stm32-rng.c                 |   9 +
 drivers/char/ipmi/ipmi_ssif.c                      |   4 +-
 drivers/clocksource/fsl_ftm_timer.c                |   2 +-
 drivers/clocksource/mips-gic-timer.c               |   2 +-
 drivers/cpufreq/cppc_cpufreq.c                     |  23 +-
 drivers/cpufreq/cpufreq.c                          |   6 +-
 drivers/dma/mv_xor_v2.c                            |  25 ++-
 drivers/dma/pl330.c                                |   6 +-
 drivers/dma/qcom/bam_dma.c                         |  27 ++-
 drivers/dma/sh/rcar-dmac.c                         |  11 +-
 drivers/firmware/dmi_scan.c                        |   2 +-
 drivers/firmware/efi/arm-runtime.c                 |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |  33 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   8 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |   3 +-
 drivers/gpu/drm/ast/ast_tables.h                   |   4 +-
 drivers/gpu/drm/bridge/sii902x.c                   |  20 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |  12 +-
 drivers/gpu/drm/exynos/regs-fimc.h                 |   2 +-
 drivers/gpu/drm/imx/ipuv3-crtc.c                   |   5 +
 drivers/gpu/drm/meson/meson_crtc.c                 |   6 +
 drivers/gpu/drm/meson/meson_drv.c                  |  29 ++-
 drivers/gpu/drm/meson/meson_drv.h                  |   3 +
 drivers/gpu/drm/meson/meson_plane.c                |   7 +-
 drivers/gpu/drm/nouveau/nouveau_backlight.c        |  10 +-
 drivers/gpu/drm/omapdrm/dss/dss.c                  | 193 +++++++++--------
 drivers/gpu/drm/panel/panel-simple.c               |   2 +-
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c          |  18 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |   7 +-
 drivers/gpu/drm/sun4i/sun4i_dotclock.c             |   5 +-
 drivers/gpu/drm/tegra/drm.c                        |   1 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |  17 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.h                |  25 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |  31 ++-
 drivers/gpu/ipu-v3/ipu-pre.c                       |   3 +
 drivers/gpu/ipu-v3/ipu-prg.c                       |  15 +-
 drivers/hwmon/nct6775.c                            |  10 +-
 drivers/hwmon/pmbus/adm1275.c                      |   4 +-
 drivers/hwmon/pmbus/max8688.c                      |   2 +-
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |   2 +-
 drivers/hwtracing/intel_th/core.c                  |   2 +-
 drivers/i2c/busses/i2c-mv64xxx.c                   |   8 +-
 drivers/ide/ide-cd.c                               |   2 +
 drivers/infiniband/core/multicast.c                |  26 ++-
 drivers/infiniband/core/rdma_core.c                |   5 +-
 drivers/infiniband/core/sa_query.c                 |   7 +-
 drivers/infiniband/core/ucma.c                     |   2 +-
 drivers/infiniband/core/umem.c                     |   7 +-
 drivers/infiniband/core/uverbs_ioctl.c             |   3 +
 drivers/infiniband/core/uverbs_ioctl_merge.c       |  18 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |  24 ++-
 drivers/infiniband/hw/bnxt_re/main.c               |  10 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |   6 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h         |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |   3 +-
 drivers/infiniband/hw/bnxt_re/roce_hsi.h           |  25 ++-
 drivers/infiniband/hw/hfi1/chip.c                  |   4 +
 drivers/infiniband/hw/mlx4/cq.c                    |   4 +-
 drivers/infiniband/hw/mlx4/main.c                  |  11 +-
 drivers/infiniband/hw/mlx5/cq.c                    |   3 +-
 drivers/infiniband/hw/mlx5/main.c                  |   3 +
 drivers/infiniband/hw/mlx5/qp.c                    |   4 +-
 drivers/infiniband/hw/qedr/main.c                  |   3 +-
 drivers/infiniband/hw/qedr/verbs.c                 |  58 +++--
 drivers/infiniband/sw/rxe/rxe_verbs.c              |   2 +-
 drivers/iommu/amd_iommu.c                          |   2 +
 drivers/iommu/mtk_iommu.c                          |  15 +-
 drivers/iommu/mtk_iommu.h                          |   1 +
 drivers/macintosh/rack-meter.c                     |   4 +-
 drivers/md/bcache/request.c                        |   2 +-
 drivers/md/bcache/writeback.c                      |  20 +-
 drivers/md/md.c                                    |  49 ++++-
 drivers/md/md.h                                    |   2 +
 drivers/md/raid1.c                                 |  11 +
 drivers/md/raid10.c                                |  14 +-
 drivers/md/raid5.c                                 |  15 +-
 drivers/misc/cxl/cxl.h                             |   4 +
 drivers/misc/cxl/native.c                          |  11 +-
 drivers/misc/cxl/pci.c                             |  19 +-
 drivers/mmc/host/sdhci-iproc.c                     |  33 ++-
 drivers/net/bonding/bond_main.c                    |   6 +-
 drivers/net/can/m_can/m_can.c                      |   7 +-
 drivers/net/dsa/Makefile                           |   5 +-
 drivers/net/dsa/mt7530.c                           |   1 +
 drivers/net/ethernet/broadcom/bgmac.c              |   3 +-
 drivers/net/ethernet/broadcom/bgmac.h              |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   3 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |  12 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c     |   1 +
 drivers/net/ethernet/cisco/enic/enic_main.c        |  10 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |  23 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   2 +-
 drivers/net/ethernet/freescale/fman/fman_dtsec.c   |   2 +-
 drivers/net/ethernet/freescale/gianfar.c           |   7 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |  42 +++-
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |   2 +-
 drivers/net/ethernet/intel/e1000e/mac.c            |   2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  11 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   3 +-
 drivers/net/ethernet/marvell/mvneta.c              |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   2 -
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   3 +-
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.h   |  20 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |   8 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |   1 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_cxt.c          |   5 +-
 drivers/net/ethernet/qlogic/qed/qed_rdma.c         |   1 +
 drivers/net/ethernet/qlogic/qede/qede_fp.c         |  20 +-
 drivers/net/ethernet/qualcomm/emac/emac-mac.c      |  23 +-
 drivers/net/ethernet/renesas/sh_eth.c              |   6 +-
 drivers/net/ethernet/renesas/sh_eth.h              |   1 +
 drivers/net/ethernet/smsc/smsc911x.c               |   4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  16 +-
 drivers/net/ethernet/sun/sunvnet.c                 |   2 +-
 drivers/net/hyperv/netvsc.c                        |   2 +-
 drivers/net/hyperv/netvsc_drv.c                    |  51 ++++-
 drivers/net/hyperv/rndis_filter.c                  |  20 +-
 drivers/net/ieee802154/ca8210.c                    |  14 +-
 drivers/net/macsec.c                               |   5 +-
 drivers/net/macvlan.c                              |   2 +-
 drivers/net/phy/dp83640.c                          |  18 ++
 drivers/net/usb/lan78xx.c                          |  44 ++--
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/usb/r8152.c                            |   2 +-
 drivers/net/usb/smsc75xx.c                         |   7 +-
 drivers/net/virtio_net.c                           |   4 +-
 drivers/net/wireless/ath/ath10k/mac.c              |  12 ++
 drivers/net/wireless/ath/ath9k/common-spectral.c   |  12 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   2 +-
 .../net/wireless/intel/iwlwifi/fw/api/time-event.h |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  13 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |   3 +
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  54 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   8 +
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |  28 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |  39 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       | 107 +++++-----
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |  21 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  23 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |  11 +-
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |  32 ++-
 drivers/net/wireless/rsi/rsi_sdio.h                |   2 +
 drivers/nvme/host/fabrics.c                        |   4 +-
 drivers/nvme/host/pci.c                            |  27 ++-
 drivers/nvme/target/core.c                         |   9 +-
 drivers/parisc/lba_pci.c                           |  20 +-
 drivers/pci/pci-driver.c                           |  17 +-
 drivers/pci/quirks.c                               |   3 +
 drivers/pcmcia/cs.c                                |  10 +-
 drivers/pcmcia/cs_internal.h                       |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp.c                |   4 +-
 drivers/phy/rockchip/phy-rockchip-emmc.c           |  27 ++-
 drivers/pinctrl/devicetree.c                       |   6 +-
 drivers/pinctrl/pinctrl-mcp23s08.c                 |  37 +++-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c               |  40 ++--
 drivers/power/supply/ltc2941-battery-gauge.c       |   8 +-
 drivers/power/supply/max17042_battery.c            |   1 +
 drivers/regulator/gpio-regulator.c                 |  16 +-
 drivers/regulator/of_regulator.c                   |   1 +
 drivers/remoteproc/imx_rproc.c                     |   6 +-
 drivers/s390/block/dasd.c                          |  21 +-
 drivers/s390/cio/device_fsm.c                      |   7 +-
 drivers/s390/cio/device_ops.c                      |  72 +++----
 drivers/s390/cio/io_sch.h                          |   1 +
 drivers/s390/cio/vfio_ccw_fsm.c                    |   5 +
 drivers/scsi/scsi_lib.c                            |   2 +
 drivers/scsi/sr.c                                  |  21 +-
 drivers/scsi/sr_ioctl.c                            |  10 +-
 drivers/soc/imx/gpc.c                              |  10 +-
 drivers/soc/qcom/wcnss_ctrl.c                      |   2 +-
 drivers/spi/spi-bcm-qspi.c                         |   4 +-
 drivers/usb/host/pci-quirks.c                      | 109 ++++++++++
 drivers/usb/host/pci-quirks.h                      |   5 +
 drivers/usb/host/xhci-hub.c                        |   7 +
 drivers/usb/host/xhci-pci.c                        |  11 +
 drivers/usb/host/xhci.h                            |   2 +-
 drivers/video/fbdev/sbuslib.c                      |   4 +-
 drivers/watchdog/asm9260_wdt.c                     |   8 +-
 drivers/watchdog/aspeed_wdt.c                      |  13 +-
 drivers/watchdog/davinci_wdt.c                     |  15 +-
 drivers/watchdog/dw_wdt.c                          |  23 +-
 drivers/watchdog/f71808e_wdt.c                     |   3 +-
 drivers/watchdog/sbsa_gwdt.c                       |   3 +-
 drivers/xen/events/events_base.c                   |   4 +-
 drivers/xen/pvcalls-back.c                         |   2 +-
 drivers/xen/swiotlb-xen.c                          |   2 +-
 drivers/xen/xen-acpi-processor.c                   |   6 +-
 drivers/xen/xenbus/xenbus_probe.c                  |   5 +-
 drivers/zorro/zorro.c                              |  12 ++
 fs/affs/namei.c                                    |  10 +-
 fs/aio.c                                           |   4 +-
 fs/btrfs/ctree.h                                   |   2 +-
 fs/btrfs/disk-io.c                                 |   5 +-
 fs/btrfs/extent-tree.c                             |   1 +
 fs/btrfs/inode.c                                   |  16 +-
 fs/btrfs/send.c                                    |   3 +
 fs/btrfs/super.c                                   |   2 +-
 fs/btrfs/tests/qgroup-tests.c                      |   2 +-
 fs/btrfs/transaction.c                             |  10 +-
 fs/btrfs/tree-log.c                                |  77 ++++++-
 fs/ceph/super.c                                    |  27 ++-
 fs/dcache.c                                        |  32 ++-
 fs/ecryptfs/inode.c                                |   3 +-
 fs/ext2/namei.c                                    |   6 +-
 fs/ext4/namei.c                                    |   6 +-
 fs/ext4/super.c                                    |  12 ++
 fs/f2fs/checkpoint.c                               |   2 +
 fs/f2fs/extent_cache.c                             |   3 +
 fs/f2fs/file.c                                     |   8 +-
 fs/f2fs/namei.c                                    |  12 +-
 fs/fscache/page.c                                  |  13 +-
 fs/gfs2/file.c                                     |   5 +-
 fs/gfs2/quota.h                                    |   2 +
 fs/jffs2/dir.c                                     |  12 +-
 fs/jfs/namei.c                                     |  12 +-
 fs/nfs/nfs4client.c                                |   6 +-
 fs/nilfs2/namei.c                                  |   6 +-
 fs/ocfs2/dlm/dlmdomain.c                           |  14 --
 fs/ocfs2/dlm/dlmdomain.h                           |  25 ++-
 fs/ocfs2/dlm/dlmrecovery.c                         |   9 +
 fs/orangefs/namei.c                                |   9 +-
 fs/proc/proc_sysctl.c                              |   3 +
 fs/reiserfs/namei.c                                |  12 +-
 fs/super.c                                         |  30 ++-
 fs/udf/namei.c                                     |   6 +-
 fs/udf/super.c                                     |   5 +-
 fs/ufs/namei.c                                     |   6 +-
 fs/xfs/xfs_discard.c                               |  14 +-
 include/asm-generic/bug.h                          |   1 +
 include/linux/bio.h                                |   4 +-
 include/linux/compiler-gcc.h                       |  15 +-
 include/linux/compiler.h                           |   5 +
 include/linux/dcache.h                             |   1 +
 include/linux/if_vlan.h                            |  79 +++++--
 include/linux/kvm_host.h                           |   3 +-
 include/linux/ptr_ring.h                           |   2 +-
 include/net/ip.h                                   |  11 +-
 include/net/ip_fib.h                               |   1 +
 include/net/llc_conn.h                             |   2 +-
 include/net/mac80211.h                             |   2 +-
 include/net/regulatory.h                           |   2 +-
 include/net/route.h                                |   3 +-
 include/rdma/ib_umem.h                             |   1 -
 include/soc/arc/mcip.h                             |   5 +
 include/uapi/drm/virtgpu_drm.h                     |   1 +
 include/uapi/linux/if_ether.h                      |   1 +
 ipc/shm.c                                          |  19 +-
 kernel/audit.c                                     |   2 +
 kernel/debug/kdb/kdb_main.c                        |  27 ++-
 kernel/events/core.c                               |  70 ++++--
 kernel/rcu/tree_plugin.h                           |  14 +-
 kernel/relay.c                                     |   2 +-
 kernel/sched/rt.c                                  |   2 +
 kernel/sys.c                                       |   2 +
 kernel/workqueue.c                                 |   2 +-
 lib/radix-tree.c                                   |   4 +-
 lib/test_kmod.c                                    |   2 +-
 mm/huge_memory.c                                   |   5 +-
 mm/kasan/kasan.c                                   |  66 +++++-
 mm/khugepaged.c                                    |   8 +-
 mm/kmemleak.c                                      |  12 +-
 mm/ksm.c                                           |  28 +++
 mm/mempolicy.c                                     |   3 +
 mm/page_idle.c                                     |  12 +-
 mm/page_owner.c                                    |   6 +-
 mm/slab.c                                          |   1 +
 mm/swapfile.c                                      |   4 +
 mm/vmscan.c                                        |   8 +-
 mm/vmstat.c                                        |   2 +
 mm/z3fold.c                                        |   9 +-
 net/8021q/vlan_core.c                              |   4 +-
 net/batman-adv/bat_iv_ogm.c                        |   2 +-
 net/batman-adv/bat_v.c                             |   2 +-
 net/batman-adv/bridge_loop_avoidance.c             |  22 +-
 net/batman-adv/distributed-arp-table.c             |   2 +-
 net/batman-adv/fragmentation.c                     |   3 +-
 net/batman-adv/gateway_client.c                    |   5 +-
 net/batman-adv/multicast.c                         |   8 +-
 net/batman-adv/routing.c                           |  15 +-
 net/batman-adv/soft-interface.c                    |   8 +-
 net/bridge/netfilter/ebtables.c                    |  33 ++-
 net/ceph/ceph_common.c                             |   7 +
 net/core/ethtool.c                                 |   5 +-
 net/core/skbuff.c                                  |   9 +-
 net/ipv4/ip_gre.c                                  |   5 -
 net/ipv4/ip_tunnel.c                               |   8 +-
 net/ipv4/ip_vti.c                                  |   2 -
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |  15 +-
 net/ipv4/route.c                                   |  26 ++-
 net/ipv4/tcp_illinois.c                            |   2 +-
 net/ipv4/xfrm4_policy.c                            |   1 +
 net/ipv6/ip6_tunnel.c                              |  12 +-
 net/ipv6/ip6_vti.c                                 |   2 +-
 net/ipv6/sit.c                                     |   7 +
 net/llc/llc_c_ac.c                                 |  15 +-
 net/llc/llc_conn.c                                 |  32 ++-
 net/mac80211/agg-rx.c                              |   4 +-
 net/mac80211/ieee80211_i.h                         |   2 +-
 net/mac80211/mesh.c                                |  17 +-
 net/mac80211/rx.c                                  |   2 +-
 net/mac80211/spectmgmt.c                           |   7 +-
 net/mac80211/sta_info.c                            |   3 +-
 net/netfilter/ipvs/ip_vs_ftp.c                     |   2 +-
 net/netlabel/netlabel_unlabeled.c                  |  10 +
 net/nfc/llcp_commands.c                            |   4 +
 net/nfc/netlink.c                                  |   3 +-
 net/qrtr/smd.c                                     |   1 +
 net/rds/tcp_listen.c                               |  14 +-
 net/rxrpc/input.c                                  |  15 +-
 net/rxrpc/recvmsg.c                                |   5 +-
 net/rxrpc/sendmsg.c                                |   4 +-
 net/sched/act_bpf.c                                |   2 +-
 net/sched/act_ipt.c                                |   9 +-
 net/sched/act_pedit.c                              |   2 +-
 net/sched/act_police.c                             |   2 +-
 net/sched/act_sample.c                             |   3 +-
 net/sched/act_simple.c                             |   2 +-
 net/sched/act_skbmod.c                             |   2 +-
 net/smc/smc_core.c                                 |   1 +
 net/smc/smc_ib.c                                   |  10 +-
 net/smc/smc_llc.c                                  |   2 +-
 net/smc/smc_wr.h                                   |   1 -
 net/tls/tls_main.c                                 |   3 +-
 net/wireless/sme.c                                 |   2 +
 net/xfrm/xfrm_input.c                              |   6 +
 net/xfrm/xfrm_output.c                             |   5 +-
 net/xfrm/xfrm_policy.c                             |   7 +-
 net/xfrm/xfrm_replay.c                             |   2 +-
 scripts/adjust_autoksyms.sh                        |   7 +
 scripts/package/builddeb                           |   2 +-
 security/integrity/digsig.c                        |   1 +
 security/integrity/ima/Kconfig                     |   1 +
 security/integrity/ima/ima_crypto.c                |   2 +
 security/integrity/ima/ima_main.c                  |  13 ++
 sound/core/timer.c                                 |   4 +-
 sound/core/vmaster.c                               |   5 +-
 tools/hv/hv_fcopy_daemon.c                         |   3 +-
 tools/hv/hv_vss_daemon.c                           |   1 +
 tools/perf/Makefile.perf                           |   3 +-
 tools/perf/builtin-record.c                        |   9 +
 tools/perf/builtin-stat.c                          |   9 +-
 tools/perf/builtin-top.c                           |   6 +-
 tools/perf/perf.h                                  |   1 +
 tools/perf/tests/dwarf-unwind.c                    |  46 ++--
 .../perf/tests/shell/trace+probe_libc_inet_pton.sh |   6 +-
 tools/perf/tests/vmlinux-kallsyms.c                |   2 +-
 tools/perf/ui/browsers/annotate.c                  |   9 +-
 tools/perf/util/c++/clang.cpp                      |  11 +-
 tools/perf/util/hist.c                             |   4 +-
 tools/perf/util/hist.h                             |   1 -
 tools/perf/util/record.c                           |   8 +-
 tools/testing/radix-tree/idr-test.c                |   7 +
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/bpf/test_maps.c            |   2 +
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |  46 ++++
 .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     |  97 +++++++++
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |  43 ++++
 tools/testing/selftests/futex/Makefile             |   6 +-
 tools/testing/selftests/memfd/Makefile             |   1 +
 tools/testing/selftests/memfd/config               |   1 +
 tools/testing/selftests/net/psock_fanout.c         |   3 +-
 tools/testing/selftests/powerpc/mm/subpage_prot.c  |  14 ++
 tools/testing/selftests/pstore/config              |   1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c      |  61 ++++++
 tools/testing/selftests/sync/Makefile              |   2 +-
 tools/testing/selftests/vDSO/Makefile              |  14 +-
 tools/testing/selftests/vm/run_vmtests             |  25 ++-
 tools/thermal/tmon/sysfs.c                         |  12 +-
 tools/thermal/tmon/tmon.c                          |   1 -
 virt/kvm/arm/vgic/vgic-mmio.c                      |   3 +
 virt/kvm/arm/vgic/vgic.h                           |   1 +
 506 files changed, 4741 insertions(+), 1751 deletions(-)
