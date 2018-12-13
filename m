Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A19C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFDB20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544708367;
	bh=cBfrtuMRzmGaSuI/KNtOkWmbmLT78mJeqZ2SpMK/ylA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=QM2c1XG1NC5IQbsQDx2Yn570FCvFDNT5n5onYpJE1ttXTBe5A4HU/t+J6AxUTvvNE
	 k3FMgva46Az7GSFGMnktMIMbRHA6dZsKUTcgLxjxEZ/SHKgiEoum73BM9xJbF0EC+v
	 GMbR+fbpMkh41VMFmbc01SlzWYls+N4+3o7tzp8k=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFDB20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbeLMNj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:39:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbeLMNj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:39:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A175B20879;
        Thu, 13 Dec 2018 13:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544708365;
        bh=cBfrtuMRzmGaSuI/KNtOkWmbmLT78mJeqZ2SpMK/ylA=;
        h=Date:From:To:Cc:Subject:From;
        b=ZuiGAHCbg+18AWSKw+BoavSI0m32jI8Vu1GVp/qUASTb/7ArPLFQpcn/ExlU5K/Nz
         jNcVtZD9SsnXSQBMy09Bt8pUcOoHVKzheJfXaYH1wxwzhP+mEUPcPG/8Ru0rdRmH+q
         Qo5HgIc0TQChTahiAhRXJLc4Juf46XN/wmJw0WBc=
Date:   Thu, 13 Dec 2018 14:39:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.129
Message-ID: <20181213133922.GA16480@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.129 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                     |    5 +
 arch/mips/include/asm/syscall.h              |    2=20
 arch/powerpc/kernel/vdso64/datapage.S        |    2=20
 arch/powerpc/kernel/vdso64/gettimeofday.S    |    2=20
 drivers/dma/at_hdmac.c                       |   10 +++
 drivers/gpu/drm/ast/ast_main.c               |    3 -
 drivers/gpu/drm/gma500/mdfld_intel_display.c |    2=20
 drivers/infiniband/ulp/iser/iser_verbs.c     |    7 +-
 drivers/input/joystick/xpad.c                |   16 ++---
 drivers/iommu/ipmmu-vmsa.c                   |    3 +
 drivers/net/can/rcar_can.c                   |    5 +
 drivers/net/ethernet/amd/sunlance.c          |    4 +
 drivers/net/ethernet/faraday/ftmac100.c      |    7 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4.h    |    4 -
 drivers/net/ethernet/mellanox/mlx4/mr.c      |    1=20
 drivers/net/rionet.c                         |    2=20
 drivers/net/usb/ipheth.c                     |   10 +--
 drivers/net/wireless/ti/wlcore/cmd.c         |    6 --
 drivers/s390/net/qeth_core_main.c            |   27 ++++-----
 drivers/scsi/bfa/bfa_fcbuild.c               |    8 +-
 drivers/scsi/bfa/bfa_fcs.c                   |   78 +++++++++++++---------=
-----
 drivers/scsi/bfa/bfa_fcs_lport.c             |   62 ++++++++-------------
 drivers/scsi/bfa/bfa_ioc.c                   |    2=20
 drivers/scsi/bfa/bfa_svc.c                   |    4 -
 drivers/scsi/bfa/bfad.c                      |   20 +++---
 drivers/scsi/bfa/bfad_attr.c                 |    2=20
 drivers/scsi/bfa/bfad_bsg.c                  |    6 +-
 drivers/scsi/csiostor/csio_lnode.c           |   43 +++++++++-----
 drivers/scsi/scsi_devinfo.c                  |   22 ++-----
 drivers/staging/lustre/lustre/lmv/lmv_obd.c  |    2=20
 drivers/tty/serial/kgdboc.c                  |   47 +++++++---------
 drivers/usb/core/hub.c                       |    3 -
 drivers/usb/core/quirks.c                    |    7 ++
 drivers/usb/core/usb.c                       |    6 +-
 drivers/usb/gadget/udc/dummy_hcd.c           |    9 +--
 drivers/usb/host/hwa-hc.c                    |    2=20
 drivers/usb/host/xhci.c                      |   16 +++++
 drivers/usb/misc/appledisplay.c              |    1=20
 drivers/usb/serial/option.c                  |    1=20
 drivers/usb/storage/unusual_realtek.h        |   10 +++
 fs/ext2/xattr.c                              |    2=20
 fs/kernfs/symlink.c                          |    2=20
 include/linux/usb.h                          |    4 -
 include/sound/pcm_params.h                   |    4 +
 kernel/debug/kdb/kdb_support.c               |    4 -
 kernel/events/uprobes.c                      |   12 +++-
 lib/kobject.c                                |    2=20
 mm/truncate.c                                |    8 ++
 net/ipv4/ip_tunnel.c                         |    4 -
 net/mac80211/iface.c                         |    2=20
 net/mac80211/tx.c                            |    4 -
 net/sunrpc/auth_gss/auth_gss.c               |    4 +
 scripts/Makefile.extrawarn                   |    3 +
 scripts/unifdef.c                            |    4 -
 sound/core/pcm_native.c                      |    3 -
 sound/isa/wss/wss_lib.c                      |    2=20
 sound/pci/ac97/ac97_codec.c                  |    2=20
 sound/pci/hda/hda_intel.c                    |    4 +
 sound/pci/trident/trident.c                  |    2=20
 sound/sparc/cs4231.c                         |    8 --
 60 files changed, 298 insertions(+), 251 deletions(-)

Alexander Theissen (1):
      usb: appledisplay: Add 27" Apple Cinema Display

Andrea Parri (1):
      uprobes: Fix handle_swbp() vs. unregister() + register() race once mo=
