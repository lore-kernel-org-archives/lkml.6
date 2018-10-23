Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E01C004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7180920672
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7180920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeJWKGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 06:06:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:43616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbeJWKGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 06:06:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3DEDCAF6C;
        Tue, 23 Oct 2018 01:45:05 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Josh Triplett <josh@joshtriplett.org>
Date:   Tue, 23 Oct 2018 12:44:58 +1100
Cc:     Mishi Choudhary <mishi@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an interpretation document
In-Reply-To: <20181021233709.GJ1617@thunk.org>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name> <20181021222608.GA24845@localhost> <20181021233709.GJ1617@thunk.org>
Message-ID: <87tvld77xh.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Sun, Oct 21 2018, Theodore Y. Ts'o wrote:

> On Sun, Oct 21, 2018 at 11:26:08PM +0100, Josh Triplett wrote:
>> On Mon, Oct 22, 2018 at 08:20:11AM +1100, NeilBrown wrote:
>> > I call on you, Greg:
>> >  - to abandon this divisive attempt to impose a "Code of Conduct"
>> >  - to revert 8a104f8b5867c68
>> >  - to return to your core competence of building a great team around
>> >    a great kernel
>
> I would point out that Greg did not chose to "impose" a Code of
> Conduct.  That directive came from Linus; the change was signed off by
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Linus, and the choice of the timing came from Linus.  That's why the
> initial commit went in with very minimal review.  This series of
> patches, especially the first two, have a very large number of
> Acked-by sign-offs.  That's because there was a *huge* amount of
> consultation with the top contributors to the kernel (using git
> statistics) before the patch set was posted.
>
> This level of consultation did not take place before Linus took his
> break during -rc4, precisely because he didn't want people to think
> that Greg did this "behind his back" and so there was no time to do
> the sort of consultations which we did with this patch set.
>
> (And when I say we, although the TAB was obviously involved, Greg did
> most of the heavy lifting; and this is something that I can say
> definitively Greg did out of a sense of duty, and because he was asked
                               ^^^^^^^^^^^^^^^
> to take on this role.  It obviously has *not* been a fun job, and Greg
> has taken a lot of flak.  I, for one, thank Greg for taking on this
> thankless task!)


"I was told to do it" and "it was my duty" are not excuses for doing
something wrong.
I'm genuinely surprised that you would suggest it is at all relevant.
What am I missing?

NeilBrown

>
>> (I personally *do* want to see most of the patch series that started
>> this particular thread dropped, because half of it undermines the point
>> of the document. The original commit, however, is a matter of
>> celebration.)
>
> Josh, here I think it's clear a very large number of kernel developers
> disagree with you.  Part of the concerns that led to creation of the
> interpretation document was precisely because there was a lot of fear
> mongering from people outside of the kernel development community,
> some of them apparently from the Gamergate brigade.
>
> And so while it is certainly true that a huge number of open source
> projects use the Contributor's Convenant, and you don't see large
> number of people getting "impeached" for stupid stuff from, say, the
> GoLang project, there were a lot of people who *were* afraid that
> perhaps, some of the insane/silly interpretations that had been flying
> around might have actually been true.  Perhaps that's what Neil is so
> worried about.
>
> For example, it should have been obvious that if code is rejected for
> technical reasons, some shadowy, unacountable group would ***not***
> second guess the reasons for a maintainer's decision and magically
> eject said maintainer from kernel development.  Maintainers still can
> reject code for any technical reason, and in some cases, for good
> non-technical reasons, such as the Netfilter team and code
> contributions from someone who had been deemed, by his deeds, to be a
> copyright troll.  And as always, people who disagree with a
> maintainer's decision to reject a patch can always appeal directly to
> Linus by sending the change to him.
>
> The Linux kernel adopting the Contributor's Convenant was not going to
> change this.  And certainly people haven't been using the
> Contributor's Convenant to try to force crap ideas or crap code into
> the Go language.  Unfortunately, because the Code of Conduct was
> suddenly dropped in with minimal chance for consultations, that fear
> was out there.  And that's why IMHO, the interpretation document
> became necessary.
>
> Ultimately, what we're after is a cultural change that will hopefully
> strengthen the kernel community and make it a better place.  Neil is
> correct that ultimately what's important is not words in a document,
> but how people behave.  And so, if the words were causing a lot of
> anxiety because were afraid that even accidental microagressions would
> cause them to be permanently "impeached", and that failing to nit-pick
> every possible microagression might be grounds for "impeaching" a
> maintainer --- then making it clear that this is not what anyone had
> in mind is a very important thing, since anxiety can lead to people
> actively resist the cultural change which most of us are want and are
> working towards.
>
> Regards,
> 						- Ted

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvOfRsACgkQOeye3VZi
gbmptQ/9HPr13XAaEVKPbm2f3JWWgZbXjLQxbEgpnAnbWWVa5+W2jd9gKx2Z59eL
tUrVQ2XxJ7WFVnnqRMR/ZlggXHm4QPmIgTdahoL28Z4f6tm3s6TnsOGr1Zy7oq/V
xf0L07mW/XosNDEwb2Y1YC9hbL8bYvxg00fyeZQVXtYiImxXJvRYJmFxNQUyW8Qh
H8i50vGQTxWCpmtuy2CXxzbML92Agyq+7MvIFNyh0R3bxXgApFlTgS6gMA+NPvw1
Ijv5bupYnin0CakXpfb+d75TUeNkxe1isicDM6e1P0jH05QS32rt8x1Fu9T8nGBu
+FJFuSHJFScYjg933WIYTYiUdPPJia0AqJ6QcRQMEjj187fAzwnocru33xXamwC4
vg5nBrq5jxEjJex7U4edTAhZdYc8fOlQpyOF+MykOAfXrI84JLZyGngvqYxUOtlm
FBr2TG55LxdXMCRXUxFDE9huIG7sm9iRidOwWtFuAWQZYE+lVIlakkZy/r1Cfeb3
OyA/uih+fxeLKZ4zctd3AN5zd+LW/TT/UfP+frUfizJZTW0ys2sDzto0mrh6Q2eW
KjOVCjuBS1eW+bzfHQO9qL3lwFCd/3aIQl4flj6OfyptKh+S3ebGo4/i3EUKDyoR
jWqkN5mXBWxrBrSfCyjcLlHnmUe0QlBV+xlnaqu3afWpb1s2VDA=
=7M+W
-----END PGP SIGNATURE-----
--=-=-=--
