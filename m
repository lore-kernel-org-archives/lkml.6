Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346ABC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E19218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548438638;
	bh=E2TYUzqmIB/WunQuG8CLDnll55MDpbZcVbi8uzr1exg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SuuJtfUQMA/HX4zKbzSGJppqEcDd+X3y3YWWI6lBy2PiCY2PzIhgzMw8VZ/sH0vEW
	 RzfoCWFimfwXbxXhBiprgUp5GqiVXv+whJ1FLZSmb+LLNPWjJ2233LZ+1nhdCBls5D
	 ynacuRbDhq55fO9jmOI/HKGAD6t1t2aGnqxJqy+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfAYRug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:50:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39794 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfAYRuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E2TYUzqmIB/WunQuG8CLDnll55MDpbZcVbi8uzr1exg=; b=cJTiaRiDjz06MYu5Z1IakiakZ
        XL+zVT9ZY/vzicQLNIIZrBy1xSzsIkz6zlYE+e63r59gwJP2dUSoclKAPJZT2Juk36avJ9cGYm5FB
        hIl+lk7Ba++4AaQ4JAAKU9gU/F7QYcPEbJIWoHI4tJerIZ1wD3xZZ34Hh1prUL7pDcg8g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gn5cd-0004R8-Le; Fri, 25 Jan 2019 17:50:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 403DE1126FC0; Fri, 25 Jan 2019 17:50:31 +0000 (GMT)
Date:   Fri, 25 Jan 2019 17:50:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] spi: support inter-word delay requirement for devices
Message-ID: <20190125175031.GA25898@sirena.org.uk>
References: <20190125114429.20066-1-jonas@norrbonn.se>
 <20190125114429.20066-2-jonas@norrbonn.se>
 <CAMz4ku+sqzK19994BpdSfaDjNdXW_-gnCutr_fYQiv5ynxOq2g@mail.gmail.com>
 <f34151c8-28a3-3d53-a27e-b5ff512d9c94@norrbonn.se>
 <20190125174713.GA6939@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20190125174713.GA6939@sirena.org.uk>
X-Cookie: You must be present to win.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 25, 2019 at 05:47:13PM +0000, Mark Brown wrote:
> On Fri, Jan 25, 2019 at 01:06:45PM +0100, Jonas Bonn wrote:

> > Having this as device property rather than a transfer property allows this
> > to be configured one time in setup() rather than having to fiddle with the
> > configuration register for every transfer.

> That doesn't mean that the coniguration should be done in DT though, and
> given that this presumably is a property of the device there seems to be
> no reason why we'd have it in DT - if every instance of the device is
> going to need to set the property we should just figure it out from the
> compatble string instead.

To be clear here: the suggestion is to add a parameter the slave device
can set in spi_device which sets the default word_delay similarly to how
max_speed_hz works.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxLTGYACgkQJNaLcl1U
h9DCxAf/ZhToJUZAbdC/m5PTY8/S4yw7f6hqcYtAsweSErRzlz8oiLKYQNQ7h29F
pqKkoM6bRQMgVQU+P91QjCFJwsfOVHYUowcG97/zu8h5wmG/Ca9PNErXj1yhh8GI
nWP6HidxnqPgnuv61U3nLxDV4sClpQwjbsVNKyGuyshyQiYNn5+8w2kjMJkEsjUe
cGPLwgwpmarj4W3gvhdrQYZO09d6je5QH4hu1PGLLBIB2KfAPRWgHdpzrifZRSnC
csO5ofEbBTOAsmgvtYxwG4jg7ewHbJmQ5zcOSVTziPs3GCWyrK7exyY29jDnzQqH
Y1exY/p6I1RNfMj3R7U2EvWz7mbVaA==
=AuTe
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
