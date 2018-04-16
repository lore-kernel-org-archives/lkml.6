Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeDPPpI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:45:08 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:41718 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbeDPPpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:45:05 -0400
X-Google-Smtp-Source: AIpwx49iLQytoLYqCoK8KGgyg/G1rGnxS6qXUVUWK8T+JBv1PUCUb2QS9NPL2OrW2yLdMWtfFHTSig==
Date: Mon, 16 Apr 2018 17:45:01 +0200
From: Thymo van Beers <thymovanbeers@gmail.com>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: kernel-parameters.txt: Fix whitespace
Message-ID: <20180416154458.GA24716@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some lines used spaces instead of tabs at line start.
This can cause mangled lines in editors due to inconsistency.

Replace spaces for tabs where appropriate.

Signed-off-by: Thymo van Beers <thymovanbeers@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 168 ++++++++++++------------
 1 file changed, 84 insertions(+), 84 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1d1d53f85ddd..3aa8eed85f39 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -106,11 +106,11 @@
 			use by PCI
 			Format: <irq>,<irq>...
 
-	acpi_mask_gpe=  [HW,ACPI]
+	acpi_mask_gpe=	[HW,ACPI]
 			Due to the existence of _Lxx/_Exx, some GPEs triggered
 			by unsupported hardware/firmware features can result in
-                        GPE floodings that cannot be automatically disabled by
-                        the GPE dispatcher.
+			GPE floodings that cannot be automatically disabled by
+			the GPE dispatcher.
 			This facility can be used to prevent such uncontrolled
 			GPE floodings.
 			Format: <int>
@@ -472,10 +472,10 @@
 			for platform specific values (SB1, Loongson3 and
 			others).
 
-	ccw_timeout_log [S390]
+	ccw_timeout_log	[S390]
 			See Documentation/s390/CommonIO for details.
 
-	cgroup_disable= [KNL] Disable a particular controller
+	cgroup_disable=	[KNL] Disable a particular controller
 			Format: {name of the controller(s) to disable}
 			The effects of cgroup_disable=foo are:
 			- foo isn't auto-mounted if you mount all cgroups in
@@ -641,8 +641,8 @@
 		hvc<n>	Use the hypervisor console device <n>. This is for
 			both Xen and PowerPC hypervisors.
 
-                If the device connected to the port is not a TTY but a braille
-                device, prepend "brl," before the device type, for instance
+		If the device connected to the port is not a TTY but a braille
+		device, prepend "brl," before the device type, for instance
 			console=brl,ttyS0
 		For now, only VisioBraille is supported.
 
@@ -662,7 +662,7 @@
 
 	consoleblank=	[KNL] The console blank (screen saver) timeout in
 			seconds. A value of 0 disables the blank timer.
-                       Defaults to 0.
+			Defaults to 0.
 
 	coredump_filter=
 			[KNL] Change the default value for
@@ -730,7 +730,7 @@
 			or memory reserved is below 4G.
 
 	cryptomgr.notests
-                        [KNL] Disable crypto self-tests
+			[KNL] Disable crypto self-tests
 
 	cs89x0_dma=	[HW,NET]
 			Format: <dma>
@@ -746,7 +746,7 @@
 			Format: <port#>,<type>
 			See also Documentation/input/devices/joystick-parport.rst
 
-	ddebug_query=   [KNL,DYNAMIC_DEBUG] Enable debug messages at early boot
+	ddebug_query=	[KNL,DYNAMIC_DEBUG] Enable debug messages at early boot
 			time. See
 			Documentation/admin-guide/dynamic-debug-howto.rst for
 			details.  Deprecated, see dyndbg.
@@ -833,7 +833,7 @@
 			causing system reset or hang due to sending
 			INIT from AP to BSP.
 
-	disable_ddw     [PPC/PSERIES]
+	disable_ddw	[PPC/PSERIES]
 			Disable Dynamic DMA Window support. Use this if
 			to workaround buggy firmware.
 
