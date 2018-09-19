Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65E0ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CE520880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CE520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbeISM2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:28:23 -0400
Received: from sauhun.de ([88.99.104.3]:48380 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbeISM2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:28:23 -0400
Received: from localhost (i577A6BE8.versanet.de [87.122.107.232])
        by pokefinder.org (Postfix) with ESMTPSA id 41ACC2C2868;
        Wed, 19 Sep 2018 08:51:52 +0200 (CEST)
Date:   Wed, 19 Sep 2018 08:51:51 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Korsgaard <peter@korsgaard.com>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: i2c:ocores: fixes and polling mechanism
Message-ID: <20180919065151.GA1010@kunai>
References: <20180625161303.7991-1-federico.vaga@cern.ch>
 <5011687.103nMUzm2u@harkonnen>
 <20180812153400.GA1010@kunai>
 <8760022x77.fsf@dell.be.48ers.dk>
 <20180917164235.GB1082@kunai>
 <87sh26oyoe.fsf@dell.be.48ers.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <87sh26oyoe.fsf@dell.be.48ers.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I'm terribly sorry. I didn't manage to review before leaving on
> travel. I'm back next week and then I'll review, OK?

Sure thing, thanks for the heads up!


--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluh8gIACgkQFA3kzBSg
Kbab9A/+Ox93pUWmZCgQux57Z2twJ6+ImypdIa/J/ABrOIR+rW+I69ZTDkmPmV1w
VNimvXbarqTuFypFChiqYGjWwIziLjKu5v2GKr8klmZJM0+9FPWsbP80X+N7KiLP
h1x5Y0jBI+K2MzHOhrgM2zbarp2pg5OfOjQRWe+a7jy7uPE8D6ag1T9XR5lwGYGo
dgtoXguZOni4rkJGXrUH+LRn4SsOAPhDiA/qNr/BLzKB7lcbMdi6y6y7lvdbmtzS
FPEtNpAImAAbgkfbmNisK1TD7pRz3qAlvX5DvyI0T/FxBQFE24BJYnwi2B0oOl4i
+nHJ+rzooupvouqYOvdeOEm4rUK1YFdKydM5i8PPx+rCNMzcsLRyJwIMi0uyoINn
g5ctwhwAlc52W3iM4WiyAKaAiLX5zG+/fBaTrT/jrwH651m6uxSXULrPT8jm/Qd1
GhWTu617QT/lZgebGGWRQZH2W06/ByovE7VaJ/DMd7KSehf0A21jEkj3Do+3jQWJ
EV9auyZUYDP5hh/dc4RVYsdGyRc/N1HvtJaxozCxR+XwsZ6NrZi9H6hHWRMLKu/6
vFbUDPTaEKjmWK26wvoYOC72D0wLtHeCnQQFcWIkOaqlpWGKS7We+QpM18GuBOjj
BSsqzyNL1OiaUCg9VYDzFX4iQm5U1VDGROf04p4F4qu4S2U2yFI=
=8/aF
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
