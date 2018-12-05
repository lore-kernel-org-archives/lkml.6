Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD202C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A67620892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039230;
	bh=pStx4zmpxPGal1exhw2qcUTspo2kJfrUaXA6Uj0OB9U=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=dsWX2xdjkF6zUP6eL4Vgy44Xr3/FAjy58bW2ZO3vIKNIO9sVSc+x4+G4LSY0PRPAg
	 CCNmQBDR1sDYdAo4CfNi8Ciu5DjRibG2TGVvo+QR0Jo4x2UaYhm+JWVmXQPmQB1iRs
	 bnRvwSvzo1UqBnp6pbkKpdsFIGx3bTGcVBiynB20=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A67620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbeLETrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:47:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbeLETrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:47:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DE2E20892;
        Wed,  5 Dec 2018 19:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544039223;
        bh=pStx4zmpxPGal1exhw2qcUTspo2kJfrUaXA6Uj0OB9U=;
        h=Date:From:To:Cc:Subject:From;
        b=UlDPegDO+p3Ew08fA58ZTcV6Zggf5a91p60ZpWvf+lUM7PqA3yffZmyjg7fEWQVKl
         Lz598r6y8RQyJ2Rqnpk3pmWE7LnJNKd4RDKK4Kk3+ZZKi/0rJIihVJ7uilUiYDbUTe
         /BVnxr2U/MsfW99ygawm7buQJ2V4IlyGt7/vNMB8=
Date:   Wed, 5 Dec 2018 20:47:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.7
Message-ID: <20181205194701.GA20501@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.7 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.19.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt               |   56 +
 Documentation/userspace-api/spec_ctrl.rst                     |    9=20
 Makefile                                                      |    2=20
 arch/arm/boot/dts/rk3288-veyron.dtsi                          |    6=20
 arch/arm/kernel/ftrace.c                                      |   17=20
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts           |    2=20
 arch/arm64/kernel/ftrace.c                                    |   15=20
 arch/microblaze/kernel/ftrace.c                               |   15=20
 arch/mips/kernel/ftrace.c                                     |   14=20
 arch/nds32/kernel/ftrace.c                                    |   18=20
 arch/parisc/kernel/ftrace.c                                   |   17=20
 arch/powerpc/kernel/trace/ftrace.c                            |   15=20
 arch/riscv/kernel/ftrace.c                                    |   14=20
 arch/s390/kernel/ftrace.c                                     |   13=20
 arch/sh/kernel/ftrace.c                                       |   16=20
 arch/sparc/kernel/ftrace.c                                    |   11=20
 arch/x86/Kconfig                                              |   12=20
 arch/x86/Makefile                                             |    5=20
 arch/x86/events/core.c                                        |   20=20
 arch/x86/events/intel/core.c                                  |   56 -
 arch/x86/events/perf_event.h                                  |   13=20
 arch/x86/include/asm/kvm_host.h                               |    3=20
 arch/x86/include/asm/msr-index.h                              |    5=20
 arch/x86/include/asm/nospec-branch.h                          |   43=20
 arch/x86/include/asm/spec-ctrl.h                              |   20=20
 arch/x86/include/asm/switch_to.h                              |    3=20
 arch/x86/include/asm/thread_info.h                            |   20=20
 arch/x86/include/asm/tlbflush.h                               |    8=20
 arch/x86/kernel/cpu/bugs.c                                    |  493 +++++=
