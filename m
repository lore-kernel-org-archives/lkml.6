Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753777AbeE3Lqz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:46:55 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60625 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751211AbeE3LG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:57 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        akpm@linux-foundation.org
Date: Wed, 30 May 2018 11:52:40 +0100
Message-ID: <lsq.1527677560.486731940@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 000/153] 3.2.102-rc1 review
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.2.102 release.
There are 153 patches in this series, which will be posted as responses
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu May 31 23:00:00 UTC 2018.
Anything received after that time might be too late.

All the patches have also been committed to the linux-3.2.y-rc branch of
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-stable-rc.git .
A shortlog and diffstat can be found below.

Ben.

-------------

Adam Goode (1):
      ALSA: seq: correctly detect input buffer overflow
         [21fd3e956ee8a307a06bc6e095f5767a00eb2a7e]

Alan Stern (1):
      USB: OHCI: Fix race between ED unlink and URB submission
         [7d8021c967648accd1b78e5e1ddaad655cd2c61f]

Alex Chen (1):
      ocfs2: subsystem.su_mutex is required while accessing the  item->ci_parent
         [853bc26a7ea39e354b9f8889ae7ad1492ffa28d2]

Alexander Potapenko (1):
      netlink: make sure nladdr has correct size in netlink_connect()
         [7880287981b60a6808f39f297bb66936e8bdf57a]

Alexey Kodanev (2):
      dccp: check sk for closed state in dccp_sendmsg()
         [67f93df79aeefc3add4e4b31a752600f834236e2]
      sctp: verify size of a new chunk in _sctp_make_chunk()
         [07f2c7ab6f8d0a7e7c5764c4e6cc9c52951b9d9c]

Aman Deep (1):
      usb: ohci: Proper handling of ed_rm_list to handle race condition between usb_kill_urb() and finish_unlinks()
         [46408ea558df13b110e0866b99624384a33bdeba]

Andy Lutomirski (1):
      x86/entry/64: Don't use IST entry for #BP stack
         [d8ba61ba58c88d5207c1ba2f7d9a2280e7d03be9]

Anna-Maria Gleixner (1):
      hrtimer: Ensure POSIX compliance (relative CLOCK_REALTIME hrtimers)
         [48d0c9becc7f3c66874c100c126459a9da0fdced]

Arnd Bergmann (1):
      scsi: fas216: fix sense buffer initialization
         [96d5eaa9bb74d299508d811d865c2c41b38b0301]

Bart Van Assche (1):
      pktcdvd: Fix pkt_setup_dev() error path
         [5a0ec388ef0f6e33841aeb810d7fa23f049ec4cd]

Bastian Stender (1):
      mmc: block: fix updating ext_csd caches on ioctl call
         [e74ef2194b41ba5e511fab29fe5ff00e72d2f42a]

Ben Crocker (1):
      drm/radeon: insist on 32-bit DMA for Cedar on PPC64/PPC64LE
         [2c83029cda55a5e7665c7c6326909427d6a01350]

Benjamin Poirier (1):
      e1000e: Fix check_for_link return value with autoneg off
         [4e7dc08e57c95673d2edaba8983c3de4dd1f65f5]

Chenjie (1):
      mm/madvise.c: fix madvise() infinite loop under special circumstances
         [6ea8d958a2c95a1d514015d4e29ba21a8c0a1a91]

Chien Tin Tung (1):
      RDMA/ucma: Correct option size check using optlen
         [5f3e3b85cc0a5eae1c46d72e47d3de7bf208d9e2]

Christophe JAILLET (1):
      media: bt8xx: Fix err 'bt878_probe()'
         [45392ff6881dbe56d41ef0b17c2e576065f8ffa1]

Clay McClure (1):
      ubi: Fix race condition between ubi volume creation and udev
         [a51a0c8d213594bc094cb8e54aad0cb6d7f7b9a6]

Colin Ian King (1):
      scsi: aacraid: remove redundant setting of variable c
         [91814744646351a470f256fbcb853fb5a7229a9f]

Cong Wang (2):
      netfilter: ipt_CLUSTERIP: fix a refcount bug in clusterip_config_find_get()
         [db93a3632b0f8773a3899e04a3a3e0aa7a26eb46]
      netfilter: xt_RATEEST: acquire xt_rateest_mutex for hash insert
         [7dc68e98757a8eccf8ca7a53a29b896f1eef1f76]

