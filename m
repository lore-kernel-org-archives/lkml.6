Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1ADC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51A920665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51A920665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeJWJxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:53:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:42640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726872AbeJWJxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:53:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E649DB111;
        Tue, 23 Oct 2018 01:31:58 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Date:   Tue, 23 Oct 2018 12:31:50 +1100
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Mishi Choudhary <mishi@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an interpretation document
In-Reply-To: <20181022224604.GM1617@thunk.org>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name> <20181021222608.GA24845@localhost> <875zxt919d.fsf@notabene.neil.brown.name> <20181022224604.GM1617@thunk.org>
Message-ID: <87zhv578jd.fsf@notabene.neil.brown.name>
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

On Mon, Oct 22 2018, Theodore Y. Ts'o wrote:

> Neil,
>
> I disagree with your framing, and thus your analysis, and thus your
> proposed solution.
>
> On Tue, Oct 23, 2018 at 07:26:06AM +1100, NeilBrown wrote:
>> If, for example, Linus or Andrew said "if you cannot work with any given
>> maintainer, I will consider your patch directly, but you need to point
>> to where you tried, and why you failed - or to where the promise is
>> inadequate".
>>=20
>> Currently if a maintainer is rude to you, there is no where else that
>> you can go and *that* is why it hurts.  It isn't the abuse so much as
>> the powerlessness associated with it.  If you can (metaphorically) say
>> to that maintainer "I don't care about your toilet mouth, you've just
>> given me the right to take my petition to caesar" - then the emotional
>> response will be quite different to pain.
>
> No.  That's just not how things work.  Patches don't get rejected
> because maintainers are being rude.

Correct.  Patches don't get *posted* because maintainers are rude.  They
don't get accepted because they weren't posted.

Do you disagree with my claim that the main cause of hurt is
powerlessness?

Without that, we may as well be on different planets.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvOegcACgkQOeye3VZi
gblcNg//S58VVjjjMr2btixUyPpMDGO/CO3cv3uCJsWdA1BSQtfESiBziFkV6szz
5LuTe2YWR5U62e/p/rzO2Kd46IsAHg6pS3N7W8OH5bTUd7za7pyvlZDJLmYo4quO
WTUl2OCk8VYYE2ICdSw8gwMtlcjgiVDI+Yg4pJa72G+N+OTNJWYsPet0s9G9RwhY
ID3CCCyRD9hH4Ihn58ju4xVUtZ9hJIM9pHIYMq5j2Y+G9STjrtFlJOvqO0cqPtIG
Y3doHbvjrR+dcqqnS/i7p3iJej4VqDmoENCxq8OdRsqe1g5ovpo9JJyfPljAKXSC
arWBdGC3NLE0BrGkGxvHzilE3UKFKJvxGsQxtd2SI1Ay3fx47EUo/1s7+K6BvKJ8
9lA/JACaAe9JY4cx9BnYamRLv63Rj1hHVycssORuVxTZ/NTH2GxZEy+q9vVaItAH
6fVlp+OWGX5HGJrX3p9B5Y3KM3HuN24wAQspzwq6IzZLv7TVwRsi7xUwNajNG4v5
ryFfZYedLGZOxVdlpt53rGw9pA6Hon3GYLADlnrtAr+f2uoeGulBuvUtaQtxSdjT
w5B3368ajiwGGPfhZuweW6yZ4L7GBemdWx8OHdET4Di+i90XWLAbiR0ZLQM3bFtQ
SvGnVaVqIeSqFFV9l0trlyhEA0DqKK+wJ599RoHdjwTHqbpiCtA=
=ulff
-----END PGP SIGNATURE-----
--=-=-=--