+++--
 arch/x86/kernel/cpu/mcheck/mce_amd.c                          |   19=20
 arch/x86/kernel/fpu/signal.c                                  |    4=20
 arch/x86/kernel/ftrace.c                                      |   15=20
 arch/x86/kernel/process.c                                     |  101 +-
 arch/x86/kernel/process.h                                     |   39=20
 arch/x86/kernel/process_32.c                                  |   10=20
 arch/x86/kernel/process_64.c                                  |   10=20
 arch/x86/kvm/lapic.c                                          |    5=20
 arch/x86/kvm/mmu.c                                            |   27=20
 arch/x86/kvm/svm.c                                            |   25=20
 arch/x86/kvm/vmx.c                                            |   22=20
 arch/x86/kvm/x86.c                                            |   10=20
 arch/x86/mm/tlb.c                                             |  115 +-
 arch/xtensa/kernel/asm-offsets.c                              |   16=20
 arch/xtensa/kernel/process.c                                  |    5=20
 arch/xtensa/kernel/ptrace.c                                   |   42=20
 drivers/android/binder.c                                      |   21=20
 drivers/android/binder_alloc.c                                |   16=20
 drivers/android/binder_alloc.h                                |    3=20
 drivers/dma/at_hdmac.c                                        |   10=20
 drivers/hid/hid-sensor-custom.c                               |    2=20
 drivers/hid/hid-sensor-hub.c                                  |   13=20
 drivers/hv/channel.c                                          |    8=20
 drivers/iio/accel/hid-sensor-accel-3d.c                       |    5=20
 drivers/iio/gyro/hid-sensor-gyro-3d.c                         |    5=20
 drivers/iio/humidity/hid-sensor-humidity.c                    |    3=20
 drivers/iio/light/hid-sensor-als.c                            |    8=20
 drivers/iio/light/hid-sensor-prox.c                           |    8=20
 drivers/iio/magnetometer/hid-sensor-magn-3d.c                 |    8=20
 drivers/iio/magnetometer/st_magn_buffer.c                     |   12=20
 drivers/iio/orientation/hid-sensor-incl-3d.c                  |    8=20
 drivers/iio/pressure/hid-sensor-press.c                       |    8=20
 drivers/iio/temperature/hid-sensor-temperature.c              |    3=20
 drivers/misc/mic/scif/scif_rma.c                              |    2=20
 drivers/net/ethernet/cavium/thunder/nicvf_main.c              |    9=20
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c            |    4=20
 drivers/net/ethernet/cortina/gemini.c                         |    2=20
 drivers/net/ethernet/microchip/lan743x_main.c                 |   11=20
 drivers/net/ethernet/microchip/lan743x_main.h                 |    1=20
 drivers/net/phy/phy_device.c                                  |    8=20
 drivers/net/rionet.c                                          |    2=20
 drivers/net/usb/ipheth.c                                      |   10=20
 drivers/net/virtio_net.c                                      |   13=20
 drivers/pci/controller/dwc/pci-layerscape.c                   |    2=20
 drivers/pci/controller/dwc/pcie-designware-ep.c               |    1=20
 drivers/pci/pci.c                                             |   24=20
 drivers/rtc/rtc-hid-sensor-time.c                             |    2=20
 drivers/s390/net/qeth_core_main.c                             |   27=20
 drivers/staging/most/core.c                                   |    2=20
 drivers/staging/mt7621-dma/mtk-hsdma.c                        |    3=20
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c               |    2=20
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c                |    4=20
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c             |    2=20
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c |    7=20
 drivers/usb/core/quirks.c                                     |    3=20
 drivers/usb/dwc3/gadget.c                                     |    5=20
 drivers/usb/storage/unusual_realtek.h                         |   10=20
 fs/btrfs/disk-io.c                                            |   11=20
 fs/btrfs/file.c                                               |   24=20
 fs/btrfs/qgroup.c                                             |    3=20
 fs/btrfs/relocation.c                                         |    1=20
 fs/btrfs/super.c                                              |    1=20
 fs/direct-io.c                                                |    4=20
 fs/ext2/super.c                                               |    1=20
 fs/ext2/xattr.c                                               |    2=20
 fs/udf/super.c                                                |   16=20
 fs/udf/unicode.c                                              |   14=20
 fs/userfaultfd.c                                              |   15=20
 include/linux/ftrace.h                                        |    4=20
 include/linux/hid-sensor-hub.h                                |    4=20
 include/linux/net_dim.h                                       |    2=20
 include/linux/ptrace.h                                        |    4=20
 include/linux/sched.h                                         |   10=20
 include/linux/sched/smt.h                                     |   20=20
 include/linux/skbuff.h                                        |   18=20
 include/linux/tcp.h                                           |    1=20
 include/uapi/linux/prctl.h                                    |    1=20
 kernel/cpu.c                                                  |   14=20
 kernel/sched/core.c                                           |   19=20
 kernel/sched/sched.h                                          |    4=20
 kernel/trace/ftrace.c                                         |    7=20
 kernel/trace/trace_functions_graph.c                          |   49=20
 lib/test_kmod.c                                               |    1=20
 mm/huge_memory.c                                              |   43=20
 mm/khugepaged.c                                               |  129 +-
 mm/rmap.c                                                     |   13=20
 mm/shmem.c                                                    |   12=20
 mm/truncate.c                                                 |    8=20
 mm/userfaultfd.c                                              |   15=20
 net/core/dev.c                                                |    7=20
 net/core/skbuff.c                                             |    5=20
 net/ipv4/tcp_input.c                                          |   14=20
 net/ipv4/tcp_output.c                                         |    6=20
 net/ipv4/tcp_timer.c                                          |    2=20
 net/packet/af_packet.c                                        |    4=20
 net/tipc/node.c                                               |    7=20
 scripts/Makefile.build                                        |    2=20
 sound/core/control.c                                          |   80 -
 sound/isa/wss/wss_lib.c                                       |    2=20
 sound/pci/ac97/ac97_codec.c                                   |    2=20
 sound/pci/hda/hda_intel.c                                     |    2=20
 sound/pci/hda/patch_realtek.c                                 |   36=20
 sound/soc/codecs/pcm186x.h                                    |    2=20
 sound/soc/intel/boards/cht_bsw_max98090_ti.c                  |   32=20
 sound/sparc/cs4231.c                                          |    8=20
 tools/include/uapi/linux/prctl.h                              |    1=20
 135 files changed, 1584 insertions(+), 801 deletions(-)

