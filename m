Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9666BC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624DB208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624DB208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbeKJBkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:40:04 -0500
Received: from sauhun.de ([88.99.104.3]:46304 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbeKJBkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:40:04 -0500
Received: from localhost (p54B3380A.dip0.t-ipconnect.de [84.179.56.10])
        by pokefinder.org (Postfix) with ESMTPSA id DE1793E4482;
        Fri,  9 Nov 2018 16:58:52 +0100 (CET)
Date:   Fri, 9 Nov 2018 16:58:52 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v4 0/3] i2c-omap: Enable i2c-omap driver for AM654 SoCs
Message-ID: <20181109155852.GH1031@kunai>
References: <20181109111412.24777-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NzX0AQGjRQPusK/O"
Content-Disposition: inline
In-Reply-To: <20181109111412.24777-1-vigneshr@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzX0AQGjRQPusK/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 09, 2018 at 04:44:09PM +0530, Vignesh R wrote:
> Couple of patches to enable i2c-omap driver to be used with TI's new
> AM654 platforms.

Applied to for-current, thanks!


--NzX0AQGjRQPusK/O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvlrrwACgkQFA3kzBSg
KbbAfQ//SoQN5JLdZOgTo9u7MvyYHRVwLx1x6QIFPMswAruC6YpH+rdYBUYHQYg7
cevNIgeN2GxWzIT8cHcIpsKxhO+hKqZbwWrVbe9dcS4wH4lADDsrVsyfsls0dy5k
s2yZpk5EdN1DmWaRH2LkaDt0G4ZRsGff0DfdewEeIN2s84HiN21OL6gQAe6lq/xC
Zb5eR6Y0JT295CNob6ASGsjabtvuRSo5hpziDFLUV0s29x8Taid0zlPDIE2WYa4a
jBgT/Ip9zyPy/czlbjB6DLxhFBItxkc6B853RXralgWXtUveU1Sg9dJWmBPFJkCW
zbQ8TIUxUTXpPfE+XaJL5lOkG36POS4b1WzWh6lthSZzbE1B33zeYXXxmr+z/YS5
jUdqeFz8ZS24TxiouZDCrvqir/gD2CuSVQ0e9mYdApqwHCwma3sATASaqxezl84v
rTzp+WUG8xXKRwFDoXJg4eRfowBi5PYrSpE1jgC4qoI9FWwKr9ToBGCBs+Y/l2nc
jszTxOB/0yy6hb23Y2wiwPcmvSGA30egjOF35IAlkNz0PFG3A9d+Bf/tLM02zj5u
+5y/xSI6/5icAGZHHHVT7lEHltPJKkC4NYVVg29tA/+jfIMUHoD6C2aaANmE6ENh
AMvmsPOrDqipc72wcfEMXldYkH8mDoOnjDMkl9hwKRBziTjR3V4=
=LsZt
-----END PGP SIGNATURE-----

--NzX0AQGjRQPusK/O--
