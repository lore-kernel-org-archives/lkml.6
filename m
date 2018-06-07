Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id zZCEJKlYGVsgAwAAmS7hNA
	; Thu, 07 Jun 2018 16:13:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C3ADE608B8; Thu,  7 Jun 2018 16:13:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 16B7E60115;
	Thu,  7 Jun 2018 16:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16B7E60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936081AbeFGQNh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:13:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39103 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932884AbeFGOI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:08:59 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0005Zj-85; Thu, 07 Jun 2018 15:08:56 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvaw-0002g4-TR; Thu, 07 Jun 2018 15:08:54 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        akpm@linux-foundation.org
Date: Thu, 07 Jun 2018 15:05:20 +0100
Message-ID: <lsq.1528380320.647747352@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 000/410] 3.16.57-rc1 review
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.16.57 release.
There are 410 patches in this series, which will be posted as responses
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Jun 14 18:00:00 UTC 2018.
Anything received after that time might be too late.

All the patches have also been committed to the linux-3.16.y-rc branch of
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-stable-rc.git .
A shortlog and diffstat can be found below.

Ben.

-------------

Adrian Hunter (2):
      mmc: sdhci-pci: Fix S0i3 for Intel BYT-based controllers
         [f8870ae6e2d6be75b1accc2db981169fdfbea7ab]
      mmc: sdhci: Allow override of mmc host operations
         [bf60e592a1af4d6f65dd54593250183f14360eed]

Al Viro (2):
      Bluetooth: hidp_connection_add() unsafe use of l2cap_pi()
         [51bda2bca53b265715ca1852528f38dc67429d9a]
      lock_parent() needs to recheck if dentry got __dentry_kill'ed under it
         [3b821409632ab778d46e807516b457dfa72736ed]

Alaa Hleihel (1):
      IB/ipoib: Do not warn if IPoIB debugfs doesn't exist
         [14fa91e0fef8e4d6feb8b1fa2a807828e0abe815]

Alex Chen (1):
      ocfs2: subsystem.su_mutex is required while accessing the  item->ci_parent
         [853bc26a7ea39e354b9f8889ae7ad1492ffa28d2]

Alex Deucher (2):
      drm/radeon: Add dpm quirk for Jet PRO (v2)
         [239b5f64e12b1f09f506c164dff0374924782979]
      drm/radeon: fix KV harvesting
         [0b58d90f89545e021d188c289fa142e5ff9e708b]

Alexander Graf (1):
      KVM: PPC: Book3S PR: Fix svcpu copying with preemption enabled
         [07ae5389e98c53bb9e9f308fce9c903bc3ee7720]

Alexander Potapenko (1):
      netlink: make sure nladdr has correct size in netlink_connect()
         [7880287981b60a6808f39f297bb66936e8bdf57a]

Alexandra Yates (3):
      Adding Intel Lewisburg device IDs for SATA
         [f5bdd66c705484b4bc77eb914be15c1b7881fae7]
      ahci: Order SATA device IDs for codename Lewisburg
         [4d92f0099a06ef0e36c7673f7c090f1a448b2d1b]
      ahci: add new Intel device IDs
         [56e74338a535cbcc2f2da08b1ea1a92920194364]

Alexandru Ardelean (1):
      staging: iio: adc: ad7192: fix external frequency setting
         [e31b617d0a63c6558485aaa730fd162faa95a766]

Alexey Kodanev (4):
      dccp: check sk for closed state in dccp_sendmsg()
         [67f93df79aeefc3add4e4b31a752600f834236e2]
      sch_netem: fix skb leak in netem_enqueue()
         [35d889d10b649fda66121891ec05eca88150059d]
      sctp: verify size of a new chunk in _sctp_make_chunk()
         [07f2c7ab6f8d0a7e7c5764c4e6cc9c52951b9d9c]
      udplite: fix partial checksum initialization
         [15f35d49c93f4fa9875235e7bf3e3783d2dd7a1b]

Aman Deep (1):
      usb: ohci: Proper handling of ed_rm_list to handle race condition between usb_kill_urb() and finish_unlinks()
         [46408ea558df13b110e0866b99624384a33bdeba]

Anand Jain (1):
      btrfs: use proper endianness accessors for super_copy
         [3c181c12c431fe33b669410d663beb9cceefcd1b]

Andi Shyti (1):
      Input: mms114 - fix license module information
         [498e7e7ed1fd72c275a682f0903c4a20cc538658]

Andrew F. Davis (1):
      ARM: dts: omap3-n900: Fix the audio CODEC's reset pin
         [7be4b5dc7ffa9499ac6ef33a5ffa9ff43f9b7057]

Andri Yngvason (3):
      can: cc770: Fix queue stall & dropped RTR reply
         [746201235b3f876792099079f4c6fea941d76183]
      can: cc770: Fix stalls on rt-linux, remove redundant IRQ ack
         [f4353daf4905c0099fd25fa742e2ffd4a4bab26a]
      can: cc770: Fix use after free in cc770_tx_interrupt()
         [9ffd7503944ec7c0ef41c3245d1306c221aef2be]

Andy Lutomirski (1):
      x86/entry/64: Don't use IST entry for #BP stack
         [d8ba61ba58c88d5207c1ba2f7d9a2280e7d03be9]

Andy Shevchenko (1):
      x86/cpu: Rename Merrifield2 to Moorefield
         [f5fbf848303c8704d0e1a1e7cabd08fd0a49552f]

Anna-Maria Gleixner (1):
      hrtimer: Ensure POSIX compliance (relative CLOCK_REALTIME hrtimers)
         [48d0c9becc7f3c66874c100c126459a9da0fdced]

Arend Van Spriel (1):
      brcmfmac: fix P2P_DEVICE ethernet address generation
         [455f3e76cfc0d893585a5f358b9ddbe9c1e1e53b]

Arkadi Sharshevsky (1):
      team: Fix double free in error path
         [cbcc607e18422555db569b593608aec26111cb0b]

Arnaldo Carvalho de Melo (3):
      perf evlist: Introduce perf_evlist__new_dummy constructor
         [5bae0250237f7a5ec4355f9920701de247b8db91]
      perf record: Generate PERF_RECORD_{MMAP,COMM,EXEC} with --delay
         [d3dbf43c56f9176be325ce1cc72a44c8d3c210dc]
      perf report: Fix -D output for user metadata events
         [f250b09c779550e4a7a412dae6d3ad34d5201019]

Arnd Bergmann (7):
      cfg80211: fix cfg80211_beacon_dup
         [bee92d06157fc39d5d7836a061c7d41289a55797]
      cifs: silence compiler warnings showing up with gcc-8.0.0
         [ade7db991b47ab3016a414468164f4966bd08202]
      media: exynos4-is: properly initialize frame format
         [97913bcbe6da3957af27d9fdd76b3d97b99e6d6a]
      mm: hide a #warning for COMPILE_TEST
         [af27d9403f5b80685b79c88425086edccecaf711]
      scsi: fas216: fix sense buffer initialization
         [96d5eaa9bb74d299508d811d865c2c41b38b0301]
      x86/oprofile: Fix bogus GCC-8 warning in nmi_setup()
         [85c615eb52222bc5fab6c7190d146bc59fac289e]
      x86/pti: Mark constant arrays as __initconst
         [4bf5d56d429cbc96c23d809a08f63cd29e1a702e]

Ashok Raj (1):
      KVM/x86: Add IBPB support
         [15d45071523d89b3fb7372e2135fbd72f6af9506]

Aurelien Aptel (1):
      CIFS: zero sensitive data when freeing
         [97f4b7276b829a8927ac903a119bef2f963ccc58]

Baolin Wang (1):
      usb: gadget: f_fs: Fix possibe deadlock
         [b3ce3ce02d146841af012d08506b4071db8ffde3]

Bart Van Assche (1):
      pktcdvd: Fix pkt_setup_dev() error path
         [5a0ec388ef0f6e33841aeb810d7fa23f049ec4cd]

Bastian Stender (1):
      mmc: block: fix updating ext_csd caches on ioctl call
         [e74ef2194b41ba5e511fab29fe5ff00e72d2f42a]

Ben Crocker (1):
      drm/radeon: insist on 32-bit DMA for Cedar on PPC64/PPC64LE
         [2c83029cda55a5e7665c7c6326909427d6a01350]

Ben Hutchings (3):
      skb: Add skb_postpush_rcsum()
         [f8ffad69c9f8b8dfb0b633425d4ef4d2493ba61a]
      staging: android: ashmem: Fix a race condition in pin ioctls
         [ce8a3a9e76d0193e2e8d74a06d275b3c324ca652]
      xen: Add xen_arch_suspend()
         [2b953a5e994ce279904ec70220f7d4f31d380a0a]

Benjamin Poirier (1):
      e1000e: Fix check_for_link return value with autoneg off
         [4e7dc08e57c95673d2edaba8983c3de4dd1f65f5]

Bjorn Andersson (1):
      PM / devfreq: Propagate error from devfreq_add_device()
         [d1bf2d30728f310f72296b54f0651ecdb09cbb12]

Boris Ostrovsky (1):
      xen/arm: Define xen_arch_suspend()
         [ffb7dbed47da6ac4460b606a3feee295bbe4d9e2]

Boris Pismenny (1):
      IB/mlx5: Fix integer overflows in mlx5_ib_create_srq
         [c2b37f76485f073f020e60b5954b6dc4e55f693c]

Borislav Petkov (2):
      x86, microcode: Fix accessing dis_ucode_ldr on 32-bit
         [85be07c32496dc264661308e4d9d4e9ccaff8072]
      x86/microcode/AMD: Do not load when running on a hypervisor
         [a15a753539eca8ba243d576f02e7ca9c4b7d7042]

Charles_Rose@Dell.com (1):
      ahci: Add Device ID for Intel Sunrise Point PCH
         [c5967b79ecabe2baca40658d9073e28b30d7f6cf]

Chenjie (1):
      mm/madvise.c: fix madvise() infinite loop under special circumstances
         [6ea8d958a2c95a1d514015d4e29ba21a8c0a1a91]

Chien Tin Tung (1):
      RDMA/ucma: Correct option size check using optlen
         [5f3e3b85cc0a5eae1c46d72e47d3de7bf208d9e2]

Christian Borntraeger (1):
      KVM: s390: provide io interrupt kvm_stat
         [09a0fb67536a49af19f2bfc632100e9de91fe526]

Christian König (2):
      drm/radeon: fix prime teardown order
         [0f4f715bc6bed3bf14c5cd7d5fe88d443e756b14]
      drm/ttm: fix adding foreign BOs to the swap LRU
         [ed704a43e84cc536081423dcd3491acf2791aaeb]

Christophe JAILLET (3):
      media: bt8xx: Fix err 'bt878_probe()'
         [45392ff6881dbe56d41ef0b17c2e576065f8ffa1]
      power: supply: ab8500_charger: Bail out in case of error in 'ab8500_charger_init_hw_registers()'
         [09edcb647542487864e23aa8d2ef26be3e08978a]
      power: supply: ab8500_charger: Fix an error handling path
         [bf59fddde1c3eab89eb8dca8f3d3dc097887d2bb]

