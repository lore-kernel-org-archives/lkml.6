Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F5AC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920922082C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfBCOFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:05:21 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52752 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727762AbfBCNtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:42 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9S-0003td-VK; Sun, 03 Feb 2019 13:49:39 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9T-0006n3-9l; Sun, 03 Feb 2019 14:49:39 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        Denis Kirjanov <kda@linux-powerpc.org>,
        akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>
Date:   Sun, 03 Feb 2019 14:45:07 +0100
Message-ID: <lsq.1549201507.384106140@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 000/305] 3.16.63-rc1 review
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.16.63 release.
There are 305 patches in this series, which will be posted as responses
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Feb 08 18:00:00 UTC 2019.
Anything received after that time might be too late.

All the patches have also been committed to the linux-3.16.y-rc branch of
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-stable-rc.git .
A shortlog and diffstat can be found below.

Ben.

-------------

Aaro Koskinen (1):
      MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5910/OMAP310
         [e8cde625bfe8a714a856e1366bcbb259d7346095]

Aaron Ma (2):
      usb: xhci: fix timeout for transition from RExit to U0
         [a5baeaeabcca3244782a9b6382ebab6f8a58f583]
      usb: xhci: fix uninitialized completion when USB3 port got wrong status
         [958c0bd86075d4ef1c936998deefe1947e539240]

Ahmad Fatoum (1):
      mtd: spi-nor: fsl-quadspi: Don't let -EINVAL on the bus
         [000412276370a9bcfec73b3752ceefd9a927f1db]

Al Viro (2):
      gfs2_meta: ->mount() can get NULL dev_name
         [3df629d873f8683af6f0d34dfc743f637966d483]
      new helper: uaccess_kernel()
         [db68ce10c4f0a27c1ff9fa0e789e5c41f8c4ea63]

Alex Stanoev (1):
      ALSA: ca0106: Disable IZD on SB0570 DAC to fix audio pops
         [ac237c28d5ac1b241d58b1b7b4b9fa10efb22fb5]

Alexander Theissen (1):
      usb: appledisplay: Add 27" Apple Cinema Display
         [d7859905301880ad3e16272399d26900af3ac496]

Amir Goldstein (1):
      lockd: fix access beyond unterminated strings in prints
         [93f38b6fae0ea8987e22d9e6c38f8dfdccd867ee]

Anders Roxell (1):
      cpupower: remove stringop-truncation waring
         [8a7e2d2ea080d10a189a1d611344b0330468ebc3]

Andrea Parri (1):
      uprobes: Fix handle_swbp() vs. unregister() + register() race once more
         [09d3f015d1e1b4fee7e9bbdcf54201d239393391]

Andreas Kemnade (1):
      w1: omap-hdq: fix missing bus unregister at removal
         [a007734618fee1bf35556c04fa498d41d42c7301]

Andreas Larsson (1):
      sparc32: Fix inverted invalid_frame_pointer checks on sigreturns
         [07b5ab3f71d318e52c18cc3b73c1d44c908aacfa]

Andy Lutomirski (1):
      x86/vdso: Fix vDSO syscall fallback asm constraint regression
         [02e425668f5c9deb42787d10001a3b605993ad15]

Anssi Hannula (2):
      net: macb: add missing barriers when reading descriptors
         [6e0af298066f3b6d99f58989bb0dca6f764b4c6d]
      net: macb: fix dropped RX frames due to a race
         [8159ecab0db9095902d4c73605fb8787f5c7d653]

Arnd Bergmann (4):
      ARM: fix put_user() for gcc-8
         [9f73bd8bb445e0cbe4bcef6d4cfc788f1e184007]
      kbuild: fix kernel/bounds.c 'W=1' warning
         [6a32c2469c3fbfee8f25bcd20af647326650a6cf]
      mtd: docg3: don't set conflicting BCH_CONST_PARAMS option
         [be2e1c9dcf76886a83fb1c433a316e26d4ca2550]
      turn off -Wattribute-alias
         [bee20031772af3debe8cbaa234528f24c7892e8f]

Aya Levin (1):
      net/mlx4: Fix UBSAN warning of signed integer overflow
         [a463146e67c848cbab5ce706d6528281b7cded08]

Ben Greear (1):
      mac80211: Clear beacon_int in ieee80211_do_stop
         [5c21e8100dfd57c806e833ae905e26efbb87840f]

Ben Hutchings (3):
      ipv6: Fix another sparse warning on rt6i_node
         [not upstream; function has been removed]
      s390/dasd: Restore a necessary cast
         [not upstream; variable type has been changed]
      x86/boot: eboot.c: Include string function declarations
         [393f203f5fd54421fddb1e2a263f64d3876eeadb]

Benjamin Poirier (1):
      xfrm: Fix bucket count reported to userspace
         [ca92e173ab34a4f7fc4128bd372bd96f1af6f507]

Bin Meng (1):
      PCI: Add Device IDs for Intel GPU "spurious interrupt" quirk
         [d0c9606b31a21028fb5b753c8ad79626292accfd]

Breno Leitao (1):
      HID: hiddev: fix potential Spectre v1
         [f11274396a538b31bc010f782e05c2ce3f804c13]

Carlos Maiolino (1):
      xfs: Fix xqmstats offsets in /proc/fs/xfs/xqmstat
         [41657e5507b13e963be906d5d874f4f02374fd5c]

Chad Austin (1):
      fuse: continue to send FUSE_RELEASEDIR when FUSE_OPEN returns ENOSYS
         [2e64ff154ce6ce9a8dc0f9556463916efa6ff460]

Changwei Ge (1):
      ocfs2: fix a misuse a of brelse after failing ocfs2_check_dir_entry
         [29aa30167a0a2e6045a0d6d2e89d8168132333d5]

Chen Gang (1):
      s390/timex: fix get_tod_clock_ext() inline assembly
         [e38f97813302065fbc9c9eab5c1a94dc021d71e2]

Chris Mason (1):
      Btrfs: don't clean dirty pages during buffered writes
         [7703bdd8d23e6ef057af3253958a793ec6066b28]

Chris Wilson (1):
      drm/i915: Large page offsets for pread/pwrite
         [a5e856a5348f6cd50889d125c40bbeec7328e466]

Christian Hoff (1):
      Input: matrix_keypad - check for errors from of_get_named_gpio()
         [d55bda1b3e7c5a87f10da54fdda866a9a9cef30b]

Christophe Leroy (1):
      gpio: max7301: fix driver for use with CONFIG_VMAP_STACK
         [abf221d2f51b8ce7b9959a8953f880a8b0a1400d]

Chuck Lever (1):
      SUNRPC: Fix leak of krb5p encode pages
         [8dae5398ab1ac107b1517e8195ed043d5f422bd0]

Colin Ian King (3):
      media: cx231xx: fix potential sign-extension overflow on large shift
         [32ae592036d7aeaabcccb2b1715373a68639a768]
      vxge: ensure data0 is initialized in when fetching firmware version information
         [f7db2beb4c2c6cc8111f5ab90fc7363ca91107b6]
      x86/mtrr: Don't copy uninitialized gentry fields back to userspace
         [32043fa065b51e0b1433e48d118821c71b5cd65d]

Dan Carpenter (6):
      bnx2fc: fix an error code in _bnx2fc_create()
         [2043e1fd09c1896bb03a6e25b64baa84a30879c9]
      libertas_tf: prevent underflow in process_cmdrequest()
         [3348ef6a6a126706d6a73ed40c18d8033df72783]
      qlcnic: fix a return in qlcnic_dcb_get_capability()
         [c94f026fb742b2d3199422751dbc4f6fc0e753d8]
      scsi: bnx2fc: Fix NULL dereference in error handling
         [9ae4f8420ed7be4b13c96600e3568c144d101a23]
      staging: comedi: quatech_daqp_cs: fix no-op loop daqp_ao_insn_write()
         [1376b0a2160319125c3a2822e8c09bd283cd8141]
      uio: Fix an Oops on load
         [432798195bbce1f8cd33d1c0284d0538835e25fb]

Dennis Wassenberg (1):
      usb: core: Fix hub port connection events lost
         [22454b79e6de05fa61a2a72d00d2eed798abbb75]

