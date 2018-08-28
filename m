Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F40BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DDD20875
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DDD20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeH2DxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:53:15 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39581 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727094AbeH2DxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:53:15 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1funt9-0000m8-EY; Wed, 29 Aug 2018 00:59:11 +0100
Date:   Wed, 29 Aug 2018 00:59:11 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <20180828235911.GL18030@decadent.org.uk>
References: <20180828235656.GH18030@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQAwcd5tHl0Qlnzi"
Content-Disposition: inline
In-Reply-To: <20180828235656.GH18030@decadent.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: Re: [PATCH 0/2] Build fixes for liblockdep
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQAwcd5tHl0Qlnzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Also, please update your address in MAINTAINERS.

Ben.

On Wed, Aug 29, 2018 at 12:56:56AM +0100, Ben Hutchings wrote:
> In addition to the patch I recently sent for lockdep itself, the
> following fixes are also needed to make liblockdep build.
>=20
> Ben.
>=20
> Bastian Blank (1):
>   liblockdep: Stub NMI watchdog reset
>=20
> Ben Hutchings (1):
>   liblockdep: Stub task_struct::state
>=20
>  tools/include/linux/lockdep.h |  4 ++++
>  tools/include/linux/nmi.h     | 12 ++++++++++++
>  2 files changed, 16 insertions(+)
>  create mode 100644 tools/include/linux/nmi.h
>=20



--=20
Ben Hutchings
For every complex problem
there is a solution that is simple, neat, and wrong.

--LQAwcd5tHl0Qlnzi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBW4Xhzue/yOyVhhEJAQrtOQ/+OkFqjmPWQfJo/P82v0lncsbaJR7G7z0y
a78xtXvvAgoaR2qOryGKK0dK82V1ERa5ELbwfI+DN95Ye3AEYTCz2PorIbImRKzL
amSVy5+J1W5NRkmrayv8HaOtVTYXdBnDnGS039HRwCwXPeNehzOqO791PCMeoZU6
Rqi3RCzAkUgTMhaUxO4HzFJQJAplRF6AAGjql8oAmdw2tBtN8s/2XYy/i2FMT42k
WsBgzYvUax3BybFeydG58CkDpsDsglZWP1lD5Bxp8UtSIGTwYhem7jx4iShi5uH2
zfYcunfDf03tKEWPAHvtCeci94A7vP4ds7z9xKnte4FJioK7WNSoFstkpoVcb/BT
Lwn7ig4oeNhRMaIvaT/PK5BHixsDZB6G5P3Ssx/axZoqbiH9gLAe6L7erWZWF+iG
sWV83DSLadmwPybiee0Bae/dW46S0ofgPmQlCjSESdvcnU/WR7u/M7suRKJLrm4F
WSErnsYF8gdxoVCdC1SvkVXr3rSo4N67YhHIaqNVjyNm1GIuZNzaI5tr8XXaIDOB
mzsQtdCnMVKVK5fkOozi2hVgFe+9Yuae7zACahSh3WN8dxLN/gRPqbS/lvtmFBng
6G00aGFlazvlDgamnQraopaxfwWJ6939NTS25l6KOF684bMjz7QYVtwoQBbYHCwv
LabOmb0RFRI=
=ym5Y
-----END PGP SIGNATURE-----

--LQAwcd5tHl0Qlnzi--
