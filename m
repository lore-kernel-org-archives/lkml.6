Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C086C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE0E20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE0E20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeKBGzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:55:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:48366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbeKBGzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:55:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 780C8AEF2;
        Thu,  1 Nov 2018 21:50:34 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     paulmck@linux.ibm.com, Josh Triplett <josh@joshtriplett.org>
Date:   Fri, 02 Nov 2018 08:50:11 +1100
Cc:     Mishi Choudhary <mishi@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an interpretation document
In-Reply-To: <20181101164544.GA31540@linux.ibm.com>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name> <20181021222608.GA24845@localhost> <875zxt919d.fsf@notabene.neil.brown.name> <20181024121622.GA10942@localhost> <87ftwt6850.fsf@notabene.neil.brown.name> <20181027011010.GA29769@localhost> <20181101164544.GA31540@linux.ibm.com>
Message-ID: <8736sk31t8.fsf@notabene.neil.brown.name>
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

On Thu, Nov 01 2018, Paul E. McKenney wrote:

> On Sat, Oct 27, 2018 at 02:10:10AM +0100, Josh Triplett wrote:
>> On Fri, Oct 26, 2018 at 08:14:51AM +1100, NeilBrown wrote:
>> > On Wed, Oct 24 2018, Josh Triplett wrote:
>> >=20
>> > > On Tue, Oct 23, 2018 at 07:26:06AM +1100, NeilBrown wrote:
>> > >> On Sun, Oct 21 2018, Josh Triplett wrote:
>> > >>=20
>> > >> > On Mon, Oct 22, 2018 at 08:20:11AM +1100, NeilBrown wrote:
>> > >> >> I call on you, Greg:
>> > >> >>  - to abandon this divisive attempt to impose a "Code of Conduct"
>> > >> >>  - to revert 8a104f8b5867c68
>> > >> >>  - to return to your core competence of building a great team ar=
ound
>> > >> >>    a great kernel
>> > >> >>=20
>> > >> >>  #Isupportreversion
>> > >> >>=20
>> > >> >> I call on the community to consider what *does* need to be said,=
 about
>> > >> >> conduct, to people outside the community and who have recently j=
oined.
>> > >> >> What is the document that you would have liked to have read as y=
ou were
>> > >> >> starting out?  It is all too long ago for me to remember clearly=
, and so
>> > >> >> much has changed.
>> > >> >
>> > >> > The document I would have liked to have read when starting out is
>> > >> > currently checked into the source tree in
>> > >> > Documentation/process/code-of-conduct.rst .
>> > >>=20
>> > >> I'm curious - what would you have gained by reading that document?
>> > >
>> > > I would have then had rather less of a pervasive feeling of "if I ma=
ke
>> > > even a single mistake I get made an example of in ways that will feed
>> > > people's quotes files for years to come".
>> >=20
>> > Thanks for your reply.  Certainly feeling safe is important, and having
>> > clear statements that the community values and promotes psychological
>> > safety is valuable.
>> >=20
>> > The old "code of conflict" said
>> >    If however, anyone feels personally abused, threatened, or otherwise
>> >    uncomfortable due to this process, that is not acceptable.=20
>> >=20
>> > would you have not found this a strong enough statement to ward off th=
at
>> > pervasive feeling?
>>=20
>> Not when that document started out effectively saying, in an elaborate
>> way, "code > people".
>
> Interesting.
>
> I am curious what leads you to your "code > people" statement.  Of course,
> one could argue that this does not really matter given that the code of
> conflict is no longer.  However, I would like to understand for future
> reference, if for no other reason.
>
> One possibility is that you are restricting the "people" to only those
> people directly contributing in one way or another.  But those using the
> kernel (both directly and indirectly) are important as well, and it is
> exactly this group that is served by "the most robust operating system
> kernel ever", the chest-beating sentiment notwithstanding.  Which is in
> fact why I must reject (or rework or whatever) any patch that might result
> in too-short RCU grace periods:  The needs of the patch's submitter are
> quite emphatically outweighed by the needs of the kernel's many users,
> and many of the various technical requirements and restrictions are in
> fact proxies for the needs of these users.
>
> But you knew that already.
>
> Similarly for the Linux kernel's various code-style strictures, which
> serve the surprisingly large group of people reading the kernel's code.
> Including the stricture that I most love to hate, which is the one
> stating that single-line do/for/if/while statements must not be enclosed
> in braces, which sometimes causes me trouble when inserting debug code,
> but which also makes more code fit into a window of a given size.  ;-)
>
> But you knew that already, too.
>
> The maintainability requirements can be argued to mostly serve the
> maintainers, but if the code becomes unmaintainable, future users
> will be inconvenienced, to say the least.  So even the maintainability
> requirements serve the kernel's many users.
>
> But you also knew that already.
>
> So what am I missing here?
>