Corentin Labbe (1):
      powerpc/pseries: Add empty update_numa_cpu_lookup_table() for NUMA=n
         [c1e150ceb61e4a585bad156da15c33bfe89f5858]

Dan Carpenter (8):
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
      staging: ncpfs: memory corruption in ncp_read_kernel()
         [4c41aa24baa4ed338241d05494f2c595c885af8f]

Danilo Krummrich (1):
      usb: quirks: add control message delay for 1b1c:1b20
         [cb88a0588717ba6c756cb5972d75766b273a6817]

Darrick J. Wong (1):
      ext4: fix block bitmap validation when bigalloc, ^flex_bg
         [e674e5cbd0942b42a12106ac0be8330f4301bef4]

David Rientjes (1):
      kernel/relay.c: limit kmalloc size to KMALLOC_MAX_SIZE
         [88913bd8ea2a75d7e460a4bed5f75e1c32660d7e]

Dmitry Vyukov (1):
      netfilter: ipt_CLUSTERIP: fix out-of-bounds accesses in clusterip_tg_check()
         [1a38956cce5eabd7b74f94bab70265e4df83165e]

Eran Ben Elisha (1):
      net/mlx4_en: Fix mixed PFC and Global pause user control requests
         [6e8814ceb7e8f468659ef9253bd212c07ae19584]

Eric Biggers (6):
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

Eric Dumazet (3):
      l2tp: do not accept arbitrary sockets
         [17cfe79a65f98abe535261856c5aef14f306dff7]
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

Florian Fainelli (1):
      MIPS: TXX9: use IS_ENABLED() macro
         [b33b44073734842ec0c75d376c40d0471d6113ff]

Florian Westphal (5):
      netfilter: bridge: ebt_among: add missing match size checks
         [c4585a2823edf4d1326da44d1524ecbfda26bb37]
      netfilter: bridge: ebt_among: add more missing match size checks
         [c8d70a700a5b486bfa8e5a7d33d805389f6e59f9]
      netfilter: ebtables: CONFIG_COMPAT: don't trust userland offsets
         [b71812168571fa55e44cdd0254471331b9c4c4c6]
      netfilter: ebtables: fix erroneous reject of last rule
         [932909d9b28d27e807ff8eecb68c7748f6701628]
      xfrm_user: uncoditionally validate esn replay attribute struct
         [d97ca5d714a5334aecadadf696875da40f1fbf3e]

Greg Kroah-Hartman (1):
      USB: serial: pl2303: new device id for Chilitag
         [d08dd3f3dd2ae351b793fc5b76abdbf0fd317b12]

Greg Kurz (1):
      9p/trans_virtio: discard zero-length reply
         [26d99834f89e76514076d9cd06f61e56e6a509b8]

Hangbin Liu (1):
      l2tp: fix missing print session offset info
         [820da5357572715c6235ba3b3daa2d5b43a1198f]

Hans de Goede (5):
      USB: cdc-acm: Do not log urb submission errors on disconnect
         [f0386c083c2ce85284dc0b419d7b89c8e567c09f]
      ahci: Add PCI-id for the Highpoint Rocketraid 644L card
         [28b2182dad43f6f8fcbd167539a26714fd12bd64]
      libata: Apply NOLPM quirk to Crucial M500 480 and 960GB SSDs
         [62ac3f7305470e3f52f159de448bc1a771717e88]
      libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs
         [9c7be59fc519af9081c46c48f06f2b8fadf55ad8]
      libata: Make Crucial BX100 500GB LPM quirk apply to all firmware versions
         [3bf7b5d6d017c27e0d3b160aafb35a8e7cfeda1f]

Ivan Vecera (1):
      net/mlx4_en: do not ignore autoneg in mlx4_en_set_pauseparam()
         [278d436a476f69fc95d5c82bf61b6c2d02f4d44e]

Jack Stocker (1):
      Add delay-init quirk for Corsair K70 RGB keyboards
         [7a1646d922577b5b48c0d222e03831141664bb59]

Jake Daryll Obina (1):
      jffs2: Fix use-after-free bug in jffs2_iget()'s error handling path
         [5bdd0c6f89fba430e18d636493398389dadc3b17]