Clay McClure (1):
      ubi: Fix race condition between ubi volume creation and udev
         [a51a0c8d213594bc094cb8e54aad0cb6d7f7b9a6]

Colin Ian King (3):
      clocksource/drivers/fsl_ftm_timer: Fix error return checking
         [f287eb9013ccf199cbfa4eabd80c36fedfc15a73]
      scsi: aacraid: remove redundant setting of variable c
         [91814744646351a470f256fbcb853fb5a7229a9f]
      wl1251: check return from call to wl1251_acx_arp_ip_filter
         [ac1181c60822292176ab96912208ec9f9819faf8]

Cong Wang (2):
      netfilter: ipt_CLUSTERIP: fix a refcount bug in clusterip_config_find_get()
         [db93a3632b0f8773a3899e04a3a3e0aa7a26eb46]
      netfilter: xt_RATEEST: acquire xt_rateest_mutex for hash insert
         [7dc68e98757a8eccf8ca7a53a29b896f1eef1f76]

Corentin Labbe (2):
      ia64: convert unwcheck.py to python3
         [bd5edbe677948d0883f59d9625c444818d5284b1]
      powerpc/pseries: Add empty update_numa_cpu_lookup_table() for NUMA=n
         [c1e150ceb61e4a585bad156da15c33bfe89f5858]

Dan Aloni (1):
      cifs: empty TargetInfo leads to crash on recovery
         [cabfb3680f78981d26c078a26e5c748531257ebb]

Dan Carpenter (10):
      ALSA: pcm: potential uninitialized return values
         [5607dddbfca774fb38bffadcb077fe03aa4ac5c6]
      ASoC: au1x: Fix timeout tests in au1xac97c_ac97_read()
         [123af9043e93cb6f235207d260d50f832cdb5439]
      ASoC: nuc900: Fix a loop timeout test
         [65a12b3aafed5fc59f4ce41b22b752b1729e6701]
      HID: roccat: prevent an out of bounds read in kovaplus_profile_activated()
         [7ad81482cad67cbe1ec808490d1ddfc420c42008]
      ath9k_htc: Add a sanity check in ath9k_htc_ampdu_action()
         [413fd2f5c0233d3cde391679b967c1f14cd2cb27]
      cdrom: information leak in cdrom_ioctl_media_changed()
         [9de4ee40547fd315d4a0ed1dd15a2fa3559ad707]
      media: cpia2: Fix a couple off by one bugs
         [d5ac225c7d64c9c3ef821239edc035634e594ec9]
      staging: lustre: libcfs: Prevent harmless read underflow
         [134aecbc25fd77645baaea5467b2a7ed8e9d1ea7]
      staging: ncpfs: memory corruption in ncp_read_kernel()
         [4c41aa24baa4ed338241d05494f2c595c885af8f]
      staging: rts5208: Fix "seg_no" calculation in reset_ms_card()
         [7f7aeea7cf30368b9fdb86dcc9d2c8a3ebc65dfb]

Daniel N Pettersson (1):
      cifs: Fix autonegotiate security settings mismatch
         [9aca7e454415f7878b28524e76bebe1170911a88]

Danilo Krummrich (1):
      usb: quirks: add control message delay for 1b1c:1b20
         [cb88a0588717ba6c756cb5972d75766b273a6817]

Dave Hansen (1):
      x86/cpu: Rename "WESTMERE2" family to "NEHALEM_G"
         [4b3b234f434d440fcd749b9636131b76e2ce561e]

Dave Young (1):
      HID: add quirk for another PIXART OEM mouse used by HP
         [01cffe9ded15c0d664e0beb33c594e00c0d57bba]

David Ahern (1):
      net: Refactor rtable initialization
         [d08c4f355403840fad98d9918db51a7113f38ee8]

David Matlack (1):
      KVM: nVMX: mark vmcs12 pages dirty on L2 exit
         [c9f04407f2e0b3fc9ff7913c65fcfcb0a4b61570]

David Rientjes (1):
      kernel/relay.c: limit kmalloc size to KMALLOC_MAX_SIZE
         [88913bd8ea2a75d7e460a4bed5f75e1c32660d7e]

David Woodhouse (11):
      x86/cpufeature: Blacklist SPEC_CTRL/PRED_CMD on early Spectre v2  microcodes
         [a5b2966364538a0e68c9fa29bc0a3a1651799035]
      x86/cpufeatures: Add AMD feature bits for Speculation Control
         [5d10cbc91d9eb5537998b65608441b592eec65e7]
      x86/cpufeatures: Add Intel feature bits for Speculation Control
         [fc67dd70adb711a45d2ef34e12d1a8be75edde61]
      x86/cpufeatures: Clean up Spectre v2 related CPUID flags
         [2961298efe1ea1b6fc0d7ee8b76018fa6c0bcef2]
      x86/cpuid: Fix up "virtual" IBRS/IBPB/STIBP feature bits on Intel
         [7fcae1118f5fd44a862aa5c3525248e35ee67c3b]
      x86/msr: Add definitions for new speculation control MSRs
         [1e340c60d0dd3ae07b5bedc16a0469c14b9f3410]
      x86/pti: Do not enable PTI on CPUs which are not vulnerable to  Meltdown
         [fec9434a12f38d3aeafeb75711b71d8a1fdef621]
      x86/speculation: Add basic IBPB (Indirect Branch Prediction Barrier)  support
         [20ffa1caecca4db8f79fe665acdeaa5af815a24d]
      x86/speculation: Correct Speculation Control microcode blacklist  again
         [d37fc6d360a404b208547ba112e7dabb6533c7fc]
      x86/speculation: Update Speculation Control microcode blacklist
         [1751342095f0d2b36fa8114d8e12c5688c455ac4]
      x86/speculation: Use IBRS if available before calling into firmware
         [dd84441a797150dcc49298ec95c459a8891d8bb1]

Dmitry Torokhov (1):
      Input: edt-ft5x06 - fix error handling for factory mode on non-M06
         [4b3e910d7f430ab76dd37131bb75129878950163]

Dmitry Vyukov (1):
      netfilter: ipt_CLUSTERIP: fix out-of-bounds accesses in clusterip_tg_check()
         [1a38956cce5eabd7b74f94bab70265e4df83165e]

Eran Ben Elisha (1):
      net/mlx4_en: Fix mixed PFC and Global pause user control requests
         [6e8814ceb7e8f468659ef9253bd212c07ae19584]

Eric Biggers (15):
      NFS: reject request for id_legacy key without auxdata
         [49686cbbb3ebafe42e63868222f269d8053ead00]
      binder: check for binder_thread allocation failure in binder_poll()
         [f88982679f54f75daa5b8eff3da72508f1e7422f]
      crypto: cryptd - pass through absence of ->setkey()
         [841a3ff329713f796a63356fef6e2f72e4a3f6a3]
      crypto: hash - annotate algorithms taking optional key
         [a208fa8f33031b9e0aba44c7d1b7e68eb0cbd29e]
      crypto: hash - introduce crypto_hash_alg_has_setkey()
         [cd6ed77ad5d223dc6299fb58f62e0f5267f7e2ba]
      crypto: hash - prevent using keyed hashes without setting key
         [9fa68f620041be04720d0cbfb1bd3ddfc6310b24]
      libata: fix length validation of ATAPI-relayed SCSI commands
         [058f58e235cbe03e923b30ea7c49995a46a8725f]
      libata: remove WARN() for DMA or PIO command without data
         [9173e5e80729c8434b8d27531527c5245f4a5594]
      pipe, sysctl: drop 'min' parameter from pipe-max-size converter
         [4c2e4befb3cc9ce42d506aa537c9ab504723e98c]
      pipe, sysctl: remove pipe_proc_fn()
         [319e0a21bb7823abbb4818fe2724e572bbac77a2]
      pipe: actually allow root to exceed the pipe buffer limits
         [85c2dd5473b2718b4b63e74bfeb1ca876868e11f]
      pipe: fix off-by-one error when checking buffer limits
         [9903a91c763ecdae333a04a9d89d79d2b8966503]
      pipe: read buffer limits atomically
         [f7340761812fc10313e6fcc115e0bc4f7a799112]
      pipe: reject F_SETPIPE_SZ with size over UINT_MAX
         [96e99be40e4cff870a83233731121ec0f7f95075]
      pipe: simplify round_pipe_size()
         [c4fed5a91fadc8a277b1eda474317b501651dd3e]

Eric Dumazet (4):
      l2tp: do not accept arbitrary sockets
         [17cfe79a65f98abe535261856c5aef14f306dff7]
      net: fix possible out-of-bound read in skb_network_protocol()
         [1dfe82ebd7d8fd43dba9948fdfb31f145014baa0]
      net: igmp: add a missing rcu locking section
         [e7aadb27a5415e8125834b84a74477bfbee4eff5]
      netfilter: IDLETIMER: be syzkaller friendly
         [cfc2c740533368b96e2be5e0a4e8c3cace7d9814]

Eric W. Biederman (4):
      fs: Teach path_connected to handle nfs filesystems with multiple roots.
         [95dd77580ccd66a0da96e6d4696945b8cea39431]
      mn10300/misalignment: Use SIGSEGV SEGV_MAPERR to report a failed user copy
         [6ac1dc736b323011a55ecd1fc5897c24c4f77cbd]
      signal/openrisc: Fix do_unaligned_access to send the proper signal
         [500d58300571b6602341b041f97c082a461ef994]
      signal/sh: Ensure si_signo is initialized in do_divide_error
         [0e88bb002a9b2ee8cc3cc9478ce2dc126f849696]

Erik Veijola (1):
      ALSA: usb-audio: Add a quirck for B&W PX headphones
         [240a8af929c7c57dcde28682725b29cf8474e8e5]

Ernesto A . Fernández (1):
      ext4: correct documentation for grpid mount option
         [9f0372488cc9243018a812e8cfbf27de650b187b]

Eugene Syromiatnikov (1):
      s390: fix handling of -1 in set{,fs}[gu]id16 syscalls
         [6dd0d2d22aa363fec075cb2577ba273ac8462e94]

Felix Kuehling (1):
      drm/ttm: Don't add swapped BOs to swap-LRU list
         [fd5002d6a3c602664b07668a24df4ef7a43bf078]

Florian Fainelli (2):
      net: systemport: Rewrite __bcm_sysport_tx_reclaim()
         [484d802d0f2f29c335563fcac2a8facf174a1bbc]
      pinctrl: Really force states during suspend/resume
         [981ed1bfbc6c4660b2ddaa8392893e20a6255048]

