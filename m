Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423292AbeE1MKO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1165013AbeE1LEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:04:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.16 000/272] 4.16.13-stable review
Date: Mon, 28 May 2018 12:00:33 +0200
Message-Id: <20180528100240.256525891@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.13-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.16.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.16.13-rc1
X-KernelTest-Deadline: 2018-05-30T10:03+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.16.13 release.
There are 272 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed May 30 10:01:02 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.13-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.16.13-rc1

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

Heiner Kallweit <hkallweit1@gmail.com>
    soc: amlogic: meson-gx-pwrc-vpu: fix error on shutdown when domain is powered off

Charles Keepax <ckeepax@opensource.cirrus.com>
    regmap: Correct comparison in regmap_cached

Peter Rosin <peda@axentia.se>
    ARM: dts: at91: tse850: use the correct compatible for the eeprom

Peter Rosin <peda@axentia.se>
    ARM: dts: at91: nattis: use the correct compatible for the eeprom

David Ahern <dsahern@gmail.com>
    selftests: Add FIB onlink tests

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    drm: rcar-du: lvds: Fix LVDS startup on R-Car Gen2

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    drm: rcar-du: lvds: Fix LVDS startup on R-Car Gen3

Richard Haines <richard_c_haines@btinternet.com>
    netlabel: If PF_INET6, check sk_buff ip header version

Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
    drm/vblank: Data type fixes for 64-bit vblank sequences.

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

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    soc: renesas: r8a77970-sysc: fix power area parents

Joe Perches <joe@perches.com>
    MIPS: Octeon: Fix logging messages with spurious periods after newlines

Jake Moroni <mail@jakemoroni.com>
    dpaa_eth: fix pause capability advertisement logic

Tao <xtao@amd.com>
    drm/amd/display: Set vsc pack revision when DPCD revision is >= 1.2

Archit Taneja <architt@codeaurora.org>
    dt-bindings: display: msm/dsi: Fix the PHY regulator supply props

Takeshi Kihara <takeshi.kihara.df@renesas.com>
    pinctrl: sh-pfc: r8a7796: Fix MOD_SEL register pin assignment for SSI pins group

Tejun Heo <tj@kernel.org>
    rcu: Call touch_nmi_watchdog() while printing stall warnings

Niklas Cassel <niklas.cassel@axis.com>
    net: stmmac: call correct function in stmmac_mac_config_rx_queues_routing()

Richard Guy Briggs <rgb@redhat.com>
    audit: return on memory error to avoid null pointer dereference

Stefan Wahren <stefan.wahren@i2se.com>
    hwrng: bcm2835 - Handle deferred clock properly

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
    fanotify: Avoid lost events due to ENOMEM for unlimited queues

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

Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
    ibmvnic: Allocate statistics buffers during probe

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

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/mm/slice: Fix hugepage allocation at hint address on 8xx

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/mm/slice: Enhance for supporting PPC32

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/mm/slice: create header files dedicated to slices

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/mm/slice: Remove intermediate bitmap copy

Suman Anna <s-anna@ti.com>
    ARM: dts: keystone-k2e-clocks: Fix missing unit address separator

Qi Hou <qi.hou@windriver.com>
    dmaengine: pl330: fix a race condition in case of threaded irqs

Ming Lei <ming.lei@redhat.com>
    block: null_blk: fix 'Invalid parameters' when loading module

Dexuan Cui <decui@microsoft.com>
    tools: hv: fix compiler warnings about major/target_fname

Emily Deng <Emily.Deng@amd.com>
    drm/amdgpu: Clean sdma wptr register when only enable wptr polling

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

Gao Xiang <hsiangkao@aol.com>
    f2fs: flush cp pack except cp pack 2 page at first

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

Alexey Khoroshilov <khoroshilov@ispras.ru>
    watchdog: sprd_wdt: Fix error handling in sprd_wdt_enable()