Dexuan Cui (4):
      Drivers: hv: kvp: Fix the recent regression caused by incorrect clean-up
         [e670de54c813b5bc3672dd1c67871dc60e9206f4]
      Drivers: hv: kvp: Fix two "this statement may fall through" warnings
         [fc62c3b1977d62e6374fd6e28d371bb42dfa5c9d]
      Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened channels
         [fc96df16a1ce80cbb3c316ab7d4dc8cd5c2852ce]
      Drivers: hv: vmbus: check the creation_status in vmbus_establish_gpadl()
         [eceb05965489784f24bbf4d61ba60e475a983016]

Diego Viola (2):
      libata: Apply NOLPM quirk for SAMSUNG MZ7TD256HAFV-000L9
         [a435ab4f80f983c53b4ca4f8c12b3ddd3ca17670]
      libata: blacklist SAMSUNG MZ7TD256HAFV-000L9 SSD
         [410b5c7b48368317af95f0113692561d01d8144e]

Dmitry Bazhenov (1):
      hwmon: (pmbus) Fix page count auto-detection.
         [e7c6a55606b5c46b449d76588968b4d8caae903f]

Dmitry Bilunov (1):
      KVM: Handle MSR_IA32_PERF_CTL
         [0c2df2a1affd183ba9c114915f42a2d464b4f58f]

Dmitry V. Levin (1):
      mips: fix mips_get_syscall_arg o32 check
         [c50cbd85cd7027d32ac5945bb60217936b4f7eaf]

Eduardo Habkost (1):
      kvm: x86: Add AMD's EX_CFG to the list of ignored MSRs
         [0e1b869fff60c81b510c2d00602d778f8f59dd9a]

Emmanuel Grumbach (1):
      mac80211: ignore NullFunc frames in the duplicate detection
         [990d71846a0b7281bd933c34d734e6afc7408e7e]

Emmanuel Pescosta (1):
      usb: quirks: Add delay-init quirk for Corsair K70 LUX RGB
         [a77112577667cbda7c6292c52d909636aef31fd9]

Enric Balletbo i Serra (1):
      PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.
         [23c7b54ca1cd1797ef39169ab85e6d46f1c2d061]

Eric Biggers (2):
      HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges
         [8c01db7619f07c85c5cd81ec5eb83608b56c88f5]
      ima: fix showing large 'violations' or 'runtime_measurements_count'
         [1e4c8dafbb6bf72fb5eca035b861e39c5896c2b7]

Eric Dumazet (4):
      ipv6: tunnels: fix two use-after-free
         [cbb49697d5512ce9e61b45ce75d3ee43d7ea5524]
      llc: do not use sk_eat_skb()
         [604d415e2bd642b7e02c80e719e0396b9d4a77a6]
      net-gro: reset skb->pkt_type in napi_reuse_skb()
         [33d9a2c72f086cbf1087b2fd2d1a15aa9df14a7f]
      rtnetlink: ndo_dflt_fdb_dump() only work for ARPHRD_ETHER devices
         [688838934c231bb08f46db687e57f6d8bf82709c]

Eric W. Biederman (5):
      mount: Don't allow copying MNT_UNBINDABLE|MNT_LOCKED mounts
         [df7342b240185d58d3d9665c0bbf0a0f5570ec29]
      mount: Prevent MNT_DETACH from disconnecting locked mounts
         [9c8e0a1b683525464a2abe9fb4b54404a50ed2b4]
      mount: Retest MNT_LOCKED in do_umount
         [25d202ed820ee347edec0bf3bf553544556bf64b]
      signal/GenWQE: Fix sending of SIGKILL
         [0ab93e9c99f8208c0a1a7b7170c827936268c996]
      signal: Always deliver the kernel's SIGKILL and SIGSTOP to a pid namespace init
         [3597dfe01d12f570bc739da67f857fd222a3ea66]

Erik Schmauss (1):
      ACPICA: AML interpreter: add region addresses in global list during initialization
         [4abb951b73ff0a8a979113ef185651aa3c8da19b]

Eugen Hristev (2):
      iio: adc: at91: fix acking DRDY irq on simple conversions
         [bc1b45326223e7e890053cf6266357adfa61942d]
      iio: adc: at91: fix wrong channel number in triggered buffer mode
         [aea835f2dc8a682942b859179c49ad1841a6c8b9]

Felipe Balbi (1):
      Revert "usb: dwc3: gadget: skip Set/Clear Halt when invalid"
         [38317f5c0f2faae5110854f36edad810f841d62f]

Felix Fietkau (1):
      mac80211: fix reordering of buffered broadcast packets
         [9ec1190d065998650fd9260dea8cf3e1f56c0e8c]

Filipe Manana (5):
      Btrfs: ensure path name is null terminated at btrfs_control_ioctl
         [f505754fd6599230371cb01b9332754ddc104be1]
      Btrfs: fix data corruption due to cloning of eof block
         [ac765f83f1397646c11092a032d4f62c3d478b81]
      Btrfs: fix null pointer dereference on compressed write path error
         [3527a018c00e5dbada2f9d7ed5576437b6dd5cfb]
      Btrfs: fix race between enabling quotas and subvolume creation
         [552f0329c75b3e1d7f9bb8c9e421d37403f192cd]
      Btrfs: fix use-after-free when dumping free space
         [9084cb6a24bf5838a665af92ded1af8363f9e563]

Finn Thain (1):
      scsi: esp_scsi: Track residual for PIO transfers
         [fd47d919d0c336e7c22862b51ee94927ffea227a]

Florian Fainelli (1):
      net: phy: Stop with excessive soft reset
         [6e2d85ec05591b739059f65fe8438c9c5999f7d8]

Florian Westphal (4):
      netfilter: nf_tables: don't use position attribute on rule replacement
         [447750f281abef547be44fdcfe3bc4447b3115a8]
      netfilter: nf_tables: fix oob access
         [3e38df136e453aa69eb4472108ebce2fb00b1ba6]
      netfilter: nf_tables: fix use-after-free when deleting compat expressions
         [29e3880109e357fdc607b4393f8308cef6af9413]
      netfilter: x_tables: add and use xt_check_proc_name
         [b1d0a5d0cba4597c0394997b2d5fced3e3841b4e]

Frank Sorenson (1):
      sunrpc: correct the computation for page_ptr when truncating
         [5d7a5bcb67c70cbc904057ef52d3fcfeb24420bb]

François Cami (1):
      libata: Apply NOLPM quirk for SAMSUNG PM830 CXM13D1Q.
         [76936e9a6df17b89481bd2655c8684291afbe656]

Geert Uytterhoeven (4):
      iommu/ipmmu-vmsa: Fix crash on early domain free
         [e5b78f2e349eef5d4fca5dc1cf5a3b4b2cc27abd]
      thermal: rcar: Make error and remove paths symmetrical with init
         [ac71c7025ebc1ed25114b1be77dc60b7f8cb8544]
      thermal: rcar_thermal: Prevent doing work after unbind
         [697ee786f15d7b65c7f3045d45fe3a05d28e0911]
      thermal: rcar_thermal: Prevent hardware access during system suspend
         [3a31386217628ffe2491695be2db933c25dde785]

Gustavo A. R. Silva (2):
      drivers/misc/sgi-gru: fix Spectre v1 vulnerability
         [fee05f455ceb5c670cbe48e2f9454ebc4a388554]
      drm/ioctl: Fix Spectre v1 vulnerabilities
         [505b5240329b922f21f91d5b5d1e535c805eca6d]

H Hartley Sweeten (2):
      staging: comedi: quatech_daqp_cs: fix bug in  daqp_ao_insn_write()
         [e024181b02ed6b833358bede3f2d0c52cb5fb6bc]
      staging: comedi: quatech_daqp_cs: use comedi_timeout() in ao (*insn_write)
         [e031642eccc040648b09cfc7d632e2e8d0b6f94f]

H. Peter Anvin (2):
      arch/alpha, termios: implement BOTHER, IBSHIFT and termios2
         [d0ffb805b729322626639336986bc83fc2e60871]
      termios, tty/tty_baudrate.c: fix buffer overrun
         [991a25194097006ec1e0d2e0814ff920e59e3465]

Halil Pasic (2):
      virtio/s390: avoid race on vcdev->config
         [2448a299ec416a80f699940a86f4a6d9a4f643b1]
      virtio/s390: fix race in ccw_io_helper()
         [78b1a52e05c9db11d293342e8d6d8a230a04b4e7]

Hangbin Liu (1):
      team: no need to do team_notify_peers or team_mcast_rejoin when disabling port
         [5ed9dc99107144f83b6c1bb52a69b58875baf540]

