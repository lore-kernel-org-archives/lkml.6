Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBC4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFE620866
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbeL1Ihx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 03:37:53 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45565 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730925AbeL1Ihw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 03:37:52 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id EF16480706; Fri, 28 Dec 2018 09:37:44 +0100 (CET)
Date:   Fri, 28 Dec 2018 09:37:49 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'John Hubbard' <jhubbard@nvidia.com>,
        "'john.hubbard@gmail.com'" <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        Tom Talpey <tom@talpey.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/2] put_user_page*(): start converting the call sites
Message-ID: <20181228083749.GC6341@amd>
References: <20181204001720.26138-1-jhubbard@nvidia.com>
 <b31c7b3359344e778fc525013eeece64@AcuMS.aculab.com>
 <cfba998a-8217-bf03-f0d0-c95708aea03d@nvidia.com>
 <e7cac96b06664c46bde3abe72ecab2ee@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <e7cac96b06664c46bde3abe72ecab2ee@AcuMS.aculab.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This "patch 0000" is not a commit message, as it never shows up in git =
log.
> > Each of the follow-up patches does have details about the changes it ma=
kes.
>=20
> I think you should still describe the change - at least in summary.
>=20
> The patch I looked at didn't really...
> IIRC it still referred to external links.
>=20
> > But maybe you are really asking for more background information, which I
> > should have added in this cover letter. Here's a start:
> >=20
> > https://lore.kernel.org/r/20181110085041.10071-1-jhubbard@nvidia.com
>=20
> Yes, but links go stale....

It should really explain what the end goal is... and not even the
20181110085041.10071-1-jhubbard@nvidia.com explains that.

It seems you are introducing small slowdown to simplify something...?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwl4N0ACgkQMOfwapXb+vKh7ACeJVdQzFocpewJi2c4F2t+if6H
56UAoL1qhPFQFE851+GkLtCwOWVQx1mC
=9WNe
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
