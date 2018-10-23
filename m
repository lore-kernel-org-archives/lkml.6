Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F869C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6179620671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6179620671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeJWMq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 08:46:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:58328 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726438AbeJWMq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 08:46:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11289AE81;
        Tue, 23 Oct 2018 04:25:19 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Date:   Tue, 23 Oct 2018 15:25:08 +1100
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an interpretation document
In-Reply-To: <20181023033130.GQ32577@ZenIV.linux.org.uk>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name> <20181021222608.GA24845@localhost> <875zxt919d.fsf@notabene.neil.brown.name> <20181023033130.GQ32577@ZenIV.linux.org.uk>
Message-ID: <87r2gh70ij.fsf@notabene.neil.brown.name>
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

> On Tue, Oct 23, 2018 at 07:26:06AM +1100, NeilBrown wrote:
>
>> Currently if a maintainer is rude to you, there is no where else that
>> you can go and *that* is why it hurts.  It isn't the abuse so much as
>> the powerlessness associated with it.  If you can (metaphorically) say
>> to that maintainer "I don't care about your toilet mouth, you've just
>> given me the right to take my petition to caesar" - then the emotional
>> response will be quite different to pain.
>
> Bollocks.  First of all, you *always* can take patches to Linus, even if
> maintainer is being the sodding Miss Manners.  Always could.  What you
> can't (and shouldn't be able to) is to _force_ a piece of shit patch
> (pardon the toilet mouth) into the tree on the grounds of maintainer havi=
ng
> been "rude" to your patch.

Yes, you could, and you can.  But if it was Linus who was behaving
inappropriately, where did you go then?  This is why I think whatever
"code" we have should be overtly a statement Linus makes about his
behaviour, in the first instance.

And of course a bad patch should be rejected.  In many cases a bad patch
can then be improved.  If the maintainer responds badly to your first (bad)
patch, it can be very hard to try again - once bitten twice shy, as they
say.

The point of being able to circumvent a maintainer is to be able to get
relevant rational review, instead of emotional attacks.

>
> Again, you can and always could appeal to Linus if your patches are wrong=
ly
> rejected, in your opinion.  You'd better have good evidence supporting the
> "wrongly" bit in that case, but the "right to petition" model implies that
> anyway.

I wonder how many people know about this right-to-petition, or use it.
Maybe it should be stated in the "Code of conduct".

>
> If you are talking about the situations when "rude" maintainer makes insu=
fferable
> requests to one's precious patches (e.g. demonstrates his or her mental i=
nferiority
> by admitting that they are unable to follow contributor's 0.5KLoC of spag=
hetty in a
> single function and has an unspeakable gall to demand to clean it up - in=
stead of
> passing that task upon the interns, as they ought to[1])... sure, that wo=
uld be
> something new.  Would you care to be the person charged with dealing with=
 such...
> valuable contributors?  And how good is the coverage of psychiatric treat=
ments
> offered by your medical insurance?
>
> [1] no, I'm not making it up
>=20=20
>> If Linus is not true to his new-found sensitivity, we might need someone
>> (Greg?) to be a co-maintainer, able to accept patches when Linus has a
>> relapse.  It might be good form to create this channel anyway, but I
>> doubt it would be needed in practice.
>>=20
>> So there you have it. The "Code" is upside down.
>> We need documents which:
>>   - curtail the power of the strong, starting with Linus
>>   - are adopted willingly by individuals, not imposed on the community.
>>   - provide alternate routes for patch-flow, so that no-one has ultimate
>>     power.
>
> Really?  The ultimate power being to say "No" to a patch, and nobody shou=
ld
> have such?  Are you fucking serious?

I have noticed of late a tendency in all sorts of different people to
hear/read a statement from someone they know, interpret it a particular
way, be surprised about that interpretation, and persist with believing
that interpretation anyway, rather than realizing that the most likely
explanation is a communication failure, and asking for clarification.

The "ultimate power" is the ability to say "no" to a patch, *with no
opportunity for review*.  Two people together having that ultimate power
is a totally different thing to one person having it alone.

Thanks
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvOoqUACgkQOeye3VZi
gbl5dg/7BVUVORVpSJ5vVNBa+rFP/F5QAeIz46rh0+Dn95fEO2RtJ/zUbkmnbc2U
rrswH21tN1cjUYbbbahUKmnJvyY+sOMHXq2CIVcL01m6tfwuOVaarl8tQE+lqBuj
lIzuyp41ncYqYa5HIiPRDJXu5B33oYRjZuQDbADDIgNx2V+DUDjsi7Ii5VJJXszj
A81petng7ukenGCC85DU02tx2ys1AuBRZAInpUhedkAnwif0Q01MwT1D0VtQTaEO
Nn31ao/AAO61OzH2VXSPARHXY1qqyhK/+GSbZDi9LPtsIVGuicOQtA6eZSpnvVqi
ULoRID6nh0CAyWLANYKPzeLz8oaLAN2v/ev1J7XyZYpv46LAJrrDEOdmV+OJ/dAr
ghOlrMXUO4qVOER4kwuMS3Lek7SsoLfEhf72J4chRuuTEEZgi/Buze0M/hTCk2/d
KEhxnV/wdoU6oAxPOVedkgLXh9hcD/Gi91MtWPh6Pfe6wOfzGzaYp+R/4CKbqGem
jG6VSmei6HDfgR80pjfXEfKbtPl83wKGzhsN3NXovex+perCIUGyX9hxHBRaml5p
sI87+ClOxBP5JIXNSYQdMq8+FqXN/dXDaCrCCKxB0qvIHrzz2QJqS+MM7EoTec+c
6RrKlVkBkYiIrszuwytHHRXpCrkjqEX5rRzlbsB1IxUA5PfEN7k=
=CKBo
-----END PGP SIGNATURE-----
--=-=-=--