Hans Verkuil (1):
      media: vb2: don't call __vb2_queue_cancel if vb2_start_streaming failed
         [04990215dec43c424daff00d1f622167b8aafd1f]

Hans de Goede (3):
      ACPI / platform: Add SMB0001 HID to forbidden_id_list
         [2bbb5fa37475d7aa5fa62f34db1623f3da2dfdfa]
      iio/hid-sensors: Fix IIO_CHAN_INFO_RAW returning wrong values for signed numbers
         [0145b50566e7de5637e80ecba96c7f0e6fff1aad]
      libata: Apply NOLPM quirk for SAMSUNG MZMPC128HBFU-000MV SSD
         [b5b4d3a52c8fd6e3fc6469c5a64ca0139c07229e]

Harry Pan (1):
      usb: quirk: add no-LPM quirk on SanDisk Ultra Flair device
         [2f2dde6ba89b1ef1fe23c1138131b315d9aa4019]

He Zhe (3):
      kgdboc: Passing ekgdboc to command line causes panic
         [1bd54d851f50dea6af30c3e6ff4f3e9aab5558f9]
      printk: Fix panic caused by passing log_buf_len to command line
         [277fcdb2cfee38ccdbe07e705dbd4896ba0c9930]
      x86/corruption-check: Fix panic in memory_corruption_check() when boot option without value is provided
         [ccde460b9ae5c2bd5e4742af0a7f623c2daad566]

Helge Deller (1):
      parisc: Fix map_pages() to not overwrite existing pte entries
         [3c229b3f2dd8133f61bb81d3cb018be92f4bba39]

Himanshu Madhani (1):
      scsi: qla2xxx: Fix incorrect port speed being set for FC adapters
         [4c1458df9635c7e3ced155f594d2e7dfd7254e21]

Hou Tao (1):
      jffs2: free jffs2_sb_info through jffs2_kill_sb()
         [92e2921f7eee63450a5f953f4b15dc6210219430]

Huacai Chen (1):
      hwmon: (w83795) temp4_type has writable permission
         [09aaf6813cfca4c18034fda7a43e68763f34abb1]

Hui Peng (1):
      ALSA: usb-audio: Fix UAF decrement if card has no live interfaces in card.c
         [5f8cf712582617d523120df67d392059eaf2fc4b]

Ido Schimmel (1):
      rtnetlink: Disallow FDB configuration for non-Ethernet device
         [da71577545a52be3e0e9225a946e5fd79cfab015]

Ilya Dryomov (1):
      libceph: bump CEPH_MSG_MAX_DATA_LEN
         [94e6992bb560be8bffb47f287194adf070b57695]

Ingo Molnar (1):
      timer/debug: Change /proc/timer_list from 0444 to 0400
         [8e7df2b5b7f245c9bd11064712db5cb69044a362]

Jakub Kicinski (1):
      net: sched: gred: pass the right attribute to gred_change_table_def()
         [38b4f18d56372e1e21771ab7b0357b853330186c]

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix possible use of uninitialized field
         [cec83ff1241ec98113a19385ea9e9cfa9aa4125b]

Jason Wang (1):
      vhost: make sure used idx is seen before log in vhost_add_used_n()
         [841df922417eb82c835e93d4b93eb6a68c99d599]

Jeff Mahoney (1):
      btrfs: fix error handling in btrfs_dev_replace_start
         [5c06147128fbbdf7a84232c5f0d808f53153defe]

Jeff Moyer (1):
      aio: fix spectre gadget in lookup_ioctx
         [a538e3ff9dabcdf6c3f477a373c629213d1c3066]

Jens Axboe (2):
      floppy: fix race condition in __floppy_read_block_0()
         [de7b75d82f70c5469675b99ad632983c50b6f7e7]
      scsi: sd: use mempool for discard special page
         [61cce6f6eeced5ddd9cac55e807fe28b4f18c1ba]

Jeremy Cline (1):
      ALSA: hda - Add mic quirk for the Lenovo G50-30 (17aa:3905)
         [e7bb6ad5685f05685dd8a6a5eda7bfcd14d5f95b]

Jim Mattson (2):
      KVM: nVMX: Always reflect #NM VM-exits to L1
         [3c6e099fa15fdb6fb1892199ed8709012e1294f2]
      kvm: svm: Ensure an IBPB on all affected CPUs when freeing a vmcb
         [fd65d3142f734bc4376053c8d75670041903134d]

Jiri Kosina (1):
      x86/speculation: Apply IBPB more strictly to avoid cross-process data leak
         [dbfe2953f63c640463c630746cd5d9de8b2f63ae]

Joe Jin (1):
      xen-swiotlb: use actually allocated size on check physical continuous
         [7250f422da0480d8512b756640f131b9b893ccda]

Johan Hovold (3):
      USB: serial: cypress_m8: fix interrupt-out transfer length
         [56445eef55cb5904096fed7a73cf87b755dfffc7]
      net: bcmgenet: fix OF child-node lookup
         [d397dbe606120a1ea1b11b0020c3f7a3852da5ac]
      of: add helper to lookup compatible child node
         [36156f9241cb0f9e37d998052873ca7501ad4b36]

John David Anglin (1):
      parisc: Fix address in HPMC IVA
         [1138b6718ff74d2a934459643e3754423d23b5e2]

Jorgen Hansen (2):
      VMCI: Resource wildcard match fixed
         [11924ba5e671d6caef1516923e2bd8c72929a3fe]
      VSOCK: Send reset control packet when socket is partially bound
         [a915b982d8f5e4295f64b8dd37ce753874867e88]

Josef Bacik (1):
      btrfs: wait on caching when putting the bg cache
         [3aa7c7a31c26321696b92841d5103461c6f3f517]

Juergen Gross (1):
      x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear
         [b2d7a075a1ccef2fb321d595802190c8e9b39004]

Julian Wiedmann (2):
      s390/qeth: fix length check in SNMP processing
         [9a764c1e59684c0358e16ccaafd870629f2cfe67]
      s390/qeth: invoke softirqs after napi_schedule()
         [4d19db777a2f32c9b76f6fd517ed8960576cb43e]

Junaid Shahid (1):
      kvm: mmu: Fix race in emulated page table writes
         [0e0fee5c539b61fdd098332e0e2cc375d9073706]

Jörgen Storvist (1):
      USB: serial: option: add Simcom SIM7500/SIM7600 (MBIM mode)
         [cc6730df08a291e51e145bc65e24ffb5e2f17ab6]

Kai-Heng Feng (4):
      ALSA: hda: Add support for AMD Stoney Ridge
         [3deef52ce10514ccdebba8e8ab85f9cebd0eb3f7]
      USB: Wait for extra delay time after USB_PORT_FEAT_RESET for quirky hub
         [781f0766cc41a9dd2e5d118ef4b1d5d89430257b]
      USB: quirks: Add no-lpm quirk for Raydium touchscreens
         [deefd24228a172d1b27d4a9adbfd2cdacd60ae64]
      USB: usb-storage: Add new IDs to ums-realtek
         [a84a1bcc992f0545a51d2e120b8ca2ef20e2ea97]

Kirill A. Shutemov (1):
      x86/mm: Fix regression with huge pages on PAE
         [70f1528747651b20c7769d3516ade369f9963237]

Krzysztof Kozlowski (1):
      clk: s2mps11: Fix matching when built as module and DT node contains compatible
         [8985167ecf57f97061599a155bb9652c84ea4913]

Ladi Prosek (1):
      KVM: x86: Add MSR_AMD64_DC_CFG to the list of ignored MSRs
         [405a353a0e20d09090ad96147da6afad9b0ce056]

Lars-Peter Clausen (1):
      iio: ad5064: Fix regulator handling
         [8911a43bc198877fad9f4b0246a866b26bb547ab]

Leon Romanovsky (1):
      RDMA/cm: Respect returned status of cm_init_av_by_path
         [e54b6a3bcd1ec972b25a164bdf495d9e7120b107]

Linus Torvalds (1):
      disable new gcc-7.1.1 warnings for now
         [bd664f6b3e376a8ef4990f87d08271cc2d01ba9a]

Loic Poulain (1):
      usb: chipidea: Prevent unbalanced IRQ disable
         [8b97d73c4d72a2abf58f8e49062a7ee1e5f1334e]

Lubomir Rintel (2):
      ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt
         [76f4e2c3b6a560cdd7a75b87df543e04d05a9e5f]
      libertas: don't set URB_ZERO_PACKET on IN USB transfer
         [6528d88047801b80d2a5370ad46fb6eff2f509e0]