Andrea Arcangeli (1):
      userfaultfd: shmem/hugetlbfs: only allow to register VM_MAYWRITE vmas

Andreas Dannenberg (1):
      ASoC: pcm186x: Fix device reset-registers trigger value

Andreas Fiedler (1):
      net: gemini: Fix copy/paste error

Anisse Astier (1):
      ALSA: hda/realtek - fix headset mic detection for MSI MS-B171

Ben Wolsieffer (1):
      staging: vchiq_arm: fix compat VCHIQ_IOC_AWAIT_COMPLETION

Bernd Eckstein (1):
      usbnet: ipheth: fix potential recvmsg bug and recvmsg bug 2

Borislav Petkov (1):
      x86/MCE/AMD: Fix the thresholding machinery initialization order

Bryan Whitehead (2):
      lan743x: Enable driver to work with LAN7431
      lan743x: fix return value for lan743x_tx_napi_poll

Christoph Muellner (1):
      arm64: dts: rockchip: Fix PCIe reset polarity for rk3399-puma-haikou.

Colin Ian King (2):
      staging: most: use format specifier "%s" in snprintf
      staging: mt7621-pinctrl: fix uninitialized variable ngroups

Dexuan Cui (1):
      Drivers: hv: vmbus: check the creation_status in vmbus_establish_gpad=
l()

Eric Dumazet (1):
      tcp: defer SACK compression after DupThresh

Felipe Balbi (1):
      Revert "usb: dwc3: gadget: skip Set/Clear Halt when invalid"

Filipe Manana (3):
      Btrfs: ensure path name is null terminated at btrfs_control_ioctl
      Btrfs: fix rare chances for data loss when doing a fast fsync
      Btrfs: fix race between enabling quotas and subvolume creation

Girija Kumar Kasinadhuni (1):
      ALSA: hda/realtek - Add auto-mute quirk for HP Spectre x360 laptop

Greg Kroah-Hartman (1):
      Linux 4.19.7

Gustavo Pimentel (1):
      PCI: dwc: Fix MSI-X EP framework address calculation bug

Hans de Goede (3):
      ALSA: hda: Add ASRock N68C-S UCC the power_save blacklist
      ASoC: intel: cht_bsw_max98090_ti: Add quirk for boards using pmc_plt_=
clk_0
      iio/hid-sensors: Fix IIO_CHAN_INFO_RAW returning wrong values for sig=
ned numbers

Heiko Stuebner (1):
      ARM: dts: rockchip: Remove @0 from the veyron memory node

Heiner Kallweit (1):
      net: phy: add workaround for issue where PHY driver doesn't bind to t=
he device

Hou Zhiqiang (1):
      PCI: layerscape: Fix wrong invocation of outbound window disable acce=
ssor

Hugh Dickins (9):
      mm/huge_memory: rename freeze_page() to unmap_page()
      mm/huge_memory: splitting set mapping+index before unfreeze
      mm/huge_memory: fix lockdep complaint on 32-bit i_size_read()
      mm/khugepaged: collapse_shmem() stop if punched or truncated
      mm/khugepaged: fix crashes due to misaccounted holes
      mm/khugepaged: collapse_shmem() remember to clear holes
      mm/khugepaged: minor reorderings in collapse_shmem()
      mm/khugepaged: collapse_shmem() without freezing new_page
      mm/khugepaged: collapse_shmem() do not crash on Compound

Hui Wang (1):
      ALSA: hda/realtek - fix the pop noise on headphone for lenovo laptops

Jan Kara (1):
      udf: Allow mounting volumes with incorrect identification strings

Jason Wang (2):
      virtio-net: disable guest csum during XDP set
      virtio-net: fail XDP set if guest csum is negotiated

Jim Mattson (1):
      kvm: svm: Ensure an IBPB on all affected CPUs when freeing a vmcb

Jiri Kosina (3):
      x86/speculation: Enable cross-hyperthread spectre v2 STIBP mitigation
      x86/speculation: Apply IBPB more strictly to avoid cross-process data=
 leak
      x86/speculation: Propagate information about RSB filling mitigation t=
