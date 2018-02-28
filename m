Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4191898-1519819878-2-6463820870646640053
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519819876; b=IkqYR98PM1N8FEUhM1gu7F3h+eAgAuBx3uanQDZgsIZOkiK
    yWhwPSXP5639ZHf5fld8nN8/zyzCy2AjEjHBRGneoibMgvfLo6A97VX7Ox6f/BGD
    d1SnZMDlDY0qoHPQvXZ+kEczMnQUva1RHt9ZEblEqowavO6+1UKxHDzlXWCg8Gd1
    OQvknZjIPHUPiANga5YAzY90i2bBnPqTJ+2QKjNyAU+T3K8K/n9W3wGJ+SB/LzO5
    hZ1ND+MT6QPsA0hJIXcFYPGIDgnnZVp1pvASdr18a8dBNzPHLfNzvgI7FoFn/6uE
    kws5U1fqCokzMon1ZXanIua5FVBUf2WbO+6vtzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519819876; bh=IKwMppnM6ypXPt53cW1Q3iwyTPn70xQqsHuBaQvej44=; b=v
    3ULSJizRyHk/q/jDf2GamHzRcZYVebsdlV2HfBwpMtslPzGj7dl1rHBK0Yqff8+8
    0D6sXi6W1KZG5KRhidfE1m5CCpD3BEEd14OpV3/Pj3cj20NvKGCQD77Z792kT0pH
    oiKsu2bDD0hrn7A0Tuh144fG7EMvUuDNjgXH1TgJZTAa/paWdhlj3NaLR2f2w7v0
    fV3G35oCi4IN+/K3zfkpPY8Q+u4wfnMQelGyXt0ZYLk2n4dTV5pmEEDw1nt6ymB4
    HC4swWbBRwBvVbtRBUg8Vupdv3kYzSF9FNZcc97p1lPd90XHLSCTTkJLGyFODxUU
    57/tw50Z33dB7O08+Xw6Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932134AbeB1MKW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 07:10:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46486 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbeB1MKU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 07:10:20 -0500
Date: Wed, 28 Feb 2018 13:10:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.15.7
Message-ID: <20180228121021.GA18035@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.15.7 kernel.

All users of the 4.15 kernel series must upgrade.

The updated 4.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.15.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                         |    2=20
 arch/arm64/kernel/cpufeature.c                   |    6 +
 arch/arm64/kernel/process.c                      |   11 ++-
 arch/arm64/kernel/traps.c                        |   10 ---
 arch/arm64/mm/proc.S                             |    2=20
 arch/microblaze/Makefile                         |   17 +++--
 arch/mips/boot/Makefile                          |    1=20
 arch/mips/include/asm/compat.h                   |    1=20
 arch/x86/kernel/apic/vector.c                    |   25 +++++++-
 arch/x86/oprofile/nmi_int.c                      |    2=20
 arch/xtensa/mm/init.c                            |   70 ++++++++++++++++++=
