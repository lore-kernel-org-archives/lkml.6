Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A204EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4665A214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="R8nh4h59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4665A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeIQXPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:15:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47470 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIQXPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FQK3AWVzFJm3Lt1auEIfVxtheHhHvaQ0K+bd+QF3lbI=; b=R8nh4h59RNuZh6kBGXbnY9uCe
        v/cT/X31P/SssQPP6ebom5j0mdQnT8rM9yeh5VyeUrS2EPKXi1m2RJkJVAKdGhZ0sz07y6yuD/AoF
        mNB0TtbHay5pVKa2y1XCpiu1enTceybNLGTJmvJJpoc4FYr4wKXbSGnPGv6Ylrkm0MsmY=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g1xcE-0008Qr-L4; Mon, 17 Sep 2018 17:47:18 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 9D760440078; Mon, 17 Sep 2018 18:47:14 +0100 (BST)
Date:   Mon, 17 Sep 2018 10:47:14 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-yi Chiang <cychiang@chromium.org>
Cc:     rohitkr@codeaurora.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>,
        Ryan Lee <ryans.lee@maximintegrated.com>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: max98927: Add reset-gpio support
Message-ID: <20180917174713.GD2471@sirena.org.uk>
References: <20180912121955.33048-1-cychiang@chromium.org>
 <20180912121955.33048-2-cychiang@chromium.org>
 <7aa3c049-5ba0-1db3-08c8-510da1cf779d@codeaurora.org>
 <CAFv8Nw+mVHroA599ofmK6pwtPQXgP823B2_FG4G0bm5EkNhdWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <CAFv8Nw+mVHroA599ofmK6pwtPQXgP823B2_FG4G0bm5EkNhdWw@mail.gmail.com>
X-Cookie: Universe, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 17, 2018 at 05:00:28PM +0800, Cheng-yi Chiang wrote:
> Hi Mark,
> Do you have any concern about this patch ?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.
Sending content free pings just adds to the mail volume (if they are
seen at all) and if something has gone wrong you'll have to resend the
patches anyway.

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluf6KEACgkQJNaLcl1U
h9CS1wf/d6GVXQlfL4Lgdd5viNWFNrQ1PXcoLgxhQ/pdMXgR3VWtjl5dZptkLUDr
JiQht+aZgduo8AcfI842uzQJOpjJQEMc79mzHyR472iKMJMi3Q4bqaz+jcLLx9sA
pPNoGVP5S4D68KJEEzwulTDXVdUTOkn9vfh8ygcpF+Q+33uQ0jHItwVwjAX9bjpp
9x457ke+W8XSQ1eE4EZX5UVFT+SDU54gy64sau3hsrQcz2HieBjRyu/4g7xl7k9x
wJjrdmGHIVXKo1mzr2yrjdzyWRPWOctaEeRC45jULEzQoWsQOc/abXmQgw0bAmZe
lNohr/AuSX8sWHkzThY9kZm65Tf4tQ==
=GbVP
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
