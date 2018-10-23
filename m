Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF9BC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DD520665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DD520665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeJWNuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 09:50:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:34966 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726764AbeJWNuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 09:50:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3675FAD16;
        Tue, 23 Oct 2018 05:28:13 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Date:   Tue, 23 Oct 2018 16:28:03 +1100
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an interpretation document
In-Reply-To: <20181023045247.GV32577@ZenIV.linux.org.uk>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name> <20181021222608.GA24845@localhost> <875zxt919d.fsf@notabene.neil.brown.name> <20181023033130.GQ32577@ZenIV.linux.org.uk> <87r2gh70ij.fsf@notabene.neil.brown.name> <20181023045247.GV32577@ZenIV.linux.org.uk>
Message-ID: <87o9bl6xlo.fsf@notabene.neil.brown.name>
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

> On Tue, Oct 23, 2018 at 03:25:08PM +1100, NeilBrown wrote:
>
>> >> If Linus is not true to his new-found sensitivity, we might need some=
one
>> >> (Greg?) to be a co-maintainer, able to accept patches when Linus has a
>> >> relapse.  It might be good form to create this channel anyway, but I
>> >> doubt it would be needed in practice.
>> >>=20
>> >> So there you have it. The "Code" is upside down.
>> >> We need documents which:
>> >>   - curtail the power of the strong, starting with Linus
>> >>   - are adopted willingly by individuals, not imposed on the communit=
y.
>> >>   - provide alternate routes for patch-flow, so that no-one has ultim=
ate
>> >>     power.
>> >
>> > Really?  The ultimate power being to say "No" to a patch, and nobody s=
hould
>> > have such?  Are you fucking serious?
>>=20
>> I have noticed of late a tendency in all sorts of different people to
>> hear/read a statement from someone they know, interpret it a particular
>> way, be surprised about that interpretation, and persist with believing
>> that interpretation anyway, rather than realizing that the most likely
>> explanation is a communication failure, and asking for clarification.
>>=20
>> The "ultimate power" is the ability to say "no" to a patch, *with no
>> opportunity for review*.  Two people together having that ultimate power
>> is a totally different thing to one person having it alone.
>
> If that's a clarification, I'm sorry to say that I understand you even le=
ss now.
> What are you proposing?  Duopoly?  How do you deal with disagreements?  F=
ork?
> Revert wars?

We already have team-maintainership arrangements - doing the same thing
at the top level should not be that hard to imagine.

It really about "saying" no.  I suspect all members of a team would come
to much the same decision about any given patch, but they might "say" it
differently.  One might say "anyone who wrote this should be
lobotomised", and the other might say "I see what you are trying to do,
but the approach won't work - go look at how we handle XXXX, they have a
similar problem".  Neither will accept the patch, and they will probably
both accept it after certain changes.  But when one of them is having a
bad day, I would like people to have the explicit opportunity to ignore
them and talk to the other.  Yes, they'll still get "no" twice, but they'll
also get something approaching sane review least once.

Just knowing that the person you are ranting at can by-pass you would, I
suspect, encourage a lot of people to reconsider their behavior (though
maybe I'm optomistic there).

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvOsWQACgkQOeye3VZi
gbkjxhAAh+AJbCPvpt2p1qLRsAT8UTDbRT26YN0sqE4dhemBMx7Vz7+ZQKa33Oh9
RIxeqT8s5OSTxpxV4jRd9vX+xpFKxN8LefeGA0juesyPDMZh4TGVQbGn4tvAg8NQ
Mvl7tEzwbMqmQPBIlPyDLAi5dvN2vvKtLCwVgnc26n6ZX7+7pwomjjUhdE9JqnE3
haNVdaYvIcLU5kac3CVqXio8IhjAmwQLlSPoM5bV+J7u95ZxkTaOomqHzrEbkxRa
kUK24P80nIbOG5nrQgX2o5P26iePY8tGwmABE7HbQH1P+4dsD6qfWJCJIPKXG0A2
+ASsKaC+UegwTBMtghYPuldBtimPZEbDR06W9RjIOx4q1bOO+C7hXNXfMV07wCGk
T4N3MbiNLkEBeX7TVfm98q8KVk45t2PZe86rVT2pldgdA39Sf4kYmAKzAOZ1qP+N
djini6whfvxbUfbY6Eg5+Pu3qQ3uIcWy/MQhYocnU88XYxc8wmdIY6wM0NngksmG
E1CYQd72Dgj42Iv23H+28dPDxkzEn9NPROoJHf9xVlyChKISOeFfrEGnRlaqz849
sP89Wrbt0Ce1pWqLyq94eG8VGmj6kaKAK100Jedvl+Hm+InKSBECBGGtb8NsqGnh
5uEnkXckyLXlx+7GNWRharjq82/Pjly+5L9F91DHyvhYuGujuWc=
=NgxU
-----END PGP SIGNATURE-----
--=-=-=--
