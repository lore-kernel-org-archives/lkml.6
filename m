Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeDBCba (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 22:31:30 -0400
Received: from ozlabs.org ([103.22.144.67]:49235 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753989AbeDBCb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 22:31:28 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 2 Apr 2018 12:30:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: linux-next: Signed-off-by missing for commits in the net-next tree
Message-ID: <20180402123019.2e04f084@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/alIdEvP8.bnvTw+IUfuEYBR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/alIdEvP8.bnvTw+IUfuEYBR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  45a42bc9cc65 ("Bluetooth: hci_bcm: Remove DMI quirk for the MINIX Z83-4")
  f9b95db0165a ("Bluetooth: btrsi: remove unused including <linux/version.h=
>")
  96e58d368fa6 ("Bluetooth: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for BTUSB_=
QCA_ROME")
  9ea471320e13 ("Bluetooth: Mark expected switch fall-throughs")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/alIdEvP8.bnvTw+IUfuEYBR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrBlbsACgkQAVBC80lX
0GzHpgf9GT1ujW6/s3IFQ17V4NBe6GdZ/k0b2NYtzuULxmBpnzxEySnAal3n8NOF
mD5pyMcT+B6m1zbgD5O7D7df8zY+n5cO1ucz6CdidmWzvGfV/YztT0kaZNb7FWSs
wQeJhkJAzUNafY4eRK9s4b+T8LY3uDNbQZf+oLjTkKTL0q0XdedQln2ZVWZLCdXA
dBQrj55qlp5VifrO2CX3/GWmtUjjQxAclbuo4k25kqzmcHAGFDWwtv+vMoxEL5XN
PnK1LaXPF1mTCzQBmZP1mCtOVV2tbHpNh8SDDdqZDxCUMM53CSfnDfXxr7p4grN6
Msj6v4tIsqcrRUsynQJzb5iyTE3oYw==
=LQai
-----END PGP SIGNATURE-----

--Sig_/alIdEvP8.bnvTw+IUfuEYBR--
