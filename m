Return-Path: <sfr@canb.auug.org.au>
X-Google-Smtp-Source: AG47ELuWGL/t+v/a6qi1wrlpH5kzzW7zi41tvryrjyN/RFJq//kZgSReRWKPJMowV9Z5HParqBfU
ARC-Seal: i=1; a=rsa-sha256; t=1521628743; cv=none;
        d=google.com; s=arc-20160816;
        b=mZ3ArL9kVZ1aKbuL24kOG+lUsKmUENo+m9SjBx6l1fnOHXJ9EZXNaE8z2g0fjBCGEg
         zd90YJu0pXHz/RCwT72KRvVx8vv7elM4+jksOOF8v9tH4T/gGVadXZZBDfShjcZgwxSI
         leYCGPAKHxLlt+hXzBrCa9t2kZ/WdOVZrE4olodieuMpbpsBFJ6b9jjwF8rodkkOHpub
         mtFNLi/AoNvXcMAs39xl4mYRbcrmgudWUEtFRyyJin0zLMujRhjMRJ4qBk5zFU01kuFZ
         YdLfAk80/3YYuiTCO9MjwbIdndxOx7DlJIvTETeZJJcpIUSbkooEFl+omv5Tp84ISy8S
         9Dcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:dkim-signature:arc-authentication-results;
        bh=sCqlU0vHSQBXCUExV/exPvmEtXYfQTimLdExv1/E034=;
        b=BWf1xX1ouLz3wNymF3Sd/piHUl6E1PnK+5ZrUe/elJ1SGQaZOlO5u7FA6rCo2xIM6R
         ARE6E26KxgM6Wl/0m3iF9Ypasof4dlw69LlMWB1Srix32fufba9VgyUT9jzpI2pXADgD
         fi0ztKRpon7Rj0RBPfJsAj4zu4k+mDDYpmqHYaiWeZyoR2pgGSgG1Lx74ilEbPuxo1BI
         liZBmgQNFfuvGCONDDILYsnf//yQ4uFx9iDD6uuzB1BXS4v2kkRMFqlGbwSQzySm/nOi
         sfHYRcxh7oOXUd1I3lJUtkrdm2W4lY8vARUl2wKLNmf4rlBpHA4/m3UNAkNqt1pRlvNK
         leEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@canb.auug.org.au header.s=201702 header.b=Ang1Dl0h;
       spf=pass (google.com: domain of sfr@canb.auug.org.au designates 2401:3900:2:1::2 as permitted sender) smtp.mailfrom=sfr@canb.auug.org.au
Authentication-Results: mx.google.com;
       dkim=pass header.i=@canb.auug.org.au header.s=201702 header.b=Ang1Dl0h;
       spf=pass (google.com: domain of sfr@canb.auug.org.au designates 2401:3900:2:1::2 as permitted sender) smtp.mailfrom=sfr@canb.auug.org.au
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 21 Mar 2018 21:38:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-Next Mailing List
 <linux-next@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: build failure after merge of the akpm tree
Message-ID: <20180321213822.31f8c0c8@canb.auug.org.au>
In-Reply-To: <20180321100208.GA18281@kroah.com>
References: <20180321191727.4d421df3@canb.auug.org.au>
	<20180321100208.GA18281@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3WvXyeN2DsCsY8ydzGIVpN0"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595534562081381621?=
X-GMAIL-MSGID: =?utf-8?q?1595543381068996457?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/3WvXyeN2DsCsY8ydzGIVpN0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, 21 Mar 2018 11:02:08 +0100 Greg Kroah-Hartman <gregkh@linuxfoundati=
on.org> wrote:
>
> Patch is now queued up, thanks.

Excellent.

--=20
Cheers,
Stephen Rothwell

--Sig_/3WvXyeN2DsCsY8ydzGIVpN0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqyNh4ACgkQAVBC80lX
0GwUjQf/fqv5gWqizAo2LJFX2g+3obauUPYG77/OBJsKnYo5nM4h0ttDZNZpVQFU
YsYSrrlZe3d96O4psV/C5hFNKc7je9aQeNhuV4UnROFyjWCOjoM/f5qiShsUtGBU
78sw6SZNLNjbi2EIJ0XN4e+y6X8o7ZSX0+pX0G9ENQYaLKwFPFprdFLPTvqc7S9/
1VymLhyBZB0zY8HKSBdVlwF3KVp92ycvhia8R8K+rMR2HzvrsQDK15/c8IHHyYQA
1jh4uucdivennLw4Dxc+1OB49YiJz27kaemOHWbukTX6xybgTt0zBPdJdM0AYOI/
N+p4hF0vXsFB5W0JzwIDhE0h/UASCA==
=GqTN
-----END PGP SIGNATURE-----

--Sig_/3WvXyeN2DsCsY8ydzGIVpN0--