re

Anton Blanchard (1):
      powerpc/vdso64: Use double word compare on pointers

Arnd Bergmann (4):
      drm: gma500: fix logic error
      scsi: bfa: convert to strlcpy/strlcat
      kdb: use memmove instead of overlapping memcpy
      usb: gadget: dummy: fix nonsensical comparisons

Aya Levin (1):
      net/mlx4: Fix UBSAN warning of signed integer overflow

Ben Greear (1):
      mac80211: Clear beacon_int in ieee80211_do_stop

Bernd Eckstein (1):
      usbnet: ipheth: fix potential recvmsg bug and recvmsg bug 2

Bj=F8rn Mork (1):
      USB: serial: option: add device ID for HP lt2523 (Novatel E371)

Cameron Gutman (1):
      Input: xpad - quirk all PDP Xbox One gamepads

Chuck Lever (1):
      SUNRPC: Fix leak of krb5p encode pages

Dmitry V. Levin (1):
      mips: fix mips_get_syscall_arg o32 check

Fabrizio Castro (1):
      can: rcar_can: Fix erroneous registration

Felix Fietkau (1):
      mac80211: fix reordering of buffered broadcast packets

Geert Uytterhoeven (1):
      iommu/ipmmu-vmsa: Fix crash on early domain free

Greg Kroah-Hartman (2):
      Staging: lustre: remove two build warnings
      Linux 3.18.129

Guenter Roeck (2):
      kobject: Replace strncpy with memcpy
      kernfs: Replace strncpy with memcpy

Harry Pan (1):
      usb: quirk: add no-LPM quirk on SanDisk Ultra Flair device

Jack Morgenstein (1):
      net/mlx4_core: Zero out lkey field in SW2HW_MPT fw command

Julian Wiedmann (1):
      s390/qeth: fix length check in SNMP processing

Kai-Heng Feng (2):
      USB: usb-storage: Add new IDs to ums-realtek
      ALSA: hda: Add support for AMD Stoney Ridge

Kees Cook (1):
      scsi: csiostor: Avoid content leaks and casts

Laura Abbott (2):
      kgdboc: Fix restrict error
      kgdboc: Fix warning with module build

Linus Torvalds (1):
      unifdef: use memcpy instead of strncpy

Macpaul Lin (1):
      kgdboc: fix KASAN global-out-of-bounds bug in param_set_kgdboc_var()

Martin Wilck (1):
      scsi: scsi_devinfo: cleanly zero-pad devinfo strings

Mathias Nyman (1):
      xhci: Prevent U1/U2 link pm states if exit latency is too long

Mathias Payer (1):
      USB: check usb_get_extra_descriptor for proper size

Michael Niew=F6hner (1):
      usb: core: quirks: add RESET_RESUME quirk for Cherry G230 Stream seri=
es

Pan Bian (2):
      rapidio/rionet: do not free skb before reading its length
      ext2: fix potential use after free

Pavel Tikhomirov (1):
      mm: cleancache: fix corruption on missed inode invalidation

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

Stephen Rothwell (1):
      disable stringop truncation warnings for now

Sultan Alsawaf (1):
      ip_tunnel: Fix name string concatenate in __ip_tunnel_create()

Takashi Iwai (6):
      ALSA: wss: Fix invalid snd_free_pages() at error path
      ALSA: ac97: Fix incorrect bit shift at AC97-SPSA control write
      ALSA: sparc: Fix invalid snd_free_pages() at error path
      ALSA: trident: Suppress gcc string warning
      ALSA: pcm: Call snd_pcm_unlink() conditionally at closing
      ALSA: pcm: Fix interval evaluation with openmin/max

Vincent Chen (1):
      net: faraday: ftmac100: remove netif_running(netdev) check before dis=
abling interrupts

Xiongfeng Wang (1):
      Kbuild: suppress packed-not-aligned warning for default setting only

Yangtao Li (1):
      net: amd: add missing of_node_put()


--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwSYQUACgkQONu9yGCS
aT6n7w/9FyK8B7OnQGhhP3Z8XeWYRR/9cp1Sn88kb/l+x27DKiwBxCm9e/PIbF+R
FkUOEL7zKlGE+j9DSvG7KdX+csQf4fRZgw3SP7IzkqsUubblXg1bTkw70cpGeRyQ
tlhyL6dkO64XXm1+vfj551TKOSflwuAHnKONckpq+JtGgC1aQTjZaTpjo8qpKIUK
dO8T6mM2FGi7a6myDuSIZOX3nUO5UaeEaw/EcdcUbxx9B/RtxTc8+QOdGwPAsoWO
3OjcncdQ2owjrVW6d1xiWwi55RLkAm+CuV3ZiQGt+T4N8Rmzd4eLmmYlzg6jVdaN
2VuBRHXs4wyCcdUi0gXsn9we4EaE0sLrMSnUg7mYn36Nsy3NvzBNm5SJ2coMgbuT
yQDJLjJcptcFIpVOl3kklrXJ1BmCXaq7DREpq+CpR+6T51WvAHZnUudsbZzkMW3V
IiuSnKbmL+jsaFa5XsaWR/cRZyBoy1hagSxLk0JxMBT8kgvpKzjID6UoCQysoR1g
c4qDERNfEgNIBmOyuuY1AykjnsAgeL4oscTxN+RnqpwlO4ul5seyhbAZH7mzwWcc
FnmFtyIiWShazaB7R4kLLEtM0aMWljCwiOCV68hjvuMkYjsAkc5K9GVTuY3pBud5
xud+1JbFbw8cnmS9QnwUaLFbinlQWbzbcatEsaMYysPen7riiKM=
=uDRv
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
