Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C690C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C476D208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C476D208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbeGaVB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:01:57 -0400
Received: from sauhun.de ([88.99.104.3]:56460 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728800AbeGaVB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:01:56 -0400
Received: from localhost (p54B3343C.dip0.t-ipconnect.de [84.179.52.60])
        by pokefinder.org (Postfix) with ESMTPSA id 46424656002;
        Tue, 31 Jul 2018 21:20:10 +0200 (CEST)
Date:   Tue, 31 Jul 2018 21:20:10 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        evgreen@chromium.org, acourbot@chromium.org, swboyd@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v8 2/2] MAINTAINERS: Add Qualcomm Generic Interface I2C
 driver maintainer
Message-ID: <20180731192009.pssdbejqnhf6pljh@ninjato>
References: <1532971432-16784-1-git-send-email-kramasub@codeaurora.org>
 <1532971432-16784-3-git-send-email-kramasub@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5wb2zrxdfppd2zga"
Content-Disposition: inline
In-Reply-To: <1532971432-16784-3-git-send-email-kramasub@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5wb2zrxdfppd2zga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2018 at 11:23:52AM -0600, Karthikeyan Ramasubramanian wrote:
> Add Alok Chauhan and myself as maintainers for Qualcomm GENI I2C master
> controller driver.
>=20
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>

Applied to for-next, thanks!


--5wb2zrxdfppd2zga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltgtmkACgkQFA3kzBSg
KbbF4hAAi/sjgOKr364a8VTpx1Kc6ydv8b3BG9of3i2Fc43Hsv/uUD0YpquO08mB
t1M60n5z2v5P6N/R7yjg9lrr85iWitOCc9GbS84dO958762eWalHiVqGlwvfwrvr
SJn2sV49vZF/ifMAv5qka2UqJGD8bS6CUk30hxBiTF5rtnsCOmSbV7s0FgCMsA05
L33r0tzUUbQWYYfKdzssGMfSoWt53GkyyNDZpHvfH0Hc0xFlw3xvIoZUdrJx5qek
s6CO+DaP1aIrXzzRq8xW+zeSiZitKvo0X9W+qGamMPobfLXRcr/hjuSSIGQ5FMkX
jr3GI4jpbgPJfvs+Y6wrff40f4bjyf7lm16tfgZX+dNUnajLs0rXlJU+rEOpWyzl
ByIRceeiO9nqJIxm/quPCzQqbWT5aD4akxAaDxecrmkbhUuwFOccg5qbxyW/jJ/4
UGrOKj1C+yySmNFSQWaiB+oqNlJ8K9Ojbi7vFOLbbvQPw/glQmdhTxA1wx7ePauB
aKDl1JhdqzZPPa62sLOaoIr6uB2+3TwXKHDwuJv+gnkjWv1q+CmJvBeFL9mlne7w
kBWil9NP4P/fogzjUjK3/Hh5t+VJYd6YjmdnsJiN3N6Ic5VtmGYAR9il0M1YvB0w
RSu7gF2is02tFxhiSncYwqSM+AefHA+FHmWnFei2dWx/VyYjiXE=
=qQqT
-----END PGP SIGNATURE-----

--5wb2zrxdfppd2zga--
