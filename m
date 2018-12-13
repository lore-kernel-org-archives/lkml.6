Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA016C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78ED620879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544708440;
	bh=8pcWvCAFrJPwd4xrR9wIqZ+rWkhNLJN3u2dX22l5zQM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=1M9BkYTxKHaQzkPcIxdPKKnbGjMyBmsZkz+9yhbRdkqrYdVK1AR97hppsb+odemXA
	 MH8RSywC/B5gs5Np3UoMCHrtD7PliiT3uvTxvhOeeN3mogMWAFOcDxETetPX4Np7e5
	 xJdDo1PYf7GjeerNZFF0d3jcG4no5GwA875GI79w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78ED620879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbeLMNkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:40:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbeLMNki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:40:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E413520879;
        Thu, 13 Dec 2018 13:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544708437;
        bh=8pcWvCAFrJPwd4xrR9wIqZ+rWkhNLJN3u2dX22l5zQM=;
        h=Date:From:To:Cc:Subject:From;
        b=J/KVwaicKYAkmwWOzYdkCKRGymXy715ZffMKFHQjD6GWd6BlvEfeUOEehduuxy2SH
         O2ch8VeO5mDSTWz6iFs81rgkNx1gkfIlGEA3/mayNa75zq6pmX3hGpLCY7uNccxI1C
         43BSZ4HlUth+31An/wZiusQEsxr4dOiBVaujKb/8=
Date:   Thu, 13 Dec 2018 14:40:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.88
Message-ID: <20181213134035.GA20521@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.88 kernel.

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

 Makefile                                                                  =
          |    2=20
 arch/arm/probes/kprobes/opt-arm.c                                         =
          |    2=20
 drivers/dma/cppi41.c                                                      =
          |   16=20
 drivers/dma/dw/core.c                                                     =
          |    6=20
 drivers/gpio/gpio-mockup.c                                                =
          |    6=20
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c                                     =
          |   35 +
 drivers/hid/hid-ids.h                                                     =
          |    4=20
 drivers/hid/hid-input.c                                                   =
          |    3=20
 drivers/hid/hid-multitouch.c                                              =
          |    6=20
 drivers/hv/channel_mgmt.c                                                 =
          |  185 ++++++----
 drivers/hv/connection.c                                                   =
          |   24 +
 drivers/hv/hyperv_vmbus.h                                                 =
          |    7=20
 drivers/iommu/amd_iommu_init.c                                            =
          |    3=20
 drivers/iommu/intel-iommu.c                                               =
          |    2=20
 drivers/iommu/intel-svm.c                                                 =
          |    2=20
 drivers/iommu/ipmmu-vmsa.c                                                =
          |    3=20
 drivers/media/platform/omap3isp/isp.c                                     =
          |    3=20
 drivers/mtd/nand/qcom_nandc.c                                             =
          |   32 -
 drivers/mtd/spi-nor/cadence-quadspi.c                                     =
          |   19 -
 drivers/net/can/rcar/rcar_can.c                                           =
          |    5=20
 drivers/net/ethernet/amd/sunlance.c                                       =
          |    4=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h                               =
          |    7=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c                            =
          |    1=20
 drivers/net/ethernet/faraday/ftmac100.c                                   =
          |    7=20
 drivers/net/ethernet/ibm/ibmvnic.c                                        =
          |    4=20
 drivers/net/ethernet/mellanox/mlx4/alloc.c                                =
          |    2=20
 drivers/net/ethernet/mellanox/mlx4/mlx4.h                                 =
          |    4=20
 drivers/net/ethernet/mellanox/mlx4/mr.c                                   =
          |    1=20
 drivers/net/ethernet/qlogic/qed/qed_dev.c                                 =
          |   29 +
 drivers/net/ethernet/qlogic/qed/qed_int.c                                 =
          |    2=20
 drivers/net/ethernet/qlogic/qed/qed_main.c                                =
          |    2=20
 drivers/net/team/team.c                                                   =
          |    2=20
 drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c                    =
          |    3=20
 drivers/net/wireless/mac80211_hwsim.c                                     =
          |    8=20
 drivers/nvdimm/nd-core.h                                                  =
          |    2=20
 drivers/nvdimm/pfn_devs.c                                                 =
          |   64 ++-
 drivers/nvdimm/region_devs.c                                              =
          |   41 ++
 drivers/s390/virtio/virtio_ccw.c                                          =
          |   17=20
 drivers/staging/lustre/lnet/lnet/config.c                                 =
          |    3=20
 drivers/staging/lustre/lustre/lmv/lmv_obd.c                               =
          |    2=20
 drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/debug/src/ia_cs=