Hi Paul,
 thanks for contributing your thoughts.  It is nice to have a new voice
 in the conversation, it helps me to maintain my illusion that this
 issue is relevant to the whole community.

 I cannot, of course, speak to why Josh wrote what he did, but I can
 give some insight into why I had no disagreement with that part of his
 statement.
 A key insight, worth your time to consider and unpack I think, is

      People won't care what you know, until they know that you care.

 I won't dwell on that here, but will make some more obviously relevant
 observations.

 Firstly, you gave an analytical response to what was, in my view, an
 emotional observation.  While I agree with your analysis, it is largely
 irrelevant.  It is not how people *feel* about kernel development.

 You say that the code of conflict is gone, but in fact much of it is
 preserved in the code-of-conduct-interpretation.  If you reflect on the
 focus of the second para of that document (which I think was directly
 lifted from the code-of-conflict) you will see that value is placed
 squarely on the code (kernel code, not code of conduct).  The code is
 put forward as the thing of primary importance.  People (you, me) are
 only mentioned in the context of being the authors of code that will be
 criticised  - because (it almost says this) we care about the code, but
 not about you.

 So I think it is beyond argument that the value system presented by
 this paragraph is
      code > people

 I think this is particularly unfortunate as it is not really how the
 community works, and not really how Linus works, except in those
 occasional outbursts that are publicised so much.

 I recall two specific events (there were probably others) from early in
 my Linux experience where Linus said/did things which said to me that
 he valued me, not just the code that I wrote.  I think he did that a
 lot (and probably still does).  As I knew that he "cared", I was much
 more interested in what he knew/thought.

 I think that the fact that Linus is now acknowledging every "pull"
 request is brilliant.  It doesn't really help the process much (we all
 have plenty of visibility into what Linus has pulled) and doesn't help
 the code (directly) at all.  But it tells people that Linus can see
 them, and has seen them.  It also allows people to see that they have
 an email from Linus without expecting it to be a criticism.  Certainly
 he still criticises and is right to do so, and he doesn't say "Pulled,
 thanks", which would be my preference, but the fact that he responds at
 least says "me responding to you matters" and by implication "you
 matter".

 (The code-of-conflict only acknowledged that you matter once you feel
 personally abused).
=20
Thanks,
NeilBrown


> 							Thanx, Paul
>
>>                       (Leaving aside that the more important detail
>> would be the community actually acting consistently with the code of
>> conduct it espoused.)
>>=20
>> > In the current code, would The "Our Pledge" section have been
>> > sufficient, or do you think the other sections would have actually
>> > helped you?
>>=20
>> "Our Standards" would have been at least as important to me personally,
>> as would "Enforcement" (and more importantly, examples of that applying
>> in practice and not just as empty words).
>> _______________________________________________
>> Ksummit-discuss mailing list
>> Ksummit-discuss@lists.linuxfoundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
>>=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvbdRoACgkQOeye3VZi
gbkVGw//S3rJD7QQBzMF/nJ7hpekYyo3Q4YlcA1GYucYy37p5muZV8sGTb7e2pmq
h6ZjIl/tQqjvIIeD+Yfm+2lq0vW2ez0RtnhHlO3AP9yza/fgp5t58ib72ZznKyuz
m7/5n9y8hsX2uAbZAp7s1hU+Xfv3Gu13RdbGLZh+n2wipSGdNABvfnLuRRUHIuCE
npAHjvX+SC44kDxa8AabZsu4Q9aVwFtBU7qfSJHRUDtrjh58yLIYJhQV7qnhEW/4
6Y0hrtFwlBvNt0qfN1ijHafT+nn/4hKvLUDPhRmElEtkcwUMKQYGKjrpn/bbYLY5
02va+l1upIBrGe7UnEi4dtigH0Q5xEO9FaQZVRF3pQqr3TYI7XRKT7AJ2THQFYl2
M+d7QFY7Pav3q2yvEyBZWhBzzPbGxHX5fLKKkz94xTvsTspV07kmbnKukRBUHthz
8nXKmXVRLYHIJxoXf+zjRn7yOlz8qnyOk0AAYmXy7d37iKoRQl278EOVX36upajy
OOcW55oT6/vhzHP4BPsX3OnOW2+HRcm9C0b2OaJS1q/9E3QrqP6MdOnNuHfFJ2Wp
Ag5ELpX/1KtKeoyCKRzInh0mCuwjHw1lnp5jMM3JPq89ztg1WxeoOhbBCP5PhR4Q
7XqmZIrS6psGRcX31BYoHxHl0C5iGE3Q3zE/xu/FV+ACsLTcSSo=
=jG0e
-----END PGP SIGNATURE-----
--=-=-=--
