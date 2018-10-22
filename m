Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026F8C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4CF2087D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="i5gjVAN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4CF2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbeJVTVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:21:07 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51714 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728566AbeJVTVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:21:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 682BD8EE0FC;
        Mon, 22 Oct 2018 04:03:01 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oa0Bl0AIajDv; Mon, 22 Oct 2018 04:02:58 -0700 (PDT)
Received: from [172.22.37.2] (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id ABACF8EE0BA;
        Mon, 22 Oct 2018 04:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540206176;
        bh=GjVM4BKZaWGaLzXA3iUB2ADxoUyEfzeutLaE58W6RbE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=i5gjVAN8p9STjvVa/+2E4HIOOYeVQyrRBrzo+vwaanuIDV+KSN+Lxdl3bg4VSE1BW
         F+lA4d9gKJLnkfD2QhNUCnBCu3oM1zZktRTtgq9KtGQa4rrUWqDXp/ptRcZzffIdls
         x3tWPVakrpLr3Qap4nwrbGbamn3JkvyG1ja8DBUM=
Message-ID: <1540206166.2815.24.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of
 Conduct: Fix some wording, and add an interpretation document
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     NeilBrown <neil@brown.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
Date:   Mon, 22 Oct 2018 12:02:46 +0100
In-Reply-To: <87y3ar80ac.fsf@notabene.neil.brown.name>
References: <20181020134908.GA32218@kroah.com>
         <87y3ar80ac.fsf@notabene.neil.brown.name>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-TaFZnUKXD7/gTOc36swC"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TaFZnUKXD7/gTOc36swC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-10-22 at 08:20 +1100, NeilBrown wrote:
> On Sat, Oct 20 2018, Greg Kroah-Hartman wrote:
>=20
> > Hi all,
> >=20
> > As everyone knows by now, we added a new Code of Conduct to the
> > kernel tree a few weeks ago.
>=20
> I wanted to stay detached from all this, but as remaining (publicly)
> silent might be seen (publicly) as acquiescing, I hereby declare
> that:
>    I reject, as illegitimate, this Code and the process by
>    which it is being "developed".
>=20
> It is clear from the surrounding discussions that this is well
> outside our core competencies.  It will be flawed, it isn't what we
> need.
>=20
> I call on any other community members who reject this process to say
> so, not to remain silent.
> #Iobject

Well, I've got to say we really know how to screw up the process by
ramming this in at the last minute (again):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D8e630c31a3dfc7f4ab1007f95dd507cb2fe1dda5

So yes, I'll certainly object to our inability to follow an open process.

> We don't need a "Code of Conduct" nearly as much as we need
> "Leadership in conduct".  Without the leadership, any code looks like
> a joke.

I do think we need something in document form, though.  Not least
because we do have a perception problem which having a document helps
allay, mostly for external not internal perceptions.  As I've said
several times, we have  been steadily getting better thanks mostly to
internal people helping drive more civilised discussions and being more
helpful to new patch submitters.

I've also previously pointed out that I really like the debian code of
conduct:

https://www.debian.org/code_of_conduct

But now that I'm in Edinburgh, I had a conversation with Jeremy
Allison.  Apparently the Samba community went through almost exactly
the same thing as were going through now: attempt initially to impose
the contributor covenant followed by an acrimonious argument (done
mostly in private).  However, one interesting thing for us might be
their final endpoint:

https://wiki.samba.org/index.php/How_to_do_Samba:_Nicely

Which, like the debian document is a nicely engineered statement of
values which is specifically tailored to their community and needs.=20
The interesting thing is that eventually everyone in Samba agreed to
this, including the people who initially tried to impose the
contributor covenant.

James

--=-TaFZnUKXD7/gTOc36swC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCW82uVwAKCRDnQslM7pis
hdUkAQDR2/xJd4K6zkWwSHOs8PlnbjdF/oGSchnfVkrmoZJRXQD+Jh0Z8zISqLOO
NKMV7S3CKJnCTVuxK6LJ6JcD1j20XNM=
=vlsK
-----END PGP SIGNATURE-----

--=-TaFZnUKXD7/gTOc36swC--

