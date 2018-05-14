Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbeENMkk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:40:40 -0400
Received: from ozlabs.org ([203.11.71.1]:49301 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752011AbeENMki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:40:38 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 14 May 2018 22:40:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>
Subject: Re: linux-next: Tree for May 14
Message-ID: <20180514224006.06827f71@canb.auug.org.au>
In-Reply-To: <CAHp75Vfs_Za5d8YLJ5FNJDmytRJE-P+q_Kds9V+ivBGy3v+p8g@mail.gmail.com>
References: <20180514172042.093bd880@canb.auug.org.au>
        <CAHp75Vfs_Za5d8YLJ5FNJDmytRJE-P+q_Kds9V+ivBGy3v+p8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/HLu2GBtwTdRzKUVWCtipxYB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HLu2GBtwTdRzKUVWCtipxYB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, 14 May 2018 10:26:07 +0300 Andy Shevchenko <andy.shevchenko@gmail.c=
om> wrote:
>
> Hmm... It seems my message was buried in the pile of the thread WRT
> fixes branches.

No, I just didn't read enough email early enough this morning.

> Please, add our PDx86 fixes branch as well:
> git://git.infradead.org/linux-platform-drivers-x86.git fixes

Added from tomorrow (called drivers-x86-fixes).

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

BTW, the drivers-x86 tree I have is

https://github.com/dvhart/linux-pdx86.git#for-next

and the contact is Darren Hart.  Is that expected?
--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/HLu2GBtwTdRzKUVWCtipxYB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr5g6YACgkQAVBC80lX
0GyEFgf+MwlBVSThFGIEcxXS73pJy10rOmY3u8zFWHxEwSgJ3pwlPne/QHpXpfBa
WBR5rb6TWkVM1gyVtwiceuQAVMDLNq0hNsvvZfk9OfWFcp1nxeD25U6A8HafFJR6
CvKrst6kKTMC9QZ6NEj7sJZHHmXIVl2JSBy0PsO8gfW3KUXzVueml6Z+2lult9PZ
n7cUZFAb9iAcfd/3DWrcxSAh53/OT1bwfd/yYNlrEJdoZxl3iK64Gz5BAYUL3B3V
/fRkiuPf1DKbPWrueVsc1ArWGjJkdLj/Hrxt1vkHFOXG52AaiBavfySQGakTQreG
acQq40RgTssB5UvHf7h+R+GzsMIvEg==
=ItA6
-----END PGP SIGNATURE-----

--Sig_/HLu2GBtwTdRzKUVWCtipxYB--
