Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB78C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B4820871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B4820871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbeKLDiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 22:38:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:48384 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729222AbeKLDiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 22:38:05 -0500
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLtqw-0002SZ-8E; Sun, 11 Nov 2018 17:48:54 +0000
Date:   Sun, 11 Nov 2018 17:48:54 +0000
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Message-ID: <20181111174853.l2ixlz7rmh7lsfye@decadent.org.uk>
References: <lsq.1528380320.647747352@decadent.org.uk>
 <20180608141426.GA5242@roeck-us.net>
 <945ce3bb1ecd9c70249e79d2cb5572f9475c9786.camel@decadent.org.uk>
 <bf66aa7e856d4c2c83dc78dca95eee76437a1513.camel@decadent.org.uk>
 <20181111162343.GA15513@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gz6xazovl3mfmkua"
Content-Disposition: inline
In-Reply-To: <20181111162343.GA15513@roeck-us.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: Re: [PATCH 3.16 000/410] 3.16.57-rc1 review
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gz6xazovl3mfmkua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 11, 2018 at 08:23:43AM -0800, Guenter Roeck wrote:
> On Sun, Nov 11, 2018 at 12:09:03AM +0000, Ben Hutchings wrote:
> > On Sat, 2018-06-16 at 22:18 +0100, Ben Hutchings wrote:
> > > On Fri, 2018-06-08 at 07:14 -0700, Guenter Roeck wrote:
> > > > On Thu, Jun 07, 2018 at 03:05:20PM +0100, Ben Hutchings wrote:
> > > > > This is the start of the stable review cycle for the 3.16.57 rele=
ase.
> > > > > There are 410 patches in this series, which will be posted as res=
ponses
> > > > > to this one.  If anyone has any issues with these being applied, =
please
> > > > > let me know.
> > > > >=20
> > > > > Responses should be made by Thu Jun 14 18:00:00 UTC 2018.
> > > > > Anything received after that time might be too late.
> > > > >=20
> > > >=20
> > > > Build results:
> > > > 	total: 138 pass: 136 fail: 2
> > > > Failed builds:=20
> > > > 	i386:tools/perf=20
> > > > 	x86_64:tools/perf=20
> > > > Qemu test results:
> > > > 	total: 116 pass: 116 fail: 0
> > > >=20
> > > > tools/perf builds are new, so it is probably not entirely surprising
> > > > that they fail.
> > > >=20
> > > > Deetails are available at http://kerneltests.org/builders/.
> > >=20
> > > Thanks for testing.  I see you've now made the tools/perf builds work
> > > for 3.16, so thanks for that as well.
> >=20
> > I looked again and for the current patch queue I see:
> >=20
> >     Building i386:tools/perf ... failed (script) - skipping
> >=20
> >     Building x86_64:tools/perf ... failed (script) - skipping
> >=20
> > I can still build it here in a Debian jessie environment though.
> >=20
> I re-enabled it, but now it fails. Let me know if you want to try to fix
> it. Probably something with out-of-tree build - I didn't try to find
> the reason.

Thanks.  I can reproduce the failure when building in Debian unstable,
and am working through fixing the problems.

Ben.

> Please ignore the arm qemu failures - I restructured the tests, and need
> to make some fixes.
>=20
> Guenter

--=20
Ben Hutchings
Humans are not rational beings; they are rationalising beings.

--gz6xazovl3mfmkua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlvoa4UACgkQ57/I7JWG
EQkigBAAoGGQ1uR+4QS9Ac82AztY8kyDMTjgQdxJpjhZUJVUcKsR7/rIKG/e28sL
7FuCZvpsiZSMYvsD8y3dr+vocJCDkMUVgbRWsLO7zDgm2AG8LPsl6YZJstD4B0/U
pG+qtMjjftmf3kj0NZA5T8sGiq1Sbo5861Upn6nhzi14cmlUvAYYnUYvVe+ZN+kx
zLm9H8W/6Ni7VwibwGsMATUMLn7SkK7tCHAyB/n0g6bvlKXH7+vJ6dJSY955WnVG
rlE8OYFxOUrIU7XXB3N0naW3Ahinm2oQx6JYw0JhKHJplOkNcP/BPII+iHWfkW5u
uQjFIgQGy4pQ0fQxKJs7J5WzZVLyqiB/YHACySk8Iv767LzgCSXrNmnRQk9GpBjy
yIaboYB4HWK9yPChPnKQuM37f7spBJL/W80UTSaqloxl+f5ymqZWxjFEQy8HtodC
JE9CDhfFH6OfkA6+dezbt1/Uoc9QnK0s3VVsG64WFBqmZvaYdiOmpvrxAF+O8NJS
TS9TERlVinrR380anhdLNgF/S4QMJbOXabtKAHUJ6OXrW8ALSSRVPgakDN4SBQvi
h/+rNfy93DdePoc2GP4woGaiYWyjoavOJqndRHqQ9sAfb5FDJ0dK7Wqw3Q3QHPZg
+yWR+BCe7N4kRnjcQGAW2Jr9TonI9xYs6FV1w3b0UJtJo6EkOCM=
=SccA
-----END PGP SIGNATURE-----

--gz6xazovl3mfmkua--
