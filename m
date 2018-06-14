Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6144CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CD420020
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="M9gzMJer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CD420020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755353AbeFNNsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:48:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46860 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754885AbeFNNsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UAY15v6mgKiHpP69S0KCEqlFd2iOICrqGBLVbRzMcX0=; b=M9gzMJerKXiSOozbS7Jwsg5NN
        cJwlQiNHLmHGw2g8Vqn1MbFwUgcLh1FF7nrvKXgv8qM7gcNhYbs37yVap6/IJkgqbuoUlWRUdfgVB
        6Uh/NIphjT563KU/bKRSqS9TWotAF5amBYhC2dNV3mW8u1EWDRxPPbzXfDtm+cOy4qumA=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fTSbZ-0003Wo-Tf; Thu, 14 Jun 2018 13:48:01 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fTSbZ-0007tl-Cp; Thu, 14 Jun 2018 14:48:01 +0100
Date:   Thu, 14 Jun 2018 14:48:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Rob Herring <robh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] ASoC: pxa: add binding for pxa2xx-ac97 audio complex
Message-ID: <20180614134801.GB9660@sirena.org.uk>
References: <20180611202211.15501-1-robert.jarzmik@free.fr>
 <20180612221359.GA26741@rob-hp-laptop>
 <87y3fiqzp8.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <87y3fiqzp8.fsf@belgarion.home>
X-Cookie: 15% gratuity added for parties over 8.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 13, 2018 at 09:00:19PM +0200, Robert Jarzmik wrote:
> Rob Herring <robh@kernel.org> writes:
> > On Mon, Jun 11, 2018 at 10:22:10PM +0200, Robert Jarzmik wrote:

> >> +Required properties:
> >> +  - compatible: "marvell,pxa2xx-ac97"

> > Don't use wildcards in compatible strings. Though this is so old...

> Yes, I could use pxa270-ac97.

If you're going to do that then probably best to put in a compatible
string for each SoC since they are actually meaningfully different, they
seemed to manage to break something with each new revision.

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsichAACgkQJNaLcl1U
h9CZ2wf2P8RJc94KqSk0E9cc7WOEzkM/bBC3w1dEkqBlm9nNNSmsUj81RlRFHpR2
BQztdPntC3jxepVMpyTIOGOJEhoYiIcT9yAbgoujIkaSSERjxKFyoDb00tTStjtg
6SQhPUnFDga+eXUiUhmfv8oFr4dP4PlEup43xoVnHhwLY6oo31MOVhQPrzHPb1uA
OgbYVEG8RqatEsuk649UQ8KBEHKkWE3QCmb6vL0yGcZ8GVuaUrRh19gDEpX1ea3P
ydTB/0L4gd7kMsk7LH1iwzcaD/mv1ztkw8m3NcQq9+i6hd0CGOp1G+T7YINvtism
GESrxQk8QMvL13owbaCShtGsg15A
=gAJc
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
