Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9433C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5402087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544708395;
	bh=VraEW44H4WvGKDJDPHBYSlr+hBC9nQAigyEeOopfIKQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=sQttxrfpiEOK1GghWWMOrMzhLpU+WEFYThX6neNQryUL8CpnKDlboDUielPFdaH3W
	 /egSSYhJ64LagsZAGFbh6enX29fSrt/fOj3oUowLNf5aACR7yZv3rmLzTKbS1BsfMw
	 YRFrITXZ5nmZqT0F13T7FkVWyyrgpmyYr6p5GqJs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5402087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbeLMNjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:39:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729547AbeLMNjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:39:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0051720879;
        Thu, 13 Dec 2018 13:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544708392;
        bh=VraEW44H4WvGKDJDPHBYSlr+hBC9nQAigyEeOopfIKQ=;
        h=Date:From:To:Cc:Subject:From;
        b=C5Sktt9k48DrFeQeBkNdJfobAq+CBZT040FJ9XJHJJX3us3RTqXSWx0AsvinOwy8/
         TnAJCRnc445fa1pPyGct19kO41BbzC9NhV1vONxzbV9rPPFw1VTRz0bfP/hUuGVF+O
         D6UqSnq9FjOWD8QFSNj/TJJdAmiOsF/SXibzTBFI=
Date:   Thu, 13 Dec 2018 14:39:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.167
Message-ID: <20181213133950.GA18385@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.167 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                       |    5 +
 arch/arc/Kconfig                               |    2=20
 arch/arc/Makefile                              |    2=20
 arch/arc/configs/axs101_defconfig              |    2=20
 arch/arc/configs/axs103_defconfig              |    1=20
 arch/arc/configs/axs103_smp_defconfig          |    1=20
 arch/arc/configs/nsim_700_defconfig            |    1=20
 arch/arc/configs/nsimosci_defconfig            |    2=20
 arch/arc/configs/nsimosci_hs_defconfig         |    1=20
 arch/arc/configs/nsimosci_hs_smp_defconfig     |    1=20
 arch/arc/configs/tb10x_defconfig               |    1=20
 arch/arc/configs/vdk_hs38_defconfig            |    1=20
 arch/arc/configs/vdk_hs38_smp_defconfig        |    1=20
 arch/mips/include/asm/syscall.h                |    2=20
 arch/mips/ralink/mt7620.c                      |    2=20
 arch/x86/kvm/mmu.c                             |   27 ++------
 arch/xtensa/kernel/asm-offsets.c               |   16 ++---
 arch/xtensa/kernel/process.c                   |    5 +
 drivers/dma/at_hdmac.c                         |   10 ++-
 drivers/gpu/drm/ast/ast_main.c                 |    3=20
 drivers/gpu/drm/gma500/mdfld_intel_display.c   |    2=20
 drivers/infiniband/ulp/iser/iser_verbs.c       |    7 --
 drivers/input/joystick/xpad.c                  |   16 +----
 drivers/input/keyboard/matrix_keypad.c         |   23 ++++---
 drivers/input/mouse/elan_i2c_core.c            |    3=20
 drivers/iommu/intel-iommu.c                    |    2=20
 drivers/iommu/intel-svm.c                      |    2=20
 drivers/iommu/ipmmu-vmsa.c                     |    3=20
 drivers/leds/led-class.c                       |    5 -
 drivers/leds/leds-gpio.c                       |    4 -
 drivers/leds/leds-pwm.c                        |    1=20
 drivers/media/usb/em28xx/em28xx-dvb.c          |    3=20
 drivers/misc/mic/scif/scif_rma.c               |    2=20
 drivers/net/can/rcar_can.c                     |    5 +
 drivers/net/ethernet/amd/sunlance.c            |    4 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h    |    7 ++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c |    1=20
 drivers/net/ethernet/faraday/ftmac100.c        |    7 --
 drivers/net/ethernet/mellanox/mlx4/alloc.c     |    2=20
 drivers/net/ethernet/mellanox/mlx4/mlx4.h      |    4 -
 drivers/net/ethernet/mellanox/mlx4/mr.c        |    1=20
 drivers/net/ethernet/qlogic/qed/qed_int.c      |    2=20
 drivers/net/ethernet/qlogic/qed/qed_main.c     |    2=20
 drivers/net/rionet.c                           |    2=20
 drivers/net/usb/ipheth.c                       |   10 +--
 drivers/net/wireless/mac80211_hwsim.c          |    8 +-
 drivers/net/wireless/ti/wlcore/cmd.c           |    6 -
 drivers/s390/net/qeth_core_main.c              |   27 +++-----
 drivers/s390/virtio/virtio_ccw.c               |   17 ++++-
 drivers/scsi/bfa/bfa_fcbuild.c                 |    8 +-
 drivers/scsi/bfa/bfa_fcs.c                     |   78 ++++++++++++--------=