Luca Coelho (1):
      iwlwifi: mvm: check return value of rs_rate_from_ucode_rate()
         [3d71c3f1f50cf309bd20659422af549bc784bfff]

Lukas Czerner (1):
      ext4: initialize retries variable in ext4_da_write_inline_data_begin()
         [625ef8a3acd111d5f496d190baf99d1a815bd03e]

Lukas Wunner (2):
      PCI/ASPM: Fix link_state teardown on device removal
         [aeae4f3e5c38d47bdaef50446dc0ec857307df68]
      genirq: Fix race on spurious interrupt detection
         [746a923b863a1065ef77324e1e43f19b1a3eab5c]

Maarten Jacobs (1):
      usb: cdc-acm: add entry for Hiro (Conexant) modem
         [63529eaa6164ef7ab4b907b25ac3648177e5e78f]

Maciej S. Szmigiero (1):
      pcmcia: Implement CLKRUN protocol disabling for Ricoh bridges
         [95691e3eddc41da2d1cd3cca51fecdfb46bd85bc]

Macpaul Lin (1):
      kgdboc: fix KASAN global-out-of-bounds bug in param_set_kgdboc_var()
         [dada6a43b0402eba438a17ac86fdc64ac56a4607]

Marc Kleine-Budde (4):
      can: dev: __can_get_echo_skb(): Don't crash the kernel if can_priv::echo_skb is accessed out of bounds
         [e7a6994d043a1e31d5b17706a22ce33d2a3e4cdc]
      can: dev: __can_get_echo_skb(): print error message, if trying to echo non existing skb
         [7da11ba5c5066dadc2e96835a6233d56d7b7764a]
      can: dev: __can_get_echo_skb(): replace struct can_frame by canfd_frame to access frame length
         [200f5c49f7a2cd694436bfc6cb0662b794c96736]
      can: dev: can_get_echo_skb(): factor out non sending code to __can_get_echo_skb()
         [a4310fa2f24687888ce80fdb0e88583561a23700]

Marco Felsch (1):
      media: tvp5150: fix width alignment during set_selection()
         [bd24db04101f45a9c1d874fe21b0c7eab7bcadec]

Marek Szyprowski (1):
      ARM: dts: exynos: Disable pull control for MAX8997 interrupts on Origen
         [f5e758b8358f6c27e8a351ddf0b441a64cdabb94]

Mathias Nyman (3):
      usb: xhci: Prevent bus suspend if a port connect change or polling state is detected
         [2f31a67f01a8beb22cae754c53522cb61a005750]
      xhci: Don't prevent USB2 bus suspend in state check intended for USB3 only
         [45f750c16cae3625014c14c77bd9005eda975d35]
      xhci: Prevent U1/U2 link pm states if exit latency is too long
         [0472bf06c6fd33c1a18aaead4c8f91e5a03d8d7b]

Mathias Payer (1):
      USB: check usb_get_extra_descriptor for proper size
         [704620afc70cf47abb9d6a1a57f3825d2bca49cf]

Mattias Jacobsson (1):
      USB: misc: appledisplay: add 20" Apple Cinema Display
         [f6501f49199097b99e4e263644d88c90d1ec1060]

Mauro Carvalho Chehab (3):
      media: em28xx: fix input name for Terratec AV 350
         [15644bfa195bd166d0a5ed76ae2d587f719c3dac]
      media: em28xx: make v4l2-compliance happier by starting sequence on zero
         [afeaade90db4c5dab93f326d9582be1d5954a198]
      media: em28xx: use a default format if TRY_FMT fails
         [f823ce2a1202d47110a7ef86b65839f0be8adc38]

Max Filippov (6):
      xtensa: add NOTES section to the linker script
         [4119ba211bc4f1bf638f41e50b7a0f329f58aa16]
      xtensa: enable coprocessors that are being flushed
         [2958b66694e018c552be0b60521fec27e8d12988]
      xtensa: fix boot parameters address translation
         [40dc948f234b73497c3278875eb08a01d5854d3f]
      xtensa: fix coprocessor context offset definitions
         [03bc996af0cc71c7f30c384d8ce7260172423b34]
      xtensa: fix coprocessor part of ptrace_{get,set}xregs
         [38a35a78c5e270cbe53c4fef6b0d3c2da90dd849]
      xtensa: make sure bFLT stack is 16 byte aligned
         [0773495b1f5f1c5e23551843f87b5ff37e7af8f7]

Michael Kelley (2):
      clockevents/drivers/i8253: Add support for PIT shutdown quirk
         [35b69a420bfb56b7b74cb635ea903db05e357bec]
      x86/hyper-v: Enable PIT shutdown quirk
         [1de72c706488b7be664a601cf3843bd01e327e58]

Michael Niewöhner (1):
      usb: core: quirks: add RESET_RESUME quirk for Cherry G230 Stream series
         [effd14f66cc1ef6701a19c5a56e39c35f4d395a5]

Michal Hocko (1):
      memory_hotplug: cond_resched in __remove_pages
         [dd33ad7b251f900481701b2a82d25de583867708]

Mike Kravetz (2):
      hugetlbfs: dirty pages as they are added to pagecache
         [22146c3ce98962436e401f7b7016a6f664c9ffb5]
      hugetlbfs: fix kernel BUG at fs/hugetlbfs/inode.c:444!
         [5e41540c8a0f0e98c337dda8b391e5dda0cde7cf]

Miklos Szeredi (3):
      fuse: cleanup fuse_file refcounting
         [267d84449f52349ee252db684ed95ede18e51744]
      fuse: fix blocked_waitq wakeup
         [908a572b80f6e9577b45e81b3dfe2e22111286b8]
      fuse: fix leaked notify reply
         [7fabaf303458fcabb694999d6fa772cc13d4e217]

Mikulas Patocka (2):
      mach64: fix display corruption on big endian machines
         [3c6c6a7878d00a3ac997a779c5b9861ff25dfcc8]
      mach64: fix image corruption due to reading accelerator registers
         [c09bcc91bb94ed91f1391bffcbe294963d605732]

Nadav Amit (1):
      media: uvcvideo: Fix uvc_alloc_entity() allocation alignment
         [89dd34caf73e28018c58cd193751e41b1f8bdc56]

Nathan Chancellor (2):
      clk: s2mps11: Add used attribute to s2mps11_dt_match
         [9c940bbe2bb47e03ca5e937d30b6a50bf9c0e671]
      misc: atmel-ssc: Fix section annotation on atmel_ssc_get_driver_data
         [7c97301285b62a41d6bceded7d964085fc8cc50f]

Naveen N. Rao (2):
      powerpc/pseries: Fix DTL buffer registration
         [db787af1b8a6b4be428ee2ea7d409dafcaa4a43c]
      powerpc/pseries: Fix how we iterate over the DTL entries
         [9258227e9dd1da8feddb07ad9702845546a581c9]

Nicholas Mc Guire (2):
      media: pci: cx23885: handle adding to list failure
         [c5d59528e24ad22500347b199d52b9368e686a42]
      usb: gadget: fsl_udc_core: check allocation return value and cleanup on failure
         [4ab2b48c98f2ec9712452d520a381917f91ac3d2]

Nicolas Dichtel (1):
      tun: forbid iface creation with rtnl ops
         [35b827b6d06199841a83839e8bb69c0cd13a28be]

Nicolas Huaman (1):
      ALSA: usb-audio: update quirk for B&W PX to remove microphone
         [c369c8db15d51fa175d2ba85928f79d16af6b562]

Nicolas Pitre (1):
      Cramfs: fix abad comparison when wrap-arounds occur
         [672ca9dd13f1aca0c17516f76fc5b0e8344b3e46]

Nikolay Borisov (1):
      btrfs: Always try all copies when reading extent buffers
         [f8397d69daef06d358430d3054662fb597e37c00]

Oliver Hartkopp (1):
      can: raw: check for CAN FD capable netdev in raw_sendmsg()
         [a43608fa77213ad5ac5f75994254b9f65d57cfa0]

Ondrej Mosnacek (1):
      crypto: lrw - Fix out-of bounds access on counter overflow
         [fbe1a850b3b1522e9fc22319ccbbcd2ab05328d2]

