Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0507AC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0645213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0645213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeJLEbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:31:14 -0400
Received: from sauhun.de ([88.99.104.3]:41594 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbeJLEbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:31:14 -0400
Received: from localhost (p54B3377B.dip0.t-ipconnect.de [84.179.55.123])
        by pokefinder.org (Postfix) with ESMTPSA id 7A0DE2E3577;
        Thu, 11 Oct 2018 23:02:11 +0200 (CEST)
Date:   Thu, 11 Oct 2018 23:02:10 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH] i2c: Fix kerneldoc for renamed i2c dma put function
Message-ID: <20181011210210.hsrxwqbc2loultks@katana>
References: <20181008145520.36810-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dng3cjxcefyt7pl7"
Content-Disposition: inline
In-Reply-To: <20181008145520.36810-1-swboyd@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dng3cjxcefyt7pl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 07:55:20AM -0700, Stephen Boyd wrote:
> This function was renamed in commit 82fe39a6bc7b ("i2c: refactor
> function to release a DMA safe buffer") but this kernel doc wasn't
> updated to point at the new function. Rename it.
>=20
> Fixes: 82fe39a6bc7b ("i2c: refactor function to release a DMA safe buffer=
")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied to for-current, thanks!


--dng3cjxcefyt7pl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu/ukwACgkQFA3kzBSg
KbYecRAAlUpqMldRD91/4Bpapu7M0C7rwGJ6PJPw43VweR9JQD/x0r/YE/6//EHs
4thzz2Ip7bUI/cQ8XfkfVLO/XylnIHRF9x+DbAyUO4yXWQiUBEoFMp179ZYSyrzp
Y8QdJNq8ykpNRezjJI4UjMudKLcwhoXFxOegFyXyN++IpUnru8QvyKz6ddgPSEJE
SQLpVlh1r/9U7r310ozxJi3VQMCd+saYekgXj5Vl0OO8MKlgX5vxK2+CrlD448v2
/Jazywg8l6CFCZLfsIzfMxpagRFAx2zmcIkI0EdVrcrZ8St8pPhl9+m7/2t+/ub/
ThHBm/fi+vjlfi5JllbbABTRlksHPaFivh39r1o5mzer/eRMbWT2huCBzXfmlbnx
rLiXPaGfYdI0Kr2B1c1nmDncRyAUsrPtYQ584kLHOD/urdvhFQ5+AYW24UhJ4tft
MaHPyKRxVVPqsTASeMrVCbiN/etfvruX+O/WkXp1Sjba+aHFPERZe8cFnib5D8w/
7sIS7CiUjhuR+dPau46n07qylx0i7y92UTQ8KJT+8BU6i+jHYXr0Bbf6TYWeU1sb
acxqiNeD9ydOZrcBJc3z1iZk27lvbeNQsju3z2jQ1Qu9hgK9VGuaY0wzT7IO3ynZ
WQlfiQWEiPE/aZ/8Krr5PQUO1G4X1ZrUjxcxIEZSuen9ElbolXQ=
=wISp
-----END PGP SIGNATURE-----

--dng3cjxcefyt7pl7--
