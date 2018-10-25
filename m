Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39E8C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BE020834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oObn7p3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BE020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJYTv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:51:59 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:37454 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbeJYTv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:51:59 -0400
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 8B2E84BAEB;
        Thu, 25 Oct 2018 13:19:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-type:content-type:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received; s=
        mail20150812; t=1540466375; bh=/n8Za6I7DOREQuWpWOmVFx7fazGHYKF7w
        4mX4tZjkOw=; b=oObn7p3I10d4UEZnaYEtr03e4w316fkqa4kwvJ0wPqshC8d/u
        KdZT64XepXOaACCU+p4cT6uEDM5vMwxrm+G85bByVUL2XMK22v4XOMXhZYDG4hN5
        GZlW69BkcF2Jzsgz/Glepjl9p3Vs6b0r42Qz+87T76UA6GuxhkOSnDvVqoHZ7we7
        2IfEqVjBINiibjXcoupj/vDD+vsHniQ+7DP4mvg7GPvrb8svZv1O5ufPAR1MFuwf
        yc/ETW52/221wFPgyz9J+MOKFK4sknkCLoiK8j4dCWC9wNaf2gKGCbAuvZ7/617G
        E5HA0EgEXhup4yVHOi0+8qUInyuCEPe0T1EMw==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id ErS1VCihmAar; Thu, 25 Oct 2018 13:19:35 +0200 (CEST)
From:   Rainer Fiebig <jrf@mailbox.org>
To:     linux-kernel@vger.kernel.org
Cc:     NeilBrown <neil@brown.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an interpretation document
Date:   Thu, 25 Oct 2018 13:20:56 +0200
Message-ID: <2341648.lzjnUGKk1z@siriux>
In-Reply-To: <87y3ar80ac.fsf@notabene.neil.brown.name>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart42791249.HQLrouHPFn"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart42791249.HQLrouHPFn
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Am Montag, 22. Oktober 2018, 08:20:11 schrieb NeilBrown:
> On Sat, Oct 20 2018, Greg Kroah-Hartman wrote:
> > Hi all,
> >=20
> > As everyone knows by now, we added a new Code of Conduct to the ker=
nel
> > tree a few weeks ago.
>=20
> I wanted to stay detached from all this, but as remaining (publicly)
> silent might be seen (publicly) as acquiescing, I hereby declare that=
:
>    I reject, as illegitimate, this Code and the process by
>    which it is being "developed".
>=20
> It is clear from the surrounding discussions that this is well outsid=
e our
> core competencies.  It will be flawed, it isn't what we need.
>=20
> I call on any other community members who reject this process to say =
so,
> not to remain silent.
> #Iobject
>=20
> We don't need a "Code of Conduct" nearly as much as we need "Leadersh=
ip
> in conduct".  Without the leadership, any code looks like a joke.
>=20
[...]
=20
> I call on you, Greg:
>  - to abandon this divisive attempt to impose a "Code of Conduct"
>  - to revert 8a104f8b5867c68

Yes but this seems increasingly unlikely now. However, there may be an=20=

alternative.

Jugding by the release-message for 4.19, some people here are fans of=20=

Monty Python's. No wonder - as those guys are famous for being unrelent=
ing=20
supporters of Political Correctness.

So one would be on the safe side if one just supplemented "Our Pledge"=20=

with this:

=09"Everybody has the right to be offended."

I think, John Cleese would also welcome this.[1]

What do you think?

Regards!


Rainer Fiebig



[1] https://www.dailymail.co.uk/news/article-3427218/Political-correctn=
ess-killing-comedy-says-John-Cleese-Monty-Python-star-believes-fear-off=
ending-certain-groups-lead-1984-style-society-free-expression-not-allow=
ed.html


=2D-=20
The truth always turns out to be simpler than you thought.
Richard Feynman
--nextPart42791249.HQLrouHPFn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6yx5PjBNuGB2qJXG8OH3JiWK+PUFAlvRpxgACgkQ8OH3JiWK
+PWDjRAAzzl6KYxqqlSq+q5EgB3Uy4eLnj0xZJ3SEePGvtSWwf+k78ESTZ/sU7O2
gUGsEk+4F8N4CK0Y+J0Z5DrXdpCTu0shzojYdUmzE0unthzycVdlRbXdQd5UER0R
o6gpHfqbPvsGhtKNyj2oaqRzwnJNWsz16LW81fr0dLRZtg+9vlUulYz3nvyf6VQC
kHFIR//gRyyx37Loo1lpZBSBhd+MDi95wz7yWJWM9CGxR/MvEvjNGvpPSg6O/vof
FuQqCR5k4mVSU7NkcqBgMBPGVyzMivXEIYGvSDBOHa14NiBtpqcn0P2vBQ6jwBfX
LIO0sq2Crk91zyT7Mw32ru8CO/z3m1Pxyxs6QjZnTfLQoOdG6+sy/uSQgK0HS0aW
lF0LdaaGTnf8ngVmhmNpVdrQS/4MZAeaiUZSFs1skf11Gd/z8cdi2IvHInunWUxx
BOgOhlrMWA+sj4Gqxa9zchFvUQLDNAX2JZ4AJ1a8JXIDKpuEQhXs0eqWtRkXTgtU
qOTmuSVJ/LR0WjXvXumQhqZ2y3lNAz17pzVLcq5grik4dr8+XmSkY88Imi/laNE9
q+fpOQDaUEusmdshb5BnYxmgsA9keQE/XPEeLZUz/U6ywxHaxmo/0Y0hUOuWe9q1
/AL+tEOirMM6xLbeHjRru5MctlId9OEtN09n29coJxd9cLwoTYI=
=Yy1m
-----END PGP SIGNATURE-----

--nextPart42791249.HQLrouHPFn--