Pan Bian (5):
      btrfs: relocation: set trans to be NULL after ending transaction
         [42a657f57628402c73237547f0134e083e2f6764]
      exportfs: do not read dentry after free
         [2084ac6c505a58f7efdec13eba633c6aaa085ca5]
      ext2: fix potential use after free
         [ecebf55d27a11538ea84aee0be643dd953f830d5]
      hfs: do not free node before using
         [ce96a407adef126870b3f4a1b73529dd8aa80f49]
      rapidio/rionet: do not free skb before reading its length
         [cfc435198f53a6fa1f656d98466b24967ff457d0]

Paolo Bonzini (1):
      KVM: x86: remove code for lazy FPU handling
         [bd7e5b0899a429445cc6e3037c13f8b5ae3be903]

Parav Pandit (3):
      IB/cm: Avoid AV ah_attr overwriting during LAP message handling
         [a5c57d327272bdf3a8b19686eaca2ec683449e67]
      IB/cm: Fix sleeping while spin lock is held
         [33f93e1ebcf5acfaef06cda2d3e373730519e33e]
      IB/{cm, umad}: Handle av init error
         [0c4386ec77cfcd0ccbdbe8c2e67dd3a49b2a4c7f]

Paul Mackerras (1):
      powerpc: Fix COFF zImage booting on old powermacs
         [5564597d51c8ff5b88d95c76255e18b13b760879]

Paul Moore (1):
      cipso: don't use IPCB() to locate the CIPSO IP option
         [04f81f0154e4bf002be6f4d85668ce1257efa4d9]

Paulo Alcantara (1):
      cifs: Fix separator when building path from dentry
         [c988de29ca161823db6a7125e803d597ef75b49c]

Petr Machata (1):
      vxlan: Fix error path in __vxlan_dev_create()
         [6db9246871394b3a136cd52001a0763676563840]

Punnaiah Choudary Kalluri (1):
      net: macb: Fix race condition in driver when Rx frame is dropped
         [d4c216c54197d741ed8b7ca54f13645dfb3eacde]

Quinn Tran (1):
      scsi: qla2xxx: shutdown chip if reset fail
         [1e4ac5d6fe0a4af17e4b6251b884485832bf75a3]

Richard Genoud (2):
      dmaengine: at_hdmac: fix memory leak in at_dma_xlate()
         [98f5f932254b88ce828bc8e4d1642d14e5854caa]
      dmaengine: at_hdmac: fix module unloading
         [77e75fda94d2ebb86aa9d35fb1860f6395bf95de]

Richard Weinberger (2):
      um: Drop own definition of PTRACE_SYSEMU/_SINGLESTEP
         [0676b957c24bfb6e495449ba7b7e72c5b5d79233]
      um: Give start_idle_thread() a return code
         [7ff1e34bbdc15acab823b1ee4240e94623d50ee8]

Robbie Ko (1):
      Btrfs: fix cur_offset in the error case for nocow
         [506481b20e818db40b6198815904ecd2d6daee64]

Russell King (1):
      mmc: omap_hsmmc: fix DMA API warning
         [0b479790684192ab7024ce6a621f93f6d0a64d92]

Sagi Grimberg (1):
      iser: set sector for ambiguous mr status errors
         [24c3456c8d5ee6fc1933ca40f7b4406130682668]

Sakari Ailus (1):
      media: v4l: event: Add subscription to list before calling "add" operation
         [92539d3eda2c090b382699bbb896d4b54e9bdece]

Sandeep Singh (1):
      xhci: workaround CSS timeout on AMD SNPS 3.0 xHC
         [a7d57abcc8a5bdeb53bbf8e87558e8e0a2c2a29d]

Sebastian Parschauer (2):
      HID: Add quirk for Microsoft PIXART OEM mouse
         [e82e62e390d39c3819641cd721695702180d54fb]
      HID: Add quirk for Primax PIXART OEM mice
         [fb862c3b199d28bee238d52e8270eae8650d6cb0]

Sergei Shtylyov (1):
      spi: sh-msiof: fix deferred probing
         [f34c6e6257aa477cdfe7e9bbbecd3c5648ecda69]

Serhey Popovych (1):
      tun: Consistently configure generic netdev params via rtnetlink
         [df52eab23d703142c766ac00bdb8db19d71238d0]

Spencer E. Olson (1):
      staging: comedi: ni_mio_common: protect register write overflow
         [1cbca5852d6c16e85a21487a15d211195aacd4a1]

Stefan Nuernberger (1):
      net/ipv4: defensive cipso option parsing
         [076ed3da0c9b2f88d9157dbe7044a45641ae369e]

Stefano Brivio (1):
      ipv6/ndisc: Preserve IPv6 control buffer if protocol error handlers are called
         [ee1abcf689353f36d9322231b4320926096bdee0]

Steve French (3):
      smb3: allow stats which track session and share reconnects to be reset
         [2c887635cd6ab3af619dc2be94e5bf8f2e172b78]
      smb3: do not attempt cifs operation in smb3 query info error path
         [1e77a8c204c9d1b655c61751b8ad0fde22421dbb]
      smb3: on kerberos mount if server doesn't specify auth type use krb5
         [926674de6705f0f1dbf29a62fd758d0977f535d6]

Steven Rostedt (2):
      tracing: Fix memory leak in set_trigger_filter()
         [3cec638b3d793b7cacdec5b8072364b41caeb0e1]
      tracing: Fix memory leak of instance function hash filters
         [2840f84f74035e5a535959d5f17269c69fa6edc5]

Sven Eckelmann (3):
      batman-adv: Check total_size when queueing fragments
         [53e771457e823fbc21834f60508c42a4270534fd]
      batman-adv: Expand merged fragment buffer for full packet
         [d7d8bbb40a5b1f682ee6589e212934f4c6b8ad60]
      batman-adv: Use only queued fragments when merging
         [83e8b87721f21b26b843633caca8ef453e943623]

Taehee Yoo (1):
      netfilter: xt_IDLETIMER: add sysfs filename checking routine
         [54451f60c8fa061af9051a53be9786393947367c]

Takashi Iwai (8):
      ALSA: ac97: Fix incorrect bit shift at AC97-SPSA control write
         [7194eda1ba0872d917faf3b322540b4f57f11ba5]
      ALSA: control: Fix race between adding and removing a user element
         [e1a7bfe3807974e66f971f2589d4e0197ec0fced]
      ALSA: oss: Use kvzalloc() for local buffer allocations
         [65766ee0bf7fe8b3be80e2e1c3ef54ad59b29476]
      ALSA: pcm: Call snd_pcm_unlink() conditionally at closing
         [b51abed8355e5556886623b2772fa6b7598d2282]
      ALSA: sparc: Fix invalid snd_free_pages() at error path
         [9a20332ab373b1f8f947e0a9c923652b32dab031]
      ALSA: usb-audio: Avoid nested autoresume calls
         [47ab154593827b1a8f0713a2b9dd445753d551d8]
      ALSA: usb-audio: Replace probing flag with active refcount
         [a6da499b76b1a75412f047ac388e9ffd69a5c55b]
      ALSA: wss: Fix invalid snd_free_pages() at error path
         [7b69154171b407844c273ab4c10b5f0ddcd6aa29]

Takashi Sakamoto (1):
      ALSA: control: fix failure to return numerical ID in 'add' event
         [d34890cf4113397625a6629d71749fa638a7a734]

Tang Junhui (1):
      bcache: fix miss key refill->end in writeback
         [2d6cb6edd2c7fb4f40998895bda45006281b1ac5]

Tang.Junhui (1):
      bcache: fix wrong cache_misses statistics
         [c157313791a999646901b3e3c6888514ebc36d62]

Tarick Bedeir (1):
      net/mlx4_core: Correctly set PFC param if global pause is turned off.
         [bd5122cd1e0644d8bd8dd84517c932773e999766]

Theodore Ts'o (4):
      ext4: avoid possible double brelse() in add_new_gdb() on error path
         [4f32c38b4662312dd3c5f113d8bdd459887fb773]
      ext4: fix EXT4_IOC_SWAP_BOOT
         [18aded17492088962ef43f00825179598b3e8c58]
      ext4: fix possible leak of sbi->s_group_desc_leak in error path
         [9e463084cdb22e0b56b2dfbc50461020409a5fd3]
      ext4: fix use-after-free race in ext4_remount()'s error path
         [33458eaba4dfe778a426df6a19b7aad2ff9f7eec]

Thomas Gleixner (2):
      mac80211_hwsim: Replace bogus hrtimer clockid
         [8fbcfeb8a9cc803464d6c166e7991913711c612c]
      x86/eisa: Add missing include
         [ef1d4deab953ecb1dfcf9f167043bda8b3f14a11]