Rafael J. Wysocki <rjw@rjwysocki.net>
    PCI: Restore config space on runtime resume despite being unbound

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
    powerpc/vas: Fix cleanup when VAS is not configured

Mathias Kresin <dev@kresin.me>
    MIPS: ath79: Fix AR724X_PLL_REG_PCIE_CONFIG offset

Ursula Braun <ubraun@linux.vnet.ibm.com>
    net/smc: pay attention to MAX_ORDER for CQ entries

Christophe Jaillet <christophe.jaillet@wanadoo.fr>
    spi: bcm-qspi: fIX some error handling paths

Christophe Jaillet <christophe.jaillet@wanadoo.fr>
    regulator: gpio: Fix some error handling paths in 'gpio_regulator_probe()'

John Allen <jallen@linux.vnet.ibm.com>
    ibmvnic: Fix reset return from closed state

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

Coly Li <colyli@suse.de>
    bcache: stop dc->writeback_rate_update properly

Bob Moore <robert.moore@intel.com>
    ACPICA: Fix memory leak on unusual memory leak

Erik Schmauss <erik.schmauss@intel.com>
    ACPICA: Events: add a return on failure from acpi_hw_register_read

Coly Li <colyli@suse.de>
    bcache: fix cached_dev->count usage for bch_cache_set_error()

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

Luis R. Rodriguez <mcgrof@kernel.org>
    firmware: fix checking for return values for fw_add_devm_name()

Chunyu Hu <chuhu@redhat.com>
    cpufreq: cppc_cpufreq: Fix cppc_cpufreq_init() failure path

Yong Wu <yong.wu@mediatek.com>
    iommu/mediatek: Fix protect memory setting

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Unpin the screen object backup buffer when not used

Eric Sandeen <sandeen@redhat.com>
    ext4: don't complain about incorrect features when probing

Mimi Zohar <zohar@linux.vnet.ibm.com>
    ima: clear IMA_HASH

Philipp Puschmann <pp@emlix.com>
    arm: dts: socfpga: fix GIC PPI warning

Jay Vosburgh <jay.vosburgh@canonical.com>
    virtio-net: Fix operstate for virtio when no VIRTIO_NET_F_STATUS

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Check for the end of metadata in punch_hole

Milton Miller <miltonm@us.ibm.com>
    watchdog: aspeed: Allow configuring for alternate boot

Petr Vorel <pvorel@suse.cz>
    ima: Fallback to the builtin hash algorithm

Jiandi An <anjiandi@codeaurora.org>
    ima: Fix Kconfig to select TPM 2.0 CRB interface

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Fix the return status in RX path

Arjun Vynipadath <arjun@chelsio.com>
    cxgb4: Setup FW queues before registering netdev

Anand Jain <anand.jain@oracle.com>
    btrfs: fix null pointer deref when target device is missing

Sebastian Gottschall <s.gottschall@dd-wrt.com>
    ath9k: fix crash in spectral scan

Jarosław Janik <jaroslaw.janik@gmail.com>
    nvme-pci: disable APST for Samsung NVMe SSD 960 EVO + ASUS PRIME Z370-A

James Smart <jsmart2021@gmail.com>
    nvme_fc: fix abort race on teardown with lld reject

Karthikeyan Periyasamy <periyasa@codeaurora.org>
    ath10k: Fix kernel panic while using worker (ath10k_sta_rc_update_wk)

Colin Ian King <colin.king@canonical.com>
    net: qualcomm: rmnet: check for null ep to avoid null pointer dereference

Fuyun Liang <liangfuyun1@huawei.com>
    net: hns3: fix for returning wrong value problem in hns3_get_rss_key_size

Fuyun Liang <liangfuyun1@huawei.com>
    net: hns3: fix for returning wrong value problem in hns3_get_rss_indir_size

Fuyun Liang <liangfuyun1@huawei.com>
    net: hns3: fix for the wrong shift problem in hns3_set_txbd_baseinfo