s_debug.c |    4=20
 drivers/staging/rtl8712/mlme_linux.c                                      =
          |    2=20
 drivers/staging/rtl8712/rtl871x_mlme.c                                    =
          |    2=20
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c                             =
          |    2=20
 drivers/tty/serial/8250/8250_mtk.c                                        =
          |   16=20
 drivers/tty/serial/kgdboc.c                                               =
          |    4=20
 drivers/tty/tty_port.c                                                    =
          |    3=20
 drivers/usb/core/hub.c                                                    =
          |    2=20
 drivers/usb/core/quirks.c                                                 =
          |    4=20
 drivers/usb/core/usb.c                                                    =
          |    6=20
 drivers/usb/gadget/function/f_fs.c                                        =
          |   26 -
 drivers/usb/host/hwa-hc.c                                                 =
          |    2=20
 drivers/usb/host/xhci-pci.c                                               =
          |    4=20
 drivers/usb/host/xhci.c                                                   =
          |   42 ++
 drivers/usb/host/xhci.h                                                   =
          |    3=20
 drivers/usb/misc/appledisplay.c                                           =
          |    1=20
 drivers/vhost/vsock.c                                                     =
          |   57 +--
 fs/cifs/dir.c                                                             =
          |    2=20
 fs/f2fs/data.c                                                            =
          |    3=20
 fs/f2fs/inode.c                                                           =
          |   18=20
 fs/nfs/flexfilelayout/flexfilelayout.c                                    =
          |   21 -
 fs/nfs/flexfilelayout/flexfilelayout.h                                    =
          |    4=20
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                                 =
          |   19 +
 include/linux/hyperv.h                                                    =
          |    7=20
 include/linux/usb.h                                                       =
          |    4=20
 include/sound/pcm_params.h                                                =
          |    4=20
 lib/swiotlb.c                                                             =
          |   20 -
 lib/test_firmware.c                                                       =
          |    1=20
 mm/page_alloc.c                                                           =
          |   10=20
 net/batman-adv/bat_v_elp.c                                                =
          |    6=20
 net/batman-adv/fragmentation.c                                            =
          |    2=20
 net/mac80211/iface.c                                                      =
          |    2=20
 net/mac80211/rx.c                                                         =
          |    1=20
 net/mac80211/status.c                                                     =
          |    2=20
 net/mac80211/tx.c                                                         =
          |    4=20
 net/sunrpc/auth_gss/auth_gss.c                                            =
          |    4=20
 sound/core/pcm_native.c                                                   =
          |   14=20
 sound/pci/hda/hda_intel.c                                                 =
          |    4=20
 sound/pci/hda/patch_realtek.c                                             =
          |    9=20
 sound/usb/card.c                                                          =
          |    5=20
 80 files changed, 639 insertions(+), 277 deletions(-)

Alex Deucher (1):
      drm/amdgpu/gmc8: update MC firmware for polaris

Alexander Theissen (1):
      usb: appledisplay: Add 27" Apple Cinema Display

Andy Shevchenko (1):
      dmaengine: dw: Fix FIFO size for Intel Merrifield

Aya Levin (1):
      net/mlx4: Fix UBSAN warning of signed integer overflow

Bartosz Golaszewski (1):
      gpio: mockup: fix indicated direction

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

Chao Yu (1):
      f2fs: fix to do sanity check with block address in main area v2

Chuck Lever (1):
      SUNRPC: Fix leak of krb5p encode pages

Colin Ian King (1):
      test_firmware: fix error return getting clobbered

Dan Williams (1):
      libnvdimm, pfn: Pad pfn namespaces relative to other regions

Denis Bolotin (4):
      qed: Fix PTT leak in qed_drain()
      qed: Fix reading wrong value in loop condition
      qed: Fix bitmap_weight() check
      qed: Fix QM getters to always return a valid pq

Dexuan Cui (1):
      Drivers: hv: vmbus: Offload the handling of channels to two workqueues

Emmanuel Grumbach (1):
      mac80211: ignore NullFunc frames in the duplicate detection

Fabrizio Castro (1):
      can: rcar_can: Fix erroneous registration

Felix Fietkau (2):
      mac80211: ignore tx status for PS stations in ieee80211_tx_status_ext
      mac80211: fix reordering of buffered broadcast packets

Filippo Sironi (1):
      amd/iommu: Fix Guest Virtual APIC Log Tail Address Register

Geert Uytterhoeven (1):
      iommu/ipmmu-vmsa: Fix crash on early domain free