o sysfs

Jiri Olsa (3):
      perf/x86/intel: Move branch tracing setup to the Intel-specific sourc=
e file
      perf/x86/intel: Add generic branch tracing check to intel_pmu_has_bts=
()
      perf/x86/intel: Disallow precise_ip on BTS events

Jon Maloy (1):
      tipc: fix lockdep warning during node delete

Julian Wiedmann (1):
      s390/qeth: fix length check in SNMP processing

Junaid Shahid (1):
      kvm: mmu: Fix race in emulated page table writes

Kai-Heng Feng (1):
      USB: usb-storage: Add new IDs to ums-realtek

Kailang Yang (1):
      ALSA: hda/realtek - Support ALC300

Larry Finger (2):
      staging: rtl8723bs: Fix incorrect sense of ether_addr_equal
      staging: rtl8723bs: Add missing return for cfg80211_rtw_get_station

Leonid Shatz (1):
      KVM: nVMX/nSVM: Fix bug which sets vcpu->arch.tsc_offset to L1 tsc_of=
fset

Liran Alon (1):
      KVM: x86: Fix kernel info-leak in KVM_HC_CLOCK_PAIRING hypercall

Lorenzo Bianconi (2):
      net: thunderx: set tso_hdrs pointer to NULL in nicvf_free_snd_queue
      net: thunderx: set xdp_prog to NULL if bpf_prog_add fails

Luis Chamberlain (1):
      lib/test_kmod.c: fix rmmod double free

Luiz Capitulino (1):
      KVM: VMX: re-add ple_gap module parameter

Martin Kelly (1):
      iio:st_magn: Fix enable device after trigger

Max Filippov (3):
      xtensa: enable coprocessors that are being flushed
      xtensa: fix coprocessor context offset definitions
      xtensa: fix coprocessor part of ptrace_{get,set}xregs

Maximilian Heyne (1):
      fs: fix lost error code in dio_complete

Michael Niew=F6hner (1):
      usb: core: quirks: add RESET_RESUME quirk for Cherry G230 Stream seri=
es

Mikulas Patocka (1):
      PCI: Fix incorrect value returned from pcie_get_speed_cap()

Nikolay Borisov (1):
      btrfs: Always try all copies when reading extent buffers

Pan Bian (3):
      rapidio/rionet: do not free skb before reading its length
      btrfs: relocation: set trans to be NULL after ending transaction
      ext2: fix potential use after free

Paolo Abeni (1):
      net: don't keep lonely packets forever in the gro hash

Pavel Tikhomirov (1):
      mm: cleancache: fix corruption on missed inode invalidation

Peter Zijlstra (Intel) (1):
      sched/smt: Make sched_smt_present track topology

Petr Machata (1):
      net: skb_scrub_packet(): Scrub offload_fwd_mark

Richard Genoud (2):
      dmaengine: at_hdmac: fix memory leak in at_dma_xlate()
      dmaengine: at_hdmac: fix module unloading

Sebastian Andrzej Siewior (1):
      x86/fpu: Disable bottom halves while loading FPU registers

Sergio Paracuellos (1):
      staging: mt7621-dma: fix potentially dereferencing uninitialized 'tx_=
desc'

Steven Rostedt (VMware) (18):
      function_graph: Create function_graph_enter() to consolidate architec=
ture code
      ARM: function_graph: Simplify with function_graph_enter()
      microblaze: function_graph: Simplify with function_graph_enter()
      x86/function_graph: Simplify with function_graph_enter()
      nds32: function_graph: Simplify with function_graph_enter()
      powerpc/function_graph: Simplify with function_graph_enter()
      sh/function_graph: Simplify with function_graph_enter()
      sparc/function_graph: Simplify with function_graph_enter()
      parisc: function_graph: Simplify with function_graph_enter()
      riscv/function_graph: Simplify with function_graph_enter()
      s390/function_graph: Simplify with function_graph_enter()
      arm64: function_graph: Simplify with function_graph_enter()
      MIPS: function_graph: Simplify with function_graph_enter()
      function_graph: Make ftrace_push_return_trace() static
      function_graph: Use new curr_ret_depth to manage depth instead of cur=
r_ret_stack
      function_graph: Have profiler use curr_ret_stack and not depth
      function_graph: Move return callback before update of curr_ret_stack
      function_graph: Reverse the order of pushing the ret_stack and the ca=
llback