Alexey Khoroshilov <khoroshilov@ispras.ru>
    watchdog: davinci_wdt: fix error handling in davinci_wdt_probe()

Leon Romanovsky <leonro@mellanox.com>
    net/mlx5: Protect from command bit overflow

Jacob Keller <jacob.e.keller@intel.com>
    i40e: hold the RTNL lock while changing interrupt schemes

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

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    mt76x2: fix warning in ieee80211_get_key_rx_seq()

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    mt76x2: fix possible NULL pointer dereferencing in mt76x2_tx()

Guenter Roeck <linux@roeck-us.net>
    hwmon: (nct6775) Fix writing pwmX_mode

Kan Liang <kan.liang@linux.intel.com>
    perf mmap: Fix accessing unmapped mmap in perf_mmap__read_done()

Helge Deller <deller@gmx.de>
    parisc/pci: Switch LBA PCI bus from Hard Fail to Soft Fail mode

Eran Ben Elisha <eranbe@mellanox.com>
    net/mlx5e: Move all TX timeout logic to be under state lock

Sara Sharon <sara.sharon@intel.com>
    iwlwifi: mvm: take RCU lock before dereferencing

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

Marc Dionne <marc.dionne@auristor.com>
    rxrpc: Fix resend event time calculation

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

Scott Branden <scott.branden@broadcom.com>
    bnxt_en: fix clear flags in ethtool reset handling

Florian Fainelli <f.fainelli@gmail.com>
    net: bgmac: Correctly annotate register space

Florian Fainelli <f.fainelli@gmail.com>
    net: bgmac: Fix endian access in bgmac_dma_tx_ring_free()

Dan Carpenter <dan.carpenter@oracle.com>
    platform/x86: dell-smbios: Fix memory leaks in build_tokens_sysfs()

Andrea Parri <parri.andrea@gmail.com>
    riscv/spinlock: Strengthen implementations with fences

David S. Miller <davem@davemloft.net>
    sparc64: Make atomic_xchg() an inline function rather than a macro.

Geert Uytterhoeven <geert+renesas@glider.be>
    dmaengine: rcar-dmac: Fix too early/late system suspend/resume callbacks

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

Thomas Gleixner <tglx@linutronix.de>
    genirq/affinity: Don't return with empty affinity masks on error

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

Andrey Konovalov <andreyknvl@google.com>
    kasan, slub: fix handling of kasan_slab_free hook

Andrey Konovalov <andreyknvl@google.com>
    kasan: fix invalid-free test crashing the kernel

Danilo Krummrich <danilokrummrich@dk-develop.de>
    fs/proc/proc_sysctl.c: fix potential page fault while unregistering sysctl table

James Smart <jsmart2021@gmail.com>
    nvme: expand nvmf_check_if_ready checks

Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
    bnxt_en: Ignore src port field in decap filter nodes

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

Pascal Roeleven <dev@pascalroeleven.nl>
    ARM: dts: sun4i: Fix incorrect clocks for displays

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

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PM / core: Fix direct_complete handling for devices with no callbacks

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

Rafał Miłecki <rafal@milecki.pl>
    bcma: fix buffer size caused crash in bcma_core_mips_print_irq()

Jens Axboe <axboe@kernel.dk>
    sr: pass down correctly sized SCSI sense buffer

Lidong Chen <jemmy858585@gmail.com>
    IB/umem: Use the correct mm during ib_umem_release

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Use after free race condition in send context error path

Michael Neuling <mikey@neuling.org>
    powerpc/64s: Clear PCR on boot

Jason A. Donenfeld <Jason@zx2c4.com>
    arm64: export tishift functions to modules

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

Mika Westerberg <mika.westerberg@linux.intel.com>
    ahci: Add PCI ID for Cannon Lake PCH-LP AHCI

Corneliu Doban <corneliu.doban@broadcom.com>
    mmc: sdhci-iproc: add SDHCI_QUIRK2_HOST_OFF_CARD_ON for cygnus