Florian Westphal (6):
      netfilter: bridge: ebt_among: add missing match size checks
         [c4585a2823edf4d1326da44d1524ecbfda26bb37]
      netfilter: bridge: ebt_among: add more missing match size checks
         [c8d70a700a5b486bfa8e5a7d33d805389f6e59f9]
      netfilter: ebtables: CONFIG_COMPAT: don't trust userland offsets
         [b71812168571fa55e44cdd0254471331b9c4c4c6]
      netfilter: ebtables: fix erroneous reject of last rule
         [932909d9b28d27e807ff8eecb68c7748f6701628]
      netfilter: ipv6: fix use-after-free Write in nf_nat_ipv6_manip_pkt
         [b078556aecd791b0e5cb3a59f4c3a14273b52121]
      xfrm_user: uncoditionally validate esn replay attribute struct
         [d97ca5d714a5334aecadadf696875da40f1fbf3e]

Ganesh Mahendran (1):
      android: binder: use VM_ALLOC to get vm area
         [aac6830ec1cb681544212838911cdc57f2638216]

Geert Uytterhoeven (1):
      RDMA/iwpm: Fix uninitialized error code in iwpm_send_mapinfo()
         [302d6424e4a293a5761997e6c9fc3dfb1e4c355f]

Greg Kroah-Hartman (2):
      USB: serial: pl2303: new device id for Chilitag
         [d08dd3f3dd2ae351b793fc5b76abdbf0fd317b12]
      drm: udl: Properly check framebuffer mmap offsets
         [3b82a4db8eaccce735dffd50b4d4e1578099b8e8]

Greg Kurz (1):
      9p/trans_virtio: discard zero-length reply
         [26d99834f89e76514076d9cd06f61e56e6a509b8]

Guillaume Nault (3):
      l2tp: avoid using ->tunnel_sock for getting session's parent tunnel
         [7198c77aa05560c257ee377ec1f4796812121580]
      l2tp: don't close sessions in l2tp_tunnel_destruct()
         [765924e362d12f87786060b98a49abd91e11ea96]
      l2tp: remove l2tp_tunnel_count and l2tp_session_count
         [c7fa745d988812c4dea7dbc645f025c5bfa4917e]

Hans de Goede (10):
      ASoC: rt5651: Fix regcache sync errors on resume
         [2d30e9494f1ea320aaaad0cff9ddd92c87eac355]
      PCI: Add function 1 DMA alias quirk for Highpoint RocketRAID 644L
         [1903be8222b7c278ca897c129ce477c1dd6403a8]
      USB: cdc-acm: Do not log urb submission errors on disconnect
         [f0386c083c2ce85284dc0b419d7b89c8e567c09f]
      ahci: Add PCI ids for Intel Bay Trail, Cherry Trail and Apollo Lake AHCI
         [998008b779e424bd7513c434d0ab9c1268459009]
      ahci: Add PCI-id for the Highpoint Rocketraid 644L card
         [28b2182dad43f6f8fcbd167539a26714fd12bd64]
      libata: Apply NOLPM quirk to Crucial M500 480 and 960GB SSDs
         [62ac3f7305470e3f52f159de448bc1a771717e88]
      libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs
         [9c7be59fc519af9081c46c48f06f2b8fadf55ad8]
      libata: Make Crucial BX100 500GB LPM quirk apply to all firmware versions
         [3bf7b5d6d017c27e0d3b160aafb35a8e7cfeda1f]
      libata: Modify quirks for MX100 to limit NCQ_TRIM quirk to MU01 version
         [d418ff56b8f2d2b296daafa8da151fe27689b757]
      uas: Log error codes when logging errors
         [ce39fe6fa115d9fea0112c907773a400b98d2463]

Hans van Kranenburg (1):
      btrfs: alloc_chunk: fix DUP stripe size handling
         [92e222df7b8f05c565009c7383321b593eca488b]

Hemant Kumar (1):
      usb: f_fs: Prevent gadget unbind if it is already unbound
         [ce5bf9a50daf2d9078b505aca1cea22e88ecb94a]

Horia Geantă (1):
      crypto: caam - fix endless loop when DECO acquire fails
         [225ece3e7dad4cfc44cca38ce7a3a80f255ea8f1]

Ilya Dryomov (1):
      rbd: whitelist RBD_FEATURE_OPERATIONS feature bit
         [e573427a440fd67d3f522357d7ac901d59281948]

Ingo Molnar (1):
      x86/speculation: Move firmware_restrict_branch_speculation_*() from C  to CPP
         [d72f4e29e6d84b7ec02ae93088aa459ac70e733b]

Ioana Ciornei (1):
      staging: iio: adc: remove the use of CamelCase
         [5f7e280f5ae61450a7aecd9feefe3f032b6a5abf]

Ivan Delalande (1):
      lkdtm: fix handle_irq_event symbol for INT_HW_IRQ_EN
         [5be2a5011c039506e2862650c928acfb2e3d7b9c]

Ivan Vecera (2):
      kernfs: fix regression in kernfs_fop_write caused by wrong type
         [ba87977a49913129962af8ac35b0e13e0fa4382d]
      net/mlx4_en: do not ignore autoneg in mlx4_en_set_pauseparam()
         [278d436a476f69fc95d5c82bf61b6c2d02f4d44e]

J. Bruce Fields (1):
      NFS: commit direct writes even if they fail partially
         [1b8d97b0a837beaf48a8449955b52c650a7114b4]

Jack Morgenstein (1):
      IB/mlx4: Fix incorrectly releasing steerable UD QPs when have only ETH ports
         [852f6927594d0d3e8632c889b2ab38cbc46476ad]

Jack Stocker (1):
      Add delay-init quirk for Corsair K70 RGB keyboards
         [7a1646d922577b5b48c0d222e03831141664bb59]

Jake Daryll Obina (1):
      jffs2: Fix use-after-free bug in jffs2_iget()'s error handling path
         [5bdd0c6f89fba430e18d636493398389dadc3b17]

Jakub Kicinski (1):
      net: fix race on decreasing number of TX queues
         [ac5b70198adc25c73fba28de4f78adcee8f6be0b]

James Chapman (5):
      l2tp: don't use inet_shutdown on ppp session destroy
         [225eb26489d05c679a4c4197ffcb81c81e9dcaf4]
      l2tp: don't use inet_shutdown on tunnel destroy
         [76a6abdb2513ad4ea0ded55d2c66160491f2e848]
      l2tp: fix race in pppol2tp_release with session object destroy
         [d02ba2a6110c530a32926af8ad441111774d2893]
      l2tp: fix races with tunnel socket close
         [d00fa9adc528c1b0e64d532556764852df8bd7b9]
      l2tp: fix tunnel lookup use-after-free race
         [28f5bfb819195ad9c2eb9486babe7b0e4efe925f]

James Hogan (2):
      EDAC, octeon: Fix an uninitialized variable warning
         [544e92581a2ac44607d7cc602c6b54d18656f56d]
      MIPS: Fix clean of vmlinuz.{32,ecoff,bin,srec}
         [5f2483eb2423152445b39f2db59d372f523e664e]

James Ralston (1):
      ahci: Remove Device ID for Intel Sunrise Point PCH
         [46319e13581a6c442b0a0e5a3bd5d9af4496f252]

Jan Beulich (1):
      x86/mm: Fix {pmd,pud}_{set,clear}_flags()
         [842cef9113c2120f74f645111ded1e020193d84c]

Jan Chochol (1):
      nfs: Do not convert nfs_idmap_cache_timeout to jiffies
         [cbebc6ef4fc830f4040d4140bf53484812d5d5d9]

Jan-Marek Glogowski (1):
      ALSA: hda/realtek: PCI quirk for Fujitsu U7x7
         [fdcc968a3b290407bcba9d4c90e2fba6d8d928f1]

Jason Gunthorpe (1):
      sctp: Fix mangled IPv4 addresses on a IPv6 listening socket
         [9302d7bb0c5cd46be5706859301f18c137b2439f]

Jason Wang (1):
      vhost_net: stop device during reset owner
         [4cd879515d686849eec5f718aeac62a70b067d82]

Jason Yan (5):
      ata: do not schedule hot plug if it is a sas host
         [6f54120e17e311fd7ac42b9ec2a0611caa5b46ad]
      scsi: libsas: direct call probe and destruct
         [0558f33c06bb910e2879e355192227a8e8f0219d]
      scsi: libsas: fix error when getting phy events
         [2b23d9509fd7174b362482cf5f3b5f9a2265bc33]
      scsi: libsas: fix memory leak in sas_smp_get_phy_events()
         [4a491b1ab11ca0556d2fda1ff1301e862a2d44c4]
      scsi: libsas: remove the numbering for each event enum
         [0d78f969b10f27e0be34210d482a01e1ee92994c]

Jean Delvare (1):
      firmware: dmi_scan: Fix handling of empty DMI strings
         [a7770ae194569e96a93c48aceb304edded9cc648]

Jens Axboe (1):
      aio: fix serial draining in exit_aio()
         [dc48e56d761610da4ea1088d1bea0a030b8e3e43]

Jeremy Boone (4):
      tpm: fix potential buffer overruns caused by bit glitches on the bus
         [3be23274755ee85771270a23af7691dc9b3a95db]
      tpm_i2c_infineon: fix potential buffer overruns caused by bit glitches on the bus
         [9b8cb28d7c62568a5916bdd7ea1c9176d7f8f2ed]
      tpm_i2c_nuvoton: fix potential buffer overruns caused by bit glitches on the bus
         [f9d4d9b5a5ef2f017bc344fb65a58a902517173b]
      tpm_tis: fix potential buffer overruns caused by bit glitches on the bus
         [6bb320ca4a4a7b5b3db8c8d7250cc40002046878]

Jia-Ju Bai (1):
      USB: serial: io_edgeport: fix possible sleep-in-atomic
         [c7b8f77872c73f69a16528a9eb87afefcccdc18b]

Jim Mattson (1):
      KVM: nVMX: Eliminate vmcs02 pool
         [de3a0021a60635de96aa92713c1a31a96747d72c]

Jiri Bohac (1):
      x86/gart: Exclude GART aperture from vmcore
         [2a3e83c6f96c513f43ce5a8c9034608ea584a255]

Joe Lawrence (3):
      pipe: add proc_dopipe_max_size() to safely assign pipe_max_size
         [7a8d181949fb2c16be00f8cdb354794a30e46b39]
      pipe: avoid round_pipe_size() nr_pages overflow on 32-bit
         [d3f14c485867cfb2e0c48aa88c41d0ef4bf5209c]
      sysctl: check for UINT_MAX before unsigned int min/max
         [fb910c42ccebf853c29296185c45c11164a56098]

Joel Fernandes (1):
      staging: android: ashmem: Fix lockdep issue during llseek
         [cb57469c9573f6018cd1302953dd45d6e05aba7b]

Johan Hovold (5):
      USB: serial: add Medtronic CareLink USB driver
         [cff9c2339a6d5105d7f6b1f9a96dd1d239cc76ac]
      USB: serial: add Novatel Wireless GPS driver
         [c5cd24d7b179a415df263e5b18b72f6e3aaf81e0]
      USB: serial: add support for multi-port simple drivers
         [b9f040389e23fb95fde36cb0a3c2c516fb3e9d1c]
      USB: serial: simple: add Motorola Tetra driver
         [46fe895e22ab3845515ec06b01eaf1282b342e29]
      video: fbdev: atmel_lcdfb: fix display-timings lookup
         [9cb18db0701f6b74f0c45c23ad767b3ebebe37f6]

