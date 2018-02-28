Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4191898-1519819883-2-10631434055586869329
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519819883; b=bxr1CawuM/e+2V/tRCU6PPnb2E94S/ZjQTjwo7q3uziH2P6
    3dFRjfEk8DA3riLUH1KpGShn5KhUt9IFOSG0qyjbFUsdtpcfaMgjak2I6SmzJk8z
    OPsnuQq8uoAj9U3B4jg9RGralmasqLh3KbhhYkg2VQ/7U0WlyxFw4yNhoKLxwSmI
    TtGHeyV5t9rFLgjkScXPoPEc8dUDkKcS9lFWp8ECxw2DhElFOtjjbzho2fMIhL8w
    hKUWjFZqBBg7+Nr4ZeC86dc/MxM2CflcsUqOtVZT8ENJiZUltisl/JpptjJtVBhW
    JQK6NClqBS2sbC1TxNWogden2MSy8/3RlKJDaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519819883; bh=wi7OTO8zmmEv6JdPwq+c/vXEtyK5WOTW2/uzGXtnHFg=; b=J
    6L58ZvSrSE+fr/JxOK5NBgZHg9cud9HjXG5hhqagr8lptn3hE69cTbyzKxZ+Md0s
    TYXKSzPv7H/TTkimrDQo+F6U1kbcbW4FQ0eq9A9eBoUm70pshTWHEakekrnilVg2
    pEham6eY1F/Eb2uZ1Bo3TanP5JXs1BYsxKseSnBDWDp7VOmSf9pMQMe78alpdOXM
    0GVEeaO2q4JJ/A/tAGhIi0ucgG1XOZ1NAR/p7GHtGAMrz1KcSunrQtZcTU/6kdlc
    IKzLgXSyyGovQ51rplztB1H79dn6Pq+bhgTL/Gd6MNHWEoEgjsYOyfTTqxkRrrxZ
    uNHjONb+3QR7t7nUl3QfQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752513AbeB1MKA (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 07:10:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46384 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbeB1MJ6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 07:09:58 -0500
Date: Wed, 28 Feb 2018 13:09:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.23
Message-ID: <20180228120959.GA16637@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.23 kernel.

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

 Makefile                                         |    2=20
 arch/arm64/kernel/cpufeature.c                   |    6 +
 arch/arm64/kernel/traps.c                        |   10 ---
 arch/arm64/mm/proc.S                             |    2=20
 arch/m32r/Kconfig                                |    4 -
 arch/microblaze/Makefile                         |   17 +++--
 arch/mips/boot/Makefile                          |    1=20
 arch/mips/include/asm/compat.h                   |    1=20
 arch/x86/oprofile/nmi_int.c                      |    2=20
 arch/xtensa/mm/init.c                            |   70 ++++++++++++++++++=
++---
 crypto/asymmetric_keys/pkcs7_verify.c            |   12 ++-
 crypto/asymmetric_keys/public_key.c              |    4 -
 crypto/asymmetric_keys/restrict.c                |   21 ++++--
 drivers/extcon/extcon-intel-int3496.c            |    3=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c |   58 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |    2=20
 drivers/gpu/drm/amd/amdgpu/si_dpm.c              |    5 +
 drivers/gpu/drm/amd/amdgpu/soc15.c               |    4 -
 drivers/gpu/drm/amd/amdgpu/vi.c                  |   21 ++++--
 drivers/gpu/drm/cirrus/cirrus_mode.c             |   40 +++++++------
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
 drivers/usb/renesas_usbhs/fifo.c                 |    5 +
 drivers/xen/tmem.c                               |    4 +
 include/linux/kconfig.h                          |    9 ++
 mm/zswap.c                                       |    6 +
 net/ipv4/ip_sockglue.c                           |    7 --
 net/ipv6/ipv6_sockglue.c                         |   10 ---
 net/mac80211/cfg.c                               |    2=20
 56 files changed, 415 insertions(+), 226 deletions(-)

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

Daniel Vetter (1):
      drm/cirrus: Load lut in crtc_commit

Eric Anholt (1):
      i2c: bcm2835: Set up the rising/falling edge delays

Eric Biggers (4):
      X.509: fix BUG_ON() when hash algorithm is unsupported
      X.509: fix NULL dereference when restricting key with unsupported_sig
      PKCS#7: fix certificate chain verification
      PKCS#7: fix certificate blacklisting

Fabrice Gasnier (1):
      iio: adc: stm32: fix stm32h7_adc_enable error handling

Geert Uytterhoeven (1):
      m32r: fix endianness constraints

Greg Kroah-Hartman (1):
      Linux 4.14.23

Hans de Goede (1):
      extcon: int3496: process id-pin first so that we start with the right=
 status

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

Tyrel Datwyler (1):
      scsi: ibmvfc: fix misdefined reserved field in ibmvfc_fcp_rsp_info

Will Deacon (1):
      arm64: cpufeature: Fix CTR_EL0 field definitions

Yoshihiro Shimoda (1):
      usb: renesas_usbhs: missed the "running" flag in usb_dmac with rx path


--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqWnBYACgkQONu9yGCS
aT5foQ/+Oxt3TgBs8Kma44lESS0hKPnSGkcMs1Buo06ikwDGow9Lym1phsf5vbrH
rBvl8x6EjfpZwn9gvE/QgMvod/sq5F7CLnjYzZ1LbtaNLmGpznZ+iUJ6sIUJx8o1
i8jC0vQfQHMYiKjPe54dNZ4iSUb/NPrvTHlUjWbDo1pJ7cIuQjtvplLODFmdQyU8
KpOsgYCwLL42PPZhlybkTJxfosPe6NuyaoaNolu6M0O7U1PHmndvU/mkX8D8KK4F
kB26sTovf31LW3XujYk5uzKk2lfK32rbDbIc/FXSw2XMXKFIkM1Afcmf2F+Iyhu7
FP2G1vRF+AXT/VyaIYnvHn3pUZB+WP7H8gG1YVS/FIMcmgthvPeyn2A3sYwAI1mi
cERbbkBw14jRaP+a4sf2wNtlkD4tDXvH/x4NC0jkXFNGgTf+6k6ZCB6Tz2rEI4n2
wyRrZRsOHRC/HttrhWNrpZUROHaTyUTfBmiYS0ifum/TAQoqLgVhJwp4IbiMlmC7
f7rduihinNMMRqNpqexyJVkIBa/2yBjyZV0LUp5QgedCJ4WbSqk58XNvrgZjAOrr
4Xt/K19pYIfhZsHCNrGORnKYrELlDFgpW5WSWfyCEB4YQyLOVYOkrvNOzbY8kWcz
GlCheRkkG85miOwC/bYUbaccQyFcgmxUcior2ID3FwoSSXzdcx4=
=gHNn
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