----
 drivers/scsi/bfa/bfa_fcs_lport.c               |   62 +++++++------------
 drivers/scsi/bfa/bfa_ioc.c                     |    2=20
 drivers/scsi/bfa/bfa_svc.c                     |    4 -
 drivers/scsi/bfa/bfad.c                        |   20 +++---
 drivers/scsi/bfa/bfad_attr.c                   |    2=20
 drivers/scsi/bfa/bfad_bsg.c                    |    6 -
 drivers/scsi/csiostor/csio_lnode.c             |   43 ++++++++-----
 drivers/scsi/scsi_devinfo.c                    |   22 ++----
 drivers/staging/lustre/lustre/lmv/lmv_obd.c    |    2=20
 drivers/staging/rts5208/sd.c                   |    6 -
 drivers/tty/serial/8250/8250_mtk.c             |   16 ++---
 drivers/tty/serial/kgdboc.c                    |   47 +++++++-------
 drivers/usb/core/hub.c                         |    2=20
 drivers/usb/core/quirks.c                      |    7 ++
 drivers/usb/core/usb.c                         |    6 -
 drivers/usb/gadget/udc/dummy_hcd.c             |    9 +-
 drivers/usb/host/hwa-hc.c                      |    2=20
 drivers/usb/host/xhci.c                        |   16 +++++
 drivers/usb/misc/appledisplay.c                |    1=20
 drivers/usb/storage/unusual_realtek.h          |   10 +++
 fs/btrfs/disk-io.c                             |   10 ---
 fs/btrfs/free-space-cache.c                    |    2=20
 fs/btrfs/super.c                               |    1=20
 fs/btrfs/transaction.c                         |    6 -
 fs/cifs/dir.c                                  |    2=20
 fs/exec.c                                      |    7 --
 fs/ext2/xattr.c                                |    2=20
 fs/kernfs/symlink.c                            |    2=20
 include/linux/sched.h                          |    7 +-
 include/linux/usb.h                            |    4 -
 include/sound/pcm_params.h                     |    4 -
 kernel/debug/kdb/kdb_support.c                 |    4 -
 kernel/events/uprobes.c                        |   12 +++
 lib/kobject.c                                  |    2=20
 mm/mlock.c                                     |    3=20
 mm/truncate.c                                  |    8 +-
 net/batman-adv/fragmentation.c                 |    2=20
 net/ipv4/ip_tunnel.c                           |    4 -
 net/mac80211/iface.c                           |    2=20
 net/mac80211/rx.c                              |    1=20
 net/mac80211/status.c                          |    2=20
 net/mac80211/tx.c                              |    4 -
 net/sunrpc/auth_gss/auth_gss.c                 |    4 +
 scripts/Makefile.extrawarn                     |    3=20
 scripts/unifdef.c                              |    4 -
 sound/core/control.c                           |   80 ++++++++++++++------=
-----
 sound/core/pcm_native.c                        |   14 ++--
 sound/isa/wss/wss_lib.c                        |    2=20
 sound/pci/ac97/ac97_codec.c                    |    2=20
 sound/pci/hda/hda_intel.c                      |    4 +
 sound/pci/trident/trident.c                    |    2=20
 sound/sparc/cs4231.c                           |    8 --
 sound/usb/card.c                               |    5 +
 104 files changed, 474 insertions(+), 380 deletions(-)

Adam Wong (1):
      Input: elan_i2c - add support for ELAN0621 touchpad

Alexander Theissen (1):
      usb: appledisplay: Add 27" Apple Cinema Display

Alexey Brodkin (1):
      arc: [devboards] Add support of NFSv3 ACL

Andrea Parri (1):
      uprobes: Fix handle_swbp() vs. unregister() + register() race once mo=
re

Arnd Bergmann (6):
      exec: avoid gcc-8 warning for get_task_comm
      drm: gma500: fix logic error
      scsi: bfa: convert to strlcpy/strlcat
      staging: rts5208: fix gcc-8 logic error warning
      kdb: use memmove instead of overlapping memcpy
      usb: gadget: dummy: fix nonsensical comparisons

