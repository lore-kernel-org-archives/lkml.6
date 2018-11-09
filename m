Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C53AC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E12520825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E12520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeKJBh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:37:59 -0500
Received: from sauhun.de ([88.99.104.3]:46268 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbeKJBh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:37:59 -0500
Received: from localhost (p54B3380A.dip0.t-ipconnect.de [84.179.56.10])
        by pokefinder.org (Postfix) with ESMTPSA id 712413E4482;
        Fri,  9 Nov 2018 16:56:48 +0100 (CET)
Date:   Fri, 9 Nov 2018 16:56:48 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Vignesh R <vigneshr@ti.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Strashko, Grygorii" <grygorii.strashko@ti.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] MAINTAINERS: Add entry for i2c-omap driver
Message-ID: <20181109155647.GG1031@kunai>
References: <20181108091931.3342-1-vigneshr@ti.com>
 <20181108091931.3342-4-vigneshr@ti.com>
 <20181108092320.GC951@kunai>
 <d57ace5e-d42a-0a0e-2813-4a25cc6b37bb@ti.com>
 <20181108150231.GF56134@atomide.com>
 <20181109155517.GF1031@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L1c6L/cjZjI9d0Eq"
Content-Disposition: inline
In-Reply-To: <20181109155517.GF1031@kunai>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L1c6L/cjZjI9d0Eq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Cool, thanks all! Tony, I took the liberty to interpret this message as
> an Acked-by so I could apply V3 of this series right away.

Doh, v4 I meant. Sorry for the noise.


--L1c6L/cjZjI9d0Eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvlrj8ACgkQFA3kzBSg
KbZNrg//aSCx/XN6GImK/uIuFzGiCt5fWcoXxLSBr2tgiehhtTuhCqgNlYPoETEn
wQ/ikx2Adg42ZSPpzfJSldCh6/rmK/8m6ZI6CSinpuhLVeFoENzdUwcZg+p5ajm+
8gfYgD+LwxT9UbtlV/WN43mmUZ/jJbfORhfknfTPiqnUboZrsnOrXjgoKY04BFpv
gysFOyb6SZ5reOPFFFWxJe8HgUxrFgxRat7s9ab/AjBbda5eKAMn4VM8EqmygdI9
/coBhHbQjw+L/sMZq8DTx99zq1baM1FCVbNG47Q8feYBkkEo0PZWaXe7tQ02nUT1
CFHuoEtDeEqsvwnc/HCGkAxX7Bwa+p10MeFl9AwgjElEi7fd2pZ/Go2ch4pGKYTy
Ym4eG1UfayeGl06+6XwkZLAcGfqcxpDsGt3/3H8jM+MSe23UJVx/fsJUPt0l7EaC
syLmU2ZO+Bb6mdJJ26DO+eUPSBYzbyKPTTatbHQROfnLFJmbnweupvSYLNRs+nWQ
pfi8DEkQhvtfUH5MYHy+cYGWS/Dt7HSqa4zVOi++hOUei0As5b/FfKDU3/n/qwx4
8z7Pulj7vjxDAi2GLsSsgFVxZRhaMyfU61kGlTJhbgYOY80jXd6X6OUbVImvAOdH
KtjGXkMhed2nhvVApwW9qVknyGHR+4xYfLFlVbe0OsFblr7utS0=
=XkWz
-----END PGP SIGNATURE-----

--L1c6L/cjZjI9d0Eq--