Jakub Kicinski (1):
      net: fix race on decreasing number of TX queues
         [ac5b70198adc25c73fba28de4f78adcee8f6be0b]

James Chapman (2):
      l2tp: don't use inet_shutdown on ppp session destroy
         [225eb26489d05c679a4c4197ffcb81c81e9dcaf4]
      l2tp: fix race in pppol2tp_release with session object destroy
         [d02ba2a6110c530a32926af8ad441111774d2893]

James Hogan (1):
      MIPS: Fix clean of vmlinuz.{32,ecoff,bin,srec}
         [5f2483eb2423152445b39f2db59d372f523e664e]

Jan Beulich (1):
      x86/mm: Fix {pmd,pud}_{set,clear}_flags()
         [842cef9113c2120f74f645111ded1e020193d84c]

Jason Gunthorpe (1):
      sctp: Fix mangled IPv4 addresses on a IPv6 listening socket
         [9302d7bb0c5cd46be5706859301f18c137b2439f]

Jason Yan (2):
      scsi: libsas: fix error when getting phy events
         [2b23d9509fd7174b362482cf5f3b5f9a2265bc33]
      scsi: libsas: fix memory leak in sas_smp_get_phy_events()
         [4a491b1ab11ca0556d2fda1ff1301e862a2d44c4]

Jean Delvare (2):
      firmware/dmi_scan: constify strings
         [ffbbb96dd7570b9aafd426cd77a7ee03d224cabf]
      firmware: dmi_scan: Fix handling of empty DMI strings
         [a7770ae194569e96a93c48aceb304edded9cc648]

Jeremy Boone (1):
      tpm_tis: fix potential buffer overruns caused by bit glitches on the bus
         [6bb320ca4a4a7b5b3db8c8d7250cc40002046878]

Jia-Ju Bai (1):
      USB: serial: io_edgeport: fix possible sleep-in-atomic
         [c7b8f77872c73f69a16528a9eb87afefcccdc18b]

Johannes Berg (1):
      regulatory: add NUL to request alpha2
         [657308f73e674e86b60509a430a46e569bf02846]

Julia Lawall (1):
      USB: usbmon: remove assignment from IS_ERR argument
         [46c236dc7d1212d7417e6fb0317f91c44c719322]

Julian Wiedmann (2):
      s390/qeth: fix SETIP command handling
         [1c5b2216fbb973a9410e0b06389740b5c1289171]
      s390/qeth: free netdevice when removing a card
         [6be687395b3124f002a653c1a50b3260222b3cd7]

K.Prasad (1):
      perf/hwpb: Invoke __perf_event_disable() if interrupts are already  disabled
         [500ad2d8b01390c98bc6dce068bccfa9534b8212]

Kai-Heng Feng (2):
      libata: disable LPM for Crucial BX100 SSD 500GB drive
         [b17e5729a630d8326a48ec34ef02e6b4464a6aef]
      xhci: Fix front USB ports on ASUS PRIME B350M-A
         [191edc5e2e515aab1075a3f0ef23599e80be5f59]

Kirill Marinushkin (1):
      ALSA: usb-audio: Fix parsing descriptor of UAC2 processing unit
         [a6618f4aedb2b60932d766bd82ae7ce866e842aa]

Leon Romanovsky (7):
      RDMA/ucma: Check that device exists prior to accessing it
         [c8d3bcbfc5eab3f01cf373d039af725f3b488813]
      RDMA/ucma: Check that device is connected prior to access it
         [4b658d1bbc16605330694bb3ef2570c465ef383d]
      RDMA/ucma: Check that user doesn't overflow QP state
         [a5880b84430316e3e1c1f5d23aa32ec6000cc717]
      RDMA/ucma: Ensure that CM_ID exists prior to access it
         [e8980d67d6017c8eee8f9c35f782c4bd68e004c9]
      RDMA/ucma: Fix access to non-initialized CM_ID object
         [7688f2c3bbf55e52388e37ac5d63ca471a7712e1]
      RDMA/ucma: Fix use-after-free access in ucma_close
         [ed65a4dc22083e73bac599ded6a262318cad7baf]
      RDMA/ucma: Limit possible option size
         [6a21dfc0d0db7b7e0acedce67ca533a6eb19283c]

