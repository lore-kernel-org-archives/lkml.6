Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1007980-1525279140-2-15837573462066760728
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525279139; b=FpZQqUC4rQ4rhLuJoiAjErCBhJ3PyJMqlXYd62ypyde0aTZrRs
    WJ4QGB5TFXlgs9FXR2C35D3pQj3pqrBOd3bRhXyfn4t9qC0pySiBca4rsAtM0jj3
    NFqEo+j07SHqNDOr1Hd/pffzRBlMJSp0+p3EAQcbGySm6xCbIKY95mwXlvnPpsbl
    Q68VFX4cftdKKxgg9+3V91LKvPmfaqnK1W8K79Upkv74e1xx0rmoq6OVoVnWgqDr
    e8DjWKbj4GvRk+J4cFDAg6AtaUc6DL3aRDniVtRZAC+oq6uAmTNbbYqHleedH4ks
    1BwXRsunqKwhGS3Oa5mqqBX5mFVHNtHRh0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1525279139;
    bh=FLAoeNSsGfTvG5EiLWdql846Qsg4h7P+/vYQ+W6eZ1o=; b=JpmihetM1ZLF
    I87v/zAYX3BaqRRStLc9AyIG/xzB4kLVdmkvrSW2Ofn9HTT14kB51iwWAcl5emkp
    xIiht6l50NdZseFIuM/UNnqj5A8kxsGsEVQiCXCHRHFX15FmH4Gq+m50B46VitZE
    2QZgdFRMjgRkt3r2a4UyDhN+1ES/FMOL39zhcjKizApDHxbb5iOPegeVltw2bVnV
    BaEfyGDgSrtxHgGBbh1lpviXA88xOLQudl9I0lOzfqDCNh7GntSjQQ4jAvyigQqA
    fkNcA8YgGaEytAZhnUQU63X8P/sJmmCkyJCFXRtM3WnpTJ3TLAu3/+fAMqU9u5g6
    6LZ7GajZSw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Qrg+7RBO x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Qrg+7RBO x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfES7/othrHioPx9AX7NR0FsbL/GuKA3fh2jVCoBZcKyPQ5irHk3mw0Ss8AdWxc4Afv3Cn7HbZmJm5zgptRv7kZEROso7LBXb183P6xWvn66eokDSAizw
    cU9BU8lGzEvw1e2hu9VB4OZjJ0YmF2sy5RgXl1Bp/BQa0SKVTkHWpsXIWLoLPuv92N3uFwRGJlHhkiKpCCTJdRyLDfrGUATdm80txiqDnnfFBAXb0S2uTZWS
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=noXIrTLnxmoUgqody_YA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=3ZH_m0449WxAKENj:21 a=ee33kH4Y1hRSqtev:21 a=wPNLvfGTeEIA:10
    a=smrPZpXcLplRW8NJ1JwA:9 a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeEBQi5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 12:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751174AbeEBQiz (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 2 May 2018 12:38:55 -0400
Date: Wed, 2 May 2018 09:38:43 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.39
Message-ID: <20180502163843.GA20620@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.39 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/virtual/kvm/api.txt         |    9 +
 Documentation/virtual/kvm/arm/psci.txt    |   30 +++++
 Makefile                                  |    2=20
 arch/arm/configs/socfpga_defconfig        |    1=20
 arch/arm/include/asm/kvm_host.h           |    3=20
 arch/arm/include/uapi/asm/kvm.h           |    6 +
 arch/arm/kvm/guest.c                      |   13 ++
 arch/arm64/include/asm/kvm_host.h         |    3=20
 arch/arm64/include/uapi/asm/kvm.h         |    6 +
 arch/arm64/kvm/guest.c                    |   14 ++
 arch/powerpc/kernel/eeh_driver.c          |   61 +++++++----
 arch/powerpc/mm/mem.c                     |    2=20
 arch/powerpc/platforms/powernv/npu-dma.c  |   23 +++-
 arch/powerpc/platforms/powernv/opal-rtc.c |    8 -
 arch/x86/include/uapi/asm/msgbuf.h        |   31 +++++
 arch/x86/include/uapi/asm/shmbuf.h        |   42 ++++++++
 arch/x86/kernel/cpu/microcode/core.c      |    6 -
 arch/x86/kernel/cpu/microcode/intel.c     |    2=20
 arch/x86/kernel/smpboot.c                 |    2=20
 block/bfq-iosched.c                       |   10 +
 crypto/drbg.c                             |    2=20
 drivers/amba/bus.c                        |   17 ++-
 drivers/android/binder.c                  |    8 +
 drivers/char/random.c                     |   90 ++++++++++++-----
 drivers/char/virtio_console.c             |  157 +++++++++++++------------=
-----
 drivers/cpufreq/powernv-cpufreq.c         |   14 ++
 drivers/fpga/altera-ps-spi.c              |    2=20
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c     |    7 -
 drivers/gpu/drm/i915/intel_runtime_pm.c   |   11 --
 drivers/gpu/drm/virtio/virtgpu_vq.c       |    4=20
 drivers/mtd/chips/cfi_cmdset_0001.c       |   33 +++++-
 drivers/mtd/chips/cfi_cmdset_0002.c       |    9 +
 drivers/mtd/nand/tango_nand.c             |    2=20
 drivers/mtd/spi-nor/cadence-quadspi.c     |   19 +++
 drivers/of/fdt.c                          |    7 -
 drivers/pci/host/pci-aardvark.c           |   53 +++++-----
 drivers/rtc/rtc-opal.c                    |   37 ++++---
 drivers/s390/cio/vfio_ccw_fsm.c           |   19 ++-
 drivers/scsi/sd.c                         |    2=20
 drivers/tty/n_gsm.c                       |   23 ++++
 drivers/tty/serial/earlycon.c             |    6 -
 drivers/tty/tty_io.c                      |    5=20
 drivers/tty/tty_ldisc.c                   |   29 ++---
 drivers/usb/core/hcd.c                    |    1=20
 drivers/usb/core/hub.c                    |   10 +
 drivers/usb/core/quirks.c                 |    3=20
 drivers/usb/host/xhci-pci.c               |    5=20
 drivers/usb/host/xhci-plat.c              |    1=20
 drivers/usb/serial/Kconfig                |    1=20
 drivers/usb/serial/cp210x.c               |    1=20
 drivers/usb/serial/ftdi_sio.c             |    3=20
 drivers/usb/serial/usb-serial-simple.c    |    7 +
 drivers/usb/typec/ucsi/ucsi.c             |    2=20
 drivers/usb/usbip/stub_main.c             |    5=20
 drivers/usb/usbip/usbip_common.h          |    2=20
 drivers/usb/usbip/usbip_event.c           |    4=20
 drivers/usb/usbip/vhci_hcd.c              |   13 ++
 fs/ext4/balloc.c                          |   17 ++-
 fs/ext4/extents.c                         |   16 ++-
 fs/ext4/ialloc.c                          |    7 +
 fs/ext4/super.c                           |    1=20
 fs/jbd2/transaction.c                     |    1=20
 include/asm-generic/vmlinux.lds.h         |    2=20
 include/kvm/arm_psci.h                    |   16 ++-
 include/linux/mtd/flashchip.h             |    1=20
 include/linux/serial_core.h               |   21 ++--
 include/linux/tty.h                       |    2=20
 include/linux/virtio.h                    |    3=20
 include/sound/control.h                   |    7 -
 kernel/time/tick-sched.c                  |   11 +-
 lib/kobject.c                             |   12 --
 net/ceph/messenger.c                      |    7 +
 net/ceph/mon_client.c                     |   14 ++
 sound/core/pcm_compat.c                   |    7 -
 sound/core/pcm_native.c                   |   24 ++--
 sound/core/seq/oss/seq_oss_event.c        |   15 +-
 sound/core/seq/oss/seq_oss_midi.c         |    2=20
 sound/core/seq/oss/seq_oss_synth.c        |   85 +++++++++-------
 sound/core/seq/oss/seq_oss_synth.h        |    3=20
 sound/drivers/opl3/opl3_synth.c           |    7 -
 sound/firewire/dice/dice-stream.c         |    2=20
 sound/firewire/dice/dice.c                |    2=20
 sound/pci/asihpi/hpimsginit.c             |   13 +-
 sound/pci/asihpi/hpioctl.c                |    4=20
 sound/pci/hda/hda_hwdep.c                 |   12 ++
 sound/pci/hda/patch_hdmi.c                |    9 +
 sound/pci/hda/patch_realtek.c             |    5=20
 sound/pci/rme9652/hdspm.c                 |   24 ++--
 sound/pci/rme9652/rme9652.c               |    6 -
 sound/soc/fsl/fsl_esai.c                  |    7 +
 sound/usb/mixer_maps.c                    |    3=20
 tools/lib/str_error_r.c                   |    2=20
 tools/lib/subcmd/pager.c                  |    5=20
 virt/kvm/arm/arm.c                        |   15 +-
 virt/kvm/arm/psci.c                       |   60 +++++++++++
 95 files changed, 959 insertions(+), 379 deletions(-)

Alistair Popple (1):
      powerpc/powernv/npu: Do a PID GPU TLB flush when invalidating a large=
 address range

Anatolij Gustschin (1):
      fpga-manager: altera-ps-spi: preserve nCONFIG state

Arnd Bergmann (1):
      x86/ipc: Fix x32 version of shmid64_ds and msqid64_ds

Balbir Singh (1):
      powerpc/mm: Flush cache on memory hot(un)plug

Borislav Petkov (2):
      x86/microcode/intel: Save microcode patch unconditionally
      x86/microcode: Do not exit early from __reload_late()

Collin May (1):
      USB: serial: simple: add libtransistor console

Cornelia Huck (1):
      vfio: ccw: process ssch with interrupts disabled

Daniel Kurtz (1):
      earlycon: Use a pointer table to fix __earlycon_table stride

David Henningsson (1):
      ALSA: core: Report audio_tstamp in snd_pcm_sync_ptr

Dmitry Vyukov (1):
      kobject: don't use WARN for registration failures

Eric Biggers (1):
      ext4: prevent right-shifting extents beyond EXT_MAX_BLOCKS

Evan Wang (1):
      PCI: aardvark: Fix PCIe Max Read Request Size setting

Geert Uytterhoeven (3):
      ARM: amba: Make driver_override output consistent with other buses
      ARM: amba: Fix race condition with driver_override
      ARM: amba: Don't read past the end of sysfs "driver_override" buffer

Gerd Hoffmann (1):
      drm/virtio: fix vq wait_event condition

Greg Kroah-Hartman (2):
      Revert "xhci: plat: Register shutdown for xhci_plat"
      Linux 4.14.39

Heikki Krogerus (1):
      usb: typec: ucsi: Increase command completion timeout value

Ilya Dryomov (3):
      libceph: un-backoff on tick when we have a authenticated session
      libceph: reschedule a tick in finish_hunting()
      libceph: validate con->state at the top of try_write()

Imre Deak (1):
      drm/i915: Enable display WA#1183 from its correct spot

Jeffery Miller (1):
      ALSA: pcm: Return negative delays from SNDRV_PCM_IOCTL_DELAY.

Jens Axboe (1):
      bfq-iosched: ensure to clear bic/bfqq pointers when preparing request

Joakim Tjernlund (3):
      mtd: cfi: cmdset_0001: Do not allow read/write to suspend erase block.
      mtd: cfi: cmdset_0001: Workaround Micron Erase suspend bug.
      mtd: cfi: cmdset_0002: Do not allow read/write to suspend erase block.

Josh Poimboeuf (1):
      objtool, perf: Fix GCC 8 -Wrestrict error

Kai-Heng Feng (1):
      xhci: Fix USB ports for Dell Inspiron 5775

Kailang Yang (3):
      ALSA: hda/realtek - Add some fixes for ALC233
      ALSA: hda/realtek - Update ALC255 depop optimize
      ALSA: hda/realtek - change the location for one of two front mics

Kamil Lulko (1):
      usb: core: Add quirk for HP v222w 16GB Mini

Kyle Roeschley (1):
      USB: serial: cp210x: add ID for NI USB serial console

Lukas Czerner (1):
      ext4: fix bitmap position validation

Mahesh Rajashekhara (1):
      scsi: sd: Defer spinning up drive while SANITIZE is in progress

Marc Gonzalez (1):
      mtd: rawnand: tango: Fix struct clk memory leak

Marc Zyngier (2):
      KVM: arm/arm64: Close VMID generation race
      arm/arm64: KVM: Add PSCI version selection API

Martijn Coenen (1):
      ANDROID: binder: prevent transactions into own process.

Michael Neuling (1):
      powerpc/eeh: Fix race with driver un/bind

Michael S. Tsirkin (6):
      virtio: add ability to iterate over vqs
      virtio_console: don't tie bufs to a vq
      virtio_console: free buffers after reset
      virtio_console: drop custom control queue cleanup
      virtio_console: move removal code
      virtio_console: reset on out of memory

Nicholas Piggin (1):
      rtc: opal: Fix OPAL RTC driver OPAL_BUSY loops

Nicolai H=E4hnle (1):
      drm/amdgpu: set COMPUTE_PGM_RSRC1 for SGPR/VGPR clearing shaders

Nicolin Chen (1):
      ASoC: fsl_esai: Fix divisor calculation failure at lower ratio

Ravi Chandra Sadineni (1):
      USB: Increment wakeup count on remote wakeup.

Sergey Senozhatsky (1):
      tools/lib/subcmd/pager.c: do not alias select() params

Shilpasri G Bhat (1):
      cpufreq: powernv: Fix hardlockup due to synchronous smp_call in timer=
 interrupt

Shuah Khan (4):
      usbip: usbip_event: fix to not print kernel pointer address
      usbip: usbip_host: fix to hold parent lock for device_attach() calls
      usbip: vhci_hcd: Fix usb device and sockfd leaks
      usbip: vhci_hcd: check rhport before using in vhci_hub_control()

Stephan Mueller (1):
      crypto: drbg - set freed buffers to NULL

Takashi Iwai (10):
      ALSA: usb-audio: Skip broken EU on Dell dock USB-audio
      ALSA: hda - Skip jack and others for non-existing PCM streams
      ALSA: opl3: Hardening for potential Spectre v1
      ALSA: asihpi: Hardening for potential Spectre v1
      ALSA: hdspm: Hardening for potential Spectre v1
      ALSA: rme9652: Hardening for potential Spectre v1
      ALSA: control: Hardening for potential Spectre v1
      ALSA: seq: oss: Fix unbalanced use lock for synth MIDI device
      ALSA: seq: oss: Hardening for potential Spectre v1
      ALSA: hda: Hardening for potential Spectre v1

Takashi Sakamoto (2):
      ALSA: dice: fix OUI for TC group
      ALSA: dice: fix error path to destroy initialized stream data

Tetsuo Handa (3):
      tty: Don't call panic() at tty_ldisc_init()
      tty: Avoid possible error pointer dereference at tty_ldisc_restore().
      tty: Use __GFP_NOFAIL for tty_ldisc_get()

Theodore Ts'o (6):
      ext4: set h_journal if there is a failure starting a reserved handle
      ext4: add MODULE_SOFTDEP to ensure crc32c is included in the initramfs
      ext4: add validity checks for bitmap block numbers
      random: set up the NUMA crng instances after the CRNG is fully initia=
lized
      random: fix possible sleeping allocation from irq context
      random: rate limit unseeded randomness warnings

Thomas Gleixner (1):
      tick/sched: Do not mess with an enqueued hrtimer

Thor Thayer (2):
      mtd: spi-nor: cadence-quadspi: Fix page fault kernel panic
      ARM: socfpga_defconfig: Remove QSPI Sector 4K size force

Tony Lindgren (2):
      tty: n_gsm: Fix long delays with control frame timeouts in ADM mode
      tty: n_gsm: Fix DLCI handling for ADM mode if debug & 2 is not set

Vasyl Vavrychuk (1):
      USB: serial: ftdi_sio: use jtag quirk for Arrow USB Blaster

Victor Gu (3):
      PCI: aardvark: Fix logic in advk_pcie_{rd,wr}_conf()
      PCI: aardvark: Set PIO_ADDR_LS correctly in advk_pcie_rd_conf()
      PCI: aardvark: Use ISR1 instead of ISR0 interrupt in legacy irq mode

Yazen Ghannam (1):
      x86/smpboot: Don't use mwait_play_dead() on AMD systems


--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrp6ZAACgkQONu9yGCS
aT6Zmg//RT2Wu7imaZ9hXJIrdYwb0zICicm7oOr3SkGgN7Z58YNWZiWq1oQmXHdo
dxGj3QGExGSK85yDF7+dTwgn3ZRmgS6rkxgqpapMAmI4zpWpNBVHxS75QKn9cmde
qpqasJp5tDrc/8WVy4PLCmDBhAc+/763N97IFImpMtw4FaRNtWsJF78uco6oi/T+
ThYdgOc+xp5qYVNQBrGtGRYDSxDuX7rJgRYplRhjSrv2CTfLRcc+AtBTnhQBU5l6
u8xCYoCIB/VH1f08gSg+Pz2a1klXUdz05p0sY7Wy7xjsudQHfQwUxt5jZv2d5oaG
cnhoKYLYRevTp3OXis6xCLf5e7nYfJITxULTEmNgRWy6USELV+Tf1PFNxsbGa2v9
UuWSZUDWYGSgZQnC9JX7icpojsRkVICN49t+AbCVFZEVFHHOLKfyRxBD0UxcwCsX
KdtX1Anm/vst5LBoPuOBGpV0XZkaE6CoELFbk/sXDPgqjgNAIDMGPfa4BeLG5zbC
cfNCgolo4KEMewPKiygCBtzVvsGT43NDXbzQfhTh7P0OPGdkw51xLe3MCR2EcUbh
0KioI8mTnCfTOZgD7+xYOoGIf3erkpZBiaJAmVuQpInNWAH+OT/9WpZQY7iqv4R4
qfBCT8xPlaOCJEAAtoHBEr8mXA6wa5FU2XqmqDNqhos5TDaYDOQ=
=Jfkw
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
