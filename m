Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3B4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F40322527
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPM4MHzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F40322527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeKPFoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:44:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbeKPFo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:44:29 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C04782086C;
        Thu, 15 Nov 2018 19:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542310521;
        bh=X0mFYWDX4Ojpedse/Ut04nC5pZGn/BXcr+dRghorOKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bPM4MHzDdswlqnI9YpUZrFizPA5/+a4/CLp5iD1d3ogI8MK91Va/nnV9KYfhpTyu5
         3rI+uVSy7v/3OjuC4PWr0i+j5iUzrf3b2apc0wkXq6lUd/Fagp25Blmu10e3qWp0QO
         d8nq9w+9tRO+uxcgqVCNmvhoLNxM9TvQ9wGohFfo=
Date:   Thu, 15 Nov 2018 21:35:20 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        vishal.l.verma@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zwisler@kernel.org
Subject: Re: [Ksummit-discuss] [RFC PATCH 3/3] libnvdimm, MAINTAINERS:
 Subsystem Profile
Message-ID: <20181115193520.GA24359@mtr-leonro.mtl.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAMuHMdVOJsM=66RrnbOzVthsT9=dFRQtL2rv99tCPC02M=hiXw@mail.gmail.com>
 <20181115061036.1575223d@silica.lan>
 <20181115162008.GO3759@mtr-leonro.mtl.com>
 <20181115110919.46978343@silica.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20181115110919.46978343@silica.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 11:09:34AM -0800, Mauro Carvalho Chehab wrote:
> Em Thu, 15 Nov 2018 18:20:08 +0200
> Leon Romanovsky <leon@kernel.org> escreveu:
>
> > On Thu, Nov 15, 2018 at 06:10:36AM -0800, Mauro Carvalho Chehab wrote:
> > > Em Thu, 15 Nov 2018 09:03:11 +0100
> > > Geert Uytterhoeven <geert@linux-m68k.org> escreveu:
> > >
> > > > Hi Dan,
> > > >
> > > > On Thu, Nov 15, 2018 at 6:06 AM Dan Williams <dan.j.williams@intel.=
com> wrote:
> > > > > Document the basic policies of the libnvdimm subsystem and provid=
e a
> > > > > first example of a Subsystem Profile for others to duplicate and =
edit.
> > > > >
> > > > > Cc: Ross Zwisler <zwisler@kernel.org>
> > > > > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > > > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > >
> > > > Thanks for your patch!
> > > >
> > > > > --- /dev/null
> > > > > +++ b/Documentation/nvdimm/subsystem-profile.rst
> > > >
> > > > > +Trusted Reviewers
> > > > > +-----------------
> > > > > +Johannes Thumshirn
> > > > > +Toshi Kani
> > > > > +Jeff Moyer
> > > > > +Robert Elliott
> > > >
> > > > Don't you want to add email addresses?
> > > > Only the first one is listed in MAINTAINERS.
> > >
> > > IMO, it makes sense to have their e-mails here, in a way that it could
> > > easily be parsed by get_maintainers.pl.
> >
> > I personally think that list of "trusted reviewers" makes more harm than
> > good. It creates unneeded negative feelings to those who wanted to be in
> > this list, but for any reason they don't. Those reviewers will feel
> > "untrusted".
>
> Yeah, perhaps something like "most active reviewers" would sound
> better.

I would recommend to remove this section at all.
New maintainers won't come out of blue, but will be come
=66rom existing community and such individuals for sure will see
and judge by themselves to whom they trust and to whom not.

Thanks

>
> Cheers,
> Mauro

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJb7cp4AAoJEORje4g2clinjWwQAK++V4yQRc853j590uHyWtZI
yBJabMYXfdKMh6mjP7T81EokNT7A9rMcdENkd9F2WV3NGBmAllNl66an+M6CYxTs
ztPhhSGS1SqiO2Mm1yTTcvWHGsrnv/CDqGbWOOGfkx6632dbpPs5+2Dn0U3573al
+7T4Csuh3zTcoXpWkJedl2S2M16462CqTITdbzg5JAtHoGsvftHYzmowBmU5v8+8
9Ohn78v1nFxtR0eE5JFy7N+9w06CN+jfR2ykLp0t7jvolPp0h3rHgz9/PRvHjoBz
4yRnX4S9fyhtXIaMjPNdbxQz6J3I1b+0KdD4ALV8wN0oKr9fzs+44PZgnvfOYqaK
aLl60cUd3WgYhOsKNAHRh701x6oM5AereltDw1hyDnI8EHoGF/Q0E3nwHxpkqd3g
5iSjFfz2CuJy3CNM32OEVYkbOMvQ3JbnwE2tYQARt30MNlflGVbd7wgYi9fn+WWz
ttgGU2Jc5Q6djnPBaqtHF8uOZ/FSdrRHXx6QFL1sttb2wtuYCY78DPLSBkfbYc+2
+zTNhJnxSuMkfA2OizKg8jRBYBNTm10FteX70AENnIQ9nI/g6/McEnxwKH2L76BY
e7D52h4YoU/Faayjzds/13gjFPSueGw7XNP/8GyBmEzw8y/9WZty1sNhH9nGyvDd
wcBfMJH6iX9J4zDddBdT
=eIEo
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
