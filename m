Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CAFC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441DF208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441DF208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeIYES7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:18:59 -0400
Received: from sauhun.de ([88.99.104.3]:38938 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725743AbeIYES7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:18:59 -0400
Received: from localhost (i577B9B6D.versanet.de [87.123.155.109])
        by pokefinder.org (Postfix) with ESMTPSA id E52C82C0599;
        Tue, 25 Sep 2018 00:14:35 +0200 (CEST)
Date:   Tue, 25 Sep 2018 00:14:35 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Colin King <colin.king@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: i2c-isch: fix spelling mistake "unitialized" ->
 "uninitialized"
Message-ID: <20180924221435.GH18592@kunai>
References: <20180924171437.3071-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Content-Disposition: inline
In-Reply-To: <20180924171437.3071-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 06:14:37PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Trivial fix to spelling mistake in dev_notice message.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to for-current, thanks!


--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlupYcsACgkQFA3kzBSg
KbYo7A/9FELjcZH/Lcr86xarLkGDMI/KSC5EFpa04dFESW86aRJhjZZYc4lGR1Wo
m3oiGZObxtqU1HdSQq/CdFb5DKZvVKP/VD8+RNTEQFtUrexAIXx08rnjY01JBWFU
38X1tIhg3fTM3JY2bVfUErZzuERL9ScwTmqIytfb1hzIfrWWZlY1/Cxva3q9GuOF
71q9cHhcKSLytGJmDVBxvnsfXzzQ6o2nC0e+e00uSOH+59KH+Rui8iHsTKM/uU25
AjVHdYR2T3uWL8L/ZsQUNYss3KKT5U8Hi7hJyxue6XYO/IhzNCt2DT754S36AAN/
7ghwSBgG1ewHCWbL3lY11zmYvZpH2HOXPNv+R17/w6F+i3Np+kShAd/PfwRWH+1L
SmdYTB704ex4pVuQDOghoXLGDpzpVR9cOdq9TqHnDGWProT1+4Qpv7wR/mHk/gKm
Z9YQOV+Yoi1afjuVGZZW5ROwnlkCuGkjEY06ndlMmhAZJmMYP8DUBdqxylYmIl81
P1EZRTwus/4gtMyQEpfGxolVqySuKr9+h1GlH7WZSvxlirvb8p4bwL46ALBFLBio
7O5MR+RDnACn2EkfHAahs/3y9ff99PBTLZoMJ3f5ZhhoV8Hs6gSvWIpInGZqmSD5
K29QEkedoyf7jKSirkSH0cTPhAFX+DmfJ7tLEERyxiitq/IXko0=
=Fi9A
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--
