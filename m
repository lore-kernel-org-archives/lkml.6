Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DE6C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 08:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2532081F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 08:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2532081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeKCRrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 13:47:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:41108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726290AbeKCRrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 13:47:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69F6BAC1F;
        Sat,  3 Nov 2018 08:36:27 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     paulmck@linux.ibm.com
Date:   Sat, 03 Nov 2018 19:36:19 +1100
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Mishi Choudhary <mishi@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an interpretation document
In-Reply-To: <20181102133309.GQ4170@linux.ibm.com>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name> <20181021222608.GA24845@localhost> <875zxt919d.fsf@notabene.neil.brown.name> <20181024121622.GA10942@localhost> <87ftwt6850.fsf@notabene.neil.brown.name> <20181027011010.GA29769@localhost> <20181101164544.GA31540@linux.ibm.com> <8736sk31t8.fsf@notabene.neil.brown.name> <20181102133309.GQ4170@linux.ibm.com>
Message-ID: <87lg6a1rss.fsf@notabene.neil.brown.name>
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

On Fri, Nov 02 2018, Paul E. McKenney wrote:

> On Fri, Nov 02, 2018 at 08:50:11AM +1100, NeilBrown wrote:
>> On Thu, Nov 01 2018, Paul E. McKenney wrote:
>>=20
>> > On Sat, Oct 27, 2018 at 02:10:10AM +0100, Josh Triplett wrote:
>> >> On Fri, Oct 26, 2018 at 08:14:51AM +1100, NeilBrown wrote:
>> >> > On Wed, Oct 24 2018, Josh Triplett wrote:
>> >> >=20
>> >> > > On Tue, Oct 23, 2018 at 07:26:06AM +1100, NeilBrown wrote:
>> >> > >> On Sun, Oct 21 2018, Josh Triplett wrote:
>> >> > >>=20
>> >> > >> > On Mon, Oct 22, 2018 at 08:20:11AM +1100, NeilBrown wrote:
>> >> > >> >> I call on you, Greg:
>> >> > >> >>  - to abandon this divisive attempt to impose a "Code of Cond=
uct"
>> >> > >> >>  - to revert 8a104f8b5867c68
>> >> > >> >>  - to return to your core competence of building a great team=
 around
>> >> > >> >>    a great kernel
>> >> > >> >>=20
>> >> > >> >>  #Isupportreversion
>> >> > >> >>=20
>> >> > >> >> I call on the community to consider what *does* need to be sa=
id, about
>> >> > >> >> conduct, to people outside the community and who have recentl=
y joined.
>> >> > >> >> What is the document that you would have liked to have read a=
s you were
>> >> > >> >> starting out?  It is all too long ago for me to remember clea=
rly, and so
>> >> > >> >> much has changed.
>> >> > >> >
>> >> > >> > The document I would have liked to have read when starting out=
 is
>> >> > >> > currently checked into the source tree in
>> >> > >> > Documentation/process/code-of-conduct.rst .
>> >> > >>=20
>> >> > >> I'm curious - what would you have gained by reading that documen=
t?
>> >> > >
>> >> > > I would have then had rather less of a pervasive feeling of "if I=
 make
>> >> > > even a single mistake I get made an example of in ways that will =
feed
>> >> > > people's quotes files for years to come".
>> >> >=20
>> >> > Thanks for your reply.  Certainly feeling safe is important, and ha=
ving
>> >> > clear statements that the community values and promotes psychologic=
al
>> >> > safety is valuable.
>> >> >=20
>> >> > The old "code of conflict" said
>> >> >    If however, anyone feels personally abused, threatened, or other=
wise
>> >> >    uncomfortable due to this process, that is not acceptable.=20
>> >> >=20
>> >> > would you have not found this a strong enough statement to ward off=
 that