Linus Torvalds (2):
      perf/hwbp: Simplify the perf-hwbp code, fix documentation
         [f67b15037a7a50c57f72e69a6d59941ad90a0f0f]
      tty: vt: fix up tabstops properly
         [f1869a890cdedb92a3fab969db5d0fd982850273]

Linus Walleij (1):
      mtd: jedec_probe: Fix crash in jedec_read_mfr()
         [87a73eb5b56fd6e07c8e499fe8608ef2d8912b82]

Liu Bo (1):
      Btrfs: fix extent state leak from tree log
         [55237a5f2431a72435e3ed39e4306e973c0446b7]

Lukas Czerner (1):
      ext4: fix bitmap position validation
         [22be37acce25d66ecf6403fc8f44df9c5ded2372]

Marc Kleine-Budde (1):
      slip: sl_alloc(): remove unused parameter "dev_t line"
         [936e5d8bdfa72577e28ea671d9e2ee4fef0d6b3e]

Masami Hiramatsu (1):
      tracing: probeevent: Fix to support minus offset from symbol
         [c5d343b6b7badd1f5fe0873eff2e8d63a193e732]

Matt Redfearn (1):
      MIPS: TXx9: use IS_BUILTIN() for CONFIG_LEDS_CLASS
         [0cde5b44a30f1daaef1c34e08191239dc63271c4]

Matthew Wilcox (1):
      cifs: Fix missing put_xid in cifs_file_strict_mmap
         [f04a703c3d613845ae3141bfaf223489de8ab3eb]

Matthias Schiffer (1):
      batman-adv: fix packet checksum in receive path
         [abd6360591d3f8259f41c34e31ac4826dfe621b8]

Mauro Carvalho Chehab (1):
      media: cxusb, dib0700: ignore XC2028_I2C_FLUSH
         [9893b905e743ded332575ca04486bd586c0772f7]

Mel Gorman (1):
      mm: pin address_space before dereferencing it while isolating an LRU page
         [69d763fc6d3aee787a3e8c8c35092b4f4960fa5d]

Michel Dänzer (1):
      drm/radeon: Don't turn off DP sink when disconnected
         [2681bc79eeb640562c932007bfebbbdc55bf6a7d]

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

Mulhern (1):
      dm thin: fix documentation relative to low water mark threshold
         [9b28a1102efc75d81298198166ead87d643a29ce]

Nathan Fontenot (1):
      powerpc/numa: Invalidate numa_cpu_lookup_table on cpu remove
         [1d9a090783bef19fe8cdec878620d22f05191316]

Nicolas Dichtel (2):
      netlink: avoid a double skb free in genlmsg_mcast()
         [02a2385f37a7c6594c9d89b64c4a1451276f08eb]
      netlink: ensure to loop over all netns in genlmsg_multicast_allns()
         [cb9f7a9a5c96a773bbc9c70660dc600cfff82f82]

Nicolas Pitre (1):
      console/dummy: leave .con_font_get set to NULL
         [724ba8b30b044aa0d94b1cd374fc15806cdd6f18]

Oliver Neukum (1):
      CDC-ACM: apply quirk for card reader
         [df1cc78a52491f71d8170d513d0f6f114faa1bda]

Paolo Abeni (5):
      dn_getsockoptdecnet: move nf_{get/set}sockopt outside sock lock
         [dfec091439bb2acf763497cfc58f2bdfc67c56b7]
      netfilter: drop outermost socket lock in getsockopt()
         [01ea306f2ac2baff98d472da719193e738759d93]
      netfilter: nat: cope with negative port range
         [db57ccf0f2f4624b4c4758379f8165277504fbd7]
      netfilter: on sockopt() acquire sock lock only in the required scope
         [3f34cfae1238848fd53f25e5c8fd59da57901f4b]
      netfilter: x_tables: fix missing timer initialization in xt_LED
         [10414014bc085aac9f787a5890b33b5605fbcfc4]

Pete Zaitcev (1):
      usb: usbmon: Read text within supplied buffer size
         [a5f596830e27e15f7a0ecd6be55e433d776986d8]