Johannes Berg (1):
      regulatory: add NUL to request alpha2
         [657308f73e674e86b60509a430a46e569bf02846]

John Crispin (1):
      MIPS: ralink: Don't set pm_power_off
         [81ab9f6c5ff8565e4cba330e340a8979a10521d7]

Jonas Danielsson (1):
      tty/serial: atmel: add new version check for usart
         [fd63a8903a2c40425a9811c3371dd4d0f42c0ad3]

Ju Hyung Park (1):
      libata: Enable queued TRIM for Samsung SSD 860
         [ca6bfcb2f6d9deab3924bf901e73622a94900473]

Juergen Gross (2):
      x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend
         [71c208dd54ab971036d83ff6d9837bae4976e623]
      x86/xen: init %gs very early to avoid page faults with stack protector
         [4f277295e54c5b7340e48efea3fc5cc21a2872b7]

Julia Lawall (3):
      USB: usbmon: remove assignment from IS_ERR argument
         [46c236dc7d1212d7417e6fb0317f91c44c719322]
      drivers: video: fbdev: atmel_lcdfb.c: fix error return code
         [6c131850eca653344c41d68ce87f3ab5a89af89e]
      drm/radeon: adjust tested variable
         [3a61b527b4e1f285d21b6e9e623dc45cf8bb391f]

Julian Wiedmann (2):
      s390/qeth: fix SETIP command handling
         [1c5b2216fbb973a9410e0b06389740b5c1289171]
      s390/qeth: free netdevice when removing a card
         [6be687395b3124f002a653c1a50b3260222b3cd7]

Julien Gomes (1):
      tun: allow positive return values on dev_get_valid_name() call
         [5c25f65fd1e42685f7ccd80e0621829c105785d9]

Justin Chen (1):
      MIPS: BMIPS: Do not mask IPIs during suspend
         [06a3f0c9f2725f5d7c63c4203839373c9bd00c28]

Kai-Heng Feng (3):
      drm/edid: Add 6 bpc quirk for CPT panel in Asus UX303LA
         [06998a756a3865817b87a129a7e5d5bb66dc1ec3]
      libata: disable LPM for Crucial BX100 SSD 500GB drive
         [b17e5729a630d8326a48ec34ef02e6b4464a6aef]
      xhci: Fix front USB ports on ASUS PRIME B350M-A
         [191edc5e2e515aab1075a3f0ef23599e80be5f59]

Kamil Konieczny (1):
      crypto: s5p-sss - Fix kernel Oops in AES-ECB mode
         [c927b080c67e3e97193c81fc1d27f4251bf4e036]

KarimAllah Ahmed (3):
      KVM/SVM: Allow direct access to MSR_IA32_SPEC_CTRL
         [b2ac58f90540e39324e7a29a7ad471407ae0bf48]
      KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL
         [d28b387fb74da95d69d2615732f50cceb38e9a4d]
      KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
         [28c1c9fabf48d6ad596273a11c46e0d0da3e14cd]

Karsten Koop (1):
      usb: ldusb: add PIDs for new CASSY devices supported by this driver
         [52ad2bd8918158266fc88a05f95429b56b6a33c5]

Kees Cook (1):
      NFC: llcp: Limit size of SDP URI
         [fe9c842695e26d8116b61b80bfb905356f07834b]

Kirill Marinushkin (1):
      ALSA: usb-audio: Fix parsing descriptor of UAC2 processing unit
         [a6618f4aedb2b60932d766bd82ae7ce866e842aa]

Konrad Rzeszutek Wilk (1):
      x86/spectre_v2: Don't check microcode versions when running under hypervisors
         [36268223c1e9981d6cfc33aff8520b3bde4b8114]

Lars-Peter Clausen (1):
      iio: adis_lib: Initialize trigger before requesting interrupt
         [f027e0b3a774e10302207e91d304bbf99e3a8b36]

Lassi Ylikojola (1):
      ALSA: usb-audio: add implicit fb quirk for Behringer UFX1204
         [5e35dc0338d85ccebacf3f77eca1e5dea73155e8]

Leon Romanovsky (11):
      RDMA/mlx5: Avoid memory leak in case of XRCD dealloc failure
         [b081808a66345ba725b77ecd8d759bee874cd937]
      RDMA/mlx5: Fix integer overflow while resizing CQ
         [28e9091e3119933c38933cb8fc48d5618eb784c8]
      RDMA/ucma: Check AF family prior resolving address
         [2975d5de6428ff6d9317e9948f0968f7d42e5d74]
      RDMA/ucma: Check that device exists prior to accessing it
         [c8d3bcbfc5eab3f01cf373d039af725f3b488813]
      RDMA/ucma: Check that device is connected prior to access it
         [4b658d1bbc16605330694bb3ef2570c465ef383d]
      RDMA/ucma: Check that user doesn't overflow QP state
         [a5880b84430316e3e1c1f5d23aa32ec6000cc717]
      RDMA/ucma: Don't allow join attempts for unsupported AF family
         [0c81ffc60d5280991773d17e84bda605387148b1]
      RDMA/ucma: Ensure that CM_ID exists prior to access it
         [e8980d67d6017c8eee8f9c35f782c4bd68e004c9]
      RDMA/ucma: Fix access to non-initialized CM_ID object
         [7688f2c3bbf55e52388e37ac5d63ca471a7712e1]
      RDMA/ucma: Fix use-after-free access in ucma_close
         [ed65a4dc22083e73bac599ded6a262318cad7baf]
      RDMA/ucma: Limit possible option size
         [6a21dfc0d0db7b7e0acedce67ca533a6eb19283c]

Linus Lüssing (2):
      batman-adv: fix multicast-via-unicast transmission with AP isolation
         [f8fb3419ead44f9a3136995acd24e35da4525177]
      batman-adv: fix packet loss for broadcasted DHCP packets to a server
         [a752c0a4524889cdc0765925258fd1fd72344100]

Linus Torvalds (3):
      kvm/x86: fix icebp instruction handling
         [32d43cd391bacb5f0814c2624399a5dad3501d09]
      perf/hwbp: Simplify the perf-hwbp code, fix documentation
         [f67b15037a7a50c57f72e69a6d59941ad90a0f0f]
      tty: vt: fix up tabstops properly
         [f1869a890cdedb92a3fab969db5d0fd982850273]

Linus Walleij (1):
      mtd: jedec_probe: Fix crash in jedec_read_mfr()
         [87a73eb5b56fd6e07c8e499fe8608ef2d8912b82]

Liu Bo (4):
      Btrfs: fix crash due to not cleaning up tree log block's dirty bits
         [1846430c24d66e85cc58286b3319c82cd54debb2]
      Btrfs: fix deadlock in run_delalloc_nocow
         [e89166990f11c3f21e1649d760dd35f9e410321c]
      Btrfs: fix extent state leak from tree log
         [55237a5f2431a72435e3ed39e4306e973c0446b7]
      Btrfs: fix use-after-free on root->orphan_block_rsv
         [1a932ef4e47984dee227834667b5ff5a334e4805]

Lukas Czerner (1):
      ext4: fix bitmap position validation
         [22be37acce25d66ecf6403fc8f44df9c5ded2372]

Lukas Wunner (5):
      Revert "apple-gmux: lock iGP IO to protect from vgaarb changes"
         [d6fa7588fd7a8def4c747c0c574ce85d453e3788]
      drm/nouveau: Fix deadlock on runtime suspend
         [d61a5c1063515e855bedb1b81e20e50b0ac3541e]
      drm/radeon: Fix deadlock on runtime suspend
         [15734feff2bdac24aa3266c437cffa42851990e3]
      drm: Allow determining if current task is output poll worker
         [25c058ccaf2ebbc3e250ec1e199e161f91fe27d4]
      workqueue: Allow retrieval of current task's work struct
         [27d4ee03078aba88c5e07dcc4917e8d01d046f38]

Maciej W. Rozycki (1):
      MIPS: Normalise code flow in the CpU exception handler
         [27e28e8ec47a5ce335ebf25d34ca356c80635908]

Malcolm Priestley (2):
      media: dvb-usb-v2: lmedm04: Improve logic checking of warm  start
         [3d932ee27e852e4904647f15b64dedca51187ad7]
      media: dvb-usb-v2: lmedm04: move ts2020 attach to  dm04_lme2510_tuner
         [7bf7a7116ed313c601307f7e585419369926ab05]

Marc Kleine-Budde (1):
      slip: sl_alloc(): remove unused parameter "dev_t line"
         [936e5d8bdfa72577e28ea671d9e2ee4fef0d6b3e]

Marc Zyngier (2):
      arm64: KVM: Increment PC after handling an SMC trap
         [f5115e8869e1dfafac0e414b4f1664f3a84a4683]
      arm: KVM: Fix SMCCC handling of unimplemented SMC/HVC calls
         [20e8175d246e9f9deb377f2784b3e7dfb2ad3e86]

Mark Rutland (1):
      arm64: remove __die()'s stack dump
         [c5bc503cbeee8586395aa541d2b53c69c3dd6930]

Masahiro Yamada (1):
      mmc: sdhci: export sdhci_execute_tuning()
         [85a882c2e91d3655927ecdc1db823d1420a65b8f]

Masami Hiramatsu (1):
      tracing: probeevent: Fix to support minus offset from symbol
         [c5d343b6b7badd1f5fe0873eff2e8d63a193e732]

Masatake YAMATO (1):
      route: remove unsed variable in __mkroute_input
         [cb1c61680d29a054b91a23c7a504cea8a72bdcff]

Matt Redfearn (1):
      MIPS: TXx9: use IS_BUILTIN() for CONFIG_LEDS_CLASS
         [0cde5b44a30f1daaef1c34e08191239dc63271c4]

Matthew Wilcox (1):
      cifs: Fix missing put_xid in cifs_file_strict_mmap
         [f04a703c3d613845ae3141bfaf223489de8ab3eb]

Matthias Schiffer (4):
      batman-adv: fix header size check in batadv_dbg_arp()
         [6f27d2c2a8c236d296201c19abb8533ec20d212b]
      batman-adv: fix packet checksum in receive path
         [abd6360591d3f8259f41c34e31ac4826dfe621b8]
      batman-adv: invalidate checksum on fragment reassembly
         [3bf2a09da956b43ecfaa630a2ef9a477f991a46a]
      batman-adv: update data pointers after skb_cow()
         [bc44b78157f621ff2a2618fe287a827bcb094ac4]

Mauro Carvalho Chehab (1):
      media: cxusb, dib0700: ignore XC2028_I2C_FLUSH
         [9893b905e743ded332575ca04486bd586c0772f7]

