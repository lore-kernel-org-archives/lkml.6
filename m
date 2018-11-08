Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFC2C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413BD20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413BD20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeKHS56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:57:58 -0500
Received: from sauhun.de ([88.99.104.3]:34866 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbeKHS56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:57:58 -0500
Received: from localhost (p54B33960.dip0.t-ipconnect.de [84.179.57.96])
        by pokefinder.org (Postfix) with ESMTPSA id 8E99B2C0889;
        Thu,  8 Nov 2018 10:23:20 +0100 (CET)
Date:   Thu, 8 Nov 2018 10:23:20 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] MAINTAINERS: Add entry for i2c-omap driver
Message-ID: <20181108092320.GC951@kunai>
References: <20181108091931.3342-1-vigneshr@ti.com>
 <20181108091931.3342-4-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <20181108091931.3342-4-vigneshr@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 08, 2018 at 02:49:31PM +0530, Vignesh R wrote:
> Add separate entry for i2c-omap and add my name as reviewer for this
> driver.

Thanks for stepping up, yet out of curiosity: why not maintainer?


--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvkAIgACgkQFA3kzBSg
Kba+ag//eGminUyjlFcJqcSRjGnf7+LqqeVc07AlJmwhdUwpFd9u7odCF3GTZ1hx
kV26//NQ2S62q0z9piujG5f0UvJRUKv3P/KnTEn2qjw6paAwbJNeunkJfqsOmNPd
b36cYEUHRBNe3m6WVbOkxJxUYiqBTbx0AYu0MWo0uzonyl5IYws3hFZfL+Di7jgC
8oQawmLeQ3PtMAxnVtRS6GMMpmRPogfS3tfE+3NLVzfWaa609oQynEFvfK0ynUXo
gVy91FQzmxxFtkn8Y2+Z4dtPYNmil8LnelhDljVO+sJf4hxec+igFkSc5EUMRSzO
rNXYaH2CtQv3VRLmyvTpx118i7mkCIjH4XYpTLPaIRsbJyvrZM9n2K0krQp838kL
T1prYC2gQEqWZhL+ZK/Q/CjxFCY2rzp94AgWoecn+Lb43RqfBNiDgjrsBBgRCJro
MoKb+6LETDEpj9Vql4MUi70R9wAYQBwS+ZdaBulSRXTKfHhcRMCQ58JQG/prMRvs
6YESdYeSNdIGdYI/xIp/sCHySCXZmZcoUrVJ5Wp9M2WZMcw0Ti+uxwILhHkhMapu
F59dqxoixUSX6mR5hTllQ3AxD1CHmxBIYrm0cEkdbf+P9JHGqyCuEfNkCB9jwhy+
6zBMZu49BgDPCOucQPdfsWNhs8RZiJdIFnnejWaqdKvCDh8r5CA=
=FygF
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
