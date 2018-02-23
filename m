Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2252784-1519371184-2-4685081427150113762
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
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
    t=1519371184; b=GbzFw+ZqDizJ67TPmhXkRFyeG6GV0z4DVhiF9f4lgyC30rR
    alN+0lAYRexETHnAxmchK5iXqCxL2vhzhdEUd4z+ePrqUGiVRIV6hCnuTONp7e8M
    8V69GMkT9ESoizkzRMSaSvR6+QAfCdzWRJI9lE6JvMx7f1IgWCivttC5zqaJ1CXG
    tbHf1hdMjOO56faKFmg6OKfhs8EtCKE9fYzkcvwGRxQ2t6/0MSbIKWMjwStzn6sZ
    vs9k9e+IQAWaapVmHBbCDdfHpSkQvmp3ZkBQLjVuf8FQOdPI8wda8dIMcNg42MF2
    gLjeUADawKI9yNl3KXCQkhGq03ZpUZu6GIPbrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519371184; bh=Rzy/136HfK+mgaenLzgaWzRVhpb2hsVermE8U1vK820=; b=Q
    Y5DtS7D8zr6BoDJPTKBfEamNd4m+7UkLHsIgg+GZJgflF2hzJEqH4mGx2avG/azH
    3eOl1DOq+Btdu1huCXgoz2tCuOWyLUVvQC4CocnC41Cl2Yrkrl+YNr0FJefZaSI7
    MQ38AAETCLQXQEAAU8iwne+yDz5gMwD3uE/8TbTvRHU0t4ArzPmrGvET2e/fAVOM
    rNOxKx/e2Uij1c3WNofR5gnBLfLTuZr+pWaq8wZ2v6oI/A4ZYgMSKsxKxAFwLRoz
    HeR3TLVmNlGdQDkDnztEl4sYJSFdkqGF+VjpRlI0kjkW+jLMqEssJHSmHsGMs45i
    HfjoBWkvKR5EEJg2dn74Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeBWHdD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 02:33:03 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49064 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeBWHdC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 02:33:02 -0500
Date: Fri, 23 Feb 2018 08:33:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.117
Message-ID: <20180223073302.GA12506@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.117 kernel.

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

 Documentation/devicetree/bindings/dma/snps-dma.txt  |    2 -
 Documentation/filesystems/ext4.txt                  |    2 -
 Makefile                                            |    2 -
 arch/arm/boot/dts/s5pv210.dtsi                      |    1=20
 arch/arm/boot/dts/spear1310-evb.dts                 |    2 -
 arch/arm/boot/dts/spear1340.dtsi                    |    4 +-
 arch/arm/boot/dts/spear13xx.dtsi                    |    6 ++--
 arch/arm/boot/dts/spear600.dtsi                     |    1=20
 arch/arm/boot/dts/stih407.dtsi                      |    3 +-
 arch/arm/boot/dts/stih410.dtsi                      |    3 +-
 arch/arm/mach-pxa/tosa-bt.c                         |    4 ++
 arch/s390/kernel/compat_linux.c                     |    8 ++---
 arch/x86/include/asm/processor.h                    |    2 -
 arch/x86/kernel/cpu/common.c                        |    2 -
 arch/x86/kernel/cpu/microcode/intel.c               |    2 -
 arch/x86/kernel/cpu/proc.c                          |    4 +-
 arch/x86/kvm/mmu.c                                  |   10 +++----
 drivers/devfreq/devfreq.c                           |    2 -
 drivers/gpu/drm/radeon/radeon_uvd.c                 |    2 -
 drivers/infiniband/hw/mlx4/main.c                   |   13 +++------
 drivers/md/dm.c                                     |    3 +-
 drivers/media/tuners/r820t.c                        |   13 +++++----
 drivers/net/ethernet/marvell/mvpp2.c                |   11 +++++--
 drivers/net/ethernet/mellanox/mlx4/qp.c             |    3 ++
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c |    5 ++-
 drivers/net/wireless/realtek/rtlwifi/wifi.h         |    1=20
 drivers/rtc/rtc-opal.c                              |   12 +++++++-
 drivers/video/console/dummycon.c                    |    1=20
 drivers/video/fbdev/atmel_lcdfb.c                   |    8 +++++
 fs/btrfs/inode.c                                    |    5 ++-
 fs/btrfs/tree-log.c                                 |   27 +++++++++++++++=
++++
 fs/ext4/super.c                                     |    1=20
 fs/namei.c                                          |    3 ++
 include/linux/kaiser.h                              |    2 -
 mm/memory.c                                         |    2 -
 sound/core/seq/seq_clientmgr.c                      |   23 +++++++++-------
 sound/pci/hda/patch_realtek.c                       |   28 +++++++++++++++=