Thomas Zimmermann (1):
      drm/ast: Remove existing framebuffers before loading driver
         [5478ad10e7850ce3d8b7056db05ddfa3c9ddad9a]

Thor Thayer (1):
      net: stmmac: Fix RX packet size > 8191
         [8137b6ef0ce469154e5cf19f8e7fe04d9a72ac5e]

Tom Lendacky (1):
      x86/mm: Simplify p[g4um]d_page() macros
         [fd7e315988b784509ba3f1b42f539bd0b1fca9bb]

Tomasz Figa (1):
      power: supply: max8998-charger: Fix platform data retrieval
         [cb90a2c6f77fe9b43d1e3f759bb2f13fe7fa1811]

Tony Luck (1):
      EDAC, {i7core,sb,skx}_edac: Fix uncorrected error counting
         [432de7fd7630c84ad24f1c2acd1e3bb4ce3741ca]

Tore Anderson (1):
      USB: serial: option: add HP lt4132
         [d57ec3c83b5153217a70b561d4fb6ed96f2f7a25]

Toshi Kani (3):
      x86/asm: Add pud/pmd mask interfaces to handle large  PAT bit
         [4be4c1fb9a754b100466ebaec50f825be0b2050b]
      x86/asm: Fix pud/pmd interfaces to handle large PAT bit
         [f70abb0fc3da1b2945c92751ccda2744081bf2b7]
      x86/asm: Move PUD_PAGE macros to page_types.h
         [832102671855f73962e7a04fdafd48b9385ea5c6]

Trond Myklebust (3):
      NFSv4: Don't exit the state manager without clearing NFS4CLNT_MANAGER_RUNNING
         [21a446cf186570168b7281b154b1993968598aca]
      SUNRPC: Fix a potential race in xprt_connect()
         [0a9a4304f3614e25d9de9b63502ca633c01c0d70]
      nfsd: Fix an Oops in free_session()
         [bb6ad5572c0022e17e846b382d7413cdcf8055be]

Ulf Hansson (2):
      mmc: core: Reset HPI enabled state during re-init and in case of errors
         [a0741ba40a009f97c019ae7541dc61c1fdf41efb]
      mmc: core: Use a minimum 1600ms timeout when enabling CACHE ctrl
         [e3ae3401aa19432ee4943eb0bbc2ec704d07d793]

Vasily Averin (10):
      ext4: add missing brelse() add_new_gdb_meta_bg()'s error path
         [61a9c11e5e7a0dab5381afa5d9d4dd5ebf18f7a0]
      ext4: add missing brelse() in set_flexbg_block_bitmap()'s error path
         [cea5794122125bf67559906a0762186cf417099c]
      ext4: add missing brelse() update_backups()'s error path
         [ea0abbb648452cdb6e1734b702b6330a7448fcf8]
      ext4: avoid buffer leak in ext4_orphan_add() after prior errors
         [feaf264ce7f8d54582e2f66eb82dd9dd124c94f3]
      ext4: avoid potential extra brelse in setup_new_flex_group_blocks()
         [9e4028935cca3f9ef9b6a90df9da6f1f94853536]
      ext4: fix buffer leak in __ext4_read_dirblock() on error path
         [de59fae0043f07de5d25e02ca360f7d57bfa5866]
      ext4: fix buffer leak in ext4_xattr_move_to_block() on error path
         [6bdc9977fcdedf47118d2caf7270a19f4b6d8a8f]
      ext4: fix missing cleanup if ext4_alloc_flex_bg_array() fails while resizing
         [f348e2241fb73515d65b5d77dd9c174128a7fbf2]
      ext4: fix possible inode leak in the retry loop of ext4_resize_fs()
         [db6aee62406d9fbb53315fcddd81f1dc271d49fa]
      ext4: release bs.bh before re-using in ext4_xattr_block_find()
         [45ae932d246f721e6584430017176cbcadfde610]

Vasyl Vavrychuk (1):
      mac80211_hwsim: Timer should be initialized before device registered
         [a1881c9b8a1edef0a5ae1d5c1b61406fe3402114]

Ville Syrjälä (2):
      drm/i915: Disable LP3 watermarks on all SNB machines
         [03981c6ebec4fc7056b9b45f847393aeac90d060]
      drm: Rewrite drm_ioctl_flags() to resemble the new drm_ioctl() code
         [7ef5f82b100716b23de7d2da6ff602b0842e5804]

Wanpeng Li (1):
      KVM: X86: Fix NULL deref in vcpu_scan_ioapic
         [dcbd3e49c2f0b2c2d8a321507ff8f3de4af76d7c]

Wei Yongjun (1):
      IB/mthca: Fix error return code in __mthca_init_one()
         [39f2495618c5e980d2873ea3f2d1877dd253e07a]

Wenwen Wang (1):
      dm ioctl: harden copy_params()'s copy_from_user() from malicious users
         [800a7340ab7dd667edf95e74d8e4f23a17e87076]

Wolfram Sang (1):
      mmc: core: use mrq->sbc when sending CMD23 for RPMB
         [a44f7cb937321d4961bfc8f28912126b06e701c5]

Xin Long (1):
      l2tp: fix a sock refcnt leak in l2tp_tunnel_register
         [f8504f4ca0a0e9f84546ef86e00b24d2ea9a0bd2]

Y.C. Chen (2):
      drm/ast: change resolution may cause screen blurred
         [1a37bd823891568f8721989aed0615835632d81a]
      drm/ast: fixed cursor may disappear sometimes
         [7989b9ee8bafe5cc625381dd0c3c4586de27ca26]

Yogesh Gaur (1):
      mtd: spi-nor: fsl-quadspi: fix api naming typo _init_ahb_read
         [dd50a1c4e56d6d2ea753f87a35b1f1e09cb877d7]

Young Xiao (1):
      staging: rtl8712: Fix possible buffer overrun
         [300cd664865bed5d50ae0a42fb4e3a6f415e8a10]

YueHaibing (3):
      SUNRPC: drop pointless static qualifier in xdr_get_next_encode_buffer()
         [025911a5f4e36955498ed50806ad1b02f0f76288]
      exportfs: fix 'passing zero to ERR_PTR()' warning
         [909e22e05353a783c526829427e9a8de122fba9c]
      sysv: return 'err' instead of 0 in __sysv_write_inode
         [c4b7d1ba7d263b74bb72e9325262a67139605cde]

Yujuan.Qi (1):
      Cipso: cipso_v4_optptr enter infinite loop
         [40413955ee265a5e42f710940ec78f5450d49149]

