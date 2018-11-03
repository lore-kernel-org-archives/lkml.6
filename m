Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A785C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 21:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA4D204FD
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 21:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA4D204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeKDGTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 01:19:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:56214 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbeKDGTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 01:19:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E1871ACBD;
        Sat,  3 Nov 2018 21:06:52 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     paulmck@linux.ibm.com
Date:   Sun, 04 Nov 2018 08:06:41 +1100
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Mishi Choudhary <mishi@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an interpretation document
In-Reply-To: <20181103173756.GG4170@linux.ibm.com>
References: <87y3ar80ac.fsf@notabene.neil.brown.name> <20181021222608.GA24845@localhost> <875zxt919d.fsf@notabene.neil.brown.name> <20181024121622.GA10942@localhost> <87ftwt6850.fsf@notabene.neil.brown.name> <20181027011010.GA29769@localhost> <20181101164544.GA31540@linux.ibm.com> <8736sk31t8.fsf@notabene.neil.brown.name> <20181102133309.GQ4170@linux.ibm.com> <87lg6a1rss.fsf@notabene.neil.brown.name> <20181103173756.GG4170@linux.ibm.com>
Message-ID: <87d0rl27mm.fsf@notabene.neil.brown.name>
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

On Sat, Nov 03 2018, Paul E. McKenney wrote:

> On Sat, Nov 03, 2018 at 07:36:19PM +1100, NeilBrown wrote:
>> On Fri, Nov 02 2018, Paul E. McKenney wrote:
>>=20
>> > On Fri, Nov 02, 2018 at 08:50:11AM +1100, NeilBrown wrote:
>> >> On Thu, Nov 01 2018, Paul E. McKenney wrote:
>> >>=20
>> >> > On Sat, Oct 27, 2018 at 02:10:10AM +0100, Josh Triplett wrote:
>> >> >> On Fri, Oct 26, 2018 at 08:14:51AM +1100, NeilBrown wrote:
>> >> >> > On Wed, Oct 24 2018, Josh Triplett wrote:
>> >> >> >=20
>> >> >> > > On Tue, Oct 23, 2018 at 07:26:06AM +1100, NeilBrown wrote:
>> >> >> > >> On Sun, Oct 21 2018, Josh Triplett wrote:
>> >> >> > >>=20
>> >> >> > >> > On Mon, Oct 22, 2018 at 08:20:11AM +1100, NeilBrown wrote:
>> >> >> > >> >> I call on you, Greg:
>> >> >> > >> >>  - to abandon this divisive attempt to impose a "Code of C=
onduct"
>> >> >> > >> >>  - to revert 8a104f8b5867c68
>> >> >> > >> >>  - to return to your core competence of building a great t=
eam around
>> >> >> > >> >>    a great kernel
>> >> >> > >> >>=20
>> >> >> > >> >>  #Isupportreversion
>> >> >> > >> >>=20
>> >> >> > >> >> I call on the community to consider what *does* need to be=
 said, about
>> >> >> > >> >> conduct, to people outside the community and who have rece=
ntly joined.
>> >> >> > >> >> What is the document that you would have liked to have rea=
d as you were
>> >> >> > >> >> starting out?  It is all too long ago for me to remember c=
learly, and so
>> >> >> > >> >> much has changed.
>> >> >> > >> >
>> >> >> > >> > The document I would have liked to have read when starting =
out is
>> >> >> > >> > currently checked into the source tree in
>> >> >> > >> > Documentation/process/code-of-conduct.rst .
>> >> >> > >>=20
>> >> >> > >> I'm curious - what would you have gained by reading that docu=
ment?
>> >> >> > >
>> >> >> > > I would have then had rather less of a pervasive feeling of "i=
f I make
>> >> >> > > even a single mistake I get made an example of in ways that wi=
ll feed
>> >> >> > > people's quotes files for years to come".
>> >> >> >=20
>> >> >> > Thanks for your reply.  Certainly feeling safe is important, and=
 having