Max Filippov (1):
      xtensa: fix futex_atomic_cmpxchg_inatomic
         [ca47480921587ae30417dd234a9f79af188e3666]

Mel Gorman (1):
      mm: pin address_space before dereferencing it while isolating an LRU page
         [69d763fc6d3aee787a3e8c8c35092b4f4960fa5d]

Michael Kerrisk (8):
      pipe: cap initial pipe capacity according to pipe-max-size limit
         [086e774a57fba4695f14383c0818994c0b31da7c]
      pipe: fix limit checking in alloc_pipe_info()
         [a005ca0e6813e1d796a7422a7e31d8b8d6555df1]
      pipe: fix limit checking in pipe_set_size()
         [b0b91d18e2e97b741b294af9333824ecc3fadfd8]
      pipe: make account_pipe_buffers() return a value, and use it
         [9c87bcf0a31b338dc8a69a5d251a037565a94e13]
      pipe: move limit checking logic into pipe_set_size()
         [d37d41666408102bf0ac8e48d8efdce7b809e5f6]
      pipe: refactor argument for account_pipe_buffers()
         [3734a13b96ebf039b293d8d37a934fd1bd9e03ab]
      pipe: relocate round_pipe_size() above pipe_set_size()
         [f491bd71118beba608d39ac2d5f1530e1160cd2e]
      pipe: simplify logic in alloc_pipe_info()
         [09b4d1990094dd22c27fb0163534db419458569c]

Michael Lyle (1):
      bcache: don't attach backing with duplicate UUID
         [86755b7a96faed57f910f9e6b8061e019ac1ec08]

Michael Weiser (2):
      arm64: Disable unhandled signal log messages by default
         [5ee39a71fd89ab7240c5339d04161c44a8e03269]
      arm64: Remove unimplemented syscall log message
         [1962682d2b2fbe6cfa995a85c53c069fadda473e]

Michel Dänzer (1):
      drm/radeon: Don't turn off DP sink when disconnected
         [2681bc79eeb640562c932007bfebbbdc55bf6a7d]

Mika Westerberg (1):
      ahci: Add Intel Cannon Lake PCH-H PCI ID
         [f919dde0772a894c693a1eeabc77df69d6a9b937]

Mike Kravetz (2):
      hugetlbfs: check for pgoff value overflow
         [63489f8e821144000e0bdca7e65a8d1cc23a7ee7]
      hugetlbfs: fix offset overflow in hugetlbfs mmap
         [045c7a3f53d9403b62d396b6d051c4be5044cdb4]

Mikulas Patocka (2):
      alpha: fix crash if pthread_create races with signal delivery
         [21ffceda1c8b3807615c40d440d7815e0c85d366]
      alpha: fix reboot on Avanti platform
         [55fc633c41a08ce9244ff5f528f420b16b1e04d6]

Mimi Zohar (1):
      ima: relax requiring a file signature for new files with zero length
         [b7e27bc1d42e8e0cc58b602b529c25cd0071b336]

Miquel Raynal (1):
      mtd: nand: Fix nand_do_read_oob() return value
         [87e89ce8d0d14f573c068c61bec2117751fb5103]

Mulhern (1):
      dm thin: fix documentation relative to low water mark threshold
         [9b28a1102efc75d81298198166ead87d643a29ce]

Namjae Jeon (1):
      cifs: fix memory leak when password is supplied multiple times
         [d6ccf4997e62fb6629f9f003980dca5292138b7b]

Nathan Fontenot (1):
      powerpc/numa: Invalidate numa_cpu_lookup_table on cpu remove
         [1d9a090783bef19fe8cdec878620d22f05191316]

NeilBrown (1):
      MIPS: ralink: Remove ralink_halt()
         [891731f6a5dbe508d12443175a7e166a2fba616a]

Nicholas Piggin (1):
      powerpc/64: Don't trace irqs-off at interrupt return to soft-disabled context
         [acb1feab320e38588fccc568e3767761f494976f]

Nicolas Dichtel (2):
      netlink: avoid a double skb free in genlmsg_mcast()
         [02a2385f37a7c6594c9d89b64c4a1451276f08eb]
      netlink: ensure to loop over all netns in genlmsg_multicast_allns()
         [cb9f7a9a5c96a773bbc9c70660dc600cfff82f82]

Nicolas Pitre (1):
      console/dummy: leave .con_font_get set to NULL
         [724ba8b30b044aa0d94b1cd374fc15806cdd6f18]

Nikola Ciprich (1):
      serial: 8250_pci: Add Brainboxes UC-260 4 port serial device
         [9f2068f35729948bde84d87a40d135015911345d]

Nikolay Borisov (1):
      btrfs: Handle btrfs_set_extent_delalloc failure in fixup worker
         [f3038ee3a3f1017a1cbe9907e31fa12d366c5dcb]

OKAMOTO Yoshiaki (1):
      usb: option: Add support for FS040U modem
         [69341bd15018da0a662847e210f9b2380c71e623]

Oleg Nesterov (2):
      aio: change exit_aio() to load mm->ioctx_table once and avoid rcu_read_lock()
         [4b70ac5fd9b58bfaa5f25b4ea48f528aefbf3308]
      aio: kill the misleading rcu read locks in ioctx_add_table() and kill_ioctx()
         [855ef0dec7271ff7be7381feaaf3f4aed80bd503]

Oliver Neukum (3):
      CDC-ACM: apply quirk for card reader
         [df1cc78a52491f71d8170d513d0f6f114faa1bda]
      uas: fix comparison for error code
         [9a513c905bb95bef79d96feb08621c1ec8d8c4bb]
      usb: uas: unconditionally bring back host after reset
         [cbeef22fd611c4f47c494b821b2b105b8af970bb]

Paolo Abeni (7):
      dn_getsockoptdecnet: move nf_{get/set}sockopt outside sock lock
         [dfec091439bb2acf763497cfc58f2bdfc67c56b7]
      ipv6: the entire IPv6 header chain must fit the first fragment
         [10b8a3de603df7b96004179b1b33b1708c76d144]
      l2tp: fix races with ipv4-mapped ipv6 addresses
         [b954f94023dcc61388c8384f0f14eb8e42c863c5]
      netfilter: drop outermost socket lock in getsockopt()
         [01ea306f2ac2baff98d472da719193e738759d93]
      netfilter: nat: cope with negative port range
         [db57ccf0f2f4624b4c4758379f8165277504fbd7]
      netfilter: on sockopt() acquire sock lock only in the required scope
         [3f34cfae1238848fd53f25e5c8fd59da57901f4b]
      netfilter: x_tables: fix missing timer initialization in xt_LED
         [10414014bc085aac9f787a5890b33b5605fbcfc4]

Paolo Bonzini (6):
      KVM/VMX: Optimize vmx_vcpu_run() and svm_vcpu_run() by marking the  RDMSR path as unlikely()
         [946fbbc13dce68902f64515b610eeb2a6c3d7a64]
      KVM/x86: Remove indirect MSR op calls from SPEC_CTRL
         [ecb586bd29c99fb4de599dec388658e74388daad]
      KVM: VMX: introduce alloc_loaded_vmcs
         [f21f165ef922c2146cc5bdc620f542953c41714b]
      KVM: VMX: make MSR bitmaps per-VCPU
         [904e14fb7cb96401a7dc803ca2863fd5ba32ffe6]
      KVM: x86: pass host_initiated to functions that read MSRs
         [609e36d372ad9329269e4a1467bd35311893d1d6]
      KVM: x86: rename update_db_bp_intercept to update_bp_intercept
         [a96036b8ef7df9f10cd575c0d78359bd33188e8e]

Parav Pandit (1):
      RDMA/cma: Use correct size when writing netlink stats
         [7baaa49af3716fb31877c61f59b74d029ce15b75]

Pete Zaitcev (1):
      usb: usbmon: Read text within supplied buffer size
         [a5f596830e27e15f7a0ecd6be55e433d776986d8]

Peter Malone (1):
      fbdev: Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in sbusfb_ioctl_helper().
         [250c6c49e3b68756b14983c076183568636e2bde]

Peter Zijlstra (1):
      x86/speculation: Add <asm/msr-index.h> dependency
         [ea00f301285ea2f07393678cd2b6057878320c9d]

Petr Machata (1):
      ip_tunnel: Emit events for post-register MTU changes
         [f6cc9c054e77b9a28d4594bcc201697edb21dfd2]

Raghava Aditya Renukunta (1):
      scsi: aacraid: Fix udev inquiry race condition
         [f4e8708d3104437fd7716e957f38c265b0c509ef]

Rasmus Villemoes (2):
      kernel/async.c: revert "async: simplify lowest_in_progress()"
         [4f7e988e63e336827f4150de48163bed05d653bd]
      nospec: Allow index argument to have const-qualified type
         [b98c6a160a057d5686a8c54c79cc6c8c94a7d0c8]

Roger Pau Monne (1):
      xen/pirq: fix error path cleanup when binding MSIs
         [910f8befdf5bccf25287d9f1743e3e546bcb7ce0]

Sabrina Dubroca (1):
      ipv4: lock mtu in fnhe when received PMTU < net.ipv4.route.min_pmtu
         [d52e5a7e7ca49457dd31fc8b42fb7c0d58a31221]

Scott Lawson (1):
      AHCI: Remove obsolete Intel Lewisburg SATA RAID device IDs
         [8ba559fd09bcf4e87faad3efa465dacf04c076c9]

Scott Mayhew (1):
      nfs/pnfs: fix nfs_direct_req ref leak when i/o falls back to the mds
         [ba4a76f703ab7eb72941fdaac848502073d6e9ee]

SeongJae Park (2):
      rcutorture/configinit: Fix build directory error message
         [2adfa4210f8f35cdfb4e08318cc06b99752964c2]
      rcutorture/kvm.sh: Use consistent help text for --qemu-args
         [8dcd6f3fe206c0bb8996e59386a04027b1c2fb9b]

Sergey Senozhatsky (1):
      arm64: do not use print_symbol()
         [4ef7963843d3243260aa335dfb9cb2fede06aacf]

Seunghun Han (1):
      x86/MCE: Serialize sysfs changes
         [b3b7c4795ccab5be71f080774c45bbbcc75c2aaf]

Shaohua Li (1):
      ata: Add a new flag to destinguish sas controller
         [5067c0469c643512f24786990e315f9c15cc7d24]

Shawn Lin (2):
      mmc: dw_mmc: Factor out dw_mci_init_slot_caps
         [a4faa4929ed3be15e2d500d2405f992f6dedc8eb]
      mmc: dw_mmc: Fix out-of-bounds access for slot's caps
         [0d84b9e5631d923744767dc6608672df906dd092]

Shuah Khan (3):
      usbip: keep usbip_device sockfd state in sync with tcp_socket
         [009f41aed4b3e11e6dc1e3c07377a10c20f1a5ed]
      usbip: list: don't list devices attached to vhci_hcd
         [ef824501f50846589f02173d73ce3fe6021a9d2a]
      usbip: prevent bind loops on devices attached to vhci_hcd
         [ef54cf0c600fb8f5737fb001a9e357edda1a1de8]