Zhimin Gu (1):
      x86, hibernate: Fix nosave_regions setup for hibernation
         [cc55f7537db6af371e9c1c6a71161ee40f918824]

 Makefile                                         |   8 +-
 arch/alpha/include/asm/termios.h                 |   8 +-
 arch/alpha/include/uapi/asm/ioctls.h             |   5 +
 arch/alpha/include/uapi/asm/termbits.h           |  17 ++++
 arch/arm/boot/dts/exynos4210-origen.dts          |   9 ++
 arch/arm/include/asm/uaccess.h                   |   2 +-
 arch/arm/mach-mmp/include/mach/cputype.h         |   6 +-
 arch/arm/mach-omap1/board-ams-delta.c            |   3 +
 arch/mips/include/asm/syscall.h                  |   2 +-
 arch/parisc/kernel/entry.S                       |   2 +-
 arch/parisc/kernel/traps.c                       |   3 +-
 arch/parisc/mm/init.c                            |   8 +-
 arch/powerpc/boot/crt0.S                         |   4 +-
 arch/powerpc/platforms/pseries/dtl.c             |   4 +-
 arch/s390/hypfs/hypfs_vm.c                       |   2 +-
 arch/s390/include/asm/timex.h                    |  10 +-
 arch/sparc/kernel/signal_32.c                    |   4 +-
 arch/um/os-Linux/skas/process.c                  |   5 +
 arch/x86/boot/boot.h                             |   1 -
 arch/x86/boot/compressed/eboot.c                 |   3 +-
 arch/x86/boot/video-mode.c                       |   2 +
 arch/x86/boot/video.c                            |   2 +
 arch/x86/include/asm/kvm_host.h                  |   2 -
 arch/x86/include/asm/page_64_types.h             |   3 -
 arch/x86/include/asm/page_types.h                |  13 ++-
 arch/x86/include/asm/pgtable-3level.h            |   7 +-
 arch/x86/include/asm/pgtable.h                   |  19 ++--
 arch/x86/include/asm/pgtable_types.h             |  34 ++++++-
 arch/x86/include/asm/x86_init.h                  |   1 -
 arch/x86/include/uapi/asm/msr-index.h            |   1 +
 arch/x86/kernel/check.c                          |  15 +++
 arch/x86/kernel/cpu/mshyperv.c                   |  11 +++
 arch/x86/kernel/cpu/mtrr/if.c                    |   2 +
 arch/x86/kernel/eisa.c                           |   1 +
 arch/x86/kernel/setup.c                          |   2 +-
 arch/x86/kvm/mmu.c                               |  27 ++---
 arch/x86/kvm/svm.c                               |  62 ++++--------
 arch/x86/kvm/vmx.c                               | 121 +++--------------------
 arch/x86/kvm/x86.c                               |  21 ++--
 arch/x86/mm/tlb.c                                |  29 ++++--
 arch/x86/um/shared/sysdep/ptrace_32.h            |  10 --
 arch/x86/vdso/vclock_gettime.c                   |   8 +-
 arch/xtensa/boot/Makefile                        |   2 +-
 arch/xtensa/include/asm/processor.h              |   6 +-
 arch/xtensa/kernel/asm-offsets.c                 |  16 +--
 arch/xtensa/kernel/head.S                        |   7 +-
 arch/xtensa/kernel/process.c                     |   5 +-
 arch/xtensa/kernel/ptrace.c                      |  42 +++++++-
 arch/xtensa/kernel/vmlinux.lds.S                 |   1 +
 crypto/lrw.c                                     |   7 +-
 drivers/acpi/acpi_platform.c                     |   1 +
 drivers/acpi/acpica/dsopcode.c                   |   4 +
 drivers/ata/libata-core.c                        |   5 +
 drivers/block/floppy.c                           |   3 +-
 drivers/clk/clk-s2mps11.c                        |  27 +++++
 drivers/clocksource/i8253.c                      |  14 ++-
 drivers/devfreq/devfreq.c                        |  53 +++++++++-
 drivers/dma/at_hdmac.c                           |  10 +-
 drivers/edac/i7core_edac.c                       |   1 +
 drivers/edac/sb_edac.c                           |   1 +
 drivers/gpio/gpio-max7301.c                      |  12 +--
 drivers/gpu/drm/ast/ast_drv.c                    |  21 ++++
 drivers/gpu/drm/ast/ast_mode.c                   |   3 +-
 drivers/gpu/drm/drm_drv.c                        |  21 ++--
 drivers/gpu/drm/i915/i915_gem.c                  |  15 ++-
 drivers/gpu/drm/i915/intel_pm.c                  |  43 +++++++-
 drivers/hid/hid-ids.h                            |   3 +
 drivers/hid/hid-sensor-hub.c                     |  13 ++-
 drivers/hid/uhid.c                               |  13 +++
 drivers/hid/usbhid/hid-quirks.c                  |   3 +
 drivers/hid/usbhid/hiddev.c                      |  18 +++-
 drivers/hv/channel.c                             |   8 ++
 drivers/hv/hv_kvp.c                              |  24 ++++-
 drivers/hv/vmbus_drv.c                           |  20 ++++
 drivers/hwmon/pmbus/pmbus.c                      |   2 +
 drivers/hwmon/pmbus/pmbus_core.c                 |   5 +-
 drivers/hwmon/w83795.c                           |   2 +-
 drivers/iio/accel/hid-sensor-accel-3d.c          |   5 +-
 drivers/iio/adc/at91_adc.c                       |   6 +-
 drivers/iio/dac/ad5064.c                         |  55 ++++++++---
 drivers/iio/gyro/hid-sensor-gyro-3d.c            |   5 +-
 drivers/iio/light/hid-sensor-als.c               |   8 +-
 drivers/iio/light/hid-sensor-prox.c              |   8 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c    |   8 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c     |   8 +-
 drivers/iio/pressure/hid-sensor-press.c          |   8 +-
 drivers/infiniband/core/cm.c                     |  42 +++++---
 drivers/infiniband/core/user_mad.c               |  10 +-
 drivers/infiniband/hw/mthca/mthca_main.c         |   3 +-
 drivers/infiniband/ulp/iser/iser_verbs.c         |   7 +-
 drivers/input/keyboard/matrix_keypad.c           |  23 +++--
 drivers/iommu/ipmmu-vmsa.c                       |   3 +
 drivers/md/bcache/btree.c                        |   2 +-
 drivers/md/bcache/request.c                      |   6 +-
 drivers/md/dm-ioctl.c                            |  18 ++--
 drivers/media/i2c/tvp5150.c                      |  14 ++-
 drivers/media/pci/cx23885/altera-ci.c            |  10 ++
 drivers/media/usb/cx231xx/cx231xx-video.c        |   2 +-
 drivers/media/usb/em28xx/em28xx-cards.c          |   4 +-
 drivers/media/usb/em28xx/em28xx-video.c          |   8 +-
 drivers/media/usb/uvc/uvc_driver.c               |   2 +-
 drivers/media/v4l2-core/v4l2-event.c             |  43 ++++----
 drivers/media/v4l2-core/videobuf2-core.c         |   4 +-
 drivers/misc/atmel-ssc.c                         |   2 +-
 drivers/misc/genwqe/card_base.h                  |   2 +-
 drivers/misc/genwqe/card_dev.c                   |   9 +-
 drivers/misc/sgi-gru/grukdump.c                  |   4 +
 drivers/misc/vmw_vmci/vmci_resource.c            |   3 +-
 drivers/mmc/card/block.c                         |  15 ++-
 drivers/mmc/core/mmc.c                           |  19 +++-
 drivers/mmc/host/omap.c                          |  11 ++-
 drivers/mmc/host/omap_hsmmc.c                    |  12 ++-
 drivers/mtd/devices/Kconfig                      |   2 +-
 drivers/mtd/spi-nor/fsl-quadspi.c                |  14 ++-
 drivers/net/can/dev.c                            |  48 ++++++---
 drivers/net/ethernet/broadcom/genet/bcmmii.c     |   2 +-
 drivers/net/ethernet/cadence/macb.c              |  22 ++++-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c  |   4 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4.h        |   4 +-
 drivers/net/ethernet/neterion/vxge/vxge-config.c |   2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.c  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h     |   3 +-
 drivers/net/ethernet/stmicro/stmmac/descs_com.h  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c  |   2 +-
 drivers/net/phy/phy_device.c                     |   2 -
 drivers/net/rionet.c                             |   2 +-
 drivers/net/team/team.c                          |   2 -
 drivers/net/tun.c                                |   2 +-
 drivers/net/vxlan.c                              |  13 ++-
 drivers/net/wireless/iwlwifi/mvm/rs.c            |  29 ++++--
 drivers/net/wireless/libertas/if_usb.c           |   2 -
 drivers/net/wireless/libertas_tf/if_usb.c        |   5 +-
 drivers/net/wireless/mac80211_hwsim.c            |   8 +-
 drivers/of/base.c                                |  25 +++++
 drivers/pci/pcie/aspm.c                          |   2 +-
 drivers/pci/quirks.c                             |   4 +
 drivers/pci/remove.c                             |   4 +-
 drivers/pcmcia/ricoh.h                           |  35 +++++++
 drivers/pcmcia/yenta_socket.c                    |   3 +-
 drivers/power/max8998_charger.c                  |   2 +-
 drivers/rtc/rtc-hid-sensor-time.c                |   2 +-
 drivers/s390/block/dasd_alias.c                  |   3 +-
 drivers/s390/kvm/virtio_ccw.c                    |  17 +++-
 drivers/s390/net/qeth_core_main.c                |  27 +++--
 drivers/s390/net/qeth_l2_main.c                  |   3 +
 drivers/s390/net/qeth_l3_main.c                  |   3 +
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                |   3 +-
 drivers/scsi/esp_scsi.c                          |   1 +
 drivers/scsi/esp_scsi.h                          |   2 +
 drivers/scsi/mac_esp.c                           |   2 +
 drivers/scsi/qla2xxx/qla_init.c                  |   2 +-
 drivers/scsi/qla2xxx/qla_mbx.c                   |   5 +-
 drivers/scsi/sd.c                                |  17 +++-
 drivers/spi/spi-sh-msiof.c                       |   4 +-
 drivers/staging/comedi/drivers/ni_mio_common.c   |  22 +++--
 drivers/staging/comedi/drivers/quatech_daqp_cs.c |  25 ++++-
 drivers/staging/rtl8712/mlme_linux.c             |   2 +-
 drivers/staging/rtl8712/rtl871x_mlme.c           |   2 +-
 drivers/thermal/rcar_thermal.c                   |   9 +-
 drivers/tty/serial/kgdboc.c                      |   9 +-
 drivers/tty/tty_ioctl.c                          |   4 +-
 drivers/uio/uio.c                                |   7 +-
 drivers/usb/chipidea/otg.h                       |   3 +-
 drivers/usb/class/cdc-acm.c                      |   3 +
 drivers/usb/core/hub.c                           |  16 ++-
 drivers/usb/core/quirks.c                        |  18 ++++
 drivers/usb/core/usb.c                           |   6 +-
 drivers/usb/dwc3/gadget.c                        |   6 --
 drivers/usb/gadget/fsl_udc_core.c                |  30 +++++-
 drivers/usb/host/hwa-hc.c                        |   2 +-
 drivers/usb/host/xhci-hub.c                      |  67 +++++++++----
 drivers/usb/host/xhci-pci.c                      |   4 +
 drivers/usb/host/xhci-ring.c                     |   2 +-
 drivers/usb/host/xhci.c                          |  42 +++++++-
 drivers/usb/host/xhci.h                          |   5 +-
 drivers/usb/misc/appledisplay.c                  |   2 +
 drivers/usb/serial/cypress_m8.c                  |   2 +-
 drivers/usb/serial/option.c                      |   8 +-
 drivers/usb/storage/unusual_realtek.h            |  10 ++
 drivers/vhost/vhost.c                            |   2 +
 drivers/video/fbdev/aty/mach64_accel.c           |  28 +++---
 drivers/w1/masters/omap_hdq.c                    |   2 +
 drivers/xen/swiotlb-xen.c                        |   6 ++
 fs/aio.c                                         |   2 +
 fs/btrfs/dev-replace.c                           |   7 +-
 fs/btrfs/disk-io.c                               |  10 +-
 fs/btrfs/extent-tree.c                           |   1 +
 fs/btrfs/file.c                                  |  30 ++++--
 fs/btrfs/free-space-cache.c                      |   2 +
 fs/btrfs/inode.c                                 |   6 +-
 fs/btrfs/ioctl.c                                 |  12 ++-
 fs/btrfs/qgroup.c                                |   3 +-
 fs/btrfs/relocation.c                            |   1 +
 fs/btrfs/super.c                                 |   1 +
 fs/cifs/cifs_debug.c                             |   3 +
 fs/cifs/cifs_spnego.c                            |   6 +-
 fs/cifs/dir.c                                    |   2 +-
 fs/cifs/inode.c                                  |  10 +-
 fs/cramfs/inode.c                                |   3 +-
 fs/exportfs/expfs.c                              |   3 +-
 fs/ext2/xattr.c                                  |   2 +-
 fs/ext4/ext4.h                                   |   3 +-
 fs/ext4/inline.c                                 |   2 +-
 fs/ext4/ioctl.c                                  |  33 +++++--
 fs/ext4/namei.c                                  |   5 +-
 fs/ext4/resize.c                                 |  28 +++---
 fs/ext4/super.c                                  |  91 ++++++++++-------
 fs/ext4/xattr.c                                  |   4 +
 fs/fuse/dev.c                                    |  19 +++-
 fs/fuse/dir.c                                    |   4 +-
 fs/fuse/file.c                                   |  37 +++----
 fs/fuse/fuse_i.h                                 |   3 +-
 fs/gfs2/ops_fstype.c                             |   3 +
 fs/hfs/btree.c                                   |   3 +-
 fs/jffs2/super.c                                 |   4 +-
 fs/lockd/host.c                                  |   2 +-
 fs/namespace.c                                   |  22 ++++-
 fs/nfs/nfs4state.c                               |   8 +-
 fs/ocfs2/dir.c                                   |   3 +-
 fs/sysv/inode.c                                  |   2 +-
 fs/xfs/xfs_stats.c                               |   2 +-
 include/linux/can/dev.h                          |   1 +
 include/linux/ceph/libceph.h                     |   8 +-
 include/linux/hid-sensor-hub.h                   |   4 +-
 include/linux/i8253.h                            |   1 +
 include/linux/kvm_host.h                         |   2 -
 include/linux/netfilter/x_tables.h               |   2 +
 include/linux/of.h                               |   8 ++
 include/linux/ptrace.h                           |  21 +++-
 include/linux/uaccess.h                          |   3 +
 include/linux/usb.h                              |   4 +-
 include/linux/usb/quirks.h                       |   3 +
 include/net/cipso_ipv4.h                         |  25 +++--
 kernel/bounds.c                                  |   4 +-
 kernel/events/uprobes.c                          |  12 ++-
 kernel/irq/manage.c                              |   8 +-
 kernel/printk/printk.c                           |   7 +-
 kernel/ptrace.c                                  |  10 ++
 kernel/signal.c                                  |   2 +-
 kernel/time/timer_list.c                         |   2 +-
 kernel/trace/ftrace.c                            |   1 +
 kernel/trace/trace_events_trigger.c              |   6 +-
 mm/hugetlb.c                                     |  29 +++++-
 mm/memory_hotplug.c                              |   2 +
 net/batman-adv/fragmentation.c                   |  20 ++--
 net/batman-adv/types.h                           |   2 +
 net/can/raw.c                                    |  15 +--
 net/core/dev.c                                   |   4 +
 net/core/rtnetlink.c                             |  13 +++
 net/ipv4/cipso_ipv4.c                            |  62 ++++++++----
 net/ipv6/ip6_fib.c                               |   6 +-
 net/ipv6/ip6_vti.c                               |   1 +
 net/ipv6/ndisc.c                                 |   3 +-
 net/l2tp/l2tp_core.c                             |   9 +-
 net/llc/af_llc.c                                 |  13 +--
 net/mac80211/iface.c                             |   2 +
 net/mac80211/rx.c                                |   1 +
 net/mac80211/tx.c                                |   4 +-
 net/netfilter/nf_tables_api.c                    |  22 ++---
 net/netfilter/nft_compat.c                       |   3 +-
 net/netfilter/x_tables.c                         |  30 ++++++
 net/netfilter/xt_IDLETIMER.c                     |  20 ++++
 net/netfilter/xt_hashlimit.c                     |   5 +-
 net/netfilter/xt_recent.c                        |   6 +-
 net/netlabel/netlabel_kapi.c                     |  15 ++-
 net/sched/sch_gred.c                             |   2 +-
 net/sunrpc/auth_gss/auth_gss.c                   |   4 +
 net/sunrpc/svc_xprt.c                            |   2 +-
 net/sunrpc/xdr.c                                 |   7 +-
 net/sunrpc/xprt.c                                |  11 ++-
 net/vmw_vsock/vmci_transport.c                   |  67 +++++++++----
 net/xfrm/xfrm_state.c                            |   2 +-
 security/integrity/ima/ima_fs.c                  |   6 +-
 sound/core/control.c                             |  79 ++++++++-------
 sound/core/oss/pcm_oss.c                         |   2 +-
 sound/core/oss/pcm_plugin.c                      |   2 +-
 sound/core/pcm_native.c                          |   3 +-
 sound/isa/wss/wss_lib.c                          |   2 -
 sound/pci/ac97/ac97_codec.c                      |   2 +-
 sound/pci/ca0106/ca0106.h                        |   2 +-
 sound/pci/hda/hda_intel.c                        |   4 +
 sound/pci/hda/patch_conexant.c                   |   1 +
 sound/sparc/cs4231.c                             |   8 +-
 sound/usb/card.c                                 |  81 ++++++++++-----
 sound/usb/endpoint.c                             |  10 +-
 sound/usb/mixer.c                                |  32 ++----
 sound/usb/mixer_quirks.c                         | 112 ++++++++++-----------
 sound/usb/pcm.c                                  |  32 +++---
 sound/usb/proc.c                                 |   4 +-
 sound/usb/quirks-table.h                         |   9 +-
 sound/usb/usbaudio.h                             |  11 ++-
 tools/power/cpupower/bench/parse.c               |   2 +-
 293 files changed, 2221 insertions(+), 1084 deletions(-)

-- 
Ben Hutchings
Horngren's Observation:
              Among economists, the real world is often a special case.

