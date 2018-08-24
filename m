Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA47AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1E021477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1E021477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeHXSgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:36:23 -0400
Received: from sauhun.de ([88.99.104.3]:41406 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbeHXSgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:36:22 -0400
Received: from localhost (p54B33931.dip0.t-ipconnect.de [84.179.57.49])
        by pokefinder.org (Postfix) with ESMTPSA id A4423305D9C;
        Fri, 24 Aug 2018 17:01:19 +0200 (CEST)
Date:   Fri, 24 Aug 2018 17:01:19 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Sedat Dilek <sedat.dilek@credativ.de>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler
 warning
Message-ID: <20180824150119.y7ikykvq37a6brbj@ninjato>
References: <20180819135135.8801-1-sedat.dilek@credativ.de>
 <20180824130130.bialyhjarwkwodzw@ninjato>
 <1335058904.531.1535118581478@ox.credativ.com>
 <20180824140705.t3pkiqfpnqzaaksz@ninjato>
 <1600966696.540.1535120394100@ox.credativ.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ypud544zi5r45xoq"
Content-Disposition: inline
In-Reply-To: <1600966696.540.1535120394100@ox.credativ.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ypud544zi5r45xoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 24, 2018 at 04:19:53PM +0200, Sedat Dilek wrote:
> > Wolfram Sang <wsa@the-dreams.de> hat am 24. August 2018 um 16:07 geschr=
ieben:
> >=20
> >=20
> >=20
> > > will my patch go to [1]?
> >=20
> > It won't be needed anymore, the __deprecated function will go away until
> > next week.
> >
>=20
> The relict in drivers/i2/Makefile should go away, too.

Correct. I will apply your patch, just with an shoertened commit message
(because the use case is gone) if this is OK with you.


--ypud544zi5r45xoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluAHbkACgkQFA3kzBSg
KbZ4rRAAhxadVF05CgNk4OwtTLIpGXgZLUYQy0wJId3h+thmcGT8OkQ9uUvintRo
Iz/fFfl33Or9DhdSTSungbWqjA9FkhNXfi0vg5rXbwsvMOg/oFFsEYEW+uR53sX7
CyEcpd8kYiIKYGuV5ppo7Y5pMVF336cqyt7tt7FoB6cpvCphoYVZtvg3hjkjfMLW
npUtkaWO4ZvTb/EvZQbYLg3j8fgOlnB4qJ1nIxJHAXFfGHp6eup9m5ve2m9d/1ae
V451XukT1fmyFWHiIK6iM0OvSX9F5cWsJ0/v3AvNhxvO0nVZLvAjaynmwzjvzKO1
9BzEQkfYQp/QKpVAOLQeh0nsTCj1DTGR6y8RC9ss+B/yylQ8aZfaUpdRmVi5mwvJ
jfqN3x4UPdxCkSqzHoqBjBi5hMr/HgJgHoc8VqlWJJ8RzKABZvYtriBIGOLhhUay
Pcgsw7ZR7gdjkSOrvd3nve9d/1P8zB5heR1DJFGDUjn8hmXORE8/+iFt1f/BQq6x
9V52/c+v/hmYNdNOPO7ZhsMYAgFNA3TNBCeDVemkMh5+ewEcoKxTD7hZFxJt0Emd
RvOumo9MbsVwnboJKYzXf62MV6jOrmZNcXVa30QVR/BV/AdhJx3GuSZhCsIPz/Sr
14LUC8B2AdiVA4UCUyg2MSyqQ7iAg/tKSPqogHPWAbi6XXd5Aos=
=L8HM
-----END PGP SIGNATURE-----

--ypud544zi5r45xoq--
