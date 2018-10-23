Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD75C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A642F20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A642F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeJXFK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 01:10:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:49168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbeJXFK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 01:10:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79F3DAFFB;
        Tue, 23 Oct 2018 20:45:25 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Date:   Wed, 24 Oct 2018 07:45:14 +1100
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an interpretation document
In-Reply-To: <20181023060059.GW32577@ZenIV.linux.org.uk>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name> <20181021222608.GA24845@localhost> <875zxt919d.fsf@notabene.neil.brown.name> <20181023033130.GQ32577@ZenIV.linux.org.uk> <87r2gh70ij.fsf@notabene.neil.brown.name> <20181023045247.GV32577@ZenIV.linux.org.uk> <87o9bl6xlo.fsf@notabene.neil.brown.name> <20181023060059.GW32577@ZenIV.linux.org.uk>
Message-ID: <87in1s75ph.fsf@notabene.neil.brown.name>
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

On Tue, Oct 23 2018, Al Viro wrote:

> On Tue, Oct 23, 2018 at 04:28:03PM +1100, NeilBrown wrote:
>
>> > If that's a clarification, I'm sorry to say that I understand you even=
 less now.
>> > What are you proposing?  Duopoly?  How do you deal with disagreements?=
  Fork?
>> > Revert wars?
>>=20
>> We already have team-maintainership arrangements - doing the same thing
>> at the top level should not be that hard to imagine.
>>=20
>> It really about "saying" no.  I suspect all members of a team would come
>> to much the same decision about any given patch, but they might "say" it
>> differently.  One might say "anyone who wrote this should be
>> lobotomised", and the other might say "I see what you are trying to do,
>> but the approach won't work - go look at how we handle XXXX, they have a
>> similar problem".  Neither will accept the patch, and they will probably
>> both accept it after certain changes.  But when one of them is having a
>> bad day, I would like people to have the explicit opportunity to ignore
>> them and talk to the other.  Yes, they'll still get "no" twice, but they=
'll
>> also get something approaching sane review least once.
>
> You still have not answered the question I've asked - what to do in case =
of
> real disagreements, seeing that "pass it to Linus for final decision" obv=
iously
> doesn't work here.  And while we are at it, what to do in case when "they"
> _agree_ that patch is unsalvagable?  I'm quite sure that you can think of
> examples of such...

Sorry, things easily get lost in such a wide ranging conversation.
Handling of real disagreements is not my problem, unless I am a member
of the maintainership team.  We have maintainership teams which appear
to work, so they provide an existence-proof that something can be
achieved.

Were I to have an opportunity to be part of a maintainership team, I
would probably base any internal agreement necessary on two principles.
1/ People on the team are reasonably competent, and aren't going to
  commit anything that all controversial without being quite confident.
  I would choose to trust.

2/ We commit bad patches often, and when we realize, we fix them.  You
  and I have both been on both sides of that.  We (the community)
  even commit quite large mistakes (devfs, control-groups) and the world
  doesn't end.  Accepting imperfection is a key part of Linus' pragmatic
  approach, and a key part of the success of Linux.

If they agree that the patch is unsalvagable, then they say so -
politely and with reasons.  It is a right-of-review, not a
right-of-success.


>
> BTW, out of curiosity - when has anyone suggested lobotomies[1]?  I'd lik=
e to see
> details - got to be interesting...

Sorry, it was a deliberately ficticious example.

Thanks for showing an interest, it is more than a lot of people are
doing.
NeilBrown

>
> [1] on kernel development lists, that is - I can think of examples in e.g.
> NANAE circa '98 or so regarding the SGI employees responsible for sendmail
> setup they used to ship in IRIX, but that was more of a possible explanat=
ion
> of the reasons rather than suggested remedy...

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvPiFsACgkQOeye3VZi
gbn7nw/9FdMy4AjQzbWQfWmM5bonCBdC7uM/1Q/rQTu7OtqJ0JCWGxXIz8EYc+b1
odLqfK/mv7UMGHFulcly8pClL3okIT2UMvIKZyu+u3c/+jpKkp1QS46VXV69Ia0d
TKEVK2oIoWxvJD65ZBMVyAuldUy82EwPvPUGtJyVDXJqmz271hpMmbjue2hPNDXb
GwkVwNIXruHRmtEnyZ42DFq8Hh7A8Wtw9Ib565WgqENeyZzbmXVEUA+CKbCgqIb0
4n6L+rSaBKVk+nAgd4yecGiIzU3rJGbM5Hc+gawrrcmIQ/U47FDTD5yKGp/UbCNV
kS+X/xQJbrAbHWTu09ko0fn9lIUGsluQlDU30M1KsP8chf3RbmBwqchGshIuq1ea
jI5IxDWBMj5BTs7a08V26C4kIgJ4w6WuXKjRUqnqTytAF0t6YLPp8/BGuIiyJo13
0xeqw44Dr4IOmsY/RC6mcISQiAfUfZRr2LeejUGvkLcHiPNu1HOnETbcz1xPRl0K
+/BfPyEu1msrXsJicML/KKDH9L0SEOqzOcp9zToqworVK2gRSvNFNTPcO9+1o8sp
fZsvCmnFfdhf/uwfE3PWG0L6ZH8T/OXmj2vRHZn4IHnQvnyvpcDo0nW35LObG6Zp
Nuy0G3nDZP4VLnoOE7b6A9HVSUaHBQ9nff5MS5nsyQvPxw5pcYU=
=FBmv
-----END PGP SIGNATURE-----
--=-=-=--