>> >> >> > clear statements that the community values and promotes psycholo=
gical
>> >> >> > safety is valuable.
>> >> >> >=20
>> >> >> > The old "code of conflict" said
>> >> >> >    If however, anyone feels personally abused, threatened, or ot=
herwise
>> >> >> >    uncomfortable due to this process, that is not acceptable.=20
>> >> >> >=20
>> >> >> > would you have not found this a strong enough statement to ward =
off that
>> >> >> > pervasive feeling?
>> >> >>=20
>> >> >> Not when that document started out effectively saying, in an elabo=
rate
>> >> >> way, "code > people".
>> >> >
>> >> > Interesting.
>> >> >
>> >> > I am curious what leads you to your "code > people" statement.  Of =
course,
>> >> > one could argue that this does not really matter given that the cod=
e of
>> >> > conflict is no longer.  However, I would like to understand for fut=
ure
>> >> > reference, if for no other reason.
>> >> >
>> >> > One possibility is that you are restricting the "people" to only th=
ose
>> >> > people directly contributing in one way or another.  But those usin=
g the
>> >> > kernel (both directly and indirectly) are important as well, and it=
 is
>> >> > exactly this group that is served by "the most robust operating sys=
tem
>> >> > kernel ever", the chest-beating sentiment notwithstanding.  Which i=
s in
>> >> > fact why I must reject (or rework or whatever) any patch that might=
 result
>> >> > in too-short RCU grace periods:  The needs of the patch's submitter=
 are
>> >> > quite emphatically outweighed by the needs of the kernel's many use=
rs,
>> >> > and many of the various technical requirements and restrictions are=
 in
>> >> > fact proxies for the needs of these users.
>> >> >
>> >> > But you knew that already.
>> >> >
>> >> > Similarly for the Linux kernel's various code-style strictures, whi=
ch
>> >> > serve the surprisingly large group of people reading the kernel's c=
ode.
>> >> > Including the stricture that I most love to hate, which is the one
>> >> > stating that single-line do/for/if/while statements must not be enc=
losed
>> >> > in braces, which sometimes causes me trouble when inserting debug c=
ode,
>> >> > but which also makes more code fit into a window of a given size.  =
;-)
>> >> >
>> >> > But you knew that already, too.
>> >> >
>> >> > The maintainability requirements can be argued to mostly serve the
>> >> > maintainers, but if the code becomes unmaintainable, future users
>> >> > will be inconvenienced, to say the least.  So even the maintainabil=
ity
>> >> > requirements serve the kernel's many users.
>> >> >
>> >> > But you also knew that already.
>> >> >
>> >> > So what am I missing here?
>> >> >
>> >>=20
>> >> Hi Paul,
>> >>  thanks for contributing your thoughts.  It is nice to have a new voi=
ce
>> >>  in the conversation, it helps me to maintain my illusion that this
>> >>  issue is relevant to the whole community.
>> >
>> > I am not sure whether I should feel Australia-style chastened,
>> > American-style encouraged, or what, but either way, good show on that
>> > paragraph.  ;-)
>> >
>> >>  I cannot, of course, speak to why Josh wrote what he did, but I can
>> >>  give some insight into why I had no disagreement with that part of h=
is
>> >>  statement.
>> >>  A key insight, worth your time to consider and unpack I think, is
>> >>=20
>> >>       People won't care what you know, until they know that you care.
>> >>=20
>> >>  I won't dwell on that here, but will make some more obviously releva=
nt
>> >>  observations.
>> >>=20
>> >>  Firstly, you gave an analytical response to what was, in my view, an
>> >>  emotional observation.  While I agree with your analysis, it is larg=
ely
>> >>  irrelevant.  It is not how people *feel* about kernel development.
>> >>=20
>> >>  You say that the code of conflict is gone, but in fact much of it is
>> >>  preserved in the code-of-conduct-interpretation.  If you reflect on =
the
>> >>  focus of the second para of that document (which I think was directly
>> >>  lifted from the code-of-conflict) you will see that value is placed
>> >>  squarely on the code (kernel code, not code of conduct).  The code is
>> >>  put forward as the thing of primary importance.  People (you, me) are
>> >>  only mentioned in the context of being the authors of code that will=
 be
>> >>  criticised  - because (it almost says this) we care about the code, =
but
>> >>  not about you.
>> >>=20
>> >>  So I think it is beyond argument that the value system presented by
>> >>  this paragraph is
>> >>       code > people
>> >>=20
>> >>  I think this is particularly unfortunate as it is not really how the
>> >>  community works, and not really how Linus works, except in those
>> >>  occasional outbursts that are publicised so much.
>> >>=20
>> >>  I recall two specific events (there were probably others) from early=
 in