@@ -1188,7 +1188,7 @@
 			parameter will force ia64_sal_cache_flush to call
 			ia64_pal_cache_flush instead of SAL_CACHE_FLUSH.
 
-	forcepae [X86-32]
+	forcepae	[X86-32]
 			Forcefully enable Physical Address Extension (PAE).
 			Many Pentium M systems disable PAE but may have a
 			functionally usable PAE implementation.
@@ -1247,7 +1247,7 @@
 
 	gamma=		[HW,DRM]
 
-	gart_fix_e820=  [X86_64] disable the fix e820 for K8 GART
+	gart_fix_e820=	[X86_64] disable the fix e820 for K8 GART
 			Format: off | on
 			default: on
 
@@ -1341,14 +1341,14 @@
 			x86-64 are 2M (when the CPU supports "pse") and 1G
 			(when the CPU supports the "pdpe1gb" cpuinfo flag).
 
-	hvc_iucv=	[S390] Number of z/VM IUCV hypervisor console (HVC)
-			       terminal devices. Valid values: 0..8
-	hvc_iucv_allow=	[S390] Comma-separated list of z/VM user IDs.
-			       If specified, z/VM IUCV HVC accepts connections
-			       from listed z/VM user IDs only.
+	hvc_iucv=	[S390]	Number of z/VM IUCV hypervisor console (HVC)
+				terminal devices. Valid values: 0..8
+	hvc_iucv_allow=	[S390]	Comma-separated list of z/VM user IDs.
+				If specified, z/VM IUCV HVC accepts connections
+				from listed z/VM user IDs only.
 
-	hwthread_map=	[METAG] Comma-separated list of Linux cpu id to
-			        hardware thread id mappings.
+	hwthread_map=	[METAG]	Comma-separated list of Linux cpu id to
+				hardware thread id mappings.
 				Format: <cpu>:<hwthread>
 
 	keep_bootcon	[KNL]
@@ -1357,11 +1357,11 @@
 			between unregistering the boot console and initializing
 			the real console.
 
-	i2c_bus=	[HW] Override the default board specific I2C bus speed
-			     or register an additional I2C bus that is not
-			     registered from board initialization code.
-			     Format:
-			     <bus_id>,<clkrate>
+	i2c_bus=	[HW]	Override the default board specific I2C bus speed
+				or register an additional I2C bus that is not
+				registered from board initialization code.
+				Format:
+				<bus_id>,<clkrate>
 
 	i8042.debug	[HW] Toggle i8042 debug mode
 	i8042.unmask_kbd_data
@@ -1390,7 +1390,7 @@
 			Default: only on s2r transitions on x86; most other
 			architectures force reset to be always executed
 	i8042.unlock	[HW] Unlock (ignore) the keylock
-	i8042.kbdreset  [HW] Reset device connected to KBD port
+	i8042.kbdreset	[HW] Reset device connected to KBD port
 
 	i810=		[HW,DRM]
 
@@ -1546,13 +1546,13 @@
 			programs exec'd, files mmap'd for exec, and all files
 			opened for read by uid=0.
 
-	ima_template=   [IMA]
+	ima_template=	[IMA]
 			Select one of defined IMA measurements template formats.
 			Formats: { "ima" | "ima-ng" | "ima-sig" }
 			Default: "ima-ng"
 
 	ima_template_fmt=
-	                [IMA] Define a custom template format.
+			[IMA] Define a custom template format.
 			Format: { "field1|...|fieldN" }
 
 	ima.ahash_minsize= [IMA] Minimum file size for asynchronous hash usage
@@ -1595,7 +1595,7 @@
 	inport.irq=	[HW] Inport (ATI XL and Microsoft) busmouse driver
 			Format: <irq>
 
-	int_pln_enable  [x86] Enable power limit notification interrupt
+	int_pln_enable	[x86] Enable power limit notification interrupt
 
 	integrity_audit=[IMA]
 			Format: { "0" | "1" }
