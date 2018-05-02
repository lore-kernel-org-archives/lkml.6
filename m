Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-945659-1525276571-2-7199683974079699229
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
    1525276570; b=NNbvj5TG3XpN9JiS6dMXSBRGjQbJRi5L4LQ4Yk65u6Q4GYMe1O
    tYYFWsD8wcOoM3EsyR9SPIIZZudNb/cQ2i9EL07w47yY23+lIpstMRwyWpEdCmg3
    1KBCJh3GUMR35o5AGdOqHyZ0u9O/lDKFS0Bs7xPGHeQNWyCUDFrS3V3X6HHauh22
    8HqonSvAr6bRXerbK3EzZZKutLjmdfD7imiygGaZgef8SXkW0o1n0Lpx2yqm0Vn2
    1+W6ldQBuS51e4NNf6mPe5QcRhoGyfrGX2N5X4uKph+GGQq2YlYiX6iicPl2WYis
    8uUBShGvl4nobd3vGiF5ZL1ypgwXmVzC9tRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1525276570;
    bh=FCYLY519eHiAuOUnnGo9zNZH384bWlKazJPKn7MutlY=; b=b/t6isXu4zPb
    nNjyxAZx4ZoMMAkED1UUck7AaAJQi4spCn6s07rEQVjPZ+oVZVAzEtYWa7oQyK3A
    VLHL2j+4Bx679H38n26wQabvwHXO/8veG2QlePmM76bT2nhGLMqXZjc1AJfzMoDh
    JbxwQ8/CzTpwQZDil9+ldLWEj5UMaGSMO0eo4zF11EExcZB+IbWt7S3bA2oQxKDn
    dZi5+xBcc1eVuSBCmVVonPu2ZcBLsGwkk/qypppAJ9UlEsj/7en5CyuL5CBoQngr
    EVm/0zkTAhLfxluq96eTZ1PNUJoP4Tjo1ev/d9YpxPUGOifEZN5zzxpxhDsP81T9
    XOUyqT1M2w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=nEky0H0J x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=nEky0H0J x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfEBvbsf1Al6LnXaslam1qDFKOhyxMvPNlvGV7etpKJyjxb+7boQo0IPXIUAr52qEquTRq9ElBaGlKQEEuJL307cQITEK9ju4LpmUkWZGd4XgkkFAL+FI
    HaeWSr+/D6qgJCruIdNM/iwD5UddTgrrl/UVvKUsDcuvFSxQfmGneqxFax+VftA3DSGAwu0cysDpFlpx4yGf4g9KfnBPzuypSeMW0td7b1DOyNrhM9D+sRAn
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=SisYBh5ByA8d0X1xjTMA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=qLwXyVg2yX2suAn7:21 a=v9qT0f2sQDW_x5UG:21 a=wPNLvfGTeEIA:10
    a=8h4ssRzCBEJtYSef9lMA:9 a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeEBP4J (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 11:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751174AbeEBP4H (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 2 May 2018 11:56:07 -0400
Date: Wed, 2 May 2018 08:55:56 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.16.7
Message-ID: <20180502155556.GA16483@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.16.7 kernel.

All users of the 4.16 kernel series must upgrade.

The updated 4.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.16.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/virtual/kvm/api.txt                           |    9=20
 Documentation/virtual/kvm/arm/psci.txt                      |   30 ++
 Makefile                                                    |    2=20
 arch/arm/boot/dts/gemini-nas4220b.dts                       |   28 +-
 arch/arm/configs/socfpga_defconfig                          |    1=20
 arch/arm/include/asm/kvm_host.h                             |    3=20
 arch/arm/include/uapi/asm/kvm.h                             |    6=20
 arch/arm/kvm/guest.c                                        |   13=20
 arch/arm64/include/asm/kvm_host.h                           |    3=20
 arch/arm64/include/uapi/asm/kvm.h                           |    6=20
 arch/arm64/kvm/guest.c                                      |   14 -
 arch/powerpc/kernel/mce_power.c                             |    7=20
 arch/powerpc/mm/mem.c                                       |    2=20
 arch/powerpc/platforms/powernv/npu-dma.c                    |   23 +
 arch/powerpc/platforms/powernv/opal-rtc.c                   |    8=20
 arch/sparc/include/uapi/asm/oradax.h                        |    2=20
 arch/x86/include/uapi/asm/msgbuf.h                          |   31 ++
 arch/x86/include/uapi/asm/shmbuf.h                          |   42 +++
 arch/x86/kernel/cpu/microcode/core.c                        |    6=20
 arch/x86/kernel/cpu/microcode/intel.c                       |    2=20
 arch/x86/kernel/smpboot.c                                   |    2=20
 block/bfq-iosched.c                                         |   10=20
 block/blk-core.c                                            |   15 -
 block/blk-mq.c                                              |    7=20
 crypto/drbg.c                                               |    2=20
 drivers/amba/bus.c                                          |   17 -
 drivers/android/binder.c                                    |    8=20
 drivers/char/random.c                                       |   90 +++++-
 drivers/char/virtio_console.c                               |  157 +++++--=
-----
 drivers/cpufreq/powernv-cpufreq.c                           |   14 -
 drivers/crypto/ccp/sp-dev.c                                 |    6=20
 drivers/fpga/altera-ps-spi.c                                |    2=20
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                       |    7=20
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           |   10=20
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c       |    5=20
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c |   32 --
 drivers/gpu/drm/drm_edid.c                                  |   11=20
 drivers/gpu/drm/i915/intel_cdclk.c                          |   16 +
 drivers/gpu/drm/i915/intel_fbdev.c                          |    2=20
 drivers/gpu/drm/i915/intel_runtime_pm.c                     |   11=20
 drivers/gpu/drm/virtio/virtgpu_vq.c                         |    4=20
 drivers/mtd/chips/cfi_cmdset_0001.c                         |   33 ++
 drivers/mtd/chips/cfi_cmdset_0002.c                         |    9=20
 drivers/mtd/nand/marvell_nand.c                             |   25 -
 drivers/mtd/nand/tango_nand.c                               |    2=20
 drivers/mtd/spi-nor/cadence-quadspi.c                       |   19 +
 drivers/of/fdt.c                                            |    7=20
 drivers/pci/host/pci-aardvark.c                             |   53 ++--
 drivers/pci/pci-driver.c                                    |    5=20
 drivers/rtc/rtc-opal.c                                      |   37 +-
 drivers/s390/cio/vfio_ccw_fsm.c                             |   19 -
 drivers/sbus/char/oradax.c                                  |    2=20
 drivers/scsi/sd.c                                           |    2=20
 drivers/scsi/sd_zbc.c                                       |  140 ++++++-=
---
 drivers/slimbus/messaging.c                                 |    2=20
 drivers/tty/n_gsm.c                                         |   23 +
 drivers/tty/serial/earlycon.c                               |    6=20
 drivers/tty/serial/mvebu-uart.c                             |    1=20
 drivers/tty/tty_io.c                                        |    5=20
 drivers/tty/tty_ldisc.c                                     |   29 --
 drivers/usb/core/hcd.c                                      |    1=20
 drivers/usb/core/hub.c                                      |   10=20
 drivers/usb/core/quirks.c                                   |    3=20
 drivers/usb/host/xhci-dbgtty.c                              |    8=20
 drivers/usb/host/xhci-pci.c                                 |    5=20
 drivers/usb/host/xhci-plat.c                                |    1=20
 drivers/usb/serial/Kconfig                                  |    1=20
 drivers/usb/serial/cp210x.c                                 |    1=20
 drivers/usb/serial/ftdi_sio.c                               |    3=20
 drivers/usb/serial/usb-serial-simple.c                      |    7=20
 drivers/usb/typec/ucsi/ucsi.c                               |    2=20
 drivers/usb/usbip/stub_main.c                               |    5=20
 drivers/usb/usbip/usbip_common.h                            |    2=20
 drivers/usb/usbip/usbip_event.c                             |    4=20
 drivers/usb/usbip/vhci_hcd.c                                |   13=20
 drivers/virt/vboxguest/vboxguest_core.c                     |   66 ++---
 drivers/virt/vboxguest/vboxguest_core.h                     |    9=20
 drivers/virt/vboxguest/vboxguest_linux.c                    |   19 +
 drivers/virt/vboxguest/vboxguest_utils.c                    |   17 -
 fs/cifs/cifssmb.c                                           |    3=20
 fs/cifs/smb2ops.c                                           |   18 +
 fs/cifs/smb2pdu.c                                           |    4=20
 fs/cifs/smbdirect.c                                         |   36 --
 fs/cifs/transport.c                                         |    4=20
 fs/ext4/balloc.c                                            |   17 +
 fs/ext4/extents.c                                           |   16 -
 fs/ext4/ialloc.c                                            |    7=20
 fs/ext4/super.c                                             |    1=20
 fs/jbd2/transaction.c                                       |    1=20
 include/asm-generic/vmlinux.lds.h                           |    2=20
 include/kvm/arm_psci.h                                      |   16 +
 include/linux/blkdev.h                                      |    5=20
 include/linux/mtd/flashchip.h                               |    1=20
 include/linux/serial_core.h                                 |   21 +
 include/linux/tty.h                                         |    2=20
 include/linux/vbox_utils.h                                  |   23 -
 include/linux/virtio.h                                      |    3=20
 include/sound/control.h                                     |    7=20
 kernel/module.c                                             |    3=20
 kernel/time/tick-sched.c                                    |   11=20
 lib/kobject.c                                               |   12=20
 net/ceph/messenger.c                                        |    7=20
 net/ceph/mon_client.c                                       |   14 -
 sound/core/pcm_compat.c                                     |    7=20
 sound/core/pcm_native.c                                     |   24 -
 sound/core/seq/oss/seq_oss_event.c                          |   15 -
 sound/core/seq/oss/seq_oss_midi.c                           |    2=20
 sound/core/seq/oss/seq_oss_synth.c                          |   85 +++---
 sound/core/seq/oss/seq_oss_synth.h                          |    3=20
 sound/drivers/opl3/opl3_synth.c                             |    7=20
 sound/firewire/dice/dice-stream.c                           |    2=20
 sound/firewire/dice/dice.c                                  |    2=20
 sound/pci/asihpi/hpimsginit.c                               |   13=20
 sound/pci/asihpi/hpioctl.c                                  |    4=20
 sound/pci/hda/hda_hwdep.c                                   |   12=20
 sound/pci/hda/patch_hdmi.c                                  |    9=20
 sound/pci/hda/patch_realtek.c                               |    5=20
 sound/pci/rme9652/hdspm.c                                   |   24 +
 sound/pci/rme9652/rme9652.c                                 |    6=20
 sound/soc/fsl/fsl_esai.c                                    |    7=20
 sound/soc/omap/omap-dmic.c                                  |   14 -
 sound/usb/mixer_maps.c                                      |    3=20
 tools/lib/str_error_r.c                                     |    2=20
 virt/kvm/arm/arm.c                                          |   15 -
 virt/kvm/arm/psci.c                                         |   60 ++++
 125 files changed, 1216 insertions(+), 601 deletions(-)

Abhay Kumar (1):
      drm/i915/audio: set minimum CD clock to twice the BCLK

Alan Jenkins (1):
      block: do not use interruptible wait anywhere

Alistair Popple (1):
      powerpc/powernv/npu: Do a PID GPU TLB flush when invalidating a large=
 address range

Anatolij Gustschin (1):
      fpga-manager: altera-ps-spi: preserve nCONFIG state

Arnd Bergmann (1):
      x86/ipc: Fix x32 version of shmid64_ds and msqid64_ds

Balbir Singh (1):
      powerpc/mm: Flush cache on memory hot(un)plug

Bart Van Assche (1):
      scsi: sd_zbc: Avoid that resetting a zone fails sporadically

Borislav Petkov (2):
      x86/microcode/intel: Save microcode patch unconditionally
      x86/microcode: Do not exit early from __reload_late()

Brijesh Singh (1):
      crypto: ccp - add check to get PSP master only when PSP is detected

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

Geert Uytterhoeven (4):
      ARM: amba: Make driver_override output consistent with other buses
      ARM: amba: Fix race condition with driver_override
      ARM: amba: Don't read past the end of sysfs "driver_override" buffer
      slimbus: Fix out-of-bounds access in slim_slicesize()

Gerd Hoffmann (1):
      drm/virtio: fix vq wait_event condition

Greg Kroah-Hartman (2):
      Revert "xhci: plat: Register shutdown for xhci_plat"
      Linux 4.16.7

Hans de Goede (3):
      virt: vbox: Move declarations of vboxguest private functions to priva=
te header
      virt: vbox: Add vbg_req_free() helper function
      virt: vbox: Use __get_free_pages instead of kmalloc for DMA32 memory

Harry Wentland (2):
      drm/amd/display: Don't read EDID in atomic_check
      drm/amd/display: Disallow enabling CRTC without primary plane with FB

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

Jianchao Wang (1):
      blk-mq: start request gstate with gen 1

Joakim Tjernlund (3):
      mtd: cfi: cmdset_0001: Do not allow read/write to suspend erase block.
      mtd: cfi: cmdset_0001: Workaround Micron Erase suspend bug.
      mtd: cfi: cmdset_0002: Do not allow read/write to suspend erase block.

Josh Poimboeuf (1):
      objtool, perf: Fix GCC 8 -Wrestrict error

Jos=E9 Roberto de Souza (1):
      drm/i915/fbdev: Enable late fbdev initial configuration

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

Linus Walleij (1):
      ARM: dts: Fix NAS4220B pin config

Long Li (2):
      cifs: smbd: Avoid allocating iov on the stack
      cifs: smbd: Don't use RDMA read/write when signing is used

Lukas Czerner (1):
      ext4: fix bitmap position validation

Mahesh Rajashekhara (1):
      scsi: sd: Defer spinning up drive while SANITIZE is in progress

Mahesh Salgaonkar (1):
      powerpc/mce: Fix a bug where mce loops on memory UE.

Marc Gonzalez (1):
      mtd: rawnand: tango: Fix struct clk memory leak

Marc Zyngier (3):
      serial: mvebu-uart: Fix local flags handling on termios update
      KVM: arm/arm64: Close VMID generation race
      arm/arm64: KVM: Add PSCI version selection API

Martijn Coenen (1):
      ANDROID: binder: prevent transactions into own process.

Michael S. Tsirkin (6):
      virtio: add ability to iterate over vqs
      virtio_console: don't tie bufs to a vq
      virtio_console: free buffers after reset
      virtio_console: drop custom control queue cleanup
      virtio_console: move removal code
      virtio_console: reset on out of memory

Mika Westerberg (1):
      PCI / PM: Do not clear state_saved in pci_pm_freeze() when smart susp=
end is set

Mikita Lipski (1):
      drm/amd/display: Fix deadlock when flushing irq

Miquel Raynal (1):
      mtd: rawnand: marvell: fix the chip-select DT parsing logic

Nicholas Piggin (1):
      rtc: opal: Fix OPAL RTC driver OPAL_BUSY loops

Nicolai H=E4hnle (1):
      drm/amdgpu: set COMPUTE_PGM_RSRC1 for SGPR/VGPR clearing shaders

Nicolin Chen (1):
      ASoC: fsl_esai: Fix divisor calculation failure at lower ratio

Ravi Chandra Sadineni (1):
      USB: Increment wakeup count on remote wakeup.

Rob Gardner (1):
      sparc64: Fix mistake in oradax license text

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

Steve French (1):
      SMB311: Fix reconnect

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

Tero Kristo (1):
      ASoC: dmic: Fix clock parenting

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

Thomas Richter (1):
      module: Fix display of wrong module .text address

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

Ville Syrj=E4l=E4 (1):
      drm/edid: Reset more of the display info

Yazen Ghannam (1):
      x86/smpboot: Don't use mwait_play_dead() on AMD systems

Zhengjun Xing (1):
      xhci: Fix Kernel oops in xhci dbgtty


--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrp34kACgkQONu9yGCS
aT4ryQ//bhyO27fKMTWUwT1CDlExWNGIp9K93g4y+6Ef557bSsuOyH/VmPwMirOX
JWvmqNsRzBZvbf8oQwV7UWzSjPmBgbRLMlTwJv6mNXMCwhMHyXtvLHmGqSxxKt8Q
d46sNQAsibNzKu0E8bf6S6afd+8s7wC/619YeKeFG18sDPK7k9tiOiQHZH5ZeP/B
rX+CzPwzV0snQt89gIqRSiKMbhZgDts9aDQNMz0ZSCd7wc5/yHao/Gv+v/cg6Fh3
V452Y8BjWYXPQ9/GVeu8tqf4S3orzNKBa5rhNwrIybEs4hqPLXm/KTLo7gUPmEqs
W1TnVmAScYGJgdMLDLsDHSesx15Yi2vwaimOKl6in0Nj1ueCJUkXbB6i0cJxAGLL
1W/a3iipXJmA9NaF12vyTwiXYG+PE47//ix4F9Z6WUBOwDIg+CR6iMI/t6PWVKB8
net37qLIgU+ONNhkO4eII2lVlkvfDdTUs0GUUHQHjtoVKBcSS52/PoaVZ7jUGyCn
kubBrkH5VRM3dGQ/TCcFfbyf/eYVqdwjRpXCfJKEGc0QKd7r9q0na78I9uN8kirV
1CbJ5c+M3+GCL4GDpKip/4KUQOb5NE0LcaFPp0zUnUYRq0ce3MoEArGJMqT8QVTj
B+cFo8Qa60k+kyRxLPWSz8K6utf7obAPRs3Us9a7S8M/OKTEfQs=
=DTdG
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
