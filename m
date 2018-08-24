Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF47C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6609621564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6609621564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeHXQgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:36:06 -0400
Received: from sauhun.de ([88.99.104.3]:40502 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbeHXQgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:36:06 -0400
Received: from localhost (p54B33931.dip0.t-ipconnect.de [84.179.57.49])
        by pokefinder.org (Postfix) with ESMTPSA id B3A053058F2;
        Fri, 24 Aug 2018 15:01:30 +0200 (CEST)
Date:   Fri, 24 Aug 2018 15:01:30 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Sedat Dilek <sedat.dilek@credativ.de>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler
 warning
Message-ID: <20180824130130.bialyhjarwkwodzw@ninjato>
References: <20180819135135.8801-1-sedat.dilek@credativ.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4qlrxwaq262b2c2p"
Content-Disposition: inline
In-Reply-To: <20180819135135.8801-1-sedat.dilek@credativ.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4qlrxwaq262b2c2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sedat,

> This can be dropped with commit 771c035372a036f83353eef46dbb829780330234
> ("deprecate the '__deprecated' attribute warnings entirely and for good")
> now in upstream.

The pull request removing attach_adapter() is on the way now. Thanks for
triggering all this!

Happy hacking,

   Wolfram


--4qlrxwaq262b2c2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluAAaoACgkQFA3kzBSg
Kba/Kw//SfMPEGby0Te5xq3rsh2auGUmBcNYGxLpQECdRjXFnIkyco2rbeSvpttb
NVtskxsNZW8Cc3XbzpM61cCwKXS7iw/VULmC5aNE3JB5h1vVuptZuf7FveSdNuaB
Plw2O00zjU6lflN39tdMyHEMtqc2tVyJQscH/B6dsz6ps6wDyLTStpdv4f5C/z9J
sRvLa0iHeBpd9VignMAVIpQ+PofWDb41PEPssLvEN65htOcD51u60AOXb+qQPo4t
hHUx2Foo8eXE1GP4Vcft8GSDdsqON6I/RoPPVVJMqY2RQ8UtaoDyeG+SjWDuIn/P
WFsPoDGm0Q1MLDL60yqui0KNEpNVRUZ8B5EfQ04NsPuOnC7W7uaXyeTlagP39vyV
Nw6UHEt8SI4m+eHh47I2VPZ6flAjf/+5H0WhPcuf3fMe5BYLmWfIVyeRoSEez0gd
GMp/ITvFPB/reYRoA5PlLowgjoJpVElee9s/FtvuBkCbOh8+soBMur7V1W1Bouia
qc6b4CLDBmNCoO4iF+bQRCYNZ7naN/1331kLbpScb5GqRs1rFkelN2vIamwc6S6N
GOgk9A6QxBwyhVupSbk2NVGy7vcOqUMRJQffZC5179HKziYAI6QB6oqprx/3hN1o
tPw64sefWKA40n3oQDE8/srMevDr/OItEHFgXY86Wci+RMLOm0g=
=e7D7
-----END PGP SIGNATURE-----

--4qlrxwaq262b2c2p--
