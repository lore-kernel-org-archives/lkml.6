Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbeDBGvA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 02:51:00 -0400
Received: from ozlabs.org ([103.22.144.67]:38317 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752150AbeDBGu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 02:50:58 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 2 Apr 2018 16:50:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Johan Hedberg <johan.hedberg@intel.com>
Cc: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the net-next
 tree
Message-ID: <20180402165001.02856dee@canb.auug.org.au>
In-Reply-To: <20180402053803.GA17750@x1c.home>
References: <20180402123019.2e04f084@canb.auug.org.au>
        <20180402053803.GA17750@x1c.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/c4Js4VYBEqVhdF45z6tpi9y"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c4Js4VYBEqVhdF45z6tpi9y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Mon, 2 Apr 2018 08:38:03 +0300 Johan Hedberg <johan.hedberg@intel.com> w=
rote:
>
> On Mon, Apr 02, 2018, Stephen Rothwell wrote:
> >   45a42bc9cc65 ("Bluetooth: hci_bcm: Remove DMI quirk for the MINIX Z83=
-4")
> >   f9b95db0165a ("Bluetooth: btrsi: remove unused including <linux/versi=
on.h>")
> >   96e58d368fa6 ("Bluetooth: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for BT=
USB_QCA_ROME")
> >   9ea471320e13 ("Bluetooth: Mark expected switch fall-throughs")
> >=20
> > are missing a Signed-off-by from their committer. =20
>=20
> I think this is because I fixed up a missing author name in "Bluetooth:
> hci_bcm: Remove DMI quirk for the MINIX Z83-4" and did a push --force,
> whereas these patches were originally committed by Marcel. Should I be
> adding my signed-off-by to all affected patches when doing such rebases?

Yep, Ideally we should have a Signed-off-by from everyone who involved
in getting the patches into the final tree.  That definitely means that
the final committer needs to add one.

--=20
Cheers,
Stephen Rothwell

--Sig_/c4Js4VYBEqVhdF45z6tpi9y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrB0pkACgkQAVBC80lX
0GwuWwgAkn8XouVUI4euAd36PCPJgRdzjARYoxbVpDXPjaB3O8r9ExVshQpcolR1
rX1NRCz3RWybUGNq92LB253VUlutzyl+7fDs2Jj1H6jjVRQxHbniyKVmuOP5E3An
14e85SOagxjklSenaz2R92NakxSfOh7Dm1DOqtU846x1OZ38TeJWCR6i+9gmg5RE
GRtYAPI4Zjj5gCxHcSO6o5ujJTRQcr3KUGTq2qNBKxfrOApiiGhSVvY+Y1tVVK3D
/2uEUAxNRce/v0fWmqIDktfehfKDagwSMtlMo2N8Wi0oxqDGkWCskZ0OYD0lZM73
fLFcQS94V8ETI6k/bPDs+ndI+5/yhA==
=UAcJ
-----END PGP SIGNATURE-----

--Sig_/c4Js4VYBEqVhdF45z6tpi9y--
