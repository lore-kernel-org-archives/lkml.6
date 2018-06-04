Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeFDEPj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 00:15:39 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33808 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbeFDEPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 00:15:37 -0400
X-Google-Smtp-Source: ADUXVKLaa4e+7kbKBgbx/yqX3fdxrfokJXoHqcjEbxMAZJ+bx0KNOZV+9jDTCfi0BmtXgxkqRaUXmA==
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <CF1B7A14-3C16-4CD1-8274-C6A3E0065624@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_AC5195C5-C0C4-42EC-9BAB-4E0F5665B0FE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [lustre-devel] [PATCH] staging: lustre: delete the filesystem
 from the tree.
Date: Sun, 3 Jun 2018 22:15:31 -0600
In-Reply-To: <FE290581-D17D-4CEC-9AE2-B79DCBBD0823@gmail.com>
Cc: NeilBrown <neilb@suse.com>, Andreas Dilger <andreas.dilger@intel.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Oleg Drokin <oleg.drokin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        lustre-devel <lustre-devel@lists.lustre.org>
To: Alexey Lyashkov <alexey.lyashkov@gmail.com>
References: <20180601091133.GA27521@kroah.com>
 <20180601114151.GA25225@infradead.org>
 <E5BF8501-35EB-4DDF-ADBE-6016CF31A502@dilger.ca>
 <29ACF5A8-7608-46BB-8191-E3FEB77D0F24@cray.com>
 <87h8mmrt6b.fsf@notabene.neil.brown.name>
 <58123CDD-8424-4E1D-A11F-0F899970A49B@intel.com>
 <87h8mjp5o0.fsf@notabene.neil.brown.name>
 <FE290581-D17D-4CEC-9AE2-B79DCBBD0823@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_AC5195C5-C0C4-42EC-9BAB-4E0F5665B0FE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 3, 2018, at 9:59 PM, Alexey Lyashkov <alexey.lyashkov@gmail.com> =
wrote:
>=20
>> On Sun, Jun 03 2018, Dilger, Andreas wrote:
>>=20
>>> LNet is originally based on a high-performance networking stack =
called
>>> Portals (v3, http://www.cs.sandia.gov/Portals/), with additions for =
LNet
>>> routing to allow cross-network bridging.
>>>=20
>>> A critical part of LNet is that it is for RDMA and not packet-based
>>> messages.  Everything in Lustre is structured around RDMA.  Of =
course,
>>> RDMA is not possible with TCP
>=20
> To be clear. Soft IB (aka Soft RoCE) driver is part of OFED stack from =
4.8
> (or 4.9).  So RDMA API now is possible with TCP networks.

Well, strictly speaking RoCE still isn't possible with TCP networks.  =
RoCE v1
is an Ethernet layer protocol (not IP based), while RoCE v2 is UDP/IP =
based.

Cheers, Andreas






--Apple-Mail=_AC5195C5-C0C4-42EC-9BAB-4E0F5665B0FE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlsUvOMACgkQcqXauRfM
H+BjwxAAqy3yv1bQaQgs06nxm7BJHE0Yr0LS1sgRzPKWM66z8qKso73kRFhb6LYI
92LOfamEDBI5fk5qcVGKEUu34zVscbIj29Jn6wdAQSI5Xo4jEY+oWjAr5iOuN0kb
WLjDv6ZjdI/29jTe4Dns9O/RpS5knXRRoPDEjUg0j1c8+ls3g7/gTua/ybNqqiQN
qlXwONi2257ByJvAT1nY4Flj6ZRHVFSp5S2ZLIprG2s5FQoUspIgg5UMM41OUADd
9hzxTB485NCCzH7WgPtXU+BP2DjBI6HanitZtkORWFOOMiW3y1byNjBFSXyCeFq6
5kZtUGDyKC+aNrg+u4WyYk1AnM7Ufcz1H9EeZgAP8H8NtXcZ9nkl6XqnYwCsoyMs
BzyJ9gQjkO2m6Sy1DHDythmjzhMv/bkPapY9YDN4bRHMMnShBeUtu3aKqT3Tyvbt
B+3twkkwzsIEeRRIR+2+1eW6YhshnRgwsFg47YPsB7Mj3M6x0eK0GGCCTyo4G+tl
77mJhR4FI/Sb4cD6X3C8ul8Sdip8Zma5NUEv5NfceY8VV/Hiy7Uct+MXaJFIORRr
3pOo3KGqLmeSyNaADmuO6SCQXsYCjs024LT9pjDeJOKWbSlRxcfRaVgAXLAoWiLM
0wu9mCV+oz8iss1bMh8yJjkELWP1NvJBSfImEWsnxLMuWY8V/8Q=
=S8hY
-----END PGP SIGNATURE-----

--Apple-Mail=_AC5195C5-C0C4-42EC-9BAB-4E0F5665B0FE--