Corneliu Doban <corneliu.doban@broadcom.com>
    mmc: sdhci-iproc: fix 32bit writes for TRANSFER_MODE register

Srinath Mannam <srinath.mannam@broadcom.com>
    mmc: sdhci-iproc: remove hard coded mmc cap 1.8v

Mathieu Malaterre <malat@debian.org>
    mmc: block: propagate correct returned value in mmc_rpmb_ioctl

Al Viro <viro@zeniv.linux.org.uk>
    do d_instantiate/unlock_new_inode combinations safely

Ben Hutchings <ben.hutchings@codethink.co.uk>
    ALSA: timer: Fix pause event notification

Omar Sandoval <osandov@fb.com>
    Btrfs: fix error handling in btrfs_truncate()

Al Viro <viro@zeniv.linux.org.uk>
    aio: fix io_destroy(2) vs. lookup_ioctx() race

Dave Chinner <dchinner@redhat.com>
    fs: don't scan the inode cache before SB_BORN is set

Al Viro <viro@zeniv.linux.org.uk>
    fix breakage caused by d_find_alias() semantics change

Al Viro <viro@zeniv.linux.org.uk>
    affs_lookup(): close a race with affs_remove_link()

Colin Ian King <colin.king@canonical.com>
    KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"

Maciej W. Rozycki <macro@mips.com>
    MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR accesses to o32 FGRs

Maciej W. Rozycki <macro@mips.com>
    MIPS: ptrace: Expose FIR register through FP regset

Paul Cercueil <paul@crapouillou.net>
    MIPS: Fix build with DEBUG_ZBOOT and MACH_JZ4770

NeilBrown <neil@brown.name>
    MIPS: c-r4k: Fix data corruption related to cache coherence

Alexandre Belloni <alexandre.belloni@bootlin.com>
    MIPS: xilfpga: Actually include FDT in fitImage

Alexandre Belloni <alexandre.belloni@bootlin.com>
    MIPS: xilfpga: Stop generating useless dtb.o


-------------