@@ -1648,39 +1648,39 @@
 			0	disables intel_idle and fall back on acpi_idle.
 			1 to 9	specify maximum depth of C-state.
 
-	intel_pstate=  [X86]
-		       disable
-		         Do not enable intel_pstate as the default
-		         scaling driver for the supported processors
-		       passive
-			 Use intel_pstate as a scaling driver, but configure it
-			 to work with generic cpufreq governors (instead of
-			 enabling its internal governor).  This mode cannot be
-			 used along with the hardware-managed P-states (HWP)
-			 feature.
-		       force
-			 Enable intel_pstate on systems that prohibit it by default
-			 in favor of acpi-cpufreq. Forcing the intel_pstate driver
-			 instead of acpi-cpufreq may disable platform features, such
-			 as thermal controls and power capping, that rely on ACPI
-			 P-States information being indicated to OSPM and therefore
-			 should be used with caution. This option does not work with
-			 processors that aren't supported by the intel_pstate driver
-			 or on platforms that use pcc-cpufreq instead of acpi-cpufreq.
-		       no_hwp
-		         Do not enable hardware P state control (HWP)
-			 if available.
-		hwp_only
-			Only load intel_pstate on systems which support
-			hardware P state control (HWP) if available.
-		support_acpi_ppc
-			Enforce ACPI _PPC performance limits. If the Fixed ACPI
-			Description Table, specifies preferred power management
-			profile as "Enterprise Server" or "Performance Server",
-			then this feature is turned on by default.
-		per_cpu_perf_limits
-			Allow per-logical-CPU P-State performance control limits using
-			cpufreq sysfs interface
+	intel_pstate=	[X86]
+			disable
+				Do not enable intel_pstate as the default
+				scaling driver for the supported processors
+			passive
+				Use intel_pstate as a scaling driver, but configure it
+				to work with generic cpufreq governors (instead of
+				enabling its internal governor).  This mode cannot be
+				used along with the hardware-managed P-states (HWP)
+				feature.
+			force
+				Enable intel_pstate on systems that prohibit it by default
+				in favor of acpi-cpufreq. Forcing the intel_pstate driver
+				instead of acpi-cpufreq may disable platform features, such
+				as thermal controls and power capping, that rely on ACPI
+				P-States information being indicated to OSPM and therefore
+				should be used with caution. This option does not work with
+				processors that aren't supported by the intel_pstate driver
+				or on platforms that use pcc-cpufreq instead of acpi-cpufreq.
+			no_hwp
+				Do not enable hardware P state control (HWP)
+				if available.
+			hwp_only
+				Only load intel_pstate on systems which support
+				hardware P state control (HWP) if available.
+			support_acpi_ppc
+				Enforce ACPI _PPC performance limits. If the Fixed ACPI
+				Description Table, specifies preferred power management
+				profile as "Enterprise Server" or "Performance Server",
+				then this feature is turned on by default.
+			per_cpu_perf_limits
+				Allow per-logical-CPU P-State performance control limits using
+				cpufreq sysfs interface
 
 	intremap=	[X86-64, Intel-IOMMU]
 			on	enable Interrupt Remapping (default)
@@ -1765,21 +1765,21 @@
 			specified in the flag list (default: domain):
 
 			nohz
-			  Disable the tick when a single task runs.
+				Disable the tick when a single task runs.
 			domain