++---
 crypto/asymmetric_keys/pkcs7_verify.c            |   12 ++-
 crypto/asymmetric_keys/public_key.c              |    4 -
 crypto/asymmetric_keys/restrict.c                |   21 ++++--
 drivers/extcon/extcon-intel-int3496.c            |    3=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c |   58 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |   10 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |    2=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          |   11 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c          |    4 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           |   13 ++++
 drivers/gpu/drm/amd/amdgpu/si_dpm.c              |    5 +
 drivers/gpu/drm/amd/amdgpu/soc15.c               |    4 -
 drivers/gpu/drm/amd/amdgpu/vi.c                  |   21 ++++--
 drivers/gpu/drm/cirrus/cirrus_mode.c             |   40 +++++++------
 drivers/gpu/drm/drm_atomic_helper.c              |   15 ++++
 drivers/gpu/drm/drm_edid.c                       |    3=20
 drivers/gpu/drm/drm_mm.c                         |   21 +++++-
 drivers/gpu/drm/i915/intel_breadcrumbs.c         |   29 +++------
 drivers/hid/hid-core.c                           |    3=20
 drivers/hid/hid-ids.h                            |    3=20
 drivers/i2c/busses/i2c-bcm2835.c                 |   21 ++++++
 drivers/i2c/busses/i2c-designware-master.c       |    2=20
 drivers/iio/adc/stm32-adc.c                      |    7 +-
 drivers/iio/imu/adis_trigger.c                   |    7 +-
 drivers/iio/industrialio-buffer.c                |    2=20
 drivers/iio/proximity/Kconfig                    |    2=20
 drivers/infiniband/core/rdma_core.c              |   10 ++-
 drivers/infiniband/core/uverbs_cmd.c             |   16 +++--
 drivers/infiniband/core/uverbs_main.c            |   27 ++++++--
 drivers/irqchip/irq-gic-v3.c                     |    2=20
 drivers/irqchip/irq-mips-gic.c                   |    2=20
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c       |   10 ---
 drivers/net/thunderbolt.c                        |   19 ++++--
 drivers/pci/quirks.c                             |   39 +++++++-----
 drivers/scsi/ibmvscsi/ibmvfc.h                   |    2=20
 drivers/usb/core/quirks.c                        |    3=20
 drivers/usb/dwc3/ep0.c                           |    7 +-
 drivers/usb/dwc3/gadget.c                        |    2=20
 drivers/usb/gadget/function/f_fs.c               |   44 ++------------
 drivers/usb/host/ehci-hub.c                      |    4 -
 drivers/usb/host/ohci-hcd.c                      |   10 ++-
 drivers/usb/host/ohci-hub.c                      |    4 -
 drivers/usb/host/ohci-q.c                        |   17 +++--
 drivers/usb/misc/ldusb.c                         |    6 +
 drivers/usb/musb/musb_host.c                     |    8 --
 drivers/usb/phy/phy-mxs-usb.c                    |    3=20
 drivers/usb/renesas_usbhs/fifo.c                 |    5 +
 drivers/xen/tmem.c                               |    4 +
 include/drm/drm_atomic.h                         |    9 ++
 include/linux/kconfig.h                          |    9 ++
 include/uapi/linux/if_ether.h                    |    6 +
 include/uapi/linux/libc-compat.h                 |    6 -
 kernel/irq/matrix.c                              |   23 ++++---
 mm/page_alloc.c                                  |    4 +
 mm/zswap.c                                       |    6 +
 net/ipv4/ip_sockglue.c                           |    7 --
 net/ipv6/ipv6_sockglue.c                         |   10 ---
 net/mac80211/cfg.c                               |    2=20
 69 files changed, 540 insertions(+), 256 deletions(-)

AMAN DEEP (1):
      usb: ohci: Proper handling of ed_rm_list to handle race condition bet=
ween usb_kill_urb() and finish_unlinks()

Alex Deucher (4):
      drm/amdgpu: Add dpm quirk for Jet PRO (v2)
      drm/amdgpu: only check mmBIF_IOV_FUNC_IDENTIFIER on tonga/fiji
      drm/amdgpu: add atpx quirk handling (v2)
      drm/amdgpu: Avoid leaking PM domain on driver unbind (v2)

Andreas Klinger (1):
      iio: srf08: fix link error "devm_iio_triggered_buffer_setup" undefined

Ard Biesheuvel (1):
      arm64: mm: don't write garbage into TTBR1_EL1 register

Arnd Bergmann (4):
      cfg80211: fix cfg80211_beacon_dup
      Kbuild: always define endianess in kconfig.h
      x86/oprofile: Fix bogus GCC-8 warning in nmi_setup()
      microblaze: fix endian handling

Ben Gardner (1):
      i2c: designware: must wait for enable

Bin Liu (1):
      Revert "usb: musb: host: don't start next rx urb if current one faile=
d"

Casey Leedom (1):
      PCI/cxgb4: Extend T3 PCI quirk to T4+ devices

Chris Wilson (2):
      drm: Handle unexpected holes in color-eviction
      drm/i915/breadcrumbs: Ignore unsubmitted signalers

Christian K=F6nig (1):
      drm/amdgpu: fix VA hole handling on Vega10 v3

Daniel Vetter (1):
      drm/cirrus: Load lut in crtc_commit

Eric Anholt (1):
      i2c: bcm2835: Set up the rising/falling edge delays

Eric Biggers (4):
      X.509: fix BUG_ON() when hash algorithm is unsupported
      X.509: fix NULL dereference when restricting key with unsupported_sig
      PKCS#7: fix certificate chain verification
      PKCS#7: fix certificate blacklisting

Fabio Estevam (1):
      usb: phy: mxs: Fix NULL pointer dereference on i.MX23/28

Fabrice Gasnier (1):
      iio: adc: stm32: fix stm32h7_adc_enable error handling

Greg Kroah-Hartman (1):
      Linux 4.15.7

Hans de Goede (1):
      extcon: int3496: process id-pin first so that we start with the right=
 status

Hauke Mehrtens (1):
      uapi/if_ether.h: move __UAPI_DEF_ETHHDR libc define

Huang Rui (1):
      drm/amdgpu: disable MMHUB power gating on raven

Huang Ying (1):
      mm, swap, frontswap: fix THP swap if frontswap enabled

Jack Pham (2):
      usb: gadget: f_fs: Process all descriptors during bind
      usb: gadget: f_fs: Use config_ep_by_speed()

Jack Stocker (1):
      Add delay-init quirk for Corsair K70 RGB keyboards

