Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-40036-1519819754-2-5186524535415414836
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
    t=1519819754; b=d3lKhM7oZmTZaaNj3oYk90Ni1b7oYajqesJmWrNgUZwygl2
    pLGpwwtILT18XaB0K1NrLt9gzCm9NgnNKzEFGhZ2PIKALzvMY843UkeuNLz1TEYp
    NJnIIcMWwE7maeX2GZSomPDzsY1NnnthK2YcFGZZo2MyNOr7ZrFJtw7Ftae2NsEz
    O8AyK1va7HSC1OO8YKMput58cM2+vqSxp7V2QD2VduteoICYTzXNqBEeJQbDZm6l
    Nn+Y0YrH1PCH/ba1A/GNJbZfvpdYRNcfayYHjnOA/0QPKTFDFOD2BaGA6hK+LZPU
    ipz/y0TbfYYdHe+MTxL6i5td+npW6NGrSWYib5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519819754; bh=ejTXv3kT5dXbnkfT7ZhqJIE+HllQ4dF05QUJ1ovEHXc=; b=v
    OmbLNVQr894AG1yfywzrnARSxXa9SZ0sfIpdbUcbMEeqLqYsAetd4tKvDIqu6F0X
    6lhOfvxg349xfqzfFVJBGPjHRH4k2SFlekOJ1Im/CqmBPnoEI7z/X67kmMpTLME0
    Mm64WLd7nptAheVq8lsZUgI6dlyj8bgJo9BNOGnq/2hjDB5oeSHyNL+xzKNtG2Ee
    94Nw+1e74aUamHK7Xq+oli99hAS51GbfsHbXvHjlQxIbHX1zZEiFp1XxR5GrooGd
    Dmf8SW9dHX8iLjUtoxC111OQaoGuIRMRVGWVjkthy+U10Mdoz7Qw47a7QumP1TuY
    4xKEbZUzhCUH6jMK9/gew==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeB1MJN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 07:09:13 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46208 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbeB1MJM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 07:09:12 -0500
Date: Wed, 28 Feb 2018 13:09:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.119
Message-ID: <20180228120913.GA10458@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.119 kernel.

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

 Makefile                                   |    2=20
 arch/arm64/kernel/traps.c                  |    2=20
 arch/powerpc/kernel/setup_64.c             |    2=20
 arch/x86/oprofile/nmi_int.c                |    2=20
 drivers/android/binder.c                   |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    2=20
 drivers/gpu/drm/drm_edid.c                 |    3 +
 drivers/hid/hid-core.c                     |    3 +
 drivers/hid/hid-ids.h                      |    3 +
 drivers/iio/imu/adis_trigger.c             |    7 +-
 drivers/iio/industrialio-buffer.c          |    2=20
 drivers/irqchip/irq-gic-v3.c               |    2=20
 drivers/pci/host/pci-keystone.c            |    9 ++-
 drivers/scsi/ibmvscsi/ibmvfc.h             |    2=20
 drivers/usb/core/quirks.c                  |    3 +
 drivers/usb/dwc3/gadget.c                  |    2=20
 drivers/usb/gadget/function/f_fs.c         |    6 --
 drivers/usb/host/ohci-q.c                  |   17 +++---
 drivers/usb/misc/ldusb.c                   |    6 ++
 drivers/usb/renesas_usbhs/fifo.c           |    5 +
 include/net/ip_tunnels.h                   |    9 ---
 net/ipv4/Kconfig                           |    1=20
 net/ipv4/ip_sockglue.c                     |    7 --
 net/ipv4/ip_tunnel.c                       |   78 ++++--------------------=
-----
 net/ipv6/ipv6_sockglue.c                   |   10 ---
 net/ipv6/sit.c                             |   17 +++---
 net/mac80211/cfg.c                         |    2=20
 27 files changed, 87 insertions(+), 121 deletions(-)

