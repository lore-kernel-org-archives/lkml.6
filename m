Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926EDC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EBE208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544725236;
	bh=354BmieO/0xEbvx8HaW1xvPqiGCUdTidEzSETNrQ6YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hkY57ldDhGP8KZT9LRY77oRuS39ftSaZzK6i7nZPJQ+AnPthCxNBWxlKVnNIkcYf1
	 yUw7gQ8ji0/4STlMf3KADuCPHA7XY9lLDr0kj5Dg5rcaNr0g7mkzsREK2QNL9Lmzqg
	 m7sObqaoK3CY+gT4aIcOYEtRLl48r8DNofO52hUk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37EBE208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbeLMSUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:20:35 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52656 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbeLMSUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D6aHvL7XCW0+a5QOZZI+JCjiDXtCDH4r4YwQBk6W3e0=; b=PSJ2RCWSvE0b/zCDIlJXp1btk
        25+Hk/P27KNcPS6UXPUL80q+AvJ27lg+5p5yT5131V/vK5TR8wqxE3idxwplWptM8AUqfSxRw+uTJ
        vSZ0nANDKG8OZN52KhwH4ZzjX+/yGIQy1Fs8hhi2RqPiFbtymNT7tZkJKbzdVfc0Km+Ig=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXVb0-0002SO-KV; Thu, 13 Dec 2018 18:20:26 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 22D1011254D1; Thu, 13 Dec 2018 18:20:26 +0000 (GMT)
Date:   Thu, 13 Dec 2018 18:20:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        vladimir_zapolskiy@mentor.com
Subject: Re: [RFC PATCH v2] regmap: regmap-irq/gpio-max77620: add level-irq
 support
Message-ID: <20181213182026.GX10669@sirena.org.uk>
References: <20181211140555.GA5872@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QQ0dNM4HnH4+xgqD"
Content-Disposition: inline
In-Reply-To: <20181211140555.GA5872@localhost.localdomain>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QQ0dNM4HnH4+xgqD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 04:05:55PM +0200, Matti Vaittinen wrote:

> One specific question hit me while doing this. Why does the regmap-irq
> core do default trigger type configuration? I did leave this in the
> patch - but to me it is strange. For me it would be unexpected that the
> HW default trigger level is changed by common code. I would understand
> if change was done by some board specific code, or code specific to a
> chip - but 'core' doing this seems wrong to me. Should it be removed?

I can't remember and can't find any record of any discussion of it which
is odd, might've been on IRC or something.  Let's just remove it and see
what breaks, since we generally provide the type along with the request
for the interrupt I'm not sure how often the default actually gets used. =
=20
Possibly safer as a second patch though in case there is a good reason
that I missed so we can easily revert it.

Unfortunately this also collides with a change I applied earlier on from
Bartosz which supports chips that use masks instead of a separate type
register to handle types so it'll need respinning, sorry about that.  It
does look safe to me but it's possible I missed something.  Equally it
only seems to be some quite old Tegra systems using the max77620 so
perhaps mainline usage of affected devices is limited anyway...

--QQ0dNM4HnH4+xgqD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSoukACgkQJNaLcl1U
h9DTUgf+Nn/sT9v2nc1Owok4i4RdYdocHxSUnJ98ZZVLknBIFd01JLu5p3W067IC
h/X5zmu2oF0E6VSvIiBmzhYW+qMKwRp8zakpHyrU7kYvWCtbesLJvFlFt4+MXuqw
94Q/WbdEb51JtlqhUioi7Flj53bBByDQPKVaXzAHoP8AznfFoOMNYzcLOruEQS9S
UpwPYl4oppkIzUXHz22b+vxfvCxmkba8LTegos7rkFwEm+ASzC/D2815dGZ2/geq
HpEtvwuxamN9aLwUFuxjZKmsM/kDOXD/QLZpBwDhMgk4q/rlqS+mWcjnj7Kvivmx
lmgUYY2Cs6m0TjmiLtzzMAj1EANPTg==
=KWEc
-----END PGP SIGNATURE-----

--QQ0dNM4HnH4+xgqD--
