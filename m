Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35C2C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3F42083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3F42083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeJZGrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:47:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:33518 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbeJZGrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:47:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77E19B0CD;
        Thu, 25 Oct 2018 22:12:33 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     esr@thyrsus.com, "Theodore Y. Ts'o" <tytso@mit.edu>,
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
Date:   Fri, 26 Oct 2018 09:12:21 +1100
Subject: Re: The linux devs can rescind their license grant.
In-Reply-To: <20181025214123.GA2448@thyrsus.com>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name> <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com> <185b786a2bd6e8d527dca161dc42e4f1@redchan.it> <20181025081911.GB11343@kroah.com> <20181025193901.GD26403@thyrsus.com> <20181025204718.GB25649@thunk.org> <20181025214123.GA2448@thyrsus.com>
Message-ID: <87a7n165h6.fsf@notabene.neil.brown.name>
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

> Theodore Y. Ts'o <tytso@mit.edu>:
>> On Thu, Oct 25, 2018 at 03:39:01PM -0400, Eric S. Raymond wrote:
>> > Under Jacobsen vs. Katzer (535 f 3d 1373 fed cir 2008) authors of
>> > GPLed software have a specific right to relief (including injunctive
>> > relief) against misappropriation of their software. That ruling (which
>> > was the case of first impression on the binding status of the GPL)
>> > reputational damage is *specifically* recognized as grounds for relief.
>>=20
>> I've read the legal briefs, and I'm pretty sure they don't say what
>> you are claiming they say.  Yes, I'm not a lawyer --- but that's OK
>> --- neither are you.
>
> How much are you willing to gamble on not being wrong?
>
>> The *vast* majority of the "anti-CoC dissidents" who have been
>> advancing this argument, have, as near as I can tell, little or no
>> copyright ownership in the kernel.
>
> I do not have any facts with which to dispute this specific claim.
> However, I do notice that a significant number of long-time
> contributors have put themselves in the anti-CoC camp. I note Al Viro
> as a recent example.

I think you are blurring two groups here.
Ted describes "anti-CoC dissidents" as people who are advancing an
argument about rescinding their license.  This is a smaller groups than
the "ant-CoC camp" who don't really like the CoC.  I suspect is it is a
much smaller group when restricting to actual copyright holders.

I am against the CoC as it stands, but rescinding any license is such an
enormous over-reaction, I find the concept laughable.

NeilBrown


>
> Even supposing you are right about most of the anti-Coc people being
> outsiders, a tiny minority of people with a genuine IP stake could do a
> lot of damage.  I ask again: how much are you willing to gamble on not
> being wrong?
>
> I definitely do not want to see the kind of explosion we could witness.
> I think you are making it more likely rather than less by appearing
> high-handed and dismissive.   Because, whatever the merits of the
> CoC itself, there has been a process failure here.  It doesn't look
> good to be defending that failure.
>
> A change like the CoC adoption was not a good thing to do without
> proper public notice, discussion, and consensus-building *beforehand*.
> This was an unforced error on the part of the leadership group;
> please, *please* don't compound it by digging in around the error.  Do
> you really think you're going to win hearts and minds among insider
> dissidents - people with a genuine stake - by dismissing the
> opposition as a troll job?
>
> Instead of declaiming about "trolls", how about we fix the process
> failure instead?
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

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvSP8UACgkQOeye3VZi
gbnBgg//YXyTrRXBoJyJ2fTlvsnSfCK5x4sGdV3Ni/kQ/XVL7A9SjO5ZGgWrZNc3
HYkAq7Gq4eYBYPB7guAEhnMsX8ctjUf/ryYn/IkXmJ7YrSdzzZrME0q2TVDjoDnZ
27+l5avDrJVdrUIOYKZOdati2mC4s7eZRegAodIa6JPbYYkQOvckWDqLb0DzFHMj
bZSWIevDbEG3VOOirAnY/6pUIJEseYyC5mmHefIi3kM1lP6Tm1ANEuhn0xj7yy4d
0JfdpdaZH7iwABC672nOFRACgx+u7eHVUCRwHjPrkGIEYCkYlpOCe3QFlqZIPJgw
03vhgQLsdKrm2gT44usGYI2IXN5IlQ7sv8fULc0BbPLnLT7O94Js5hGpyrbiINnq
7DS04c9EZC8pSx3+rEqoFmqKo0MLJcaaBOXiIkPX4njeTbkxPgnyB7Xp/7HWycrj
yqKTYmFCG6cFNDz/O7YVT1baCpNF4I8iYpRIXvSCisC/pXx2ZIYDfZwuBYWcbqDc
+f+vl8/ifdLB2pLLex3gTN+soBFQVX0V+0nXeWFqtkdaT2IML4uig+J7b1t94a56
4XLNGLdS3q1J62hk8T3GJsZ8YUSBUli91Ux2v0Do18CLjM5gParf4glZwavl9L0Y
tt8kooluX5EMsCRcqsYWzcbCyTZJ2r3ek7V+R3ZAcnvW7n1HqQ4=
=0+s7
-----END PGP SIGNATURE-----
--=-=-=--
