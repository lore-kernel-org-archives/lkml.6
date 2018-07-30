Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F366916256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FBF208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FBF208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbeG3TPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:15:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40672 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeG3TPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:15:46 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5DD2E805F3; Mon, 30 Jul 2018 19:39:41 +0200 (CEST)
Date:   Mon, 30 Jul 2018 19:39:40 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory,
 and IO v2
Message-ID: <20180730173940.GB881@amd>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180727220123.GB18879@amd>
 <20180730154035.GC4567@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <20180730154035.GC4567@cmpxchg.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-07-30 11:40:35, Johannes Weiner wrote:
> On Sat, Jul 28, 2018 at 12:01:23AM +0200, Pavel Machek wrote:
> > > 		How do you use this feature?
> > >=20
> > > A kernel with CONFIG_PSI=3Dy will create a /proc/pressure directory w=
ith
> > > 3 files: cpu, memory, and io. If using cgroup2, cgroups will also
> >=20
> > Could we get the config named CONFIG_PRESSURE to match /proc/pressure?
> > "PSI" is little too terse...
>=20
> I'd rather have the internal config symbol match the naming scheme in
> the code, where psi is a shorter, unique token as copmared to e.g.
> pressure, press, prsr, etc.

I'd do "pressure", really. Yes, psi is shorter, but I'd say that
length is not really important there.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltfTVwACgkQMOfwapXb+vIlkgCeK9KRUnDyKNk7tez2Mpwtukiw
uAMAn0ZpVKvSol9WKtgbznn5hShpYu+b
=iFrT
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
