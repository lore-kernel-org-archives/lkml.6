Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeDQKDJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 06:03:09 -0400
Received: from ozlabs.org ([203.11.71.1]:38379 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751927AbeDQKDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 06:03:08 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 17 Apr 2018 20:01:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Howells <dhowells@redhat.com>
Cc: Jessica Yu <jeyu@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: linux-next: manual merge of the efi-lock-down tree with the
 modules tree
Message-ID: <20180417200142.6eb2c629@canb.auug.org.au>
In-Reply-To: <25950.1523951172@warthog.procyon.org.uk>
References: <20180417113218.4e6ba307@canb.auug.org.au>
        <25950.1523951172@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gkaOe9cMOGfEGdBt03gB5iK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gkaOe9cMOGfEGdBt03gB5iK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, 17 Apr 2018 08:46:12 +0100 David Howells <dhowells@redhat.com> wrot=
e:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
> > Today's linux-next merge of the efi-lock-down tree got a conflict in: =
=20
>=20
> Can you drop my branch for the moment?

Sure, no problem.  Just let me know when to grab it again.

--=20
Cheers,
Stephen Rothwell

--Sig_/gkaOe9cMOGfEGdBt03gB5iK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrVxgYACgkQAVBC80lX
0GzRcQf/a3OnaBT495zp6dZKXzqp8K6VIre+sq+SujLr1afZPv2FLxqS6fjKPgQv
JixVKrBZm9N5Lh3CSxYSE6h5pdKf6fPtUJbCLZG1ddSeihVdPy6QV0UmQltO4MAl
axfTinalUg+OYEuBp5yLKoUFryWfFNLMAIP9uxWzyiX/9S9BPmF4adXY/dya56IH
F049Lq7EjKMz8tAnALkyjCy3adz8isouKN+9xp/B8/GTEFBiNNLnUFbL1eahDKei
j53CsGRx+wiAgjbQgtQLqUnN1KJDx4EPl+6k5iCfrs4KBEjkkF37HSUIAXHc7GAF
sECPG+4MSmfYY7ROs0/DoHKzKiytZA==
=+/HC
-----END PGP SIGNATURE-----

--Sig_/gkaOe9cMOGfEGdBt03gB5iK--