Takashi Iwai (4):
      ALSA: wss: Fix invalid snd_free_pages() at error path
      ALSA: ac97: Fix incorrect bit shift at AC97-SPSA control write
      ALSA: control: Fix race between adding and removing a user element
      ALSA: sparc: Fix invalid snd_free_pages() at error path

Tal Gilboa (1):
      net/dim: Update DIM start sample after each DIM iteration

Thomas Gleixner (21):
      x86/speculation: Rename SSBD update functions
      x86/Kconfig: Select SCHED_SMT if SMP enabled
      sched/smt: Expose sched_smt_present static key
      x86/speculation: Rework SMT state change
      x86/l1tf: Show actual SMT state
      x86/speculation: Reorder the spec_v2 code
      x86/speculation: Mark string arrays const correctly
      x86/speculataion: Mark command line parser data __initdata
      x86/speculation: Unify conditional spectre v2 print functions
      x86/speculation: Add command line control for indirect branch specula=
tion
      x86/process: Consolidate and simplify switch_to_xtra() code
      x86/speculation: Avoid __switch_to_xtra() calls
      x86/speculation: Prepare for conditional IBPB in switch_mm()
      ptrace: Remove unused ptrace_may_access_sched() and MODE_IBRS
      x86/speculation: Split out TIF update
      x86/speculation: Prevent stale SPEC_CTRL msr content
      x86/speculation: Prepare arch_smt_update() for PRCTL mode
      x86/speculation: Add prctl() control for indirect branch speculation
      x86/speculation: Enable prctl mode for spectre_v2_user
      x86/speculation: Add seccomp Spectre v2 user space protection mode
      x86/speculation: Provide IBPB always command line options

Tim Chen (7):
      x86/speculation: Update the TIF_SSBD comment
      x86/speculation: Clean up spectre_v2_parse_cmdline()
      x86/speculation: Remove unnecessary ret variable in cpu_show_common()
      x86/speculation: Move STIPB/IBPB string conditionals out of cpu_show_=
common()
      x86/speculation: Disable STIBP when enhanced IBRS is in use
      x86/speculation: Reorganize speculation control MSRs update
      x86/speculation: Prepare for per task indirect branch speculation con=
trol

Todd Kjos (1):
      binder: fix race that allows malicious free of live buffer

Wanpeng Li (2):
      KVM: LAPIC: Fix pv ipis use-before-initialization
      KVM: X86: Fix scan ioapic use-before-initialization

Willem de Bruijn (1):
      packet: copy user buffers before orphan or clone

Yu Zhao (1):
      mm: use swp_offset as key in shmem_replace_page()

YueHaibing (1):
      misc: mic/scif: fix copy-paste error in scif_create_remote_lookup

Zhenzhong Duan (3):
      x86/speculation: Add RETPOLINE_AMD support to the inline asm CALL_NOS=
PEC variant
      x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support
      x86/retpoline: Remove minimal retpoline support

xingaopeng (1):
      ext2: initialize opts.s_mount_opt as zero before using it


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwIKzEACgkQONu9yGCS
aT7QoQ//Tz84USa0NLAYphc13kd9eF0a76RQ8uBsKcwmPHHr5imWsHw5RCCQPPt+
ye/qS4DcQc+YJ0F3+xswdMxxTZ2oOoVpNVYQK1v0CtzllzBk5vNpywNuxFd6UFje
Tm7NHKZN9pbvTMXZAxl4G8etHhTqQyzjohAX1x98Ip5RkqqeA0OuP/kl1t25KdzB
BXlh8wmVHc4S+udV8B9VclbuaUX/sE5cBWaBC8nSYea8sJWVZmc0743UFkaVUe6y
1GI/vgZNdS16g+3ABI73vORtmYUnq7xq37t8qzNYbwbQxijkGm9Pzs4qhZJ5bBwt
bnbh7Tqf6ZuBYoIa2atuiwxR+0Y3ZtkN1AOIRz8lLaFeZDSWxQcswuXUawn3QCzf
uqeK8A1BSu79hWeaHMPE2bONyLMqH/d0jx5WQp8PJOgOsFt/++T36zL6lcjo/DCY
6qwsR99a4lNGnlI6ZzYyywy5Pcm/V52OFEz9kUvuTvm8SrBxvFU7PoLWyQq7F+T2
rA3I/y3NIJuylE0TkNL6yLybiumCiZiyyF+CVo8ZP7zxC33Nxm657+C1+zEy1e5f
Sc1mTJifZqacz7YH7PLS0RX/BSeSEticPAfBglhVDeDCfBqImIkOotwKx6gh5FWK
ZxaOzW9jAFaXIx/tLkKy+JobCp2EJnhCFZucS7NvmjI8yPIS0Q0=
=VfNA
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
