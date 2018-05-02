Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-999392-1525279186-2-9212312735320375760
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525279185; b=KNRlZ4pZFgowIJQ5a9bk6XnYQ5btP5m8QH5YFClr2xi1PjaMGZ
    Lv1LplSW66qkOo+r3VZAdfIW1vNBWPbS0lw13VV/uNF1hS/Vx+YBfIshGrQwg8oh
    zUTJRp9e1v2yB7838lxJM/oYFcWhEiqG26zDBOx7pcWgb/YUG2XyPSICueu180ZG
    8+XMw6w6sqaB6GvDQ6fDRDxjb2RsRkyDR+2cqklXkXFd7lHlL/TKcX1P/diwLvEp
    wvNDkBHZSp3JTTGyKJjXY8UHj8D8PNTk1giydOwlUiKDrdTY8NkhP9kI/XfMcphA
    ByW6h6nbf5euwmd32oL0bBgNJdmiqXQLvVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1525279185;
    bh=IHzucGzjySYHjJRTNrS7kH+cdr/cgcMg4GYrm84hT6c=; b=haZWLcJWpBkr
    3xKyz7URjLzueWuD3wBx3a57wW46NwPwxfPTHUgwDkpUygwwhMKYX9UeMsXSNmUK
    wpY5uH6Rqm4BHZcD3eNsrZVRicep+NBMxcgwhchKIc39J/JJDxctVSECE85B24jy
    4hY7YMMbhur/7spqglDYu92zMeB9XOGHQv34oAFP9rP5umqZhui4Bkiqjd1HgfZw
    FS7cU7WZQyWqk1gt47igmHeIzHHTXnz9yAcn4vCNurZIpps5a348X5wegtMmuD+X
    Ix5w5kSMup+DDqNoOch3tn2+mUD7/flE+XkzB9nTZUtSGu34A8O2qdksymzi8eTE
    sBVc2wuJSg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ZOD8l4ND x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=ZOD8l4ND x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfBKaT9a3L07i3+uKQLgrHcF15rgz2Wp497qdhykjqPbBmvOtFQtA4owbumeztb1/CfXInkw3Qx+rNl7JMzy7qnxNbU1AJbR9/HRgVjHt5cEwqaNdPA4y
    zma5zJ/pzpjvIQKOL+nzq7X/DwQ3B61q4HhHVpj2oqxlQVJw37GJt64rHRmDlLmMxwLvl/WeK8adAg4Hc7lS6gJvR+dCZw6IgVWVgq0soWBC7xDpDmHT6HsU
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=QbIqFZPZMX5iqtYNW7wA:9 a=wPNLvfGTeEIA:10 a=QS2mGrKfASJYg-aR1O0A:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeEBQjl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 12:39:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751702AbeEBQji (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 2 May 2018 12:39:38 -0400
Date: Wed, 2 May 2018 09:39:27 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.131
Message-ID: <20180502163927.GA20825@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.131 kernel.

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

 Makefile                               |    2=20
 arch/x86/include/uapi/asm/msgbuf.h     |   31 ++++++++++++
 arch/x86/include/uapi/asm/shmbuf.h     |   42 ++++++++++++++++
 arch/x86/kernel/smpboot.c              |    2=20
 drivers/amba/bus.c                     |   17 ++++--
 drivers/char/virtio_console.c          |   49 +++++++++----------
 drivers/gpu/drm/virtio/virtgpu_vq.c    |    4 -
 drivers/mtd/chips/cfi_cmdset_0001.c    |   33 ++++++++++--
 drivers/mtd/chips/cfi_cmdset_0002.c    |    9 ++-
 drivers/scsi/sd.c                      |    2=20
 drivers/tty/n_gsm.c                    |   23 ++++++++
 drivers/tty/serial/serial_mctrl_gpio.c |    5 +
 drivers/tty/tty_io.c                   |    5 +
 drivers/tty/tty_ldisc.c                |   16 +++---
 drivers/usb/core/hcd.c                 |    1=20
 drivers/usb/core/hub.c                 |   10 +++
 drivers/usb/core/quirks.c              |    3 +
 drivers/usb/serial/Kconfig             |    1=20
 drivers/usb/serial/cp210x.c            |    1=20
 drivers/usb/serial/ftdi_sio.c          |    3 -
 drivers/usb/serial/usb-serial-simple.c |    7 ++
 drivers/usb/usbip/stub_main.c          |    5 +
 drivers/usb/usbip/usbip_common.h       |    2=20
 fs/ext4/balloc.c                       |   17 +++++-
 fs/ext4/extents.c                      |   16 ++++--
 fs/ext4/ialloc.c                       |    7 ++
 fs/jbd2/transaction.c                  |    1=20
 include/linux/mtd/flashchip.h          |    1=20
 include/linux/tty.h                    |    2=20
 include/linux/virtio.h                 |    3 +
 include/sound/control.h                |    7 +-
 lib/kobject.c                          |   12 +---
 net/ceph/messenger.c                   |    7 ++
 sound/core/pcm_native.c                |    1=20
 sound/core/seq/oss/seq_oss_event.c     |   15 +++--
 sound/core/seq/oss/seq_oss_midi.c      |    2=20
 sound/core/seq/oss/seq_oss_synth.c     |   85 +++++++++++++++++++---------=
-----
 sound/core/seq/oss/seq_oss_synth.h     |    3 -
 sound/drivers/opl3/opl3_synth.c        |    7 +-
 sound/pci/asihpi/hpimsginit.c          |   13 +++--
 sound/pci/asihpi/hpioctl.c             |    4 +
 sound/pci/hda/hda_hwdep.c              |   12 ++++
 sound/pci/hda/patch_realtek.c          |    2=20
 sound/pci/rme9652/hdspm.c              |   24 +++++----
 sound/pci/rme9652/rme9652.c            |    6 +-
 sound/soc/fsl/fsl_esai.c               |    7 ++
 sound/usb/mixer_maps.c                 |    3 +
 47 files changed, 395 insertions(+), 135 deletions(-)

Arnd Bergmann (1):
      x86/ipc: Fix x32 version of shmid64_ds and msqid64_ds

Collin May (1):
      USB: serial: simple: add libtransistor console

David Henningsson (1):
      ALSA: core: Report audio_tstamp in snd_pcm_sync_ptr

Dmitry Vyukov (1):
      kobject: don't use WARN for registration failures

Eric Biggers (1):
      ext4: prevent right-shifting extents beyond EXT_MAX_BLOCKS

Geert Uytterhoeven (3):
      ARM: amba: Make driver_override output consistent with other buses
      ARM: amba: Fix race condition with driver_override
      ARM: amba: Don't read past the end of sysfs "driver_override" buffer

Gerd Hoffmann (1):
      drm/virtio: fix vq wait_event condition

Greg Kroah-Hartman (1):
      Linux 4.4.131

Ilya Dryomov (1):
      libceph: validate con->state at the top of try_write()

Joakim Tjernlund (3):
      mtd: cfi: cmdset_0001: Do not allow read/write to suspend erase block.
      mtd: cfi: cmdset_0001: Workaround Micron Erase suspend bug.
      mtd: cfi: cmdset_0002: Do not allow read/write to suspend erase block.

Kailang Yang (1):
      ALSA: hda/realtek - Add some fixes for ALC233

Kamil Lulko (1):
      usb: core: Add quirk for HP v222w 16GB Mini

Kyle Roeschley (1):
      USB: serial: cp210x: add ID for NI USB serial console

Lukas Czerner (1):
      ext4: fix bitmap position validation

Mahesh Rajashekhara (1):
      scsi: sd: Defer spinning up drive while SANITIZE is in progress

Michael S. Tsirkin (2):
      virtio: add ability to iterate over vqs
      virtio_console: free buffers after reset

Nicolin Chen (1):
      ASoC: fsl_esai: Fix divisor calculation failure at lower ratio

Ravi Chandra Sadineni (1):
      USB: Increment wakeup count on remote wakeup.

Romain Izard (1):
      serial: mctrl_gpio: Add missing module license

Shuah Khan (2):
      usbip: usbip_host: fix to hold parent lock for device_attach() calls
      usbip: vhci_hcd: Fix usb device and sockfd leaks

Takashi Iwai (9):
      ALSA: usb-audio: Skip broken EU on Dell dock USB-audio
      ALSA: opl3: Hardening for potential Spectre v1
      ALSA: asihpi: Hardening for potential Spectre v1
      ALSA: hdspm: Hardening for potential Spectre v1
      ALSA: rme9652: Hardening for potential Spectre v1
      ALSA: control: Hardening for potential Spectre v1
      ALSA: seq: oss: Fix unbalanced use lock for synth MIDI device
      ALSA: seq: oss: Hardening for potential Spectre v1
      ALSA: hda: Hardening for potential Spectre v1

Tetsuo Handa (2):
      tty: Don't call panic() at tty_ldisc_init()
      tty: Use __GFP_NOFAIL for tty_ldisc_get()

Theodore Ts'o (2):
      ext4: set h_journal if there is a failure starting a reserved handle
      ext4: add validity checks for bitmap block numbers

Tony Lindgren (2):
      tty: n_gsm: Fix long delays with control frame timeouts in ADM mode
      tty: n_gsm: Fix DLCI handling for ADM mode if debug & 2 is not set

Uwe Kleine-K=F6nig (1):
      serial: mctrl_gpio: export mctrl_gpio_disable_ms and mctrl_gpio_init

Vasyl Vavrychuk (1):
      USB: serial: ftdi_sio: use jtag quirk for Arrow USB Blaster

Yazen Ghannam (1):
      x86/smpboot: Don't use mwait_play_dead() on AMD systems


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrp6b8ACgkQONu9yGCS
aT6SYxAAiCn5iqrHApM7rhlXpvmHX+41btf4/7Wa8y8byjmpPBsVgBAiwz8D3NiP
C3u5dtnPOTMjiq2VpvJsz6tsD4j9oHhuYmFHRRQ22+N3FTUK322G08cAJfvN3cdc
gGE1qSaeACQv3pMnBmJjkxb/uiVpY6fXU+oeKXQRCDFk5gnV36OnxZtcaRtrfRNn
sqireA7xuXn7tnRKOCZTLBSZKkeUlOztzeOmqLIpXP8lnxfdMmcZxFz1x8CW9deh
RQPRzioqVAJMZd61GenW1LKrydn/1lqgOwzTQ+2rt8n0rRjPF+F5mkObfAb867fa
bkxuhRMDMXEQfmn/cHcJo/xRX5VJl1JFfXBX9BmVxe2DDkZ+JaRQcIaM0D/q0L0Z
OELhpZL1ybm0j2Dv/CQujAuSrtf0iDBfY8SVYdYP7zHNsi2YNxZIZmRuWeGwNiag
vyh+mYcxh9dSVtHSoWKsU/trN/n61UKPbra2R6myVFE8IYNEHabOqUFcBro0cSVL
ovdmf8KkYNcAIn/wPeN/IhX1upYA8QIvRDgIxzru5nvu+3NuAJro6puik8aYU2J4
fRdgaWuIvlSGLuanbBCtabyxIqioUTZBqyMFyRxXLV4qXVSKDV/m99CY7FKwYajX
k3XI9wshXYjdEbz+kF+K9K8OGtmxWUuLtdi4Qq2kFbMWT7ZLdTg=
=y++1
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
