Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E223C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D465D20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544708419;
	bh=J6xNi+b97Oc8h+cARRK9+8TUH5SKP8jPRhbCZjLDwAo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=KA+gXqHIwrHxAWHH4iN8E3hQFptIlpsDNXizAGlmxyryk02pqxKnBx4OlIMgPkVhY
	 i2JQint/Hm3KV/sO8/dWo77z6mj0taxd5IzuJDi5f/9LewQ/GRrX570JcgLl7vAVUh
	 8CET5mcqv173nqnIgt8RkryalTsVSdbOhpuT6BTQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D465D20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbeLMNkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:40:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbeLMNkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:40:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A3A320879;
        Thu, 13 Dec 2018 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544708415;
        bh=J6xNi+b97Oc8h+cARRK9+8TUH5SKP8jPRhbCZjLDwAo=;
        h=Date:From:To:Cc:Subject:From;
        b=WoA/7gYJqwwARqzG8Ax3Setl0Fb1V1p3Wjv2/91SokW0txUHLLhdlsDzJmhpHXGCd
         O/gZvaPPRBaZBCfXVRrvTKgPL0K+mkxYvZZoykIrEfYyuzYfHKsFEuCwXue2/bThJN
         620msi5iMck0eZyuK8525HyCx9m1od+LAaNyxHmc=
Date:   Thu, 13 Dec 2018 14:40:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.145
Message-ID: <20181213134013.GA19457@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.145 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                               |   10 ++-
 arch/arc/configs/zebu_hs_defconfig                     |    1=20
 arch/arc/configs/zebu_hs_smp_defconfig                 |    1=20
 drivers/dma/cppi41.c                                   |   16 +++++
 drivers/hid/hid-ids.h                                  |    1=20
 drivers/hid/hid-input.c                                |    3 +
 drivers/iommu/intel-iommu.c                            |    2=20
 drivers/iommu/intel-svm.c                              |    2=20
 drivers/iommu/ipmmu-vmsa.c                             |    3 +
 drivers/media/platform/omap3isp/isp.c                  |    3 -
 drivers/mtd/nand/qcom_nandc.c                          |   32 +++++-----
 drivers/net/can/rcar/rcar_can.c                        |    5 +
 drivers/net/ethernet/amd/sunlance.c                    |    4 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h            |    7 ++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c         |    1=20
 drivers/net/ethernet/faraday/ftmac100.c                |    7 +-
 drivers/net/ethernet/mellanox/mlx4/alloc.c             |    2=20
 drivers/net/ethernet/mellanox/mlx4/mlx4.h              |    4 -
 drivers/net/ethernet/mellanox/mlx4/mr.c                |    1=20
 drivers/net/ethernet/qlogic/qed/qed_int.c              |    2=20
 drivers/net/ethernet/qlogic/qed/qed_main.c             |    2=20
 drivers/net/team/team.c                                |    2=20
 drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c |    3 +
 drivers/net/wireless/mac80211_hwsim.c                  |    8 +-
 drivers/s390/virtio/virtio_ccw.c                       |   17 ++++-
 drivers/scsi/sr_ioctl.c                                |   21 ++-----
 drivers/staging/lustre/lnet/lnet/config.c              |    3 -
 drivers/staging/lustre/lustre/lmv/lmv_obd.c            |    2=20
 drivers/staging/rtl8712/mlme_linux.c                   |    2=20
 drivers/staging/rtl8712/rtl871x_mlme.c                 |    2=20
 drivers/tty/serial/8250/8250_mtk.c                     |   16 ++---
 drivers/tty/serial/kgdboc.c                            |    4 -
 drivers/tty/tty_port.c                                 |    3 -
 drivers/usb/core/hub.c                                 |    2=20
 drivers/usb/core/quirks.c                              |    4 +
 drivers/usb/core/usb.c                                 |    6 +-
 drivers/usb/host/hwa-hc.c                              |    2=20
 drivers/usb/host/xhci.c                                |   16 +++++
 drivers/usb/misc/appledisplay.c                        |    1=20
 drivers/vhost/vsock.c                                  |   50 +++++++++++-=
-----
 fs/cifs/dir.c                                          |    2=20
 include/linux/usb.h                                    |    4 -
 include/sound/pcm_params.h                             |    4 +
 lib/swiotlb.c                                          |   20 +++---
 mm/page_alloc.c                                        |   10 ---
 net/batman-adv/fragmentation.c                         |    2=20
 net/mac80211/iface.c                                   |    2=20
 net/mac80211/rx.c                                      |    1=20
 net/mac80211/status.c                                  |    2=20
 net/mac80211/tx.c                                      |    4 -
 net/sunrpc/auth_gss/auth_gss.c                         |    4 +
 scripts/Kbuild.include                                 |    5 +
 sound/core/pcm_native.c                                |   14 ++--
 sound/pci/hda/hda_intel.c                              |    4 +
 sound/pci/hda/patch_realtek.c                          |    9 +++
 sound/usb/card.c                                       |    5 +
 56 files changed, 231 insertions(+), 134 deletions(-)

Alexander Theissen (1):
      usb: appledisplay: Add 27" Apple Cinema Display

Alexey Brodkin (1):
      ARC: [zebu] Remove CONFIG_INITRAMFS_SOURCE from defconfigs

Aya Levin (1):
      net/mlx4: Fix UBSAN warning of signed integer overflow

Ben Greear (1):
      mac80211: Clear beacon_int in ieee80211_do_stop

Benson Leung (1):
      HID: input: Ignore battery reported by Symbol DS4308

Bin Liu (1):
      dmaengine: cppi41: delete channel from pending list when stop channel

Chanho Min (1):
      ALSA: pcm: Fix starvation on down_write_nonblock()

