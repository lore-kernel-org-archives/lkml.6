Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67F0ECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 08:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F13E2087B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 08:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F13E2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeIPNoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 09:44:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34401 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeIPNoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 09:44:38 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C83BA8074F; Sun, 16 Sep 2018 10:22:28 +0200 (CEST)
Date:   Sun, 16 Sep 2018 10:22:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        rdunlap@infradead.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        luciano.coelho@intel.com, linuxwifi@intel.com,
        linux-wireless@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: v4.19-rc3 on thinkpad x220: kernel BUG at
 kernel/dma/swiotlb.c:521 when enabling radios
Message-ID: <20180916082227.GA4602@amd>
References: <20180916064702.GA4180@amd>
 <20180916065703.GA4392@amd>
 <CAF7Mx6o1PV2xcgLp94=9OP1ZaxoxjebPE1_t93hQ65UkDLgKWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <CAF7Mx6o1PV2xcgLp94=9OP1ZaxoxjebPE1_t93hQ65UkDLgKWQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > I was running X220 with wireless disabled for long long time. Now I
> > > needed to enable it, and got...
> >
> > Tried with next-0913, and machine crashed with capslock LED blinking
> > when I toggled the switch...
> >
> > Any ideas?
>=20
> Replying using my phone. There has been such a report from Randy Dunlap on
> September 11 with subject "4.19-rc[23] iwlwifi: BUG in swiotlb".
>=20
> Did not quite follow that, just recall seeing it fly by. Maybe it helps.

Thanks for pointer.

Hi, Randy! We have same problem.

I switched back to v4.18, and it seems to be ok.

I'd prefer not to hear the b-word. Any other ideas?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlueEsMACgkQMOfwapXb+vK6igCgtQ23s8F5RGloD0DXZehRvtZH
j8gAnjhINpzzmzRaD5ICdCnIIHlRrksz
=HcVE
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