Peter Malone (1):
      fbdev: Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in sbusfb_ioctl_helper().
         [250c6c49e3b68756b14983c076183568636e2bde]

Raghava Aditya Renukunta (1):
      scsi: aacraid: Fix udev inquiry race condition
         [f4e8708d3104437fd7716e957f38c265b0c509ef]

Rasmus Villemoes (1):
      nospec: Allow index argument to have const-qualified type
         [b98c6a160a057d5686a8c54c79cc6c8c94a7d0c8]

Seunghun Han (1):
      x86/MCE: Serialize sysfs changes
         [b3b7c4795ccab5be71f080774c45bbbcc75c2aaf]

Stefan Roese (1):
      ALSA: pcm: Use dma_bytes as size parameter in dma_mmap_coherent()
         [9066ae7ff5d89c0b5daa271e2d573540097a94fa]

Stephan Mueller (1):
      crypto: af_alg - whitelist mask and type
         [bb30b8848c85e18ca7e371d0a869e94b3e383bdf]

Takashi Iwai (7):
      ALSA: aloop: Fix access to not-yet-ready substream via cable
         [8e6b1a72a75bb5067ccb6b56d8ca4aa3a300a64e]
      ALSA: aloop: Sync stale timer before release
         [67a01afaf3d34893cf7d2ea19b34555d6abb7cb0]
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

Tejun Heo (1):
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

Tony Luck (1):
      x86/MCE: Save microcode revision in machine check records
         [fa94d0c6e0f3431523f5701084d799c77c7d4a4f]

Tyrel Datwyler (1):
      scsi: ibmvfc: fix misdefined reserved field in ibmvfc_fcp_rsp_info
         [c39813652700f3df552b6557530f1e5f782dbe2f]

Ulrich Hecht (1):
      serial: sh-sci: prevent lockup on full TTY buffers
         [7842055bfce4bf0170d0f61df8b2add8399697be]

Vinicius Costa Gomes (1):
      skbuff: Fix not waking applications when errors are enqueued
         [6e5d58fdc9bedd0255a8781b258f10bbdc63e975]

Wang Nan (1):
      x86/traps: Enable DEBUG_STACK after cpu_init() for TRAP_DB/BP
         [b4d8327024637cb2a1f7910dcb5d0ad7a096f473]

Xin Long (2):
      bonding: process the err returned by dev_set_allmulti properly in bond_enslave
         [9f5a90c107741b864398f4ac0014711a8c1d8474]
      bridge: check brport attr show in brport_show
         [1b12580af1d0677c3c3a19e35bfe5d59b03f737f]

Yisheng Xie (1):
      mm/mempolicy.c: avoid use uninitialized preferred_node
         [8970a63e965b43288c4f5f40efbc2bbf80de7f16]

Zhang Bo (1):
      Input: matrix_keypad - fix race when disabling interrupts
         [ea4f7bd2aca9f68470e9aac0fc9432fd180b1fe7]