>> >> > pervasive feeling?
>> >>=20
>> >> Not when that document started out effectively saying, in an elaborate
>> >> way, "code > people".
>> >
>> > Interesting.
>> >
>> > I am curious what leads you to your "code > people" statement.  Of cou=
rse,
>> > one could argue that this does not really matter given that the code of
>> > conflict is no longer.  However, I would like to understand for future
>> > reference, if for no other reason.
>> >
>> > One possibility is that you are restricting the "people" to only those
>> > people directly contributing in one way or another.  But those using t=
he
>> > kernel (both directly and indirectly) are important as well, and it is
>> > exactly this group that is served by "the most robust operating system
>> > kernel ever", the chest-beating sentiment notwithstanding.  Which is in
>> > fact why I must reject (or rework or whatever) any patch that might re=
sult
>> > in too-short RCU grace periods:  The needs of the patch's submitter are
>> > quite emphatically outweighed by the needs of the kernel's many users,
>> > and many of the various technical requirements and restrictions are in
>> > fact proxies for the needs of these users.
>> >
>> > But you knew that already.
>> >
>> > Similarly for the Linux kernel's various code-style strictures, which
>> > serve the surprisingly large group of people reading the kernel's code.
>> > Including the stricture that I most love to hate, which is the one
>> > stating that single-line do/for/if/while statements must not be enclos=
ed
>> > in braces, which sometimes causes me trouble when inserting debug code,
>> > but which also makes more code fit into a window of a given size.  ;-)
>> >
>> > But you knew that already, too.
>> >
>> > The maintainability requirements can be argued to mostly serve the
>> > maintainers, but if the code becomes unmaintainable, future users
>> > will be inconvenienced, to say the least.  So even the maintainability
>> > requirements serve the kernel's many users.
>> >
>> > But you also knew that already.
>> >
>> > So what am I missing here?
>> >
>>=20
>> Hi Paul,
>>  thanks for contributing your thoughts.  It is nice to have a new voice
>>  in the conversation, it helps me to maintain my illusion that this
>>  issue is relevant to the whole community.
>
> I am not sure whether I should feel Australia-style chastened,
> American-style encouraged, or what, but either way, good show on that
> paragraph.  ;-)
>
>>  I cannot, of course, speak to why Josh wrote what he did, but I can
>>  give some insight into why I had no disagreement with that part of his
>>  statement.
>>  A key insight, worth your time to consider and unpack I think, is
>>=20
>>       People won't care what you know, until they know that you care.
>>=20
>>  I won't dwell on that here, but will make some more obviously relevant
>>  observations.
>>=20
>>  Firstly, you gave an analytical response to what was, in my view, an
>>  emotional observation.  While I agree with your analysis, it is largely
>>  irrelevant.  It is not how people *feel* about kernel development.
>>=20
>>  You say that the code of conflict is gone, but in fact much of it is
>>  preserved in the code-of-conduct-interpretation.  If you reflect on the
>>  focus of the second para of that document (which I think was directly
>>  lifted from the code-of-conflict) you will see that value is placed
>>  squarely on the code (kernel code, not code of conduct).  The code is
>>  put forward as the thing of primary importance.  People (you, me) are
>>  only mentioned in the context of being the authors of code that will be
>>  criticised  - because (it almost says this) we care about the code, but
>>  not about you.
>>=20
>>  So I think it is beyond argument that the value system presented by
>>  this paragraph is
>>       code > people
>>=20
>>  I think this is particularly unfortunate as it is not really how the
>>  community works, and not really how Linus works, except in those
>>  occasional outbursts that are publicised so much.
>>=20
>>  I recall two specific events (there were probably others) from early in
>>  my Linux experience where Linus said/did things which said to me that
>>  he valued me, not just the code that I wrote.  I think he did that a
>>  lot (and probably still does).  As I knew that he "cared", I was much
>>  more interested in what he knew/thought.
>>=20
>>  I think that the fact that Linus is now acknowledging every "pull"
>>  request is brilliant.  It doesn't really help the process much (we all
>>  have plenty of visibility into what Linus has pulled) and doesn't help
>>  the code (directly) at all.  But it tells people that Linus can see
>>  them, and has seen them.  It also allows people to see that they have
>>  an email from Linus without expecting it to be a criticism.  Certainly
>>  he still criticises and is right to do so, and he doesn't say "Pulled,
>>  thanks", which would be my preference, but the fact that he responds at
>>  least says "me responding to you matters" and by implication "you
>>  matter".
>>=20
>>  (The code-of-conflict only acknowledged that you matter once you feel
>>  personally abused).
>
> I agree that Linus's acknowledging pull requests is a good thing.  I have
> long appreciated my upstream maintainer doing the same, and I do try to
> acknowledge patch submissions myself.  And yes, motivating people is an
> underappreciated art, and an art made more difficult by the wide variety
> of mindsets, even within a relatively like-minded community such as the
> Linux kernel community.  So I agree that improvements are welcome, and
> further believe that there always will be room for improvement.
>
> But I am still not seeing "code > people" in the interpretation document.
> For me, it is all about people.
>
> Back to "People won't care what you know, until they know that you care."
>
> Fortunately for me, it is not necessary for all that many people to care
> what I know, given that I have the usual human limitations on the number
> of individuals that I can directly relate to, and this number is way
> less than the billions that have some relationship to the Linux kernel,
> unwitting though that relationship is in the common case.
>
> In contrast, back in the late 70s, my software had two users, and I
> frequently chatted with both of them.  This is clearly not possible in
> the case of the Linux kernel.  Nor would it be all that helpful, given
> that all they really need from me is to keep RCU working properly.
> So I instead create an abstraction of those users' needs in the form
> of requirements.  These requirements might seem dull and uninspiring,
> but they are in fact a proxy for the needs of the users.
>
> In short, instead of "code > people", I am seeing "our users need us".
>

