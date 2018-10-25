Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399DDC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDDE2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDDE2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeJZFtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:49:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:54042 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726075AbeJZFtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:49:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7EEE4AF0D;
        Thu, 25 Oct 2018 21:15:02 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Josh Triplett <josh@joshtriplett.org>
Date:   Fri, 26 Oct 2018 08:14:51 +1100
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an interpretation document
In-Reply-To: <20181024121622.GA10942@localhost>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name> <20181021222608.GA24845@localhost> <875zxt919d.fsf@notabene.neil.brown.name> <20181024121622.GA10942@localhost>
Message-ID: <87ftwt6850.fsf@notabene.neil.brown.name>
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

On Wed, Oct 24 2018, Josh Triplett wrote:

> On Tue, Oct 23, 2018 at 07:26:06AM +1100, NeilBrown wrote:
>> On Sun, Oct 21 2018, Josh Triplett wrote:
>>=20
>> > On Mon, Oct 22, 2018 at 08:20:11AM +1100, NeilBrown wrote:
>> >> I call on you, Greg:
>> >>  - to abandon this divisive attempt to impose a "Code of Conduct"
>> >>  - to revert 8a104f8b5867c68
>> >>  - to return to your core competence of building a great team around
>> >>    a great kernel
>> >>=20
>> >>  #Isupportreversion
>> >>=20
>> >> I call on the community to consider what *does* need to be said, about
>> >> conduct, to people outside the community and who have recently joined.
>> >> What is the document that you would have liked to have read as you we=
re
>> >> starting out?  It is all too long ago for me to remember clearly, and=
 so
>> >> much has changed.
>> >
>> > The document I would have liked to have read when starting out is
>> > currently checked into the source tree in
>> > Documentation/process/code-of-conduct.rst .
>>=20
>> I'm curious - what would you have gained by reading that document?
>
> I would have then had rather less of a pervasive feeling of "if I make
> even a single mistake I get made an example of in ways that will feed
> people's quotes files for years to come".

Thanks for your reply.  Certainly feeling safe is important, and having
clear statements that the community values and promotes psychological
safety is valuable.

The old "code of conflict" said
   If however, anyone feels personally abused, threatened, or otherwise
   uncomfortable due to this process, that is not acceptable.=20

would you have not found this a strong enough statement to ward off that
pervasive feeling?

In the current code, would The "Our Pledge" section have been
sufficient, or do you think the other sections would have actually
helped you?

>
> See
> https://hbr.org/2017/08/high-performing-teams-need-psychological-safety-h=
eres-how-to-create-it
> for more on the benefits of that.

Thanks for the link.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvSMkwACgkQOeye3VZi
gblbqxAAxHLxaEPR964HG/HkxGC7q+P2Eve9bvQII+JykbmmvyUrwmAz97vvk/jo
yKR5eQWsm/zNQPnLQCHQilF+v35dtE0qOqHCEqcza6aJepB1lTbwx5af2o5ZnkNk
KA9SSLcfdyYfP8Pq8GpmlS/c+53qNt6OIYhYJngudxbP6VpgysRl79vaAcEHuVfi
6ToYJzKMm/ZsJLqOQuaTQsvhEmF/e6yrdXFbCCQQzuZAjnwvKKMUkSGpnRaux3wi
1GTlRJflJKr1rI9XWQptRwfJu0esrH00q2BxuLc2UQqO4FcDpLwpDlJUecXVoClm
6lXE7cV/pjq7IghfpsCplLHWd7e/3xJWvc4xe9g8jHTbqnTkeCGDAZLEaKPCBTXi
CSXIoVV/2i80wNONQgUm3OUYg4MXcoOtp/lr/eS0c6OO3xa8BLIKFvgtKjDKxaZP
yGfe3viXpt1IyRlnli80+79HS4YNc2abM/hQwFhV2eRc04M5nZNfZHp36xVwyYoA
5qO906UTcBxW2+mz5aY4Zc2PRT6keBkHRAKQuJuQuL1yq/d9oM9rPq/9L+3K2aMS
8YjlU0Y76lA4B4GKBJ5/nyunLxxYDb5ZM2/QJSXOqGx76pJyTWfki9okjLLyc+Hu
t2O6b+GoQts7rNwj4G6KPL+Q104u1DVQBX9dClAuVoRwk4TLUQc=
=qLBs
-----END PGP SIGNATURE-----
--=-=-=--