Aya Levin (1):
      net/mlx4: Fix UBSAN warning of signed integer overflow

Ben Greear (1):
      mac80211: Clear beacon_int in ieee80211_do_stop

Bernd Eckstein (1):
      usbnet: ipheth: fix potential recvmsg bug and recvmsg bug 2

Cameron Gutman (1):
      Input: xpad - quirk all PDP Xbox One gamepads

Chanho Min (1):
      ALSA: pcm: Fix starvation on down_write_nonblock()

Christian Hoff (1):
      Input: matrix_keypad - check for errors from of_get_named_gpio()

Chuck Lever (1):
      SUNRPC: Fix leak of krb5p encode pages

Denis Bolotin (2):
      qed: Fix PTT leak in qed_drain()
      qed: Fix reading wrong value in loop condition

Dmitry V. Levin (1):
      mips: fix mips_get_syscall_arg o32 check

Emmanuel Grumbach (1):
      mac80211: ignore NullFunc frames in the duplicate detection

Fabrizio Castro (1):
      can: rcar_can: Fix erroneous registration

Felix Fietkau (2):
      mac80211: ignore tx status for PS stations in ieee80211_tx_status_ext
      mac80211: fix reordering of buffered broadcast packets

Filipe Manana (2):
      Btrfs: ensure path name is null terminated at btrfs_control_ioctl
      Btrfs: fix use-after-free when dumping free space

Geert Uytterhoeven (1):
      iommu/ipmmu-vmsa: Fix crash on early domain free

Greg Kroah-Hartman (2):
      Staging: lustre: remove two build warnings
      Linux 4.4.167

Guenter Roeck (2):
      kobject: Replace strncpy with memcpy
      kernfs: Replace strncpy with memcpy

Halil Pasic (2):
      virtio/s390: avoid race on vcdev->config
      virtio/s390: fix race in ccw_io_helper()

Harry Pan (1):
      usb: quirk: add no-LPM quirk on SanDisk Ultra Flair device

Hui Peng (1):
      ALSA: usb-audio: Fix UAF decrement if card has no live interfaces in =
card.c

Jack Morgenstein (1):
      net/mlx4_core: Zero out lkey field in SW2HW_MPT fw command

Josef Bacik (1):
      btrfs: release metadata before running delayed refs

Julian Wiedmann (1):
      s390/qeth: fix length check in SNMP processing

Junaid Shahid (1):
      kvm: mmu: Fix race in emulated page table writes

Kai-Heng Feng (2):
      USB: usb-storage: Add new IDs to ums-realtek
      ALSA: hda: Add support for AMD Stoney Ridge

Kees Cook (1):
      scsi: csiostor: Avoid content leaks and casts

Kevin Hilman (1):
      ARC: change defconfig defaults to ARCv2

Laura Abbott (2):
      kgdboc: Fix restrict error
      kgdboc: Fix warning with module build

Linus Torvalds (1):
      unifdef: use memcpy instead of strncpy

Lu Baolu (1):
      iommu/vt-d: Fix NULL pointer dereference in prq_event_thread()

Macpaul Lin (1):
      kgdboc: fix KASAN global-out-of-bounds bug in param_set_kgdboc_var()

Markus Hofstaetter (1):
      leds: call led_pwm_set() in leds-pwm to enforce default LED_OFF

Martin Wilck (1):
      scsi: scsi_devinfo: cleanly zero-pad devinfo strings

Mathias Kresin (1):
      MIPS: ralink: Fix mt7620 nd_sd pinmux

Mathias Nyman (1):
      xhci: Prevent U1/U2 link pm states if exit latency is too long

Mathias Payer (1):
      USB: check usb_get_extra_descriptor for proper size

Matthias Schwarzott (1):
      media: em28xx: Fix use-after-free when disconnecting

Max Filippov (2):
      xtensa: enable coprocessors that are being flushed
      xtensa: fix coprocessor context offset definitions

Michael Niew=F6hner (1):
      usb: core: quirks: add RESET_RESUME quirk for Cherry G230 Stream seri=
es

Milo Kim (1):
      leds: turn off the LED and wait for completion on unregistering LED c=
lass device

Nikolay Borisov (1):
      btrfs: Always try all copies when reading extent buffers

Noah Westervelt (1):
      Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15ARR

