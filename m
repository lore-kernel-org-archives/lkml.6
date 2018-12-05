Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B8CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C43920878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="dD+NCeUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C43920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeLEOSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:18:14 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52774 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeLEOSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fHQHdmahNzrGjYVZ+awsbF7yYhxbw1T7tG6H4aZKH1w=; b=dD+NCeUZx7SaP391pc+Zlwj/Q
        /cxFGnBfCj52xdX7EgSdKaiK8LJrIIdT9ZQtHJiCsjGEA4LJhZCHQdwBPZsafjQdQ48XMEW35j2qn
        jE6lBuDp5Q+ghbA8GhkbFnXLv0iab0HarqX3E8mB5egbT1k2JZpByeaKPjoXqzTGq0y98=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gUY04-0003sm-D5; Wed, 05 Dec 2018 14:18:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C0CBE112533F; Wed,  5 Dec 2018 14:18:03 +0000 (GMT)
Date:   Wed, 5 Dec 2018 14:18:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Vignesh R <vigneshr@ti.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
Message-ID: <20181205141803.GD6205@sirena.org.uk>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181203101937.7b01a0ad@bbrezillon>
 <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
 <20181205134618.56223758@bbrezillon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
In-Reply-To: <20181205134618.56223758@bbrezillon>
X-Cookie: Real Users never use the Help key.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 01:46:18PM +0100, Boris Brezillon wrote:
> Vignesh R <vigneshr@ti.com> wrote:

> > >>   spi: nxp-fspi: add octal mode flag bit for octal support =20

> Mark, I think you can pick this one too.

I don't have this any more, it looked like this was stuck behind the
otehr MTD changes which seemed to have problems.  If someone could
resend?

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwH3hsACgkQJNaLcl1U
h9AQ7gf/aJLlaDvMy6aZuK7FrotyfySX7CJt+US7KUsb63DCSjupYyNQDjrU+hY+
MkA22EG1ml0RP1q5rOL+fgDnWtogzWGPApXwhT/R2prcgyK0YKqhk8eM2dAhzT6L
JfO+E9rGSM3rBYu5XaGZ7h++3H8mgH9GwkK/GQhgdSc/rOsUJtFZWpBr0+9AYlgi
UvQunc+4z95nlS73u7ZB+LOvC4L+h8vSp6yPIeN+TIpWc7pwSpbbCcYc3Rv81Usw
KqmpkRh9/rgai7zX844+tqa9KqPIZ++29cZHd2vmItMO0PMLcG+fk3S0jps5q27x
ZdLFbvdUupJ3Klk6uxPk8REewVaDog==
=6Sez
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