Simon Shields (1):
      ARM: dts: exynos: Correct Trats2 panel reset line
         [1b377924841df1e13ab5b225be3a83f807a92b52]

Stefan Agner (1):
      spi: imx: do not access registers while clocks disabled
         [d593574aff0ab846136190b1729c151c736727ec]

Stefan Roese (1):
      ALSA: pcm: Use dma_bytes as size parameter in dma_mmap_coherent()
         [9066ae7ff5d89c0b5daa271e2d573540097a94fa]

Stefan Windfeldt-Prytz (1):
      iio: buffer: check if a buffer has been set up when poll is called
         [4cd140bda6494543f1c1b0ccceceaa44b676eef6]

Stefano Brivio (3):
      ip_tunnel: Clamp MTU to bounds on new link
         [24fc79798b8ddfd46f2dd363a8d29072c083b977]
      vti4: Don't count header length twice on tunnel setup
         [dd1df24737727e119c263acf1be2a92763938297]
      vti4: Don't override MTU passed on link creation via IFLA_MTU
         [03080e5ec72740c1a62e6730f2a5f3f114f11b19]

Stephan Mueller (1):
      crypto: af_alg - whitelist mask and type
         [bb30b8848c85e18ca7e371d0a869e94b3e383bdf]

Sven Eckelmann (2):
      batman-adv: Fix internal interface indices types
         [f22e08932c2960f29b5e828e745c9f3fb7c1bb86]
      batman-adv: Fix skbuff rcsum on packet reroute
         [fc04fdb2c8a894283259f5621d31d75610701091]

Takashi Iwai (8):
      ALSA: aloop: Fix access to not-yet-ready substream via cable
         [8e6b1a72a75bb5067ccb6b56d8ca4aa3a300a64e]
      ALSA: aloop: Sync stale timer before release
         [67a01afaf3d34893cf7d2ea19b34555d6abb7cb0]
      ALSA: hda/realtek - Always immediately update mute LED with pin VREF
         [e40bdb03d3cd7da66bd0bc1e40cbcfb49351265c]
      ALSA: seq: Clear client entry before deleting else at closing
         [a2ff19f7b70118ced291a28d5313469914de451b]
      ALSA: seq: Don't allow resizing pool in use
         [d85739367c6d56e475c281945c68fdb05ca74b4c]
      ALSA: seq: Fix possible UAF in snd_seq_check_queue()
         [d0f833065221cbfcbadf19fd4102bcfa9330006a]
      ALSA: seq: Fix racy pool initializations
         [d15d662e89fc667b90cd294b0eb45694e33144da]
      ALSA: seq: More protection for concurrent write and ioctl races
         [7bd80091567789f1c0cb70eb4737aac8bcd2b6b9]

Tang Junhui (1):
      bcache: fix crashes in duplicate cache device register
         [cc40daf91bdddbba72a4a8cd0860640e06668309]

Tariq Toukan (1):
      net/mlx4_core: Cleanup FMR unmapping flow
         [fd4a3e2828b4ca35aef40e5bdc1ed7d87b3cb50a]

Teijo Kinnunen (1):
      USB: storage: Add JMicron bridge 152d:2567 to unusual_devs.h
         [5126a504b63d82785eaece3a9c30c660b313785a]

Tejun Heo (3):
      fs/aio: Add explicit RCU grace period when freeing kioctx
         [a6d7cff472eea87d96899a20fa718d2bab7109f3]
      fs/aio: Use RCU accessors for kioctx_table->table[]
         [d0264c01e7587001a8c4608a5d1818dba9a4c11a]
      tty: make n_tty_read() always abort if hangup is in progress
         [28b0f8a6962a24ed21737578f3b1b07424635c9e]

Theodore Ts'o (2):
      ext4: add validity checks for bitmap block numbers
         [7dac4a1726a9c64a517d595c40e95e2d0d135f6f]
      ext4: fail ext4_iget for root directory if unallocated
         [8e4b5eae5decd9dfe5a4ee369c22028f90ab4c44]

Thinh Nguyen (1):
      usb: dwc3: gadget: Set maxpacket size for ep0 IN
         [6180026341e852a250e1f97ebdcf71684a3c81b9]

Thomas Gleixner (1):
      posix-timers: Protect posix clock array access against speculation
         [19b558db12f9f4e45a22012bae7b4783e62224da]

Thomas Richter (1):
      perf annotate: Fix objdump comment parsing for Intel mov dissassembly
         [35a8a148d8c1ee9e5ae18f9565a880490f816f89]

Tim Chen (1):
      x86/speculation: Use Indirect Branch Prediction Barrier in context switch
         [18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7]

Tobias Jordan (1):
      spi: sun6i: disable/unprepare clocks on remove
         [2d9bbd02c54094ceffa555143b0d68cd06504d63]

Todd Kjos (1):
      binder: replace "%p" with "%pK"
         [8ca86f1639ec5890d400fff9211aca22d0a392eb]

Tony Luck (1):
      x86/MCE: Save microcode revision in machine check records
         [fa94d0c6e0f3431523f5701084d799c77c7d4a4f]

Toshiaki Makita (2):
      net: Fix untag for vlan packets without ethernet header
         [ae4745730cf8e693d354ccd4dbaf59ea440c09a9]
      net: Fix vlan untag for bridge and vlan_dev with reorder_hdr off
         [4bbb3e0e8239f9079bf1fe20b3c0cb598714ae61]

Trond Myklebust (2):
      NFS: Add a cond_resched() to nfs_commit_release_pages()
         [7f1bda447c9bd48b415acedba6b830f61591601f]
      NFS: Fix 2 use after free issues in the I/O code
         [196639ebbe63a037fe9a80669140bd292d8bcd80]

Tyrel Datwyler (1):
      scsi: ibmvfc: fix misdefined reserved field in ibmvfc_fcp_rsp_info
         [c39813652700f3df552b6557530f1e5f782dbe2f]

Ulf Magnusson (1):
      ARM: mvebu: Fix broken PL310_ERRATA_753970 selects
         [8aa36a8dcde3183d84db7b0d622ffddcebb61077]

Ulrich Hecht (1):
      serial: sh-sci: prevent lockup on full TTY buffers
         [7842055bfce4bf0170d0f61df8b2add8399697be]

Vinicius Costa Gomes (1):
      skbuff: Fix not waking applications when errors are enqueued
         [6e5d58fdc9bedd0255a8781b258f10bbdc63e975]

Viresh Kumar (4):
      arm: spear13xx: Fix dmas cells
         [cdd10409914184c7eee5ae3e11beb890c9c16c61]
      arm: spear13xx: Fix spics gpio controller's warning
         [f8975cb1b8a36d0839b6365235778dd9df1d04ca]
      arm: spear600: Add missing interrupt-parent of rtc
         [6ffb5b4f248fe53e0361b8cbc2a523b432566442]
      cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()
         [0373ca74831b0f93cd4cdbf7ad3aec3c33a479a5]

Wang Nan (1):
      x86/traps: Enable DEBUG_STACK after cpu_init() for TRAP_DB/BP
         [b4d8327024637cb2a1f7910dcb5d0ad7a096f473]

Wanpeng Li (1):
      KVM: mmu: Fix overlap between public and private memslots
         [b28676bb8ae4569cced423dc2a88f7cb319d5379]

Wei Yongjun (1):
      mtd: ubi: wl: Fix error return code in ubi_wl_init()
         [7233982ade15eeac05c6f351e8d347406e6bcd2f]

Will Deacon (2):
      arm64: __show_regs: Only resolve kernel symbols when running at EL1
         [a06f818a70de21b4b3b4186816094208fc7accf9]
      arm64: traps: Don't print stack or raw PC/LR values in backtraces
         [a25ffd3a6302a67814280274d8f1aa4ae2ea4b59]

Xin Long (4):
      bonding: fix the err path for dev hwaddr sync in bond_enslave
         [5c78f6bfae2b10ff70e21d343e64584ea6280c26]
      bonding: move dev_mc_sync after master_upper_dev_link in bond_enslave
         [ae42cc62a9f07f1f6979054ed92606b9c30f4a2e]
      bonding: process the err returned by dev_set_allmulti properly in bond_enslave
         [9f5a90c107741b864398f4ac0014711a8c1d8474]
      bridge: check brport attr show in brport_show
         [1b12580af1d0677c3c3a19e35bfe5d59b03f737f]

Yisheng Xie (2):
      mm/mempolicy.c: avoid use uninitialized preferred_node
         [8970a63e965b43288c4f5f40efbc2bbf80de7f16]
      staging: android: ashmem: Fix possible deadlock in ashmem_ioctl
         [740a5759bf222332fbb5eda42f89aa25ba38f9b2]

Yufen Yu (1):
      md raid10: fix NULL deference in handle_write_completed()
         [01a69cab01c184d3786af09e9339311123d63d22]

Yunlei He (1):
      f2fs: fix a panic caused by NULL flush_cmd_control
         [d4fdf8ba0e5808ba9ad6b44337783bd9935e0982]

Zhang Bo (1):
      Input: matrix_keypad - fix race when disabling interrupts
         [ea4f7bd2aca9f68470e9aac0fc9432fd180b1fe7]

Zhouyi Zhou (1):
      ext4: save error to disk in __ext4_grp_locked_error()
         [06f29cc81f0350261f59643a505010531130eea0]

