Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819B1FC6122
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433BF205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433BF205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbeG3Tfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:35:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41273 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeG3Tfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:35:47 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B808D80616; Mon, 30 Jul 2018 19:59:36 +0200 (CEST)
Date:   Mon, 30 Jul 2018 19:59:36 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory,
 and IO v2
Message-ID: <20180730175936.GA2416@amd>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180727220123.GB18879@amd>
 <20180730154035.GC4567@cmpxchg.org>
 <20180730173940.GB881@amd>
 <20180730175120.GJ1206094@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20180730175120.GJ1206094@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-07-30 10:51:20, Tejun Heo wrote:
> Hello,
>=20
> On Mon, Jul 30, 2018 at 07:39:40PM +0200, Pavel Machek wrote:
> > > I'd rather have the internal config symbol match the naming scheme in
> > > the code, where psi is a shorter, unique token as copmared to e.g.
> > > pressure, press, prsr, etc.
> >=20
> > I'd do "pressure", really. Yes, psi is shorter, but I'd say that
> > length is not really important there.
>=20
> This is an extreme bikeshedding without any relevance.  You can make
> suggestions but please lay it to the rest.  There isn't any general
> consensus against the current name and you're just trying to push your
> favorite name without proper justifications after contributing nothing
> to the project.  Please stop.

Its true I have no interest in psi. But I'm trying to use same kernel
you are trying to "improve" and I was confused enough by seing
"CONFIG_PSI". And yes, my association was "pounds per square inch" and
"what is it doing here".

So I'm asking you to change the name.

USB is well known acronym, so it is okay to have CONFIG_USB. PSI is
also well known -- but means something else.

And the code kind-of acknowledges that acronym is unknown, by having
/proc/pressure.

So please just fix it.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltfUggACgkQMOfwapXb+vKAvgCfQE/kZZxaNG37MoP55aHmHCeO
XIEAn0L3Iqd7uuiqMrYzFwuLGN0MMs/N
=bq/s
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
