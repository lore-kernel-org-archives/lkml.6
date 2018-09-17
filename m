Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB80ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771DF214DC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771DF214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbeIQWKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:10:46 -0400
Received: from sauhun.de ([88.99.104.3]:37546 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727736AbeIQWKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:10:46 -0400
Received: from localhost (i577B9641.versanet.de [87.123.150.65])
        by pokefinder.org (Postfix) with ESMTPSA id F09992CE416;
        Mon, 17 Sep 2018 18:42:35 +0200 (CEST)
Date:   Mon, 17 Sep 2018 18:42:35 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Korsgaard <peter@korsgaard.com>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: i2c:ocores: fixes and polling mechanism
Message-ID: <20180917164235.GB1082@kunai>
References: <20180625161303.7991-1-federico.vaga@cern.ch>
 <5011687.103nMUzm2u@harkonnen>
 <20180812153400.GA1010@kunai>
 <8760022x77.fsf@dell.be.48ers.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <8760022x77.fsf@dell.be.48ers.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Thanks! I'll take a look at the patches now.

Ping :)


--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluf2XsACgkQFA3kzBSg
KbaiSBAAgCGWJXLkvzG545mw40PHCWZVFWPxGRDYen9W9uDLpmQkFEVZNbq5pflp
/K3vN95jHYeHn4P1ixQ+hHQE2gJfBNaK0u++tlSqEYFoAo7gGApIh4ooeCeWS1fo
mPBoQXHYNuvSDewzQsVp4j9RWt2rubvOmQUNvNltMqnNAb/LAj7RUccUAm4IM2tx
xC24hLqmDCWIQrvNkfb5T9tp7ssBdOiJ6pga1e8InNyM5PYAEx/kgqtPM/w21udg
NGrPQnUktlbSzrFQIAsncXK/ZpadERvxVre0K5nTZ6wRPWfj+3l7o49BJtCTgTWR
hrDdjfJIA2WCJgbHsJOoTDdByqdUCFRje/8STRmLsndSjLLgCU8xQBP+4c4LMyXk
mWnBfUqexw/3BH4fnEJRzagEa67p/4deI6tMPkfQDXkujZ2wZAYyzF8sm/u/z6HX
lc9tgOep1TFxcEDzBd2/BtuqxZnz4BeQBsdARQVFAnlbmRebK9fCWlbY8RVgizqJ
ucsJhb8FMtm67jsImbXsOSocPXdSsMeo4iXwMUTpr3cyCiv8C8q0hX+IMQBmcJd7
9nLNtiSxtSf/oKFpSzgjZoUgUVZYTrRQfb+lXUUuJ6tVOIeZcKuNP6bjnb3VbDmp
goo4f5xd6qGrmloQV5XOaTjye/g1FZ2NxCpSOW72PAT8fCvKekk=
=gJye
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