>> >>  my Linux experience where Linus said/did things which said to me that
>> >>  he valued me, not just the code that I wrote.  I think he did that a
>> >>  lot (and probably still does).  As I knew that he "cared", I was much
>> >>  more interested in what he knew/thought.
>> >>=20
>> >>  I think that the fact that Linus is now acknowledging every "pull"
>> >>  request is brilliant.  It doesn't really help the process much (we a=
ll
>> >>  have plenty of visibility into what Linus has pulled) and doesn't he=
lp
>> >>  the code (directly) at all.  But it tells people that Linus can see
>> >>  them, and has seen them.  It also allows people to see that they have
>> >>  an email from Linus without expecting it to be a criticism.  Certain=
ly
>> >>  he still criticises and is right to do so, and he doesn't say "Pulle=
d,
>> >>  thanks", which would be my preference, but the fact that he responds=
 at
>> >>  least says "me responding to you matters" and by implication "you
>> >>  matter".
>> >>=20
>> >>  (The code-of-conflict only acknowledged that you matter once you feel
>> >>  personally abused).
>> >
>> > I agree that Linus's acknowledging pull requests is a good thing.  I h=
ave
>> > long appreciated my upstream maintainer doing the same, and I do try to
>> > acknowledge patch submissions myself.  And yes, motivating people is an
>> > underappreciated art, and an art made more difficult by the wide varie=
ty
>> > of mindsets, even within a relatively like-minded community such as the
>> > Linux kernel community.  So I agree that improvements are welcome, and
>> > further believe that there always will be room for improvement.
>> >
>> > But I am still not seeing "code > people" in the interpretation docume=
nt.
>> > For me, it is all about people.
>> >
>> > Back to "People won't care what you know, until they know that you car=
e."
>> >
>> > Fortunately for me, it is not necessary for all that many people to ca=
re
>> > what I know, given that I have the usual human limitations on the numb=
er
>> > of individuals that I can directly relate to, and this number is way
>> > less than the billions that have some relationship to the Linux kernel,
>> > unwitting though that relationship is in the common case.
>> >
>> > In contrast, back in the late 70s, my software had two users, and I
>> > frequently chatted with both of them.  This is clearly not possible in
>> > the case of the Linux kernel.  Nor would it be all that helpful, given
>> > that all they really need from me is to keep RCU working properly.
>> > So I instead create an abstraction of those users' needs in the form
>> > of requirements.  These requirements might seem dull and uninspiring,
>> > but they are in fact a proxy for the needs of the users.
>> >
>> > In short, instead of "code > people", I am seeing "our users need us".
>>=20
>> Ok, maybe we need to introduce a distinction here.
>> - our users are affected by our product
>> - our developers are affected by our process
>>=20
>> The para in question talks a lot about meeting the needs of our users,
>> and says almost nothing about meeting the needs of our developers.  In
>> fact, our developers need to submit their needs to the needs for the
>> users.  So maybe the inequality is "users > developers".
>>=20
>> Now you and I and most of the community know that this isn't true, the
>> developers are actually valued: patches are reviewed, bug reports are
>> attended to, questions are answered.
>
> I completely and emphatically agree that the reality is quite a bit more
> complicated and nuanced than can be captured by sound bites, whether
> inequalities or otherwise.  For example, one sense in which "users >
> developers" might be said to be true is that things usually don't go
> at all well for developers when users vote with their feet, abandoning
> the project.  And one sense in which "developers > users" might be said
> to be true is in terms of direct influence over the project itself.
>
> I am quite confident that you could easily come up with a very large
> number of additional examples supporting any number of inequalities
> between any number of pairs of subgroups within the greater Linux-kernel
> community.  ;-)
>
>> On re-reading the text in question, I see that it says:
>>=20
>>    Your contributions and ideas behind them will be
>>    carefully reviewed, ...
>>=20
>> and while that is a good thing, it really doesn't come across as
>> welcoming to me. ( .... will be *welcomed* and carefully reviewed....)
>
> Heh!  Like many people in my country, there is a mat labeled "Welcome" in
> front of my door.  And, again like many people in my country, that door
> is almost always locked, which is admittedly strange and ironic enough.
> But given where the code of conduct is located, it would be more like a
> "Welcome" mat hidden in the shrubbery behind my house, now wouldn't it?
> Which would be even more strange, though perhaps no more ironic.
>
> Yet putting the code of conduct (say) in all caps in the Linux kernel's
> home directory might not be sending all that positive a message, so
> it makes no sense to move it from its current location.  We therefore
> cannot really rely on the code of conduct to serve as the Linux kernel's
> "Welcome" mat.  Nor should that be its purpose.
>
>> And I guess this highlights the wisdom of your response to Josh:
>>    Communication is inherently difficult.
>
> Thank you, much though I wish I was wrong on this point.
>
>> This is, in part, why I suggest that we shouldn't have a code of conduct
>> at all.  Whatever we write, different people will understand it
>> differently.  And history suggests that some of us will treat it like a
>> legal document and try to be lawyers, but without all the training real
>> lawyers have.
>>=20
>> Instead of a code of conduct, we just need good conduct, and to
>> encourage that conduct when we see it.
>> This builds on our core competencies as a community:  our usual mode of
>> working is to each work independently on our own areas, and to combine
>> our skills intermittently as need and opportunity arises.  The "Linux
>> kernel" emerges organically from the work of multiple developers, and
>> likewise, the only meaningful statement of the conduct of the community =
is
>> that conduct with emerges organically from the conduct of the members.
>
> If the was a perfect world, we might well not need a code of conduct.
> On the other hand, in a perfect world we also just might not need locks
> (with or without the ironic "Welcome" mat), passwords, urgent security
> patches, fences topped with concertina wire, weapons, and much more
> besides.
>
> So rather than randomly mutate the code of conduct further, let alone
> remove it completely, let's instead leave it alone for a few years.
> We then might have enough experience with it to make any needed
> adjustments.

