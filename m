Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD05C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E7420844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E7420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbeGYLtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:49:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35642 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbeGYLtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:49:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B5146260416
Date:   Wed, 25 Jul 2018 12:37:50 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Marek Belisko <marek@goldelico.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH 04/32] ARM: dts: omap3-gta04: fixes for tvout / venc
Message-ID: <20180725103750.4yltpfswd52fpw63@earth.universe>
References: <cover.1532501910.git.hns@goldelico.com>
 <73e5b1fd4cc27e3148c6bc2e8f8281f3996ccf68.1532501910.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ll6onkhnahxv7igd"
Content-Disposition: inline
In-Reply-To: <73e5b1fd4cc27e3148c6bc2e8f8281f3996ccf68.1532501910.git.hns@goldelico.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ll6onkhnahxv7igd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Jul 25, 2018 at 08:58:36AM +0200, H. Nikolaus Schaller wrote:
>  			port@1 {
> -				reg = <1>;
> +				reg = <0>;

You should also update the node name.

--  Sebastian

--ll6onkhnahxv7igd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltYUvUACgkQ2O7X88g7
+ppctA//Wd340Y3Z4khluvOvD0SeWlPYwYWDLb2MkM+OF6JHxW8HnJDROA5loXVN
4Ndx1HyM1V7Oz7YTd00Yj2T577BDUg5rxLzevzpw25KiIU3ajwU8yi9Sf2jnfwsg
8RxGVHkpGY1WuhYt2a5gFMxCT9Z9eAwr/HOra2zru2wstzfr4fkBMezJ2UQO5mqq
L3CkmTlKyB6+FQhmdteWQEC3TIM6ly+7w4iRgyso+PHFH4pz3SsK1QGV2abw1QiU
MzcFCwLy621jJ/JIJngDtbIhZHJtqX+ql6fC84HPwjQunZlkNdjF3xHJu3M3Z2ZI
mux9D+Ak+jF8pXz1WojUFcc5smn35bTaDzBwIoVNRiPXUhHm4kJtZGgMOK/M8JZc
RFw80k7zo70anz3/N60XXAg/SH2hA8A7pHOIzrKQrWneKVEljKbPE3Ozj428lhI2
rZAwg/KJttfYKLl40/pcrADARbstb6mdTzYFLYeSJRcQM6n8NGrwVf9ECRFScJwM
GDXcwqVVwY4WhIiDbLH6pXPGealIyoX6VefZS/FVvXJ7JuEpAiBMmcVm39VGYh9a
o8+5Nz72XhaI9jYJ1ZLKte8VTniR179m3TGqmMPi4HZNsk7ZRRuS/DBW7ZGq47D5
gRTTdBpqJb1/I3h32AAiDyvEOQIA4OC0o+vARXPrsx4tKepMFLM=
=1qAX
-----END PGP SIGNATURE-----

--ll6onkhnahxv7igd--
