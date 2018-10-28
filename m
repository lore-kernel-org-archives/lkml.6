Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB69C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56462082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56462082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeJ2Geh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 02:34:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:43972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727078AbeJ2Geg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 02:34:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7576ACEF;
        Sun, 28 Oct 2018 21:48:40 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Josh Triplett <josh@joshtriplett.org>
Date:   Mon, 29 Oct 2018 08:48:33 +1100
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an interpretation document
In-Reply-To: <20181027011010.GA29769@localhost>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name> <20181021222608.GA24845@localhost> <875zxt919d.fsf@notabene.neil.brown.name> <20181024121622.GA10942@localhost> <87ftwt6850.fsf@notabene.neil.brown.name> <20181027011010.GA29769@localhost>
Message-ID: <8736sp4ua6.fsf@notabene.neil.brown.name>
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

On Sat, Oct 27 2018, Josh Triplett wrote:

> On Fri, Oct 26, 2018 at 08:14:51AM +1100, NeilBrown wrote:
>> On Wed, Oct 24 2018, Josh Triplett wrote:
>>=20
>> > On Tue, Oct 23, 2018 at 07:26:06AM +1100, NeilBrown wrote:
>> >> On Sun, Oct 21 2018, Josh Triplett wrote:
>> >>=20
>> >> > On Mon, Oct 22, 2018 at 08:20:11AM +1100, NeilBrown wrote:
>> >> >> I call on you, Greg:
>> >> >>  - to abandon this divisive attempt to impose a "Code of Conduct"
>> >> >>  - to revert 8a104f8b5867c68
>> >> >>  - to return to your core competence of building a great team arou=
nd
>> >> >>    a great kernel
>> >> >>=20
>> >> >>  #Isupportreversion
>> >> >>=20
>> >> >> I call on the community to consider what *does* need to be said, a=
bout
>> >> >> conduct, to people outside the community and who have recently joi=
ned.
>> >> >> What is the document that you would have liked to have read as you=
 were
>> >> >> starting out?  It is all too long ago for me to remember clearly, =
and so
>> >> >> much has changed.
>> >> >
>> >> > The document I would have liked to have read when starting out is
>> >> > currently checked into the source tree in
>> >> > Documentation/process/code-of-conduct.rst .
>> >>=20
>> >> I'm curious - what would you have gained by reading that document?
>> >
>> > I would have then had rather less of a pervasive feeling of "if I make
>> > even a single mistake I get made an example of in ways that will feed
>> > people's quotes files for years to come".
>>=20
>> Thanks for your reply.  Certainly feeling safe is important, and having
>> clear statements that the community values and promotes psychological
>> safety is valuable.
>>=20
>> The old "code of conflict" said
>>    If however, anyone feels personally abused, threatened, or otherwise
>>    uncomfortable due to this process, that is not acceptable.=20
>>=20
>> would you have not found this a strong enough statement to ward off that
>> pervasive feeling?
>
> Not when that document started out effectively saying, in an elaborate
> way, "code > people". (Leaving aside that the more important detail
> would be the community actually acting consistently with the code of
> conduct it espoused.)

I certainly cannot argue with that. .... that those starting words have
been preserved in the code-of-conduct-interpretation.rst, so we still
have them.

>
>> In the current code, would The "Our Pledge" section have been
>> sufficient, or do you think the other sections would have actually
>> helped you?
>
> "Our Standards" would have been at least as important to me personally,
> as would "Enforcement" (and more importantly, examples of that applying
> in practice and not just as empty words).

I find it interesting that you appear to particularly value the
Enforcement section, I particularly dislike it.
It is also interesting that you seem to fear that it might be "empty
words", and elsewhere in this thread Laura Abbott wondered

   Will those problems actually be handled appropriately when the time
   comes? I can't actually say for sure

She goes on to opine that trust is needed, but if we really had trust,
we might not need the code.