Diffstat:

 .../devicetree/bindings/clock/sunxi-ccu.txt        |   4 +
 .../devicetree/bindings/display/msm/dsi.txt        |   4 +
 .../bindings/pinctrl/axis,artpec6-pinctrl.txt      |   5 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts        |   2 +-
 arch/arm/boot/dts/at91-tse850-3.dts                |   2 +-
 arch/arm/boot/dts/bcm283x.dtsi                     |   6 +-
 arch/arm/boot/dts/dra71-evm.dts                    |   4 +-
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts            |  52 +--
 arch/arm/boot/dts/keystone-k2e-clocks.dtsi         |   2 +-
 arch/arm/boot/dts/r8a7791-porter.dts               |   2 +-
 arch/arm/boot/dts/socfpga.dtsi                     |   2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                   |   6 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   4 +-
 arch/arm64/include/asm/atomic_lse.h                |  24 +-
 arch/arm64/kernel/arm64ksyms.c                     |   8 +
 arch/arm64/lib/tishift.S                           |  15 +-
 arch/m68k/coldfire/device.c                        |  12 +-
 arch/mips/boot/compressed/uart-16550.c             |   6 +-
 arch/mips/boot/dts/xilfpga/Makefile                |   2 -
 arch/mips/cavium-octeon/octeon-irq.c               |  10 +-
 arch/mips/generic/Platform                         |   1 +
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h     |   2 +-
 arch/mips/kernel/ptrace.c                          |  22 +-
 arch/mips/kernel/ptrace32.c                        |   4 +-
 arch/mips/kvm/mips.c                               |   2 +-
 arch/mips/mm/c-r4k.c                               |   9 +-
 arch/powerpc/include/asm/book3s/64/slice.h         |  27 ++
 arch/powerpc/include/asm/irq_work.h                |   1 +
 arch/powerpc/include/asm/mmu-8xx.h                 |   6 +
 arch/powerpc/include/asm/nohash/32/slice.h         |  18 +
 arch/powerpc/include/asm/nohash/64/slice.h         |  12 +
 arch/powerpc/include/asm/page.h                    |   1 +
 arch/powerpc/include/asm/page_64.h                 |  59 ----
 arch/powerpc/include/asm/slice.h                   |  42 +++
 arch/powerpc/kernel/cpu_setup_power.S              |   6 +
 arch/powerpc/kernel/dt_cpu_ftrs.c                  |   1 +
 arch/powerpc/kernel/idle_book3s.S                  |   2 +
 arch/powerpc/kernel/setup-common.c                 |   2 +
 arch/powerpc/kernel/traps.c                        |  47 ++-
 arch/powerpc/mm/8xx_mmu.c                          |   2 +-
 arch/powerpc/mm/hugetlbpage.c                      |   2 +
 arch/powerpc/mm/mmu_context_nohash.c               |  18 +-
 arch/powerpc/mm/slice.c                            |  49 ++-
 arch/powerpc/perf/core-book3s.c                    |  25 ++
 arch/powerpc/platforms/Kconfig.cputype             |   1 +
 arch/powerpc/platforms/powernv/npu-dma.c           | 229 ++++++++-----
 arch/powerpc/platforms/powernv/vas-debug.c         |  11 +
 arch/powerpc/platforms/powernv/vas.c               |   6 +-
 arch/powerpc/sysdev/mpic.c                         |   2 +-
 arch/riscv/include/asm/fence.h                     |  12 +
 arch/riscv/include/asm/spinlock.h                  |  29 +-
 arch/s390/kvm/vsie.c                               |   2 +-
 arch/sh/kernel/entry-common.S                      |   2 +-
 arch/sparc/include/asm/atomic_64.h                 |   6 +-
 arch/x86/events/core.c                             |  15 +-
 arch/x86/events/intel/core.c                       |  12 +-
 arch/x86/events/intel/ds.c                         |  92 ++++-
 arch/x86/events/perf_event.h                       |   2 +-
 arch/x86/include/asm/tlbflush.h                    |   7 +-
 arch/x86/kernel/apic/apic.c                        |   2 +-
 arch/x86/kernel/devicetree.c                       |  21 +-
 arch/x86/kvm/cpuid.c                               |   9 +-
 arch/x86/kvm/lapic.c                               |  26 +-
 arch/x86/kvm/vmx.c                                 |  20 +-
 arch/x86/kvm/x86.c                                 |   5 +-
 arch/x86/mm/pageattr.c                             |   6 +-
 arch/x86/mm/pgtable.c                              |   9 +
 drivers/acpi/acpi_pad.c                            |   3 +
 drivers/acpi/acpica/evevent.c                      |   9 +-
 drivers/acpi/acpica/nseval.c                       |   8 +
 drivers/acpi/acpica/psargs.c                       |   4 +
 drivers/ata/ahci.c                                 |   1 +
 drivers/ata/libata-core.c                          |   6 +
 drivers/base/firmware_class.c                      |  12 +-
 drivers/base/power/main.c                          |   7 +-
 drivers/base/regmap/regmap.c                       |   2 +-
 drivers/bcma/driver_mips.c                         |   2 +-
 drivers/block/null_blk.c                           |  46 +--
 drivers/block/paride/pcd.c                         |   2 +
 drivers/cdrom/cdrom.c                              |   3 -
 drivers/cdrom/gdrom.c                              |   3 +
 drivers/char/hw_random/bcm2835-rng.c               |   2 +
 drivers/char/hw_random/stm32-rng.c                 |   9 +
 drivers/char/ipmi/ipmi_ssif.c                      |   4 +-
 drivers/cpufreq/cppc_cpufreq.c                     |  23 +-
 drivers/cpufreq/cpufreq.c                          |   6 +-
 drivers/dma/pl330.c                                |   6 +-
 drivers/dma/qcom/bam_dma.c                         |  27 +-
 drivers/dma/sh/rcar-dmac.c                         |  13 +-
 drivers/firmware/dmi_scan.c                        |   2 +-
 drivers/firmware/efi/arm-runtime.c                 |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |  33 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |   7 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   4 +-
 drivers/gpu/drm/bridge/sii902x.c                   |  20 +-
 drivers/gpu/drm/drm_vblank.c                       |   8 +-
 drivers/gpu/drm/meson/meson_drv.c                  |  29 +-
 drivers/gpu/drm/omapdrm/dss/dss.c                  | 193 ++++++-----
 drivers/gpu/drm/panel/panel-simple.c               |   2 +-
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c          |  18 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |   7 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.h                |  25 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |  31 +-
 drivers/hwmon/nct6775.c                            |  10 +-
 drivers/hwmon/pmbus/adm1275.c                      |   4 +-
 drivers/hwmon/pmbus/max8688.c                      |   2 +-
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |   2 +-
 drivers/hwtracing/intel_th/core.c                  |   2 +-
 drivers/i2c/busses/i2c-mv64xxx.c                   |   8 +-
 drivers/ide/ide-cd.c                               |   2 +
 drivers/infiniband/core/multicast.c                |  26 +-
 drivers/infiniband/core/umem.c                     |   7 +-
 drivers/infiniband/hw/hfi1/chip.c                  |   4 +
 drivers/infiniband/hw/mlx5/main.c                  |   3 +
 drivers/infiniband/sw/rxe/rxe_verbs.c              |   2 +-
 drivers/iommu/amd_iommu.c                          |   2 +
 drivers/iommu/mtk_iommu.c                          |  15 +-
 drivers/iommu/mtk_iommu.h                          |   1 +
 drivers/macintosh/rack-meter.c                     |   4 +-
 drivers/md/bcache/bcache.h                         |   9 +-
 drivers/md/bcache/super.c                          |  39 ++-
 drivers/md/bcache/sysfs.c                          |   3 +-
 drivers/md/bcache/writeback.c                      |  60 +++-
 drivers/md/bcache/writeback.h                      |   2 -
 drivers/misc/cxl/cxl.h                             |   4 +
 drivers/misc/cxl/native.c                          |  11 +-
 drivers/misc/cxl/pci.c                             |  19 +-
 drivers/mmc/core/block.c                           |   2 +-
 drivers/mmc/host/sdhci-iproc.c                     |  33 +-
 drivers/net/ethernet/broadcom/bgmac.c              |   3 +-
 drivers/net/ethernet/broadcom/bgmac.h              |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   8 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c       |   4 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |  11 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c     |   1 +
 drivers/net/ethernet/cisco/enic/enic_main.c        |  10 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |  23 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   4 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |  30 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  30 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  61 ++--
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |   2 +
 drivers/net/ethernet/renesas/sh_eth.c              |   6 +-
 drivers/net/ethernet/renesas/sh_eth.h              |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  16 +-
 drivers/net/hyperv/netvsc.c                        |   8 +-
 drivers/net/hyperv/netvsc_drv.c                    |   2 +-
 drivers/net/hyperv/rndis_filter.c                  |   4 +-
 drivers/net/ieee802154/ca8210.c                    |  14 +-
 drivers/net/phy/dp83640.c                          |  18 +
 drivers/net/usb/lan78xx.c                          |  34 +-
 drivers/net/virtio_net.c                           |   2 +-
 drivers/net/wireless/ath/ath10k/mac.c              |  12 +
 drivers/net/wireless/ath/ath9k/common-spectral.c   |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |  11 +-
 drivers/net/wireless/mediatek/mt76/mt76x2_main.c   |  11 +
 drivers/net/wireless/mediatek/mt76/mt76x2_tx.c     |   5 +-
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |  32 +-
 drivers/net/wireless/rsi/rsi_sdio.h                |   2 +
 drivers/nvme/host/core.c                           |  17 +-
 drivers/nvme/host/fabrics.c                        |  83 ++++-
 drivers/nvme/host/fabrics.h                        |  33 +-
 drivers/nvme/host/fc.c                             |  17 +-
 drivers/nvme/host/nvme.h                           |   1 +
 drivers/nvme/host/pci.c                            |   7 +-
 drivers/nvme/host/rdma.c                           |  14 +-
 drivers/nvme/target/loop.c                         |  11 +-
 drivers/parisc/lba_pci.c                           |  20 +-
 drivers/pci/pci-driver.c                           |  17 +-
 drivers/pci/quirks.c                               |   3 +
 drivers/pcmcia/cs.c                                |  10 +-
 drivers/pcmcia/cs_internal.h                       |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp.c                |   4 +-
 drivers/phy/rockchip/phy-rockchip-emmc.c           |  27 +-
 drivers/pinctrl/devicetree.c                       |   6 +-
 drivers/pinctrl/pinctrl-mcp23s08.c                 |  37 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c               |  40 +--
 drivers/platform/x86/dell-smbios-base.c            |   4 +-
 drivers/power/supply/ltc2941-battery-gauge.c       |   8 +-
 drivers/power/supply/max17042_battery.c            |   1 +
 drivers/regulator/gpio-regulator.c                 |  16 +-
 drivers/regulator/of_regulator.c                   |   1 +
 drivers/remoteproc/imx_rproc.c                     |   6 +-
 drivers/s390/cio/vfio_ccw_fsm.c                    |   5 +
 drivers/scsi/sr.c                                  |  21 +-
 drivers/scsi/sr_ioctl.c                            |  10 +-
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c            |   6 +-
 drivers/soc/qcom/wcnss_ctrl.c                      |   2 +-
 drivers/soc/renesas/r8a77970-sysc.c                |  12 +-
 drivers/spi/spi-bcm-qspi.c                         |   4 +-
 drivers/watchdog/asm9260_wdt.c                     |   8 +-
 drivers/watchdog/aspeed_wdt.c                      |  13 +-
 drivers/watchdog/davinci_wdt.c                     |  15 +-
 drivers/watchdog/dw_wdt.c                          |  23 +-
 drivers/watchdog/sprd_wdt.c                        |   4 +-
 drivers/xen/swiotlb-xen.c                          |   2 +-
 drivers/xen/xen-acpi-processor.c                   |   6 +-
 drivers/zorro/zorro.c                              |  12 +
 fs/affs/namei.c                                    |  10 +-
 fs/aio.c                                           |   4 +-
 fs/btrfs/dev-replace.c                             |   2 +-
 fs/btrfs/disk-io.c                                 |   5 +-
 fs/btrfs/extent-tree.c                             |   1 +
 fs/btrfs/inode.c                                   |  19 +-
 fs/btrfs/tests/qgroup-tests.c                      |   2 +-
 fs/btrfs/transaction.c                             |  10 +-
 fs/btrfs/tree-log.c                                |  75 ++++-
 fs/dcache.c                                        |  22 ++
 fs/ecryptfs/inode.c                                |   3 +-
 fs/ext2/namei.c                                    |   6 +-
 fs/ext4/namei.c                                    |   6 +-
 fs/ext4/super.c                                    |  12 +
 fs/f2fs/checkpoint.c                               |  71 ++--
 fs/f2fs/extent_cache.c                             |   3 +
 fs/f2fs/file.c                                     |   8 +-
 fs/f2fs/namei.c                                    |  12 +-
 fs/fscache/page.c                                  |  13 +-
 fs/gfs2/bmap.c                                     |  10 +-
 fs/gfs2/file.c                                     |   5 +-
 fs/gfs2/quota.h                                    |   2 +
 fs/jffs2/dir.c                                     |  12 +-
 fs/jfs/namei.c                                     |  12 +-
 fs/nilfs2/namei.c                                  |   6 +-
 fs/notify/fanotify/fanotify.c                      |  19 +-
 fs/notify/fanotify/fanotify.h                      |   3 +-
 fs/notify/fanotify/fanotify_user.c                 |   2 +-
 fs/ocfs2/dlm/dlmdomain.c                           |  14 -
 fs/ocfs2/dlm/dlmdomain.h                           |  25 +-
 fs/ocfs2/dlm/dlmrecovery.c                         |   9 +
 fs/orangefs/namei.c                                |   9 +-
 fs/proc/proc_sysctl.c                              |   3 +
 fs/reiserfs/namei.c                                |  12 +-
 fs/super.c                                         |  30 +-
 fs/udf/namei.c                                     |   6 +-
 fs/udf/super.c                                     |   5 +-
 fs/ufs/namei.c                                     |   6 +-
 fs/xfs/xfs_discard.c                               |  14 +-
 include/drm/drm_vblank.h                           |   2 +-
 include/linux/dcache.h                             |   1 +
 include/rdma/ib_umem.h                             |   1 -
 ipc/shm.c                                          |  19 +-
 kernel/audit.c                                     |   2 +
 kernel/debug/kdb/kdb_main.c                        |  27 +-
 kernel/events/core.c                               |  49 ++-
 kernel/irq/affinity.c                              |  15 +-
 kernel/rcu/tree_plugin.h                           |  14 +-
 kernel/sched/rt.c                                  |   2 +
 kernel/sys.c                                       |   2 +
 lib/radix-tree.c                                   |   4 +-
 lib/test_kasan.c                                   |   8 +
 mm/kasan/kasan.c                                   |  66 +++-
 mm/ksm.c                                           |  28 ++
 mm/page_idle.c                                     |  12 +-
 mm/slub.c                                          |  57 ++--
 mm/swapfile.c                                      |   4 +
 mm/vmscan.c                                        |   8 +-
 mm/z3fold.c                                        |   9 +-
 net/netlabel/netlabel_unlabeled.c                  |  10 +
 net/rxrpc/call_event.c                             |   2 +-
 net/rxrpc/input.c                                  |  15 +-
 net/rxrpc/sendmsg.c                                |   4 +-
 net/smc/smc_ib.c                                   |  10 +-
 net/smc/smc_wr.h                                   |   1 -
 security/integrity/ima/Kconfig                     |   1 +
 security/integrity/ima/ima_crypto.c                |   2 +
 security/integrity/ima/ima_main.c                  |  13 +
 security/integrity/ima/ima_policy.c                |   2 +-
 security/selinux/hooks.c                           |  20 +-
 sound/core/timer.c                                 |   4 +-
 sound/core/vmaster.c                               |   5 +-
 tools/hv/hv_fcopy_daemon.c                         |   3 +-
 tools/hv/hv_vss_daemon.c                           |   1 +
 tools/perf/Makefile.perf                           |   3 +-
 tools/perf/builtin-stat.c                          |   9 +-
 tools/perf/builtin-top.c                           |   6 +-
 tools/perf/tests/dwarf-unwind.c                    |  46 ++-
 .../perf/tests/shell/trace+probe_libc_inet_pton.sh |   6 +-
 tools/perf/tests/vmlinux-kallsyms.c                |   2 +-
 tools/perf/ui/browsers/annotate.c                  |   9 +-
 tools/perf/util/c++/clang.cpp                      |  11 +-
 tools/perf/util/hist.c                             |   4 +-
 tools/perf/util/hist.h                             |   1 -
 tools/perf/util/mmap.c                             |   6 +
 tools/testing/radix-tree/idr-test.c                |   7 +
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/net/fib-onlink-tests.sh    | 375 +++++++++++++++++++++
 tools/testing/selftests/net/psock_fanout.c         |   3 +-
 tools/thermal/tmon/sysfs.c                         |  12 +-
 tools/thermal/tmon/tmon.c                          |   1 -
 298 files changed, 3076 insertions(+), 1191 deletions(-)