Hi Paul,
 thanks for your thoughts, and particularly for the door-mat analogy.
 It is a thing of beauty.

 I agree that the window of opportunity appears to be closed.  Indeed,
 it appears now that it was closed before I wrote my "Call to action"
 despite the apparent offer of an open discussion.  Maybe I was the only
 one too blind to see that for what it was.

>
> Of course, the optimal outcome would be zero experience with it at all
> ever due to overwhelming best behavior on the part of all concerned,
> but again, this world is sometimes less than perfect.

I have two concerns (fears??) going forward.
One is that the CoC might be weaponized as has already happened to the
GNU Kind Communication Guidelines - see the thread leading to the recent
LWN QoTD by RMS.  In essence, it is being used to attack rather than to
protect (you could argue in this case it is also being used to defend
in a different sense, but the attack is, I think, not healthy).
Maybe I can now say "I told you so" - while that is cold comfort, it is
still better than no comfort.

The second is that people might perceive behavioural improvements in the
community from this time, see the CoC added at this time, and
incorrectly assume causality - the most likely actual cause is
improvement in leadership.  I hope that I have made enough noise that
such people will think twice about copying our mistakes.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlveDeIACgkQOeye3VZi
gbnBExAApRRxBYH+hHUIEAdDj4mzm283OP5Aa9ODM3Bo0ORs5IsAytq5sbpML/fD
SoJ5ylgeFzVzGc0KJk3d5jFsE+JwMLvUl83vLidFjYlHtljTXeWFUpdkFeDkQxpe
68ig2zVeZCrLkI4Cwlj6TabONYeL6y0MoD1w8/XbmUEHhmGpVz2qbjxO+AAM6Tm8
RrwcTwTX9+T2tHrBJST9ThSeeTGO+hZudc+B6QVYeMHaWL32WilEfPVOp8Z1cvfr
gnl/Zc/TDjwQ1Lw7VnSJ6MNjsDdXbSgwvKQc21NQw6GFdWve+nS3yLcUAdv7PW+q
UcIj/s9fKDirgE2Z0H0ubSxurIIJf2s3o/bJGYzQ7jUYRBcSsgBN7790+HhoiNC6
VYNSbZGcpfCJupm2phJankmFyJt0+0nqzvpN9xSr0XAVJ1HULZR6zQXpDDUILSkP
OT8yhRRvk3ZfAuTzCa0nui/abCucz2i2EKQiM8ad3+t5vgxfp0mTZ7NKvCph03Nr
nJUoyUf6wVqwCVvBRvbGqABiee073TBXnrFbtBiNGx7IjWPrjlFnxX89RefOQc2X
wGaXV/UZ2nMmkZ2a07zbj1x/PlsWbcOFHPA75runXpssfyBsZXswaHHxrZvo+fFX
kMcOTlufWUGXDwEX0ld2x3mHzKocu0IblOodEbTiiaqubJ8WgLg=
=Z7dd
-----END PGP SIGNATURE-----
--=-=-=--
