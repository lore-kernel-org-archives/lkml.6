Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A15AC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648A020663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648A020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbeJWFQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:16:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51846 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeJWFQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:16:14 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1257D806E8; Mon, 22 Oct 2018 22:56:02 +0200 (CEST)
Date:   Mon, 22 Oct 2018 22:56:03 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Meelis Roos <mroos@linux.ee>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 32-bit PTI with THP = userspace corruption
Message-ID: <20181022205603.GA13595@amd>
References: <20180830205527.dmemjwxfbwvkdzk2@suse.de>
 <alpine.LRH.2.21.1808310711380.17865@math.ut.ee>
 <20180831070722.wnulbbmillxkw7ke@suse.de>
 <alpine.DEB.2.21.1809081223450.1402@nanos.tec.linutronix.de>
 <20180911114927.gikd3uf3otxn2ekq@suse.de>
 <alpine.LRH.2.21.1809111454100.29433@math.ut.ee>
 <20180911121128.ikwptix6e4slvpt2@suse.de>
 <20180918140030.248afa21@alans-desktop>
 <20181021123745.GA26042@amd>
 <20181022075642.icowfdg3y5wcam63@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20181022075642.icowfdg3y5wcam63@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-10-22 09:56:42, Joerg Roedel wrote:
> On Sun, Oct 21, 2018 at 02:37:45PM +0200, Pavel Machek wrote:
> > On Tue 2018-09-18 14:00:30, Alan Cox wrote:
> > > There are pretty much no machines that don't support PAE and are still
> > > even vaguely able to boot a modern Linux kernel. The oddity is the
> > > Pentium-M but most distros shipped a hack to use PAE on the Pentium M
> > > anyway as it seems to work fine.
> >=20
> > I do have some AMD Geode here, in form of subnotebook. Definitely
> > newer then Pentium Ms, but no PAE...
>=20
> Are the AMD Geode chips affected by Meltdown?

Probably not.

I'm not saying this has meltdown/spectre etc. I'm just saying there
are relatively new machines without PAE.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvOOWMACgkQMOfwapXb+vKdnQCfQWRIYB0YVhUQy5x2lAKP3R7S
UCgAn1H9DxQwUf2iJyC1WampdF4XOkY2
=dtC3
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