AMAN DEEP (1):
      usb: ohci: Proper handling of ed_rm_list to handle race condition bet=
ween usb_kill_urb() and finish_unlinks()

Alex Deucher (1):
      drm/amdgpu: Avoid leaking PM domain on driver unbind (v2)

Arnd Bergmann (2):
      cfg80211: fix cfg80211_beacon_dup
      x86/oprofile: Fix bogus GCC-8 warning in nmi_setup()

Eric Biggers (1):
      binder: add missing binder_unlock()

Greg Kroah-Hartman (1):
      Linux 4.4.119

Jack Pham (1):
      usb: gadget: f_fs: Process all descriptors during bind

Jack Stocker (1):
      Add delay-init quirk for Corsair K70 RGB keyboards

Johan Hovold (1):
      PCI: keystone: Fix interrupt-controller-node lookup

Kai-Heng Feng (1):
      drm/edid: Add 6 bpc quirk for CPT panel in Asus UX303LA

Karsten Koop (1):
      usb: ldusb: add PIDs for new CASSY devices supported by this driver

Lars-Peter Clausen (1):
      iio: adis_lib: Initialize trigger before requesting interrupt

Michael Ellerman (1):
      powerpc/64s: Fix RFI flush dependency on HARDLOCKUP_DETECTOR

Michael Weiser (1):
      arm64: Disable unhandled signal log messages by default

Paolo Abeni (3):
      netfilter: drop outermost socket lock in getsockopt()
      ip_tunnel: replace dst_cache with generic implementation
      ip_tunnel: fix preempt warning in ip tunnel creation/updating

Shanker Donthineni (1):
      irqchip/gic-v3: Use wmb() instead of smb_wmb() in gic_raise_softirq()

Stefan Windfeldt-Prytz (1):
      iio: buffer: check if a buffer has been set up when poll is called

Thinh Nguyen (1):
      usb: dwc3: gadget: Set maxpacket size for ep0 IN

Tyrel Datwyler (1):
      scsi: ibmvfc: fix misdefined reserved field in ibmvfc_fcp_rsp_info

Yoshihiro Shimoda (1):
      usb: renesas_usbhs: missed the "running" flag in usb_dmac with rx path


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqWm+UACgkQONu9yGCS
aT6b8hAAy3mkZ8sK34eDSdtlX5h8iSS6XwOi1SZya/64Epy3BmG3FcRZbg53B/pR
JzEuKcUUWS44S+gO89sRN3ktsBLbGG6NZzUt7/ie6qNySDL32C3h+YIBvtw4yiyJ
ZHyWu6hw7o3ObJiV2FpxTAO8YFoeY7i9ecsZod+36cwSBYufs1TS1WN+z9jkp8Jd
ex1KbjUECJ6Jkq3Jk9p4k2lVWgx5In3ycOQA/Y5DTcHV1kx8oMjW0PWxqrmAZJ4O
K925z1zePslXFrdEsIoyZY/OoqbZODPINhDGNA/faV276mNQJpHq+yAskuWvi6e8
Bvpg9ofpajxW2Uy9DfReKaHixMrB58ipRCXoQ5S7iELUWjtWgCYWCdRDZnDplLYd
1RixqMROQ/jr+MZxbeyX7IU3e2W9E/hil/nsNApZpBdhl4uwEb/RaP0qzRDgb5kX
lg3gr4cWO8MHCfY7nqKeXB7XdNdX86FsyX0cXQIUUGuGvT3H8AZcGg6W4SMJGOnI
koZZxDpu3aisB/tnogsRIXxhl0my9HxFCRTwQibWm81lzHaRDdBsMCLmoFraa1g5
ZBIXgN2gTyl0HvM6DjyedtWxUtnKoB9nPmQVuvtEoYRHr/AEQVwOo381mHmmV22p
CO4+Pu6zPVrJNj0DW00+WO1pHR1sx2BDpVhbdYdhvTUJm2RvqqU=
=kpNL
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