None of us, to my knowledge, has credible expertise or demonstrated
experience in this area, so we might easily become the blind misleading
the blind.  However I would like to make one more attempt to give
context and meaning to my dislike for that section.

The approach described seem to be combative rather than conciliatory.
The first action-step described is to mark a report - to complain.  This
isn't quite as bad as being litigious, but it seems headed in that
direction.  I would rather we gave people the power to resolve their own
issues, rather than an avenue to magnify them but involving others.

Think for a moment about how we resolve technical differences.  I
acknowledge that we don't always resolve them very well, but when we do
=2D what techniques seem to work?  We don't have any court to which we can
apply to resolve our differences, we need to present our case and garner
support from like-minded people.  To help with that, we do have some
standards like "no regressions" and "maintainable" and various
coding-style guidelines.  They don't necessarily answer everything but
they help.  Over all this, there is a general principle that the person
who writes the code makes the decisions - "code talks".  The person who
puts in the effort gets heard more than the person who complains from
the side lines.  This isn't all perfect, but it largely works, and we
are familiar with it.

Can we translate any of that experience to the social/harm side of
things?
1/ We can have some standards.  We will never all agree on the level
  of detail needed (but then, we don't all agree on checkpatch.pl
  either), but anything generally in the right direction would help (I
  like "Be helpful. Don't be harmful".  "Be kind to each other" is in
  the interpretation).
2/ We can voice our support when we see a cause the we agree with,
  whether it is a revised API, or discomfort with a particular
  word-choice.
3/ We can make sure that people who have done valuable work (written a
  patch, found a bug, etc) have a place where they can be heard, even if
  they find the need to filter all messages from an unrepentant abuser.

I think our practice, in the technical sphere, has generally been
towards conciliation, not combat.  I think that is the experience that
we should try to leverage in the more social sphere.

A useful side-node is that "hurting people hurt people".  If someone
does hurt you, there is a good chance that they are hurting themselves.
Do you want to increase that hurt by fighting back?  Would it not be
better to simply side-step.

Thanks,
NeilBrown

=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvWLrEACgkQOeye3VZi
gbmK+w//ZbCiunyMxmKn6YQXpX5LMeFXl5SPS5gujJVK1Lr0u4lT3vA7ZXAoWGIK
CUiJIlDELFkzdf9Bhi9FiMVEG6vm4mOcCntyPQmNU6PTU3OQ0jjnE0qYzqGcwO6j
mdwzpEf/UgyjgP+y9KP2TAJ5x8YDjBqoyniSIklT9hrcwxvnXjAusoYQGlZeLds+
jBT0XJrdCS0E6jxTj7pLifsHMcArX0VE3pseDYNfl6yssrf5ONC//u3Ho3uYBXOF
lABFS+HgcjHf+QpcJ2SPNyqLwlFfn0OhggWwfhymPjzWnbhfRwKv7pwYqu1fBMsM
xF9y5nRs+jfduRcqEHbt5Ug/bd1DlBS+/F+5+autW5dwMGwJa8t1M7Xl9ZgwBoqJ
bbtS87kp3O5LiLz2gpb/DjYWEduEUI2e5r7Job5UMKgkCwILF80CQ69nlMG0iP1d
G5tpoWm1bdkVi1aJSbG1b4uWT7m9pzIBh6zEhvK8/ZOdZ6wSDm+kGIW8+tZz7A5i
O79UVbfc916vRA3G108AGMA87KuPGX73juR1bPqoY+Nxw8847DjjA59t444sgQbR
4KQB0ZAn6DUQjwcBxYKfgKJvOcNCee1GWNN9n3M2P4lTvZQcD9aBd2UJ47hKgW8t
SAsbrbp5CQzzdV52uNm2LNeef6XXa8C/wFpl9twDImyWsOTDxnQ=
=RnQp
-----END PGP SIGNATURE-----
--=-=-=--