Greg Kroah-Hartman (3):
      Staging: lustre: remove two build warnings
      staging: atomisp: remove "fun" strncpy warning
      Linux 4.14.88

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

Junwei Zhang (1):
      drm/amdgpu: update mc firmware image for polaris12 variants

Kai-Heng Feng (2):
      HID: multitouch: Add pointstick support for Cirque Touchpad
      ALSA: hda: Add support for AMD Stoney Ridge

Kees Cook (2):
      ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE
      swiotlb: clean up reporting

Lu Baolu (1):
      iommu/vt-d: Fix NULL pointer dereference in prq_event_thread()

Macpaul Lin (1):
      kgdboc: fix KASAN global-out-of-bounds bug in param_set_kgdboc_var()

Mathias Nyman (1):
      xhci: Prevent U1/U2 link pm states if exit latency is too long

Mathias Payer (1):
      USB: check usb_get_extra_descriptor for proper size

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

Sandeep Singh (1):
      xhci: workaround CSS timeout on AMD SNPS 3.0 xHC

Shen Jing (1):
      Revert "usb: gadget: ffs: Fix BUG when userland exits with submitted =
AIO transfers"

Stefan Hajnoczi (1):
      vhost/vsock: fix use-after-free in network stack callers

Sudarsana Reddy Kalluru (1):
      bnx2x: Assign unique DMAE channel number for FW DMAE transactions.

Sven Eckelmann (2):
      batman-adv: Use explicit tvlv padding for ELP packets
      batman-adv: Expand merged fragment buffer for full packet

Takashi Iwai (3):
      ALSA: pcm: Call snd_pcm_unlink() conditionally at closing
      ALSA: pcm: Fix interval evaluation with openmin/max
      ALSA: hda/realtek - Fix speaker output regression on Thinkpad T570

Tariq Toukan (1):
      net/mlx4_core: Fix uninitialized variable compilation warning

Tetsuo Handa (1):
      mm: don't warn about allocations which stall for too long

Thomas Falcon (1):
      ibmvnic: Fix RX queue buffer cleanup

Thor Thayer (1):
      mtd: spi-nor: Fix Cadence QSPI page fault kernel panic

Tigran Mkrtchyan (1):
      flexfiles: use per-mirror specified stateid for IO

Vasyl Vavrychuk (1):
      mac80211_hwsim: Timer should be initialized before device registered

Vincent Chen (1):
      net: faraday: ftmac100: remove netif_running(netdev) check before dis=
abling interrupts

Yangtao Li (1):
      net: amd: add missing of_node_put()

Young Xiao (2):
      staging: rtl8712: Fix possible buffer overrun
      Revert commit ef9209b642f "staging: rtl8723bs: Fix indenting errors a=
nd an off-by-one mistake in core/rtw_mlme_ext.c"


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwSYVIACgkQONu9yGCS
aT55nhAAodF5xCk7gqUCcXt8GvgrvKJX9AyGhICvMFUCBb7v0PVqR56p73yLwTp3
rT1ATiOlhdGa34eTtJwMFanrKBbvSqzA3w20+LBUTlZVgaTf+nhXLK99b77Xuyg4
B9JlfNy8UvkhrbtPJudFBSf7yCMhOEgbAhJyV+l+/vtQDXzC01kjsxhtOKVcg9v5
VTuctFqfzlaIsIg/4+fkahhQzuTugoSwBYJFVhs35RZHI25OrJEamEtLzj8L0E5G
T56WXkwczAz+S5Jc5HrETHaVQXgX0k6mTZzM8wiVQOlGXh3QQ2aD+1gl8aHkWXiE
P42MHIWQgIscdhYYxXkh/UcO5VUtXaRcAHqn4MEUMaH/aOWmtC9MPZBBYpy8l+Xf
cQjwvxkF+UvoqIUAZ4qmPtT4IGeudr4w0sTCV0Wf/Q+GjvGRVI/x1fRVjKlfopK0
mypuBp1wHPpyyg+Izo1Ep5pFpJxIXbHLSwYsIXS+ZM9RPYYYGOSeui0quCt+IKu0
jaVZqheIKZs4S/TJH5K19mmMZ2kQELxIORjdm8ZVR2wzPphUIcRD36pwZzZlpNtg
F0CcrkI63IudE4n8q7X1hb9EfLxb/iXRh3tRVLws4nLAx4dN2jDOyD+Ec9PgewbJ
kJH9V6w/0i2P9p7AdiRXyXdmTCHYPbHnOHgHEM3WeZBXUXao2Q4=
=UuM7
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
