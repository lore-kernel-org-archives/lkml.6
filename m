Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeDCOqc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:46:32 -0400
Received: from ozlabs.org ([103.22.144.67]:60731 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbeDCOqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:46:31 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 4 Apr 2018 00:45:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tejun Heo <tj@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux F2FS Dev Mailing List
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yufen Yu <yuyufen@huawei.com>, David Sterba <dsterba@suse.cz>
Subject: Re: [GIT PULL] f2fs update for 4.16-rc1
Message-ID: <20180404004509.4ec40d0d@canb.auug.org.au>
In-Reply-To: <20180403142029.GM388343@devbig577.frc2.facebook.com>
References: <20180130223220.GB65489@jaegeuk-macbookpro.roam.corp.google.com>
        <20180131095446.443670dc@canb.auug.org.au>
        <20180131002535.GD65489@jaegeuk-macbookpro.roam.corp.google.com>
        <20180201092551.759f32be@canb.auug.org.au>
        <20180314101704.51aaae7f@canb.auug.org.au>
        <20180403122919.3c503f74@canb.auug.org.au>
        <20180403142029.GM388343@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lQ0dANtEY6zun.ZHxgP.t.X"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lQ0dANtEY6zun.ZHxgP.t.X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

On Tue, 3 Apr 2018 07:20:29 -0700 Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Stephen.
>=20
> On Tue, Apr 03, 2018 at 12:29:19PM +1000, Stephen Rothwell wrote:
> > > I am still applying this to the merge of the btrfs tree every day ...
> > >=20
> > > Commit
> > >   578c647879f7 ("f2fs: implement cgroup writeback support")
> > > was merged into Linus' tree on Jan 31.
> > >=20
> > > Here is the actual merge fix patch: =20
>=20
> Yeah, the merge fix looks correct to me.  Depending on the merge
> order, it can go either after the btrfs merge or the f2fs merge, I
> guess.  Stephen, beyond appyling the merge fix afterwards, is there
> somethine else you are concerned about?

The f2fs part of the conflict was merged into Linus' tree on Jan 31,
and I have been applying the conflict resolution patch for a whole
release cycle i.e. the btrfs tree part of the conflict did not get
merged during the last merge window, and has not been updated since
then - in fact the btrfs tree
(git://git.kernel.org/pub/scm/linux/kernel/git/mason/linux-btrfs.git#next)
has not been updated or merged into Linus' tree since last December.

:-(
--=20
Cheers,
Stephen Rothwell

--Sig_/lQ0dANtEY6zun.ZHxgP.t.X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrDk3UACgkQAVBC80lX
0GwVNAf+Pf59wdhx47aU01ixtXFWMkYl9tJeqGxZ1Ce9iGQdZPv2CmiwoE6gqSwR
RUAa9YYfq71qg72dkUOds01Nz5DRFwJIKq4b4CWJhCRxEJAgmA5Mb5tKvIbyWXla
uRfCZT6O66rgYwrBUY+qq6XUKwc6hQ8Quzvdxf8s1EzV0wZxsJKZ/yVMMebsrFTP
WsiInyhR7tbwQu5exLAsP3YSiStzoaBFqH7874RlccXiaLw/gb5dJAJIGe8Zx0p1
65s8WJ6G/BhS1+KaJ0yYFumr2T6e1ugi0nydxEld4ifkpqRL8lizjmG1u33TnH5T
6k5Kzt6ID6BFKVBKUTkblwftZFBiTw==
=ptOT
-----END PGP SIGNATURE-----

--Sig_/lQ0dANtEY6zun.ZHxgP.t.X--