Pan Bian (3):
      rapidio/rionet: do not free skb before reading its length
      ext2: fix potential use after free
      iommu/vt-d: Use memunmap to free memremap

Patrick Gaskin (1):
      Input: elan_i2c - add ELAN0620 to the ACPI table

Paulo Alcantara (1):
      cifs: Fix separator when building path from dentry

Pavel Tikhomirov (1):
      mm: cleancache: fix corruption on missed inode invalidation

Peter Shih (1):
      tty: serial: 8250_mtk: always resume the device in probe.

Richard Genoud (2):
      dmaengine: at_hdmac: fix memory leak in at_dma_xlate()
      dmaengine: at_hdmac: fix module unloading

Sagi Grimberg (1):
      iser: set sector for ambiguous mr status errors

Sam Bobroff (1):
      drm/ast: Fix incorrect free on ioregs

Sasha Levin (1):
      Revert "wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_=
timeout()"

Simon Guo (1):
      mm: mlock: avoid increase mm->locked_vm on mlock() when already mlock=
2(,MLOCK_ONFAULT)

Stephen Rothwell (1):
      disable stringop truncation warnings for now

Sudarsana Reddy Kalluru (1):
      bnx2x: Assign unique DMAE channel number for FW DMAE transactions.

Sultan Alsawaf (1):
      ip_tunnel: Fix name string concatenate in __ip_tunnel_create()

Sven Eckelmann (1):
      batman-adv: Expand merged fragment buffer for full packet

Takashi Iwai (7):
      ALSA: wss: Fix invalid snd_free_pages() at error path
      ALSA: ac97: Fix incorrect bit shift at AC97-SPSA control write
      ALSA: control: Fix race between adding and removing a user element
      ALSA: sparc: Fix invalid snd_free_pages() at error path
      ALSA: trident: Suppress gcc string warning
      ALSA: pcm: Call snd_pcm_unlink() conditionally at closing
      ALSA: pcm: Fix interval evaluation with openmin/max

Tariq Toukan (1):
      net/mlx4_core: Fix uninitialized variable compilation warning

Vasyl Vavrychuk (1):
      mac80211_hwsim: Timer should be initialized before device registered

Vincent Chen (1):
      net: faraday: ftmac100: remove netif_running(netdev) check before dis=
abling interrupts

Wei Yongjun (1):
      leds: leds-gpio: Fix return value check in create_gpio_led()

Xiongfeng Wang (1):
      Kbuild: suppress packed-not-aligned warning for default setting only

Yangtao Li (1):
      net: amd: add missing of_node_put()

YueHaibing (1):
      misc: mic/scif: fix copy-paste error in scif_create_remote_lookup


--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwSYSYACgkQONu9yGCS
aT6bpA//XOH+rgivatSXm/uOCh6iVc7XQ0RhlBXucyqepzxvBM3NsPyCpArsrLqv
wkpFrDhA4CI/6Z/0ezRi2A68eyeeEZNcHT1A5Ye5Mcw8pzo/J3xxGZ9MUma3CywS
pFOtV+011m/sXVYN03RpuwPykuyNj+DBF+/2t/jePfWU9rnEm41xHtNts1ms5+hi
rRompzLrQjXagiuyk7GcPiJvrLawcqEAtUEgJkhhr856+CP2KtQUsMYggx8y6Dx9
mkMu3/jdiNlEG+PibTEJityQIPSBnX5f80GRPPjrm/htVrWyYt6mEzgNarir70xG
mkVCjGgd/gLBryw/Y6DRJunLGk/b2Iyh+2ElQ/eiUOOW85C66Des/CxmI+8w0WJS
nzZd/YKejwvqO5Nnv44ZQD1wVwr8PykyfTYUNaA2fT747ikpjIrOpIV+EceEqAlg
rvQUp/Mr0EVL7sQNxNYeR35VK0yflZ9jy9T+AnTn4eHQYc9ppq8vlscYE+5AhJAx
iIZYSyXy0v5H7vjQ4FHIxVHfNaEWcTlqyPrY11VGVz2z+U8xbGz/gtc3+wzzjGm5
I0snaeBewKRcWkbop9i5nEIn47klQ0NBslZ8375VIItK2Drn+3zb2510fGIRnkrL
xvilPaPBO+SMp29Ua36nZpZzqyo8+alSi+M6mhy9wQV3c7q3IAA=
=H7SQ
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