Chanho Park (1):
      tty: do not set TTY_IO_ERROR flag if console port

Chuck Lever (1):
      SUNRPC: Fix leak of krb5p encode pages

Denis Bolotin (2):
      qed: Fix PTT leak in qed_drain()
      qed: Fix reading wrong value in loop condition

Emmanuel Grumbach (1):
      mac80211: ignore NullFunc frames in the duplicate detection

Fabrizio Castro (1):
      can: rcar_can: Fix erroneous registration

Felix Fietkau (2):
      mac80211: ignore tx status for PS stations in ieee80211_tx_status_ext
      mac80211: fix reordering of buffered broadcast packets

Gao feng (1):
      vsock: lookup and setup guest_cid inside vhost_vsock_lock

Geert Uytterhoeven (1):
      iommu/ipmmu-vmsa: Fix crash on early domain free

Greg Kroah-Hartman (2):
      Staging: lustre: remove two build warnings
      Linux 4.9.145

Halil Pasic (2):
      virtio/s390: avoid race on vcdev->config
      virtio/s390: fix race in ccw_io_helper()

Hangbin Liu (1):
      team: no need to do team_notify_peers or team_mcast_rejoin when disab=
ling port

Harry Pan (1):
      usb: quirk: add no-LPM quirk on SanDisk Ultra Flair device

Hui Peng (1):
      ALSA: usb-audio: Fix UAF decrement if card has no live interfaces in =
card.c

Jack Morgenstein (1):
      net/mlx4_core: Zero out lkey field in SW2HW_MPT fw command

Jens Axboe (1):
      sr: pass down correctly sized SCSI sense buffer

Kai-Heng Feng (1):
      ALSA: hda: Add support for AMD Stoney Ridge

Kees Cook (1):
      swiotlb: clean up reporting

Lu Baolu (1):
      iommu/vt-d: Fix NULL pointer dereference in prq_event_thread()

Macpaul Lin (1):
      kgdboc: fix KASAN global-out-of-bounds bug in param_set_kgdboc_var()

Mathias Nyman (1):
      xhci: Prevent U1/U2 link pm states if exit latency is too long

Mathias Payer (1):
      USB: check usb_get_extra_descriptor for proper size

Nick Desaulniers (1):
      kbuild: fix linker feature test macros when cross compiling with Clang

Olof Johansson (1):
      mtd: rawnand: qcom: Namespace prefix some commands

Pan Bian (1):
      iommu/vt-d: Use memunmap to free memremap

Paulo Alcantara (1):
      cifs: Fix separator when building path from dentry

Peter Shih (1):
      tty: serial: 8250_mtk: always resume the device in probe.

Rafa=C5=82 Mi=C5=82ecki (1):
      brcmutil: really fix decoding channel info for 160 MHz bandwidth

Sakari Ailus (1):
      media: omap3isp: Unregister media device as first

Stefan Agner (1):
      kbuild: allow to use GCC toolchain not in Clang search path

Stefan Hajnoczi (1):
      vhost/vsock: fix use-after-free in network stack callers

Sudarsana Reddy Kalluru (1):
      bnx2x: Assign unique DMAE channel number for FW DMAE transactions.

Sven Eckelmann (1):
      batman-adv: Expand merged fragment buffer for full packet

Takashi Iwai (3):
      ALSA: pcm: Call snd_pcm_unlink() conditionally at closing
      ALSA: pcm: Fix interval evaluation with openmin/max
      ALSA: hda/realtek - Fix speaker output regression on Thinkpad T570

Tariq Toukan (1):
      net/mlx4_core: Fix uninitialized variable compilation warning

Tetsuo Handa (1):
      mm: don't warn about allocations which stall for too long

Vasyl Vavrychuk (1):
      mac80211_hwsim: Timer should be initialized before device registered

Vincent Chen (1):
      net: faraday: ftmac100: remove netif_running(netdev) check before dis=
abling interrupts

Yangtao Li (1):
      net: amd: add missing of_node_put()

Young Xiao (1):
      staging: rtl8712: Fix possible buffer overrun


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwSYT0ACgkQONu9yGCS
aT6bnBAA1mKW6krJDjVWoUrYaaKtG779GIBhMNEa0FV2fEsCH3LpZJ5u+G3KN71/
0EyQEaUrxarQIIqx3d9xnKVQaAdYyPwL8PRyiHJSFlHyqJD0fA1R+O65QB2o+664
b+0p9sYyalPIYjhBd2/hbJHhKK7N4jOXVg9PPd7CyS4piNCML94FOtHfz9rWeK8s
hB/AjQDJY8jvpeAPTWCGXhlSZ1Tc7+W0E2Kz4AJqKvgUcxUEA9ZeFddkcnjs86pW
ju7m94wO2PEZNZXAUG0yFbtpAQ3H5Ua9J6FjxZTHlTsmMQErV45xJRqMqdUGWak7
q9TFZ+/eh+fIqE4L1LhR9Q9blBmHZOiQKhgaBKcL10jZmXlFALKVd0v8Xst5D5w8
OZYOmGGwqqqY84YsHdi6MqGPeJRZN/O6xpjhKkUm1KcYAibZsPXMYTdQrCXTAaQw
/iIwv4pmT5dSGKHWEgpo1QOd9q5LRw7Z/4xyM7PqZsOaYeFquSauc82gcH3rYtHS
gHmGvUj0piPNC0aG60AsavMrt3vwprwpT3wgOpINGWjlj4QBkopyetDyROqZxtwQ
/1mVTzh2veceADCjB1+u7AGkVi1IR+N/e0ZV/AT30UgD2WBZJuT4lX7VgDY+mpgb
A2neVSUnFqFm6CT6563REo9DmFtkomFjkSlM6WwFmGJn1c29SiE=
=R8MI
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
