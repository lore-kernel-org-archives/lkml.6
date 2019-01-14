Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0699C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9074220656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547467273;
	bh=Wv5fvqhcl004XjZESvvKc8/kEOEgwHvKbpgIr9NYRlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Svp4XGn6sFcVr/YkP1Ac4GY2zAJbzEpOdBbReQow1sUAkClfqHblH1U+pqmADmKD2
	 RqxIHf+4sGRyFaInyvzb8JpqM18RKz88MzflrBzK9fSRk4OnzspTgXhJHEafh1Z/zP
	 u1ghpJcwaHIDoysnu45OtuA5cCm/gbS4mxvs3UPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfANMBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:01:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56502 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfANMBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wv5fvqhcl004XjZESvvKc8/kEOEgwHvKbpgIr9NYRlE=; b=fob/tKVSH5J4ZAzEk/rLexCQl
        IIkqDTHQfjz/7HzupqdhifytS2r3G4LyOxXTH0ROgjoxM5N+MRF7uM+uH2YK6WNDLQWmYdpdhFGed
        adkKxbBcXqm2g7guZJmHpdXrdPGHvjRrnPxQgyndplPxo+Nw8G8+I4DrzADW4OSjxV6NE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gj0vQ-0004tH-03; Mon, 14 Jan 2019 12:01:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 666531127AD1; Mon, 14 Jan 2019 12:01:03 +0000 (GMT)
Date:   Mon, 14 Jan 2019 12:01:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: dt-bindings: Convert fixed-regulator to
 json-schema
Message-ID: <20190114120103.GB11073@sirena.org.uk>
References: <20190110221903.3990-6-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <20190110221903.3990-6-robh@kernel.org>
X-Cookie: From concentrate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 10, 2019 at 04:19:03PM -0600, Rob Herring wrote:
> Convert the fixed-regulator binding to DT schema format using
> json-schema.

This looks good but has collided with some other changes from Linus, can
you please respin against them?

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw8ef4ACgkQJNaLcl1U
h9C1egf9EyDGFsMmJv/xo3E2kJqh/9tf9dUeYFgj16wNrEOBt5DRZuPNgxzMPRAe
fCFq481WOjcwxQ/B5bEI/TpZFX+rOx1nsaxYPs2ZOtPu4OjN9gZlZLzuzT35+S5c
aJeCbd8Ok/XRhZuyxd3b3M7UY60CYUQpfUK1AUyZ+39/mfa1y7eN6TT3HM9OMYD0
lz1rhAKaPNw27ugIq+kIYDIbgungxphH0l+j/0waTsIugbS86dVnMxC2abfdlFBv
yKtTULJ7Ca90Ygiw0pd5yz75KJzeDVh5K3s9rut3TkghiQl3jKwMrvyG87s0SQtJ
gBcqKNpWOIQKAjaFX2EpiSvc3xiUcg==
=8aBq
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
