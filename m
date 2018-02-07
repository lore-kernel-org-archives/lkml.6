Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-841976-1518039275-2-2727036952838616153
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518039274; b=FlwjjrPRx3pr1zIkw5boOetk3hKww3ehNlpoGZnpR7m2r7H
    r7FZCPeGtueQc9kLmutV/HU8p05JsLlCzlVvRaUyK1s5Jvff77wXdnbmAfCCjdwt
    kzEyAb4O3g6/lDS56XQkGYdH7636a6XevxICMXOEU1bsBe0zqN8076B94qckYvgR
    mjHOE0Mx0Uh5K6UP3//K1HUrDKnHykk1dCX0IayIiK2xxgdWdEI9/kVlkCkyfpq9
    tF6Cn1MXs7UxO+ceZuO3gYd6nPFQMhtSuOys6PPiKgsJWSTtVXg+VD3ZqkcXm5SA
    IVuTWhfQkmBmzR5Mh9nJRCah4DdHG0StREwUspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1518039274; bh=q2J9BVnc9wiydRa20+vhTJRc+FgHTSAfI+070z3kTjE=; b=X
    lyZ/CtnoDbSDHkRhT40reoSbctF8/1Igkmy9+jo5WKK07OHk2wUZtIzNvzMfEcL0
    QM+bVnwGl1gQFSYWYJ9/0BxdXuyeTsxquA4VaWsqACWzFqNvw8erb4SgjcDEnOl0
    P48KiD0ovZAEVDl3ZB1FcImPeWuBMEgouxreG7t5dfJwyQN4Uk71mW0R4lYhSGuH
    ReQHRTMXDt353dVZ20U/P4ZZ8gjEnAg4r4qiaQF1eUJ7pXYl/zzfJ6EDdrhuLK3V
    dHUP8bwOK7HROps4gnU8UoI4DrwFAY0i9uj3kNBLLASs1M2aIP5ygGapq504o7El
    98r+SwVy2LFhgI3EOzTZA==
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
        id S1754438AbeBGVec (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 16:34:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41474 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754327AbeBGVeb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 16:34:31 -0500
Date: Wed, 7 Feb 2018 15:34:30 -0600
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.94
Message-ID: <20180207213430.GA6365@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 3.18.94 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                       |    2 +-
 arch/um/Makefile                               |    9 +++++----
 arch/um/drivers/mconsole.h                     |    2 +-
 arch/um/include/shared/init.h                  |   24 ++----------------------
 arch/um/include/shared/user.h                  |    2 +-
 arch/x86/include/asm/kvm_host.h                |    3 ++-
 arch/x86/kvm/emulate.c                         |    7 +++++++
 arch/x86/kvm/vmx.c                             |    4 ++--
 arch/x86/kvm/x86.c                             |    2 +-
 arch/x86/um/shared/sysdep/tls.h                |    6 +++---
 drivers/block/loop.c                           |   10 ++++++++--
 drivers/gpio/gpio-iop.c                        |    4 ++++
 drivers/hwmon/pmbus/pmbus_core.c               |   21 ++++++++++++---------
 drivers/input/input.c                          |    5 ++++-
 drivers/md/bcache/btree.c                      |    5 ++++-
 drivers/media/usb/usbtv/usbtv-core.c           |    1 +
 drivers/net/ethernet/intel/igb/igb_main.c      |    2 +-
 drivers/net/ethernet/xilinx/Kconfig            |    1 +
 drivers/net/xen-netfront.c                     |   18 ++++++++++++++++++
 drivers/scsi/ufs/ufshcd.c                      |    7 +++++--
 drivers/spi/spi-imx.c                          |   15 +++++++++++++--
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c |   14 ++++----------
 drivers/usb/class/cdc-acm.c                    |    5 ++++-
 drivers/usb/gadget/composite.c                 |    7 +++++--
 drivers/usb/gadget/function/f_fs.c             |    3 ++-
 drivers/usb/serial/Kconfig                     |    1 +
 drivers/usb/serial/io_edgeport.c               |    1 -
 drivers/usb/serial/pl2303.c                    |    1 +
 drivers/usb/serial/pl2303.h                    |    1 +
 drivers/usb/serial/usb-serial-simple.c         |    7 +++++++
 drivers/usb/storage/uas.c                      |    7 +++----
 fs/nfsd/nfs4state.c                            |   15 +++++++++++++--
 fs/quota/dquot.c                               |    3 ++-
 net/mac80211/mesh_hwmp.c                       |   15 +++++++++------
 security/selinux/hooks.c                       |    2 ++
 sound/core/seq/seq_clientmgr.c                 |   10 ++++++++--
 sound/core/seq/seq_clientmgr.h                 |    1 +
 sound/soc/codecs/pcm512x-spi.c                 |    4 ++++
 tools/usb/usbip/src/usbip_bind.c               |    9 +++++++++
 tools/usb/usbip/src/usbip_list.c               |    9 +++++++++
 40 files changed, 181 insertions(+), 84 deletions(-)

Andrew Elble (1):
      nfsd: check for use of the closed special stateid

Chun-Yeow Yeoh (1):
      mac80211: fix the update of path metric for RANN frame

Colin Ian King (1):
      usb: gadget: don't dereference g until after it has been null checked

Dmitry Torokhov (1):
      Input: do not emit unneeded EV_SYN when suspending

Eduardo Otubo (1):
      xen-netfront: remove warning when unloading module

Geert Uytterhoeven (1):
      net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit

Greg Kroah-Hartman (2):
      USB: serial: pl2303: new device id for Chilitag
      Linux 3.18.94

Gustavo A. R. Silva (1):
      scsi: ufs: ufshcd: fix potential NULL pointer dereference in ufshcd_config_vreg

Hans de Goede (1):
      USB: cdc-acm: Do not log urb submission errors on disconnect

Hemant Kumar (1):
      usb: f_fs: Prevent gadget unbind if it is already unbound

Icenowy Zheng (1):
      media: usbtv: add a new usbid

Jesse Chan (2):
      gpio: iop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
      ASoC: pcm512x: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jia-Ju Bai (1):
      USB: serial: io_edgeport: fix possible sleep-in-atomic

Johan Hovold (1):
      USB: serial: simple: add Motorola Tetra driver

Larry Finger (1):
      staging: rtl8188eu: Fix incorrect response to SIOCGIWESSID

Linus Torvalds (1):
      loop: fix concurrent lo_open/lo_release

Liran Alon (2):
      KVM: x86: emulator: Return to user-mode on L1 CPL=0 emulation failure
      KVM: x86: Don't re-execute instruction when not passing CR2 value

Lyude Paul (1):
      igb: Free IRQs when device is hotplugged

Mark Salyzyn (1):
      selinux: general protection fault in sock_has_perm

Michael Lyle (1):
      bcache: check return value of register_shrinker

Oliver Neukum (2):
      CDC-ACM: apply quirk for card reader
      usb: uas: unconditionally bring back host after reset

Richard Weinberger (3):
      um: Stop abusing __KERNEL__
      um: Remove copy&paste code from init.h
      um: Fix out-of-tree build

Robert Lippert (1):
      hwmon: (pmbus) Use 64bit math for DIRECT format values

Shuah Khan (2):
      usbip: prevent bind loops on devices attached to vhci_hcd
      usbip: list: don't list devices attached to vhci_hcd

Stefan Agner (1):
      spi: imx: do not access registers while clocks disabled

Takashi Iwai (1):
      ALSA: seq: Make ioctls race-free

Tetsuo Handa (1):
      quota: Check for register_shrinker() failure.

Thomas Meyer (1):
      um: link vmlinux with -no-pie

Trond Myklebust (1):
      nfsd: CLOSE SHOULD return the invalid special stateid for NFSv4.x (x>0)

Wanpeng Li (2):
      KVM: X86: Fix operand/address-size during instruction decoding
      KVM: VMX: Fix rflags cache during vCPU reset


--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlp7cOMACgkQONu9yGCS
aT7mqBAA1rVqgbdaRgfHFdyCyvTueXGCjrrDDe1yOzjB74QyAQl6g3WE1B1B0I2m
2gLKzHrd0CkhYcpJaziJHJtfcg1jpDYMTVNwpmirwQQ4hjsfJ/Z9guI1P+jGh+bs
9aw6UzboTars3QBF0o2ip1iYzKS7zKmNN2lI8c621SVTjIWxDhC1sdnvzPEdd1RT
vN1IcTesU/q9jwbosDlgSB3yu5C458+NQdxnOPo71tv3yMqmWp0t44ESvqJWmNmf
hVY7wRXCKW9tFlTeHX4NHYgovYVb+jywkJyL1Zz5srTb+p+D93RrvvG/e3+EfPP0
83TG3GDr3e+TvV20m0Q0ld+9pyfIeLEstofdmJbx13IQfCwxWvpX2eW/Zfv013go
ohcegusSn7OGCYLeiQH+Zwh5UtGoBaJ+oQgSoIRXIqajZck8EJ92Glok02FBlnJG
Z9JCC0KDxRwXI8/Q/+pWqXKR0y7xjF/jh25qdWaI9c8ya9BeZDGpPUI6ZGSyJJMg
0PMewuU3PgfR63agbh0JJz2ONMSK5jehqKB0ICb1MctaLRgfuwsZs12jsNJ6SKTG
QhluPDuVp8zoMDd4cPkuKoFFoWrEfeem+MvCDBSYtLqCva9jFnQv/5T2qThG9Mjn
l+vQR7LpRs6koUYRjhmMYOXTbBTv1Y+g7Wzviwq8VxGjK0nOjaY=
=NIkd
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