+++++
 sound/usb/mixer.c                                   |   18 +++++++-----
 sound/usb/pcm.c                                     |    9 ++++++
 39 files changed, 180 insertions(+), 70 deletions(-)

Arnd Bergmann (5):
      mm: hide a #warning for COMPILE_TEST
      x86: fix build warnign with 32-bit PAE
      ARM: pxa/tosa-bt: add MODULE_LICENSE tag
      ARM: dts: s5pv210: add interrupt-parent for ohci
      media: r820t: fix r820t_write_reg for KASAN

Bjorn Andersson (1):
      PM / devfreq: Propagate error from devfreq_add_device()

David Woodhouse (1):
      KVM/x86: Reduce retpoline performance impact in slot_handle_level_ran=
ge(), by always inlining iterator helper methods

Ernesto A. Fern=E1ndez (1):
      ext4: correct documentation for grpid mount option

Eugene Syromiatnikov (1):
      s390: fix handling of -1 in set{,fs}[gu]id16 syscalls

Greg Kroah-Hartman (1):
      Linux 4.4.117

Gustavo A. R. Silva (1):
      x86/cpu: Change type of x86_cache_size variable to unsigned int

Hui Wang (1):
      ALSA: hda - Fix headset mic detection problem for two Dell machines

Jack Morgenstein (1):
      IB/mlx4: Fix incorrectly releasing steerable UD QPs when have only ET=
H ports

Jan-Marek Glogowski (1):
      ALSA: hda/realtek: PCI quirk for Fujitsu U7x7

Johan Hovold (1):
      video: fbdev: atmel_lcdfb: fix display-timings lookup

Julia Lawall (1):
      drm/radeon: adjust tested variable

Kirill Marinushkin (1):
      ALSA: usb-audio: Fix UAC2 get_ctl request with a RANGE attribute

Larry Finger (1):
      rtlwifi: rtl8821ae: Fix connection lost problem correctly

Lassi Ylikojola (1):
      ALSA: usb-audio: add implicit fb quirk for Behringer UFX1204

Linus Torvalds (1):
      vfs: don't do RCU lookup of empty pathnames

Liu Bo (3):
      Btrfs: fix deadlock in run_delalloc_nocow
      Btrfs: fix crash due to not cleaning up tree log block's dirty bits
      Btrfs: fix unexpected -EEXIST when creating new inode

Mikulas Patocka (1):
      mvpp2: fix multicast address filter

NeilBrown (1):
      dm: correctly handle chained bios in dec_pending()

Nicolas Pitre (1):
      console/dummy: leave .con_font_get set to NULL

Patrice Chotard (1):
      ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property

Stewart Smith (1):
      rtc-opal: Fix handling of firmware error codes, prevent busy loops

Takashi Iwai (2):
      ALSA: seq: Fix regression by incorrect ioctl_mutex usages
      ALSA: seq: Fix racy pool initializations

Viresh Kumar (3):
      arm: spear600: Add missing interrupt-parent of rtc
      arm: spear13xx: Fix dmas cells
      arm: spear13xx: Fix spics gpio controller's warning

Zhouyi Zhou (1):
      ext4: save error to disk in __ext4_grp_locked_error()


--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqPw6oACgkQONu9yGCS
aT5woA/9HSnhmUaTAiNu1QdEtLdAcRN7/Yl3eVcnggLezIXbWp4HsA7NgUhUIVOe
HbMFvNv9EKBFyAnJ//NNkFrvvFKZGBXxUfdVz2NGkcZZkO1IQZuq4dbGVVBk9WWC
ze8Sod66JpQXi+2XwDea+DyvcTqgd40EvAP8wrukHJoHqgMh2A2DIAlBOHi0dMcB
tiWzB7s/R8vXAEdtz6f7wMnkJFTr6b2W/9f/1klYjg8XG8+GDOihLqkUDARF8frN
lC32ABS7K/TM5tpj6WuyMdSaQuSx6JwYShmqYQD2UB41+VFI79CD8XNJSlX/rvXh
yFvUKZNmgHkYpQNayjx59vvyel0B7dNJMuLBYklZE1k5slRiBdy3C+bXmS1cf9MM
dkEe9gNovcK30L6le9+sipEbQXgy5jkPFWa7mOTUv+51ExAgNiIlMkgNUKRRMGS4
ZGezIBOSvp+lgFk3HyKtG9CQVpeX5i9Hc8XrYvcBemDULVfacQBbfxwO6MTvjwWy
bvE6HCcHmYEaWHfyVmSePe/5mMdr4xrxppo9x2d/XGKNCRQw9kzqhrR5cYYG8ndj
0EozILQGJQDgJxGmt0IvhlczO3Jk7eSScCouVZO3kwrrh0sVEgajWX0jxMINmzVt
9ksNSzPPX7qPxEPFIr8TfbiJD3G14r5KoksEgITl9+0errT6dAw=
=vhjW
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
