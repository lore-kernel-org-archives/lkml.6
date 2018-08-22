Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE0EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC223214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC223214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeHVKIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 06:08:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46390 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeHVKIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 06:08:22 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4B7FE49B;
        Wed, 22 Aug 2018 06:44:51 +0000 (UTC)
Date:   Wed, 22 Aug 2018 08:44:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.18.4
Message-ID: <20180822064448.GA27927@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.18.4 kernel.

All users of the 4.18 kernel series must upgrade.

The updated 4.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                |    2 -
 drivers/acpi/sleep.c                    |    8 ++++
 drivers/isdn/i4l/isdn_common.c          |    8 ----
 drivers/media/usb/dvb-usb-v2/gl861.c    |   21 ++++++------
 drivers/misc/sram.c                     |    9 ++++-
 drivers/net/ethernet/marvell/mvneta.c   |   53 +++++++++++++++++++--------=
-----
 drivers/net/ethernet/realtek/r8169.c    |   12 ++++++-
 drivers/net/hyperv/rndis_filter.c       |    2 -
 drivers/tty/serial/8250/8250_dw.c       |    3 +
 drivers/tty/serial/8250/8250_exar.c     |    6 +++
 drivers/tty/serial/8250/8250_port.c     |    3 -
 drivers/uio/uio.c                       |   10 +-----
 drivers/usb/serial/option.c             |    4 ++
 drivers/usb/serial/pl2303.c             |    2 +
 drivers/usb/serial/pl2303.h             |    1=20
 drivers/usb/serial/sierra.c             |    4 +-
 net/bluetooth/sco.c                     |    3 +
 net/core/sock_diag.c                    |    2 +
 net/ipv4/ip_vti.c                       |    3 +
 net/l2tp/l2tp_core.c                    |    2 -
 net/sched/cls_matchall.c                |    2 +
 net/sched/cls_tcindex.c                 |    8 +---
 net/socket.c                            |    3 -
 sound/core/memalloc.c                   |    8 +---
 sound/core/seq/oss/seq_oss.c            |    2 -
 sound/core/seq/seq_clientmgr.c          |    2 -
 sound/core/seq/seq_virmidi.c            |   10 ++++++
 sound/firewire/dice/dice-alesis.c       |    2 -
 sound/pci/cs5535audio/cs5535audio.h     |    6 +--
 sound/pci/cs5535audio/cs5535audio_pcm.c |    4 +-
 sound/pci/hda/hda_intel.c               |    2 -
 sound/pci/hda/patch_conexant.c          |    4 +-
 sound/pci/vx222/vx222_ops.c             |    8 ++--
 sound/pcmcia/vx/vxp_ops.c               |   10 +++---
 34 files changed, 137 insertions(+), 92 deletions(-)

Aaron Sierra (1):
      serial: 8250_exar: Read INT0 from slave device, too

Aleksander Morgado (1):
      USB: option: add support for DW5821e

Andrew Lunn (1):
      net: ethernet: mvneta: Fix napi structure mixup on armada 3700

Chen Hu (1):
      serial: 8250_dw: always set baud rate in dw8250_set_termios

Greg Kroah-Hartman (1):
      Linux 4.18.4

Hailong Liu (1):
      uio: fix wrong return value from uio_mmap()

Haishuang Yan (1):
      ip_vti: fix a null pointer deferrence when create vti fallback tunnel

Hangbin Liu (3):
      net_sched: fix NULL pointer dereference when delete tcindex filter
      net_sched: Fix missing res info when create new tc_index filter
      cls_matchall: fix tcf_unbind_filter missing

Hans de Goede (1):
      ALSA: hda: Correct Asrock B85M-ITX power_save blacklist entry

Heiner Kallweit (1):
      r8169: don't use MSI-X on RTL8168g

Jeremy Cline (1):
      net: sock_diag: Fix spectre v1 gadget in __sock_diag_cmd()

Jian-Hong Pan (1):
      r8169: don't use MSI-X on RTL8106e

Jisheng Zhang (1):
      net: mvneta: fix mvneta_config_rss on armada 3700

Johan Hovold (1):
      misc: sram: fix resource leaks in probe error path

John Ogness (1):
      USB: serial: sierra: fix potential deadlock at close

Kees Cook (1):
      isdn: Disable IIOCDBGVAR

Mark (1):
      tty: serial: 8250: Revert NXP SC16C2552 workaround

Mika B=E5tsman (1):
      media: gl861: fix probe of dvb_usb_gl861

Movie Song (1):
      USB: serial: pl2303: add a new device id for ATEN

Park Ju Hyung (2):
      ALSA: hda - Sleep for 10ms after entering D3 on Conexant codecs
      ALSA: hda - Turn CX8200 into D3 as well upon reboot

Srinath Mannam (1):
      serial: 8250_dw: Add ACPI support for uart on Broadcom SoC

Sudip Mukherjee (1):
      Bluetooth: avoid killing an already killed socket

Takashi Iwai (7):
      ALSA: vx222: Fix invalid endian conversions
      ALSA: virmidi: Fix too long output trigger loop
      ALSA: cs5535audio: Fix invalid endian conversion
      ALSA: memalloc: Don't exceed over the requested size
      ALSA: vxpocket: Fix invalid endian conversions
      ALSA: seq: Fix poll() error return
      hv/netvsc: Fix NULL dereference at single queue mode fallback

Takashi Sakamoto (1):
      ALSA: dice: fix wrong copy to rx parameters for Alesis iO26

Wei Wang (1):
      l2tp: use sk_dst_check() to avoid race on sk->sk_dst_cache

Willy Tarreau (1):
      ACPI / PM: save NVS memory for ASUS 1025C laptop

Xiubo Li (1):
      Revert "uio: use request_threaded_irq instead"


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt9Bl0ACgkQONu9yGCS
aT7ViA/+N8LouRp2KcEtJQRDagP06UFMoPAs5s6iSqSVw6XNJ+w84H2R95QqVcM/
et7Xpvp8+KA5M5gLLsneQXv+cEMbFtJamu3uuVqEKbvVcXqmjO2e+Yr4l6fUVHQh
/htsI8kemKsbZ2S8PeEcp0OXCTyfMCTlJagRELCqKUdSdkwLppw91a8pHVGdrEpZ
oa3DP8tUr8IkMWK2aPW5V4w/sUWbpbvTO66MvsqAI05rShEeNzWcEc2a6Mrv70iC
2REJkWwSLNp7RkK9nM4MzzHgG+VaHPVfNIJmNYH9fXE3dW7s9kGlxv1yMAhMebZq
KcqIDAwpYzgfUoEZ2SKoFGAqwKEitXorrOny9j8ttwXSlL95t+UEOZRiRP3eDwgR
bRCsyTplGYdN5f0Zvdg/MJrS5C0/Pw1qeIs5WTZ4NAS/FFVoiuwZ5EBSFTmBv82K
iY0NKnuTz6zEHxZM4J3KpNOy1Vyx1G2RYv0fKsMd6A5O+6/4ywJp3NITRNYxTGcK
KnDq5ZjgvqJCSleg1Glt6ARPhqyi5IifP7eD8a1RWJfr2Kv25d9bb0qSO8929NT8
laRe7aJA4M1bEsWhYZS3/RRuIp3sJpyTAn5tfDdd7AvRkjTos20nxw3fJwEKKlWo
TqVXRDD1nT6EoOIForTeJ61ymctd65f8JtWdXjG6mIjoSMunnrA=
=AAGD
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
