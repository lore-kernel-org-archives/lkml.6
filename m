Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630EEC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D30207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D30207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeJXFju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 01:39:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:53456 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726992AbeJXFju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 01:39:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B7E3AE47;
        Tue, 23 Oct 2018 21:14:41 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     t@thunk.org
Date:   Wed, 24 Oct 2018 08:14:33 +1100
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Josh Triplett <josh@joshtriplett.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an interpretation document
In-Reply-To: <20181023081144.GN1617@thunk.org>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name> <20181021222608.GA24845@localhost> <875zxt919d.fsf@notabene.neil.brown.name> <20181023033130.GQ32577@ZenIV.linux.org.uk> <87r2gh70ij.fsf@notabene.neil.brown.name> <20181023081144.GN1617@thunk.org>
Message-ID: <87ftww74cm.fsf@notabene.neil.brown.name>
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

On Tue, Oct 23 2018, Theodore Y. Ts'o wrote:

> On Tue, Oct 23, 2018 at 03:25:08PM +1100, NeilBrown wrote:
>>=20
>> Yes, you could, and you can.  But if it was Linus who was behaving
>> inappropriately, where did you go then?  This is why I think whatever
>> "code" we have should be overtly a statement Linus makes about his
>> behaviour, in the first instance.
>
> You're still missing the point, and the problem.  The concern was not
> *that* a patch was rejected, it was in *how* the patch was rejected.

That is not a point I am missing.  Of course it is about *how*.
One form of rejection shows you a path forward, which might be revising
the patch, and it might be solving your problem in a completely
different way.
The other form or rejection leaves you hurting and confused and not
knowing which way to turn - so you leave.
One way gives you power to move forward, the other denies it to you.

> The "problem" has never been about how Linus was treating anyone other
> than core maintainers; i.e., most of the rants that I can think of (a)
> happened years of ago, and (b) were directed at the sort of people who
> were in the room at the Maintainer's Summit yesterday.  Who which, by
> the way, didn't have a complaint about Linus's recent behavior; in
> fact, there was general agreement that Linus's behavior has been
> getting *better* over the last few years.

The fact that Linus' behaviour has improved (with which I agree) is only
part of the story.  There is also Linus' reputation which is, I think,
worse than his behaviour has ever been - partly because he has never
(until recently) done anything to correct that reputation.

Also, it is *not* just about how Linus treats core maintainers, as you
seem to agree with below (despite your statements above).  To take the
liberty of quoting from an email on a non-public list that you will have
seen:

    The unresolved bug was that Linus' conduct, and more importantly the
    conduct of people that less artfully and less productively emulated
    his blow ups, were getting further and further away from Linus' own
    stated ideals on how to treat people.

Linus' example is (apparently) being copied.  That makes it important, I
think, for him to set an explicit counter-example.


>
> One of the more important effects of the CoC is that newcomers have a
> fear about Linux's reputation of having extremely toxic community.
> There is a narrative that has been constructed that because Linus
> behaves badly to everyone; and this gives everyone "permission" to
> behave badly.  Regardless of how true it may have been in the past, I
> believe that it is largely obsolete today.  And so, the mere existence
> of a CoC has caused some newcomers to say that they have "already
> noticed a difference" --- which is IMO mostly the effect of CoC easing
> fears, as opposed to any real change in Linux community in the past
> four weeks.

If the CoC has really eased fears, then that is clearly good news.  I
must admit to being a little surprised.

>
> I think how it will work out in practice is that the CoC will be more
> a commitment about what we are holding up as community norms.
> Unfortunately, for some poeple the term "CoC" apparently acts as
> trigger language and it brings to mind legal proceedings,
> unaccountable court-like entities, and hammering people with
> punishments for petty issues with no appeal or recourse.
>
> Perhaps this is why other communities have elected to use terms such
> as "How to do Samba: Nicely" and "GNU Kind Communication Guidelines".

And doesn't our "code", with an "interpretation" two and a half times as
long, look clumsy beside these documents??


> All of these are trying to solve the same issue, and so my suggestion
> is let's just wait and see how things go.  If people continue to see
> that the community has "changed" for the better, and other people see
> that we're not hammering people with sanctions, but rather reminding
> each other about the kind of community we aspire to be, it'll all be
> good.
>

Thanks for your time,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvPjzkACgkQOeye3VZi
gbnf6Q//dlopsrByzbq47MmPfBRLkTugAUp9TgpWmQUw00NtWR3vWKOE6Zv696jL
KJ1JiQcD5r19DYl9rMsIDmx7qX+O5bCXC0+7U8/KlDd95Tgya5R4Z2lqe86xMGjA
24vJ2qHGl+0Xd+jGvchmdx5jehv5q+zgt/11CrbRObVwNQvwDeXdm3PHH7nddTIr
5KGJBZYDXN3OUsabqlcXlDO+0JtIPLCNhMMPuTTWv6x0T2yfTtnXbXtqK25YqSYi
aEHPusNI3/f0JCho6Qwz8IfdPpcTt2h5ZaOiWv4IuWyAlEir9Z7GTg53WKt2Ncld
PQlTdHLtWFz07nKOgDAZrcsWO3yoKdSSX7JF4SOIUcyEBv2R+m2dt1LYW6LG5Xw7
ptOkGTfpu9Fx3caWcG8vskvZPpD1fsCc6Qd3QaWVjSsv7SrVRcYEgQ7aJEc2AlI9
jkgTH3sycXMvCNRBKlx6TXvk+GSdnyYhFTkrnKYyvzLU8mAKaq0zNWj72334PynQ
4i+F2HDRcfy6/NCH94KQteNOx0T5nuXqR2IFp1n3gFVlxS3mqKHNa3Lc+uQ2NKRZ
CYM0zOVjv3mvnUJ9pXTuletRgL3OmIWhAkmuVZcizOXx+NWo+THDdRGIiTeAG/pS
ocDXfAPxzLvpJrM/LEF+Phh6HjKxoKO5iwyAA5Fw33K7HgIqia4=
=QpjK
-----END PGP SIGNATURE-----
--=-=-=--