-			  Isolate from the general SMP balancing and scheduling
-			  algorithms. Note that performing domain isolation this way
-			  is irreversible: it's not possible to bring back a CPU to
-			  the domains once isolated through isolcpus. It's strongly
-			  advised to use cpusets instead to disable scheduler load
-			  balancing through the "cpuset.sched_load_balance" file.
-			  It offers a much more flexible interface where CPUs can
-			  move in and out of an isolated set anytime.
-
-			  You can move a process onto or off an "isolated" CPU via
-			  the CPU affinity syscalls or cpuset.
-			  <cpu number> begins at 0 and the maximum value is
-			  "number of CPUs in system - 1".
+				Isolate from the general SMP balancing and scheduling
+				algorithms. Note that performing domain isolation this way
+				is irreversible: it's not possible to bring back a CPU to
+				the domains once isolated through isolcpus. It's strongly
+				advised to use cpusets instead to disable scheduler load
+				balancing through the "cpuset.sched_load_balance" file.
+				It offers a much more flexible interface where CPUs can
+				move in and out of an isolated set anytime.
+
+			You can move a process onto or off an "isolated" CPU via
+			the CPU affinity syscalls or cpuset.
+			<cpu number> begins at 0 and the maximum value is
+			"number of CPUs in system - 1".
 
 			The format of <cpu-list> is described above.
 
@@ -2004,7 +2004,7 @@
 			* [no]ncqtrim: Turn off queued DSM TRIM.
 
 			* nohrst, nosrst, norst: suppress hard, soft
-                          and both resets.
+			and both resets.
 
 			* rstonce: only attempt one reset during
 			  hot-unplug link recovery
@@ -2192,7 +2192,7 @@
 			[KNL,SH] Allow user to override the default size for
 			per-device physically contiguous DMA buffers.
 
-        memhp_default_state=online/offline
+	memhp_default_state=online/offline
 			[KNL] Set the initial state for the memory hotplug
 			onlining policy. If not specified, the default value is
 			set according to the
@@ -2729,7 +2729,7 @@
 			[X86,PV_OPS] Disable paravirtualized VMware scheduler
 			clock and use the default one.
 
-	no-steal-acc    [X86,KVM] Disable paravirtualized steal time accounting.
+	no-steal-acc	[X86,KVM] Disable paravirtualized steal time accounting.
 			steal time is computed, but won't influence scheduler
 			behaviour
 
@@ -2790,7 +2790,7 @@
 	notsc		[BUGS=X86-32] Disable Time Stamp Counter
 
 	nowatchdog	[KNL] Disable both lockup detectors, i.e.
-                        soft-lockup and NMI watchdog (hard-lockup).
+			soft-lockup and NMI watchdog (hard-lockup).
 
 	nowb		[ARM]
 
@@ -2810,7 +2810,7 @@
 			If the dependencies are under your control, you can
 			turn on cpu0_hotplug.
 
-	nps_mtm_hs_ctr= [KNL,ARC]
+	nps_mtm_hs_ctr=	[KNL,ARC]
 			This parameter sets the maximum duration, in
 			cycles, each HW thread of the CTOP can run
 			without interruptions, before HW switches it.
@@ -2951,7 +2951,7 @@
 
 	pci=option[,option...]	[PCI] various PCI subsystem options:
 		earlydump	[X86] dump PCI config space before the kernel
-			        changes anything
+				changes anything
 		off		[X86] don't probe for the PCI bus
 		bios		[X86-32] force use of PCI BIOS, don't access
 				the hardware directly. Use this if your machine
@@ -3039,7 +3039,7 @@
 				is enabled by default.  If you need to use this,
 				please report a bug.
 		nocrs		[X86] Ignore PCI host bridge windows from ACPI.
-			        If you need to use this, please report a bug.
+				If you need to use this, please report a bug.
 		routeirq	Do IRQ routing for all PCI devices.
 				This is normally done in pci_enable_device(),
 				so this option is a temporary workaround
@@ -4363,7 +4363,7 @@
 
 	usbcore.initial_descriptor_timeout=
 			[USB] Specifies timeout for the initial 64-byte
-                        USB_REQ_GET_DESCRIPTOR request in milliseconds
+			USB_REQ_GET_DESCRIPTOR request in milliseconds
 			(default 5000 = 5.0 seconds).
 
 	usbcore.nousb	[USB] Disable the USB subsystem
-- 
2.16.1