Zhouyi Zhou (1):
      ext4: save error to disk in __ext4_grp_locked_error()
         [06f29cc81f0350261f59643a505010531130eea0]

 Documentation/device-mapper/thin-provisioning.txt |   8 +-
 Documentation/filesystems/ext4.txt                |   2 +-
 Makefile                                          |   4 +-
 arch/alpha/kernel/pci_impl.h                      |   3 +-
 arch/alpha/kernel/process.c                       |  12 +--
 arch/mips/boot/compressed/Makefile                |   6 +-
 arch/mips/txx9/generic/setup.c                    |  12 +--
 arch/mips/txx9/generic/setup_tx4939.c             |   2 +-
 arch/mips/txx9/rbtx4939/setup.c                   |  11 +-
 arch/mn10300/mm/misalignment.c                    |   2 +-
 arch/openrisc/kernel/traps.c                      |  10 +-
 arch/powerpc/include/asm/topology.h               |   8 ++
 arch/powerpc/platforms/pseries/hotplug-cpu.c      |   2 +
 arch/s390/kernel/compat_linux.c                   |   8 +-
 arch/sh/kernel/traps_32.c                         |   3 +-
 arch/x86/crypto/crc32c-intel.c                    |   1 +
 arch/x86/include/asm/mce.h                        |   4 +
 arch/x86/include/asm/pgtable.h                    |   4 +-
 arch/x86/include/asm/pgtable_types.h              |   5 +
 arch/x86/kernel/cpu/mcheck/mce.c                  |  26 ++++-
 arch/x86/kernel/entry_64.S                        |   2 +-
 arch/x86/kernel/traps.c                           |  20 +++-
 crypto/af_alg.c                                   |   5 +
 crypto/ahash.c                                    |  33 +++++-
 crypto/algif_hash.c                               |  54 +++-------
 crypto/crc32c.c                                   |   1 +
 crypto/cryptd.c                                   |   6 +-
 crypto/shash.c                                    |  25 ++++-
 drivers/ata/ahci.c                                |   4 +-
 drivers/ata/libata-core.c                         |  13 ++-
 drivers/ata/libata-scsi.c                         |   4 +-
 drivers/block/pktcdvd.c                           |   4 +-
 drivers/cdrom/cdrom.c                             |   2 +-
 drivers/char/tpm/tpm_tis.c                        |   5 +-
 drivers/firmware/dmi_scan.c                       |  30 +++---
 drivers/gpu/drm/radeon/radeon_connectors.c        |  31 +++---
 drivers/gpu/drm/radeon/radeon_device.c            |   4 +
 drivers/gpu/drm/ttm/ttm_bo.c                      |   2 +-
 drivers/hid/hid-roccat-kovaplus.c                 |   2 +
 drivers/infiniband/core/cma.c                     |   3 +
 drivers/infiniband/core/ucma.c                    |  33 ++++--
 drivers/input/keyboard/matrix_keypad.c            |   4 +-
 drivers/media/dvb/bt8xx/bt878.c                   |   3 +-
 drivers/media/dvb/dvb-usb/cxusb.c                 |   2 +
 drivers/media/dvb/dvb-usb/dib0700_devices.c       |   1 +
 drivers/media/video/cpia2/cpia2_v4l.c             |   4 +-
 drivers/mmc/card/block.c                          |  21 ++++
 drivers/mtd/chips/jedec_probe.c                   |   2 +
 drivers/mtd/ubi/vmt.c                             |  15 ++-
 drivers/net/bonding/bond_main.c                   |   5 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.c       |   2 +-
 drivers/net/ethernet/intel/e1000e/lib.c           |   6 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c   |  27 +++--
 drivers/net/ethernet/mellanox/mlx4/en_main.c      |   4 +-
 drivers/net/slip/slip.c                           |   4 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c     |   4 +
 drivers/s390/net/qeth_core.h                      |   5 +
 drivers/s390/net/qeth_core_main.c                 |  16 +--
 drivers/s390/net/qeth_l2_main.c                   |   2 +-
 drivers/s390/net/qeth_l3_main.c                   |   2 +-
 drivers/scsi/aacraid/aachba.c                     |  22 ++--
 drivers/scsi/arm/fas216.c                         |   2 +-
 drivers/scsi/ibmvscsi/ibmvfc.h                    |   2 +-
 drivers/scsi/libsas/sas_expander.c                |   3 +-
 drivers/tty/n_tty.c                               |   6 ++
 drivers/tty/serial/sh-sci.c                       |   2 +
 drivers/tty/vt/vt.c                               |   8 +-
 drivers/usb/class/cdc-acm.c                       |   5 +-
 drivers/usb/core/message.c                        |   4 +
 drivers/usb/core/quirks.c                         |   6 +-
 drivers/usb/dwc3/gadget.c                         |   2 +
 drivers/usb/host/ohci-q.c                         |  24 ++---
 drivers/usb/host/xhci-pci.c                       |   3 +
 drivers/usb/host/xhci.c                           |   3 +
 drivers/usb/host/xhci.h                           |   1 +
 drivers/usb/mon/mon_text.c                        | 124 ++++++++++++++--------
 drivers/usb/serial/io_edgeport.c                  |   1 -
 drivers/usb/serial/pl2303.c                       |   1 +
 drivers/usb/serial/pl2303.h                       |   1 +
 drivers/video/console/dummycon.c                  |   1 -
 drivers/video/sbuslib.c                           |   4 +-
 fs/btrfs/tree-log.c                               |   5 +-
 fs/cifs/file.c                                    |  26 +++--
 fs/ext4/balloc.c                                  |  25 ++++-
 fs/ext4/ialloc.c                                  |   7 ++
 fs/ext4/inode.c                                   |   7 ++
 fs/ext4/super.c                                   |   1 +
 fs/hugetlbfs/inode.c                              |  26 ++++-
 fs/jffs2/fs.c                                     |   1 -
 fs/namei.c                                        |   5 +-
 fs/ncpfs/ncplib_kernel.c                          |   4 +
 fs/nfs/super.c                                    |   2 +
 fs/ocfs2/cluster/nodemanager.c                    |  63 +++++++++--
 include/crypto/hash.h                             |  34 ++++--
 include/crypto/internal/hash.h                    |   2 +
 include/linux/crypto.h                            |   8 ++
 include/linux/fs.h                                |   4 +
 include/linux/nospec.h                            |   3 +-
 include/linux/perf_event.h                        |   2 +
 include/linux/usb/audio.h                         |   4 +-
 include/linux/usb/quirks.h                        |   3 +
 include/net/regulatory.h                          |   2 +-
 include/net/sctp/sctp.h                           |   7 +-
 kernel/events/core.c                              |   2 +-
 kernel/events/hw_breakpoint.c                     |  41 +++----
 kernel/hrtimer.c                                  |   7 +-
 kernel/posix-timers.c                             |  15 ++-
 kernel/relay.c                                    |   2 +-
 kernel/trace/trace_kprobe.c                       |  11 +-
 mm/hugetlb.c                                      |   9 ++
 mm/madvise.c                                      |   2 +-
 mm/mempolicy.c                                    |   3 +
 mm/vmscan.c                                       |  14 ++-
 net/9p/trans_virtio.c                             |   3 +-
 net/batman-adv/soft-interface.c                   |   7 +-
 net/bridge/br_sysfs_if.c                          |   3 +
 net/bridge/netfilter/ebt_among.c                  |  55 +++++++++-
 net/bridge/netfilter/ebtables.c                   |  17 ++-
 net/core/dev.c                                    |  12 ++-
 net/core/skbuff.c                                 |   4 +-
 net/dccp/proto.c                                  |   5 +
 net/decnet/af_decnet.c                            |  62 ++++++-----
 net/ipv4/igmp.c                                   |   4 +
 net/ipv4/ip_sockglue.c                            |  21 +---
 net/ipv4/netfilter/ipt_CLUSTERIP.c                |  24 ++++-
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c    |   6 +-
 net/ipv4/netfilter/nf_nat_proto_common.c          |   7 +-
 net/ipv6/ipv6_sockglue.c                          |  27 ++---
 net/l2tp/l2tp_core.c                              |   8 +-
 net/l2tp/l2tp_netlink.c                           |   2 +
 net/l2tp/l2tp_ppp.c                               |  62 +++++------
 net/netfilter/xt_IDLETIMER.c                      |   9 +-
 net/netfilter/xt_LED.c                            |  12 +--
 net/netfilter/xt_RATEEST.c                        |  22 +++-
 net/netlink/af_netlink.c                          |   3 +
 net/netlink/genetlink.c                           |  12 ++-
 net/sctp/sm_make_chunk.c                          |   8 +-
 net/xfrm/xfrm_user.c                              |  21 ++--
 sound/core/oss/pcm_oss.c                          |   4 +-
 sound/core/pcm_native.c                           |   2 +-
 sound/core/seq/seq_clientmgr.c                    |  29 +++--
 sound/core/seq/seq_fifo.c                         |   4 +-
 sound/core/seq/seq_memory.c                       |  14 ++-
 sound/core/seq/seq_memory.h                       |   3 +-
 sound/core/seq/seq_prioq.c                        |  27 ++---
 sound/core/seq/seq_prioq.h                        |   6 +-
 sound/core/seq/seq_queue.c                        |  28 ++---
 sound/drivers/aloop.c                             |  17 ++-
 sound/soc/au1x/ac97c.c                            |   6 +-
 sound/soc/nuc900/nuc900-ac97.c                    |   4 +-
 sound/usb/quirks-table.h                          |  47 ++++++++
 151 files changed, 1140 insertions(+), 584 deletions(-)

-- 
Ben Hutchings
The program is absolutely right; therefore, the computer must be wrong.