Ok, maybe we need to introduce a distinction here.
=2D our users are affected by our product
=2D our developers are affected by our process

The para in question talks a lot about meeting the needs of our users,
and says almost nothing about meeting the needs of our developers.  In
fact, our developers need to submit their needs to the needs for the
users.  So maybe the inequality is "users > developers".

Now you and I and most of the community know that this isn't true, the
developers are actually valued: patches are reviewed, bug reports are
attended to, questions are answered.
On re-reading the text in question, I see that it says:

   Your contributions and ideas behind them will be
   carefully reviewed, ...

and while that is a good thing, it really doesn't come across as
welcoming to me. ( .... will be *welcomed* and carefully reviewed....)

And I guess this highlights the wisdom of your response to Josh:
   Communication is inherently difficult.

This is, in part, why I suggest that we shouldn't have a code of conduct
at all.  Whatever we write, different people will understand it
differently.  And history suggests that some of us will treat it like a
legal document and try to be lawyers, but without all the training real
lawyers have.

Instead of a code of conduct, we just need good conduct, and to
encourage that conduct when we see it.
This builds on our core competencies as a community:  our usual mode of
working is to each work independently on our own areas, and to combine
our skills intermittently as need and opportunity arises.  The "Linux
kernel" emerges organically from the work of multiple developers, and
likewise, the only meaningful statement of the conduct of the community is
that conduct with emerges organically from the conduct of the members.

Thanks,
NeilBrown


> 							Thanx, Paul
>
>> Thanks,
>> NeilBrown
>>=20
>>=20
>> > 							Thanx, Paul
>> >
>> >>                       (Leaving aside that the more important detail
>> >> would be the community actually acting consistently with the code of
>> >> conduct it espoused.)
>> >>=20
>> >> > In the current code, would The "Our Pledge" section have been
>> >> > sufficient, or do you think the other sections would have actually
>> >> > helped you?
>> >>=20
>> >> "Our Standards" would have been at least as important to me personall=
y,
>> >> as would "Enforcement" (and more importantly, examples of that applyi=
ng
>> >> in practice and not just as empty words).
>> >> _______________________________________________
>> >> Ksummit-discuss mailing list
>> >> Ksummit-discuss@lists.linuxfoundation.org
>> >> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
>> >>=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvdXgQACgkQOeye3VZi
gbnBLxAAjQjYzEMQ0fDKGWR0BOacfttEOTs2ZMfvZyfUyTMyLGBOINgLhZhKLSqk
m7aWAtXz/GcOAER92zdPZzeDIkgS/k3l3au0XbfbFseN4L+m/GTODeL3vqF667c8
kbsrsQpqoB97hvB9W7fa3Yl7ZCstKXQGR5DRfydHiq2ljQBv9fFyXMAHNizcnTG2
kBfvjONZVBctCK1j0RMP5RaAWuILIeAyolifq5bS+uQ1L+861ZWUReWunxZR19mL
/9jLhx/T29p4tBDpuhxeIwE9whe0QeNKruFKvXKJFtmYB3Pra7ym9qoBTVylicID
8NdfXg4Q4y1C84tV5f+HU0Ip0OZdy8COLGBG7THdP2kcbvAxubHJlc1Ff9xyVzlp
8gmnNaSDAI2GO/6HbJaK7dPvcMjZ8DFZiI4XQRIpltr+O+U2fNnRmsqjO8pDm4ti
ojeEvZe0a76X30K45JMz1BVYKKWjh+nGGje2fo+7DLRKjyvdfqbisacWv6LxX7Fh
PPo36nDBQDci59FP6KU5pDf++Ft90rwKSq8rtBe9LIDyEnUNVOUyjW034rVHVE8Q
R5rOsHcnDpseNZn7Cg5Rsxm2oILXL2bX7/stAatKiq69bfDoU/QsETt7JopgH7p3
AZk994AU+tO3YwyBoqadx54D1skkbtHVBbswTeTPwItmBWJV7ro=
=nG/a
-----END PGP SIGNATURE-----
--=-=-=--
