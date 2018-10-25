Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2939C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABDF20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABDF20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeJZHf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:35:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:39642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727418AbeJZHfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:35:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DDC77AEC2;
        Thu, 25 Oct 2018 23:00:48 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     esr@thyrsus.com
Date:   Fri, 26 Oct 2018 09:52:42 +1100
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        visionsofalice@redchan.it,
        linux-kernel <linux-kernel@vger.kernel.org>, rms@gnu.org,
        bruce@perens.com, moglen@columbia.edu, bkuhn@sfconservancy.org,
        editor@lwn.net, Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: The linux devs can rescind their license grant.
In-Reply-To: <20181025223813.GA5137@thyrsus.com>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name> <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com> <185b786a2bd6e8d527dca161dc42e4f1@redchan.it> <20181025081911.GB11343@kroah.com> <20181025193901.GD26403@thyrsus.com> <20181025204718.GB25649@thunk.org> <20181025214123.GA2448@thyrsus.com> <87a7n165h6.fsf@notabene.neil.brown.name> <20181025223813.GA5137@thyrsus.com>
Message-ID: <871s8d63lx.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25 2018, Eric S. Raymond wrote:

> NeilBrown <neil@brown.name>:
>> I think you are blurring two groups here.
>> Ted describes "anti-CoC dissidents" as people who are advancing an
>> argument about rescinding their license.  This is a smaller groups than
>> the "ant-CoC camp" who don't really like the CoC.  I suspect is it is a
>> much smaller group when restricting to actual copyright holders.
>
> You may be right that these are semi-distinct groups.  I don't think
> the distinction makes a lot of difference to my argument, though.
> Either way, (a) there's been a process failure by the leadership, and
> (b) the threat of a massive legal disruption is real.
>
>> I am against the CoC as it stands, but rescinding any license is such an
>> enormous over-reaction, I find the concept laughable.
>
> I'm...not sure I do.  I was going to agree with you that it's a
> massive overreaction, but then a simple question occurred to me: what
> else could *I* do if I thought I had a significant stake (I don't; my
> kernel contributions are minor and old) and felt my interests were
> damaged?

Reasonable people can certainly see this issue differently.
My perspective is that I have already gained so much benefit in return
for my investment that this is little more than a rounding error.  If
something happened that really did threaten the value of my investment,
I'm sure there would be so many others who thought so too, that we would be
able to fork the community.

>
> All this could have been avoided so easily. A felt need for a new Code
> should not have been followed by the immediate imposition of one,
> but by a public RFC process and consensus-building - a process in which
> even those who lost arguments about the construction of the code could
> know they had been heard.

I do agree about the process failure.  The "immediate imposition" was
unnecessary and (I think) harmful.

Thanks,
NeilBrown


> --=20
> 		<a href=3D"http://www.catb.org/~esr/">Eric S. Raymond</a>
>
> My work is funded by the Internet Civil Engineering Institute: https://ic=
ei.org
> Please visit their site and donate: the civilization you save might be yo=
ur own.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvSSToACgkQOeye3VZi
gbljkhAAqm1TupWfL4DmgMZHocR0/d3O7zDBvYA7ZozB9Btxs9sLLgXHSqGpqTH0
rnna7YxYCkj1dacMIdGufQoW+VRYadB+5D15LGFXZ8EMqGAC3N760gmaC/SYvbgN
Dltij4OaJDzvsIkgs+czC+w55t7kuADyjloG6Ahr4vJLp3N+KVO8wRvNdC0zy67x
xv1AoCpjIT48xxkkwCrXE+F6IzhIr9tHbAWuXCzd8xWqvGRlcj3ozGw/wynO3J3k
k5bMfOICQ5JE001TzGzZ77xyxuXUtXdN9UXFDCZr2nS77Be0A9IIJ7P+Sl3//PR+
EQQ181syZvXBnGf6j0wyP09wdBE10KsqdlWn7Kq+1xtysoZWnCWmHyf5c8ETTWxe
WhO28QoHKDUoC6lkzO7b2A0TuO2BRoV2EorzizhZ8orBRTfDbviEGW+HrxlsI3Th
r2Pn/4PRO1voIfrNLRTlFgz70QnEFjay71iq4bTOiMYPb90UeEydlg+8fiar/CVe
AGRIrX9Oozw5LIxsBHxgvZhGL2hXz7rNQH47cEjTl/fJFoq3COWoKuhKUeJjozRA
XmUzJExR79ASQTG0oVAMHBA8VSv70Ts0QJBRJuelCWGCSdHo2rIAQeN8qL9uzVz5
tSsb1iztgZ5X/aC/4OGW1un8lRTFVhWXqBD527UjXglvZKPZkog=
=BHvC
-----END PGP SIGNATURE-----
--=-=-=--