James Hogan (1):
      MIPS: Drop spurious __unused in struct compat_flock

Juergen Gross (1):
      mm: don't defer struct page initialization for Xen pv guests

Kai-Heng Feng (2):
      drm/edid: Add 6 bpc quirk for CPT panel in Asus UX303LA
      drm/amdgpu: add new device to use atpx quirk

Karsten Koop (1):
      usb: ldusb: add PIDs for new CASSY devices supported by this driver

Kees Cook (2):
      kconfig.h: Include compiler types to avoid missed struct attributes
      MIPS: boot: Define __ASSEMBLY__ for its.S build

Lars-Peter Clausen (1):
      iio: adis_lib: Initialize trigger before requesting interrupt

Leo (Sunpeng) Li (1):
      drm/atomic: Fix memleak on ERESTARTSYS during non-blocking commits

Leon Romanovsky (5):
      RDMA/uverbs: Protect from races between lookup and destroy of uobjects
      RDMA/uverbs: Protect from command mask overflow
      RDMA/uverbs: Fix bad unlock balance in ib_uverbs_close_xrcd
      RDMA/uverbs: Fix circular locking dependency
      RDMA/uverbs: Sanitize user entered port numbers prior to access it

Matt Redfearn (1):
      irqchip/mips-gic: Avoid spuriously handling masked interrupts

Max Filippov (1):
      xtensa: fix high memory/reserved memory collision

Michael Weiser (2):
      arm64: Remove unimplemented syscall log message
      arm64: Disable unhandled signal log messages by default

Mika Westerberg (2):
      net: thunderbolt: Tear down connection properly on suspend
      net: thunderbolt: Run disconnect flow asynchronously when logout is r=
eceived

Paolo Abeni (1):
      netfilter: drop outermost socket lock in getsockopt()

Peter Chen (1):
      usb: host: ehci: use correct device pointer for dma ops

Shanker Donthineni (1):
      irqchip/gic-v3: Use wmb() instead of smb_wmb() in gic_raise_softirq()

Shigeru Yoshida (1):
      ohci-hcd: Fix race condition caused by ohci_urb_enqueue() and io_watc=
hdog_func()

Stefan Windfeldt-Prytz (1):
      iio: buffer: check if a buffer has been set up when poll is called

Thinh Nguyen (2):
      usb: dwc3: gadget: Set maxpacket size for ep0 IN
      usb: dwc3: ep0: Reset TRB counter for ep0 IN

Thomas Gleixner (2):
      genirq/matrix: Handle CPU offlining proper
      x86/apic/vector: Handle vector release on CPU unplug correctly

Tyrel Datwyler (1):
      scsi: ibmvfc: fix misdefined reserved field in ibmvfc_fcp_rsp_info

Will Deacon (2):
      arm64: cpufeature: Fix CTR_EL0 field definitions
      arm64: __show_regs: Only resolve kernel symbols when running at EL1

Yoshihiro Shimoda (1):
      usb: renesas_usbhs: missed the "running" flag in usb_dmac with rx path


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqWnCwACgkQONu9yGCS
aT6yAw//Qajz0Lnz1LoQW+4lfbfzI34kwPdRy/BAQhBD/0vwsyxhO89nlvQbGbG3
Z2qMw/eBpN+T1HjTowgbMoBNOoOzNNFro5p/shEbsR18PVJ8pt+Crij6TJEl3ni4
U/5QNpjZwDLg2wYElUTLJVZJ/AGB6j8f1l2gEo9nI99EjNkW+P+hozxsTMB+FHV/
CqQ8UJl/OMQWuT/kQYYDmLUCqizzVVEiNXG5nsXvpFz9OSpoJP7OkQGrTjttxW6+
BKJQKAIkGZEvxl6K7dU15WkloYSR6VG5MGiA/Z1DOgPxZcFUGQoCIjkgRjN3BCaf
vTxnFmjw3ZdWiqSBUKMUalr03xVgnLVc2aCiZVf/fmijBSly0ctZ5db7g1v0g+jT
8eATDtKIXEE/FKlYcgHurdunu3XYWURWEAAe9xonx43uiGxnmhfai1p5flcfJPG1
Hx3potrsqNCOnbu+6PscZtBHcOqtotJcOeiMU6Br/4Mjjhj3dmiO6l9Mgdy//Yik
Eobyvj2foMMvxY+WB5ZnpqQ9ll5wqE30uZEHb+Ltm3+oBZVgTB9Jcc7wSXIJ0aa+
MKgZqRQoSncO1mBU+P+BSy0Ao+NfsmmNFrRHgagvCgPWuafM0dBR6/OXNax6Fmev
TSU8NjueIovpDALsGL9jHs/dn2sprscp6wHjS/zsOfkA8cbllsU=
=ymA5
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
