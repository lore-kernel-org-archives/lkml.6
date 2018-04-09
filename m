Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbeDIEXj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 00:23:39 -0400
Received: from ozlabs.org ([103.22.144.67]:53743 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751581AbeDIEXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 00:23:37 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 9 Apr 2018 14:22:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: James Morris <jmorris@namei.org>
Cc: David Howells <dhowells@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the scsi-mkp tree with the
 efi-lock-down tree
Message-ID: <20180409142237.66d3466d@canb.auug.org.au>
In-Reply-To: <alpine.LRH.2.21.1804091251380.14450@namei.org>
References: <20180315183412.01412755@canb.auug.org.au>
        <20180406092216.4579a70c@canb.auug.org.au>
        <20180409115831.46a351ef@canb.auug.org.au>
        <alpine.LRH.2.21.1804091251380.14450@namei.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9LDqH2mx.AKXO25C+_U5Mvw"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9LDqH2mx.AKXO25C+_U5Mvw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi James,

On Mon, 9 Apr 2018 12:51:53 +1000 (AEST) James Morris <jmorris@namei.org> w=
rote:
>
> That's odd, my next-general branch is merged to Linus.

The security tree in linux-next is

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git#ne=
xt-testing

which has the efi-lock-down tree merged into it.

--=20
Cheers,
Stephen Rothwell

--Sig_/9LDqH2mx.AKXO25C+_U5Mvw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrK6o0ACgkQAVBC80lX
0Gxongf/TjiC0Jrsie0haBTFa4kYo1QJDRv61VnyLH6qI8L0SX8UhViz7YX//9Pt
hXErIp7UjR/fNNen1Jw2+5Ho/u77jWw3gfgW5jDu8y7CoU6ForkjJ/H36gsliORp
093iqo/VNVUS3l9+fTfGfcbFsdOTMffkLXN77fHaj7OmIfXV+L5nJOp32Daa4EH6
8QlUPjcVfHpMWlSNG8iQzF8vr6OPopcYswTOtNAePW2ZZ/FGTf6oQv48AKD+f2im
YFaqzEjV2Qw1gWW6ZzYb6U+ga+/ji8CIJXPPDuZb4iFvTkgtcShV4LbvuXQhUM+T
tdctfIF7TKP4im/Xlgf56LYNyQxwZw==
=QUye
-----END PGP SIGNATURE-----

--Sig_/9LDqH2mx.AKXO25C+_U5Mvw--