Zygo Blaxell (1):
      btrfs: remove spurious WARN_ON(ref->count < 0) in find_parent_nodes
         [c8195a7b1ad5648857ce20ba24f384faed8512bc]

 Documentation/device-mapper/thin-provisioning.txt  |   8 +-
 Documentation/devicetree/bindings/dma/snps-dma.txt |   2 +-
 Documentation/filesystems/ext4.txt                 |   2 +-
 Makefile                                           |   4 +-
 arch/alpha/kernel/pci_impl.h                       |   3 +-
 arch/alpha/kernel/process.c                        |   3 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |   2 +-
 arch/arm/boot/dts/omap3-n900.dts                   |   4 +-
 arch/arm/boot/dts/spear1310-evb.dts                |   2 +-
 arch/arm/boot/dts/spear1340.dtsi                   |   4 +-
 arch/arm/boot/dts/spear13xx.dtsi                   |   6 +-
 arch/arm/boot/dts/spear600.dtsi                    |   1 +
 arch/arm/kvm/handle_exit.c                         |  13 +-
 arch/arm/mach-mvebu/Kconfig                        |   4 +-
 arch/arm/xen/enlighten.c                           |   1 +
 arch/arm64/kernel/process.c                        |  16 +-
 arch/arm64/kernel/traps.c                          |  58 +-
 arch/arm64/kvm/handle_exit.c                       |   9 +
 arch/ia64/scripts/unwcheck.py                      |  16 +-
 arch/mips/boot/compressed/Makefile                 |   6 +-
 arch/mips/kernel/smp-bmips.c                       |   8 +-
 arch/mips/kernel/traps.c                           |  15 +-
 arch/mips/ralink/reset.c                           |   8 -
 arch/mips/txx9/rbtx4939/setup.c                    |   4 +-
 arch/mn10300/mm/misalignment.c                     |   2 +-
 arch/openrisc/kernel/traps.c                       |  10 +-
 arch/powerpc/include/asm/kvm_book3s.h              |   6 +-
 arch/powerpc/include/asm/topology.h                |   8 +
 arch/powerpc/kernel/entry_64.S                     |  10 +-
 arch/powerpc/kvm/book3s_interrupts.S               |   4 +-
 arch/powerpc/kvm/book3s_pr.c                       |  20 +-
 arch/powerpc/mm/numa.c                             |   5 -
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |   2 +
 arch/s390/kernel/compat_linux.c                    |   8 +-
 arch/s390/kvm/kvm-s390.c                           |   1 +
 arch/sh/kernel/traps_32.c                          |   3 +-
 arch/sparc/crypto/crc32c_glue.c                    |   1 +
 arch/x86/crypto/crc32-pclmul_glue.c                |   1 +
 arch/x86/crypto/crc32c-intel_glue.c                |   1 +
 arch/x86/include/asm/apm.h                         |   6 +
 arch/x86/include/asm/cpufeature.h                  |  15 +-
 arch/x86/include/asm/efi.h                         |   8 +
 arch/x86/include/asm/intel-family.h                |  11 +-
 arch/x86/include/asm/kvm_host.h                    |   8 +-
 arch/x86/include/asm/nospec-branch.h               |  37 ++
 arch/x86/include/asm/pgtable.h                     |   4 +-
 arch/x86/include/asm/pgtable_types.h               |   5 +
 arch/x86/include/asm/vmx.h                         |   1 +
 arch/x86/include/uapi/asm/mce.h                    |   4 +
 arch/x86/include/uapi/asm/msr-index.h              |  12 +
 arch/x86/kernel/aperture_64.c                      |  46 +-
 arch/x86/kernel/cpu/bugs.c                         |  19 +-
 arch/x86/kernel/cpu/common.c                       |  75 ++-
 arch/x86/kernel/cpu/intel.c                        |  71 +++
 arch/x86/kernel/cpu/mcheck/mce.c                   |  26 +-
 arch/x86/kernel/cpu/microcode/core.c               |   2 +-
 arch/x86/kernel/cpu/microcode/core_early.c         |  29 +-
 arch/x86/kernel/entry_64.S                         |   2 +-
 arch/x86/kernel/traps.c                            |  27 +-
 arch/x86/kvm/cpuid.c                               |  24 +-
 arch/x86/kvm/cpuid.h                               |  31 ++
 arch/x86/kvm/svm.c                                 | 171 +++++-
 arch/x86/kvm/vmx.c                                 | 619 +++++++++++----------
 arch/x86/kvm/x86.c                                 | 111 ++--
 arch/x86/mm/tlb.c                                  |  19 +
 arch/x86/oprofile/nmi_int.c                        |   2 +-
 arch/x86/xen/mmu.c                                 |   2 +-
 arch/x86/xen/suspend.c                             |  24 +
 arch/x86/xen/xen-head.S                            |  15 +
 arch/xtensa/include/asm/futex.h                    |  23 +-
 crypto/af_alg.c                                    |   5 +
 crypto/ahash.c                                     |  33 +-
 crypto/algif_hash.c                                |  54 +-
 crypto/crc32.c                                     |   1 +
 crypto/crc32c_generic.c                            |   1 +
 crypto/cryptd.c                                    |   6 +-
 crypto/shash.c                                     |  25 +-
 drivers/ata/ahci.c                                 |  24 +-
 drivers/ata/libata-core.c                          |  21 +-
 drivers/ata/libata-eh.c                            |   3 +-
 drivers/ata/libata-scsi.c                          |   4 +-
 drivers/block/pktcdvd.c                            |   4 +-
 drivers/block/rbd.c                                |   7 +-
 drivers/cdrom/cdrom.c                              |   2 +-
 drivers/char/tpm/tpm-interface.c                   |   4 +
 drivers/char/tpm/tpm_i2c_infineon.c                |   5 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c                 |   8 +-
 drivers/char/tpm/tpm_tis.c                         |   5 +-
 drivers/clocksource/fsl_ftm_timer.c                |   2 +-
 drivers/cpufreq/s3c24xx-cpufreq.c                  |   8 +-
 drivers/crypto/bfin_crc.c                          |   3 +-
 drivers/crypto/caam/ctrl.c                         |   8 +-
 drivers/crypto/s5p-sss.c                           |  12 +-
 drivers/devfreq/devfreq.c                          |   2 +-
 drivers/edac/octeon_edac-lmc.c                     |   1 +
 drivers/firmware/dmi_scan.c                        |  22 +-
 drivers/gpu/drm/drm_edid.c                         |   3 +
 drivers/gpu/drm/drm_probe_helper.c                 |  20 +
 drivers/gpu/drm/nouveau/nouveau_connector.c        |  18 +-
 drivers/gpu/drm/radeon/cik.c                       |  31 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         | 105 ++--
 drivers/gpu/drm/radeon/radeon_device.c             |   4 +
 drivers/gpu/drm/radeon/radeon_gem.c                |   2 -
 drivers/gpu/drm/radeon/radeon_object.c             |   2 +
 drivers/gpu/drm/radeon/radeon_uvd.c                |   2 +-
 drivers/gpu/drm/radeon/si_dpm.c                    |   5 +
 drivers/gpu/drm/ttm/ttm_bo.c                       |   3 +-
 drivers/gpu/drm/udl/udl_fb.c                       |   9 +-
 drivers/hid/hid-core.c                             |   3 +
 drivers/hid/hid-ids.h                              |   4 +
 drivers/hid/hid-roccat-kovaplus.c                  |   2 +
 drivers/hid/usbhid/hid-quirks.c                    |   1 +
 drivers/iio/imu/adis_trigger.c                     |   7 +-
 drivers/iio/industrialio-buffer.c                  |   2 +-
 drivers/infiniband/core/cma.c                      |   5 +-
 drivers/infiniband/core/iwpm_util.c                |   1 +
 drivers/infiniband/core/ucma.c                     |  51 +-
 drivers/infiniband/hw/mlx4/main.c                  |  13 +-
 drivers/infiniband/hw/mlx5/cq.c                    |   7 +-
 drivers/infiniband/hw/mlx5/qp.c                    |   5 +-
 drivers/infiniband/hw/mlx5/srq.c                   |  15 +-
 drivers/infiniband/ulp/ipoib/ipoib_fs.c            |   2 -
 drivers/input/keyboard/matrix_keypad.c             |   4 +-
 drivers/input/touchscreen/edt-ft5x06.c             |  14 +-
 drivers/input/touchscreen/mms114.c                 |   2 +-
 drivers/md/bcache/super.c                          |  27 +-
 drivers/md/raid10.c                                |   6 +-
 drivers/media/pci/bt8xx/bt878.c                    |   3 +-
 drivers/media/platform/exynos4-is/fimc-isp.c       |  14 +-
 drivers/media/usb/cpia2/cpia2_v4l.c                |   4 +-
 drivers/media/usb/dvb-usb-v2/lmedm04.c             |  39 +-
 drivers/media/usb/dvb-usb/cxusb.c                  |   2 +
 drivers/media/usb/dvb-usb/dib0700_devices.c        |   1 +
 drivers/misc/lkdtm.c                               |   2 +-
 drivers/mmc/card/block.c                           |  21 +
 drivers/mmc/host/dw_mmc-exynos.c                   |   1 +
 drivers/mmc/host/dw_mmc.c                          |  68 ++-
 drivers/mmc/host/dw_mmc.h                          |   2 +
 drivers/mmc/host/sdhci-pci.c                       |  27 +
 drivers/mmc/host/sdhci.c                           |   7 +-
 drivers/mmc/host/sdhci.h                           |   1 +
 drivers/mtd/chips/jedec_probe.c                    |   2 +
 drivers/mtd/nand/nand_base.c                       |   5 +-
 drivers/mtd/ubi/vmt.c                              |  15 +-
 drivers/mtd/ubi/wl.c                               |   8 +-
 drivers/net/bonding/bond_main.c                    |  73 +--
 drivers/net/can/cc770/cc770.c                      | 100 ++--
 drivers/net/can/cc770/cc770.h                      |   2 +
 drivers/net/ethernet/broadcom/bcmsysport.c         |  33 +-
 drivers/net/ethernet/broadcom/bcmsysport.h         |   2 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |   2 +-
 drivers/net/ethernet/intel/e1000e/mac.c            |   2 +-
 drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c     |  23 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |  27 +-
 drivers/net/ethernet/mellanox/mlx4/en_main.c       |   4 +-
 drivers/net/ethernet/mellanox/mlx4/mr.c            |  40 +-
 drivers/net/ethernet/mellanox/mlx4/qp.c            |   3 +
 drivers/net/slip/slip.c                            |   4 +-
 drivers/net/team/team.c                            |   4 +-
 drivers/net/tun.c                                  |   2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c      |   4 +
 drivers/net/wireless/brcm80211/brcmfmac/p2p.c      |  24 +-
 drivers/net/wireless/ti/wl1251/main.c              |   3 +-
 drivers/pci/quirks.c                               |   2 +
 drivers/pinctrl/core.c                             |  24 +-
 drivers/platform/x86/apple-gmux.c                  |  48 +-
 drivers/power/ab8500_charger.c                     |   6 +-
 drivers/s390/net/qeth_core.h                       |   5 +
 drivers/s390/net/qeth_core_main.c                  |  16 +-
 drivers/s390/net/qeth_l2_main.c                    |   2 +-
 drivers/s390/net/qeth_l3_main.c                    |   2 +-
 drivers/scsi/aacraid/aachba.c                      |  22 +-
 drivers/scsi/arm/fas216.c                          |   2 +-
 drivers/scsi/ibmvscsi/ibmvfc.h                     |   2 +-
 drivers/scsi/ipr.c                                 |   3 +-
 drivers/scsi/libsas/sas_ata.c                      |   4 +-
 drivers/scsi/libsas/sas_discover.c                 |  32 +-
 drivers/scsi/libsas/sas_expander.c                 |  11 +-
 drivers/scsi/libsas/sas_internal.h                 |   1 +
 drivers/scsi/libsas/sas_port.c                     |   3 +
 drivers/spi/spi-imx.c                              |  15 +-
 drivers/spi/spi-sun6i.c                            |   2 +-
 drivers/staging/android/ashmem.c                   |  32 +-
 drivers/staging/android/binder.c                   |  14 +-
 drivers/staging/iio/adc/ad7192.c                   |  29 +-
 drivers/staging/iio/adc/ad7192.h                   |   2 +-
 drivers/staging/iio/adc/ad7280a.c                  |   4 +-
 .../lustre/libcfs/linux/linux-crypto-adler.c       |   1 +
 drivers/staging/lustre/lustre/libcfs/tracefile.c   |   2 +-
 drivers/staging/rts5208/ms.c                       |   3 +-
 drivers/staging/usbip/stub_dev.c                   |   3 +
 drivers/staging/usbip/userspace/src/usbip_bind.c   |   9 +
 drivers/staging/usbip/userspace/src/usbip_list.c   |   9 +
 drivers/staging/usbip/vhci_hcd.c                   |   2 +
 drivers/tty/n_tty.c                                |   6 +
 drivers/tty/serial/8250/8250_pci.c                 |  11 +
 drivers/tty/serial/atmel_serial.c                  |   1 +
 drivers/tty/serial/sh-sci.c                        |   2 +
 drivers/tty/vt/vt.c                                |   8 +-
 drivers/usb/class/cdc-acm.c                        |   5 +-
 drivers/usb/core/message.c                         |   4 +
 drivers/usb/core/quirks.c                          |   6 +-
 drivers/usb/dwc3/gadget.c                          |   2 +
 drivers/usb/gadget/f_fs.c                          |   9 +-
 drivers/usb/host/ohci-q.c                          |  17 +-
 drivers/usb/host/xhci-pci.c                        |   3 +
 drivers/usb/host/xhci.c                            |   3 +
 drivers/usb/host/xhci.h                            |   1 +
 drivers/usb/misc/ldusb.c                           |   6 +
 drivers/usb/mon/mon_text.c                         | 124 +++--
 drivers/usb/serial/Kconfig                         |   3 +
 drivers/usb/serial/io_edgeport.c                   |   1 -
 drivers/usb/serial/option.c                        |   5 +
 drivers/usb/serial/pl2303.c                        |   1 +
 drivers/usb/serial/pl2303.h                        |   1 +
 drivers/usb/serial/usb-serial-simple.c             |  26 +-
 drivers/usb/storage/uas.c                          |  22 +-
 drivers/usb/storage/unusual_devs.h                 |   7 +
 drivers/vhost/net.c                                |   1 +
 drivers/video/console/dummycon.c                   |   1 -
 drivers/video/fbdev/atmel_lcdfb.c                  |  10 +-
 drivers/video/fbdev/sbuslib.c                      |   4 +-
 drivers/xen/events/events_base.c                   |   4 +-
 drivers/xen/manage.c                               |   9 +-
 fs/aio.c                                           | 134 +++--
 fs/btrfs/backref.c                                 |  11 +-
 fs/btrfs/inode.c                                   |  44 +-
 fs/btrfs/sysfs.c                                   |   6 +-
 fs/btrfs/transaction.c                             |  20 +-
 fs/btrfs/tree-log.c                                |  14 +-
 fs/btrfs/volumes.c                                 |  11 +-
 fs/cifs/cifsencrypt.c                              |   3 +-
 fs/cifs/cifssmb.c                                  |   4 +-
 fs/cifs/connect.c                                  |   4 +-
 fs/cifs/file.c                                     |  26 +-
 fs/cifs/misc.c                                     |  14 +-
 fs/cifs/smb2pdu.c                                  |   6 +-
 fs/dcache.c                                        |  11 +-
 fs/ext4/balloc.c                                   |  17 +-
 fs/ext4/ialloc.c                                   |   6 +
 fs/ext4/inode.c                                    |   6 +
 fs/ext4/super.c                                    |   1 +
 fs/f2fs/segment.c                                  |   5 +-
 fs/hugetlbfs/inode.c                               |  26 +-
 fs/jffs2/fs.c                                      |   1 -
 fs/kernfs/file.c                                   |   2 +-
 fs/namei.c                                         |   5 +-
 fs/ncpfs/ncplib_kernel.c                           |   4 +
 fs/nfs/direct.c                                    |   4 +-
 fs/nfs/idmap.c                                     |   6 +-
 fs/nfs/internal.h                                  |   1 -
 fs/nfs/nfs4sysctl.c                                |   2 +-
 fs/nfs/pagelist.c                                  |  26 +-
 fs/nfs/pnfs.c                                      |   6 +-
 fs/nfs/super.c                                     |   2 +
 fs/nfs/write.c                                     |   2 +
 fs/ocfs2/cluster/nodemanager.c                     |  63 ++-
 fs/pipe.c                                          | 198 ++++---
 include/crypto/hash.h                              |  34 +-
 include/crypto/internal/hash.h                     |   2 +
 include/drm/drm_crtc_helper.h                      |   1 +
 include/linux/crypto.h                             |   8 +
 include/linux/fs.h                                 |   4 +
 include/linux/libata.h                             |   1 +
 include/linux/mlx5/driver.h                        |   4 +-
 include/linux/mmc/sdhci.h                          |   1 +
 include/linux/nospec.h                             |   3 +-
 include/linux/pipe_fs_i.h                          |   4 +-
 include/linux/skbuff.h                             |  17 +
 include/linux/usb/quirks.h                         |   3 +
 include/linux/workqueue.h                          |   1 +
 include/net/ip.h                                   |  11 +-
 include/net/ip_fib.h                               |   1 +
 include/net/regulatory.h                           |   2 +-
 include/net/route.h                                |   3 +-
 include/net/sch_generic.h                          |   8 +
 include/net/sctp/sctp.h                            |   7 +-
 include/net/udplite.h                              |   1 +
 include/scsi/libsas.h                              |  33 +-
 include/scsi/scsi_transport_sas.h                  |   1 +
 include/uapi/linux/if_ether.h                      |   3 +
 include/uapi/linux/usb/audio.h                     |   4 +-
 include/xen/xen-ops.h                              |   1 +
 kernel/async.c                                     |  20 +-
 kernel/events/hw_breakpoint.c                      |  30 +-
 kernel/hrtimer.c                                   |   7 +-
 kernel/posix-timers.c                              |  15 +-
 kernel/relay.c                                     |   2 +-
 kernel/sysctl.c                                    |  33 +-
 kernel/trace/trace_kprobe.c                        |   4 +-
 kernel/trace/trace_probe.c                         |   8 +-
 kernel/trace/trace_probe.h                         |   2 +-
 kernel/workqueue.c                                 |  16 +
 mm/hugetlb.c                                       |   9 +
 mm/madvise.c                                       |   3 +-
 mm/memory.c                                        |   2 +-
 mm/mempolicy.c                                     |   3 +
 mm/vmscan.c                                        |  14 +-
 net/9p/trans_virtio.c                              |   3 +-
 net/batman-adv/bat_iv_ogm.c                        |  16 +-
 net/batman-adv/distributed-arp-table.c             |   2 +-
 net/batman-adv/fragmentation.c                     |   3 +-
 net/batman-adv/gateway_client.c                    |   3 +
 net/batman-adv/hard-interface.c                    |   9 +-
 net/batman-adv/multicast.c                         |   4 +-
 net/batman-adv/originator.c                        |   4 +-
 net/batman-adv/originator.h                        |   4 +-
 net/batman-adv/routing.c                           |  21 +-
 net/batman-adv/soft-interface.c                    |   8 +-
 net/batman-adv/types.h                             |   9 +-
 net/bluetooth/hidp/core.c                          |   3 +-
 net/bridge/br_sysfs_if.c                           |   3 +
 net/bridge/netfilter/ebt_among.c                   |  55 +-
 net/bridge/netfilter/ebtables.c                    |  17 +-
 net/core/dev.c                                     |  13 +-
 net/core/skbuff.c                                  |  11 +-
 net/dccp/proto.c                                   |   5 +
 net/decnet/af_decnet.c                             |  62 ++-
 net/ipv4/igmp.c                                    |   4 +
 net/ipv4/ip_sockglue.c                             |  21 +-
 net/ipv4/ip_tunnel.c                               |  30 +-
 net/ipv4/ip_vti.c                                  |   2 -
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |  24 +-
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c     |   6 +-
 net/ipv4/route.c                                   | 114 ++--
 net/ipv4/udp.c                                     |   5 +
 net/ipv4/xfrm4_policy.c                            |   1 +
 net/ipv6/ip6_checksum.c                            |   5 +
 net/ipv6/ip6_output.c                              |  13 +-
 net/ipv6/ipv6_sockglue.c                           |  27 +-
 net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c     |  18 +-
 net/ipv6/netfilter/nf_nat_l3proto_ipv6.c           |   4 +
 net/l2tp/l2tp_core.c                               | 202 +++----
 net/l2tp/l2tp_core.h                               |  26 +-
 net/l2tp/l2tp_ip.c                                 |  10 +-
 net/l2tp/l2tp_ip6.c                                |   8 +-
 net/l2tp/l2tp_ppp.c                                | 126 ++---
 net/mac80211/cfg.c                                 |   2 +-
 net/netfilter/nf_nat_proto_common.c                |   7 +-
 net/netfilter/xt_IDLETIMER.c                       |   9 +-
 net/netfilter/xt_LED.c                             |  12 +-
 net/netfilter/xt_RATEEST.c                         |  22 +-
 net/netlink/af_netlink.c                           |   3 +
 net/netlink/genetlink.c                            |  12 +-
 net/nfc/llcp_commands.c                            |   4 +
 net/nfc/netlink.c                                  |   3 +-
 net/sched/sch_netem.c                              |   6 +-
 net/sctp/sm_make_chunk.c                           |   8 +-
 net/xfrm/xfrm_user.c                               |  21 +-
 security/integrity/ima/ima_appraise.c              |   3 +-
 sound/core/oss/pcm_oss.c                           |   4 +-
 sound/core/pcm_native.c                            |   2 +-
 sound/core/seq/seq_clientmgr.c                     |  29 +-
 sound/core/seq/seq_fifo.c                          |   2 +-
 sound/core/seq/seq_memory.c                        |  14 +-
 sound/core/seq/seq_memory.h                        |   3 +-
 sound/core/seq/seq_prioq.c                         |  28 +-
 sound/core/seq/seq_prioq.h                         |   6 +-
 sound/core/seq/seq_queue.c                         |  28 +-
 sound/drivers/aloop.c                              |  17 +-
 sound/pci/hda/patch_realtek.c                      |  25 +-
 sound/soc/au1x/ac97c.c                             |   6 +-
 sound/soc/codecs/rt5651.c                          |   1 +
 sound/soc/nuc900/nuc900-ac97.c                     |   4 +-
 sound/usb/pcm.c                                    |   9 +
 sound/usb/quirks-table.h                           |  47 ++
 tools/perf/builtin-record.c                        |  13 +
 tools/perf/util/annotate.c                         |   8 +-
 tools/perf/util/evlist.c                           |  28 +
 tools/perf/util/evlist.h                           |   3 +
 tools/perf/util/session.c                          |   3 +-
 .../testing/selftests/rcutorture/bin/configinit.sh |   2 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |   4 +-
 virt/kvm/kvm_main.c                                |   3 +-
 374 files changed, 3739 insertions(+), 2144 deletions(-)

-- 
Ben Hutchings
The most exhausting thing in life is being insincere.
                                                 - Anne Morrow Lindberg
