Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E30C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4085214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4085214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeHVKJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 06:09:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46412 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeHVKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 06:09:00 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B42FB8B1;
        Wed, 22 Aug 2018 06:45:28 +0000 (UTC)
Date:   Wed, 22 Aug 2018 08:45:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.17.18
Message-ID: <20180822064525.GA28023@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.17.18 kernel.

All users of the 4.17 kernel series must upgrade.

The updated 4.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.17.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                    |    2=20
 drivers/acpi/sleep.c                                        |    8=20
 drivers/isdn/i4l/isdn_common.c                              |    8=20
 drivers/misc/sram.c                                         |    9=20
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c   |    2=20
 drivers/net/ethernet/marvell/mvneta.c                       |   53 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c             |    8=20
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c |   51 ++-
 drivers/net/ethernet/realtek/r8169.c                        |   12=20
 drivers/tty/serial/8250/8250_dw.c                           |    3=20
 drivers/tty/serial/8250/8250_exar.c                         |    6=20
 drivers/tty/serial/8250/8250_port.c                         |    3=20
 drivers/usb/serial/option.c                                 |    4=20
 drivers/usb/serial/pl2303.c                                 |    2=20
 drivers/usb/serial/pl2303.h                                 |    1=20
 drivers/usb/serial/sierra.c                                 |    4=20
 drivers/vhost/vhost.c                                       |    9=20
 include/net/af_vsock.h                                      |    4=20
 include/net/llc.h                                           |    5=20
 net/bluetooth/sco.c                                         |    3=20
 net/core/sock_diag.c                                        |    2=20
 net/dccp/ccids/ccid2.c                                      |    6=20
 net/ipv4/ip_vti.c                                           |    3=20
 net/ipv6/ip6_tunnel.c                                       |    8=20
 net/l2tp/l2tp_core.c                                        |    2=20
 net/llc/llc_core.c                                          |    4=20
 net/rxrpc/ar-internal.h                                     |    8=20
 net/rxrpc/conn_event.c                                      |    4=20
 net/rxrpc/net_ns.c                                          |    6=20
 net/rxrpc/output.c                                          |   12=20
 net/rxrpc/peer_event.c                                      |  156 ++++++-=
-----
 net/rxrpc/peer_object.c                                     |    8=20
 net/rxrpc/rxkad.c                                           |    4=20
 net/sched/cls_matchall.c                                    |    2=20
 net/sched/cls_tcindex.c                                     |    8=20
 net/socket.c                                                |    3=20
 net/vmw_vsock/af_vsock.c                                    |   15 -
 net/vmw_vsock/vmci_transport.c                              |    3=20
 sound/core/memalloc.c                                       |    8=20
 sound/core/seq/oss/seq_oss.c                                |    2=20
 sound/core/seq/seq_clientmgr.c                              |    2=20
 sound/core/seq/seq_virmidi.c                                |   10=20
 sound/pci/cs5535audio/cs5535audio.h                         |    6=20
 sound/pci/cs5535audio/cs5535audio_pcm.c                     |    4=20
 sound/pci/hda/hda_intel.c                                   |    2=20
 sound/pci/hda/patch_conexant.c                              |    4=20
 sound/pci/vx222/vx222_ops.c                                 |    8=20
 sound/pcmcia/vx/vxp_ops.c                                   |   10=20
 48 files changed, 295 insertions(+), 212 deletions(-)

Aaron Sierra (1):
      serial: 8250_exar: Read INT0 from slave device, too

Aleksander Morgado (1):
      USB: option: add support for DW5821e

Alexey Kodanev (1):
      dccp: fix undefined behavior with 'cwnd' shift in ccid2_cwnd_restart()

Andrew Lunn (1):
      net: ethernet: mvneta: Fix napi structure mixup on armada 3700

Chen Hu (1):
      serial: 8250_dw: always set baud rate in dw8250_set_termios

Cong Wang (2):
      llc: use refcount_inc_not_zero() for llc_sap_find()
      vsock: split dwork to avoid reinitializations

David Howells (1):
      rxrpc: Fix the keepalive generator [ver #2]

Dmitry Bogdanov (1):
      net: aquantia: Fix IFF_ALLMULTI flag functionality

Greg Kroah-Hartman (1):
      Linux 4.17.18

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

Jason Wang (1):
      vhost: reset metadata cache when initializing new IOTLB

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

Movie Song (1):
      USB: serial: pl2303: add a new device id for ATEN

Nir Dotan (4):
      mlxsw: core_acl_flex_actions: Return error for conflicting actions
      mlxsw: core_acl_flex_actions: Remove redundant resource destruction
      mlxsw: core_acl_flex_actions: Remove redundant counter destruction
      mlxsw: core_acl_flex_actions: Remove redundant mirror resource destru=
ction

Or Gerlitz (1):
      net/mlx5e: Properly check if hairpin is possible between two functions

Park Ju Hyung (2):
      ALSA: hda - Sleep for 10ms after entering D3 on Conexant codecs
      ALSA: hda - Turn CX8200 into D3 as well upon reboot

Srinath Mannam (1):
      serial: 8250_dw: Add ACPI support for uart on Broadcom SoC

Sudip Mukherjee (1):
      Bluetooth: avoid killing an already killed socket

Takashi Iwai (6):
      ALSA: vx222: Fix invalid endian conversions
      ALSA: virmidi: Fix too long output trigger loop
      ALSA: cs5535audio: Fix invalid endian conversion
      ALSA: memalloc: Don't exceed over the requested size
      ALSA: vxpocket: Fix invalid endian conversions
      ALSA: seq: Fix poll() error return

Wei Wang (1):
      l2tp: use sk_dst_check() to avoid race on sk->sk_dst_cache

Willy Tarreau (1):
      ACPI / PM: save NVS memory for ASUS 1025C laptop

Xin Long (1):
      ip6_tunnel: use the right value for ipv4 min mtu check in ip6_tnl_xmit


--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt9BoUACgkQONu9yGCS
aT4CqBAAoj8IL45e4/y1a18IwITn2ejaAybQ4fPDmDRJ7z5wICnmKDeItPgA/r7U
OFGVgbo7pL1UYXu8MLiCk5o5xkyXtzkgQsglns3nCfl88pWmPMvVaTAANme0vTnU
Oth4Jns+Nfwtf8Drv5T9r4fMpjBsGKu9Damr+iRaCi6T7SPQtw+VqmUaqZd4aUug
ZzKEYug0aBagHJEH8AdCNJLV0ol96Rrg8jlKmd52wlx550FB0gpZ8lPFdYbLO3p/
A49P7KboI/CVqQqDODvtj7QySHVAun8cuLy1KhlbY8lqX2B1PsEYmDIctjuWF/9P
bFp3Rs2oimty7BnzaRf8M+VmIPkFi9HEVF0zdqvPLVfFaaeYTx4t06wcRCEP+hG2
75r42O0EeThmHjmUsyQy43FMJlef9BobjiiN72QhM34ZKe2I6Cv/eC1G9aEgyT+T
NY/j+Nwt0OLQkiOLYmFHfwob0JHBFMhsusnZPSWgkitfZVwAJ10zuogpTS3pshu2
rUiCBZ8vBKVia72SWlDfxK4XWQH1/61LXL60jkH5dTPWjTpB3TYlbU2cPgIYfSf6
gd+2Cm+DKQQBrBtHKvXdFu1RXV1qZaUlcxuIb1Z06kw7WjdWdv/+gYuM5LmYdDmk
+W0Dk2Irou06uGm6JNvDhHdFL8w2jkH3q6wLJsR8xU2TvIGPmUs=
=le3O
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
