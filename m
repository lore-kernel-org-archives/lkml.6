Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EADC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095B7208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="TF1MGX3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095B7208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933222AbeGIM0R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:26:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51034 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932755AbeGIM0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8e6hn58Wa/Nmzrdryc+6YUIQi8pEGWR5YKra7BqsYqk=; b=TF1MGX3CDV9rMQqBSLbhV8o3t
        4qYElq+srLeL1A0yIYW8Fx6RgXJsGL2j/kTmNfKAjuPwW/PNI8OO2mNy63Hk6dLv4U1EBbxPFSTEv
        n/liZ2t5ZZoenNGwL+3GHdm4X46jMPQSX3slZFq0PqDmYnTcepfrnU6CqMOwF24Th+Lx0=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcVF3-0003kB-3h; Mon, 09 Jul 2018 12:26:09 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcVF2-00005l-8R; Mon, 09 Jul 2018 13:26:08 +0100
Date:   Mon, 9 Jul 2018 13:26:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        pascal paillet <p.paillet@st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        rafael.j.wysocki@intel.co
Subject: Re: Applied "regulator: core: Link consumer with regulator driver"
 to the regulator tree
Message-ID: <20180709122608.GE16082@sirena.org.uk>
References: <CGME20180709111753eucas1p1f32e66fb2f7ea3216097cd72a132355d@eucas1p1.samsung.com>
 <E1fb8Ti-00026e-NU@debutante>
 <20180709111753eucas1p1f32e66fb2f7ea3216097cd72a132355d~-rzycA5Rg0378203782eucas1p1C@eucas1p1.samsung.com>
 <CA+M3ks5ieu_6=rsfdp9QQuLJbbwJj2if26m_STF0QJJBD-6XKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline
In-Reply-To: <CA+M3ks5ieu_6=rsfdp9QQuLJbbwJj2if26m_STF0QJJBD-6XKQ@mail.gmail.com>
X-Cookie: Falling rock.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 09, 2018 at 02:13:35PM +0200, Benjamin Gaignard wrote:
> 2018-07-09 13:17 GMT+02:00 Marek Szyprowski <m.szyprowski@samsung.com>:

> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 1 at drivers/base/core.c:108
> > device_is_dependent+0xa4/0xb4
> > Modules linked in:
> > CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.18.0-rc3-next-20180706 #112

> > It looks that some more checks have to be done before adding a link between
> > regulator consumer and regulator driver, because it is not that uncommon
> > that
> > regulator consumer shares the parent device with regulator provider.

> Each time device_is_dependent() will return 1 we have a warn_on.
> It is strange since returning 1 is well documented on function description.
> I don't know if we can safely remove the warn_on or if their is a good
> reason to keep it.
> Rafael what do you think about that ?

It's trying to tell you that there's probably a higher level bug if
you're adding a link from a device to itself.  That's not super
unreasonable, though it is going to mean that every bit of generic code
like this adding links is going to have to add checks (or we have to
downgrade or make optional the WARN_ON).

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltDVF8ACgkQJNaLcl1U
h9B4fAf/f2M9nozSlq4ot+kHdRSov7AokXfHzhx1FnMeXpq85njfR+4zhazTZ8Aj
9ZGGKqopnmNY1GDaPTvSnSeK2PlXceWlBPDxtQ8Vqd0Ib2hDUWO6zcAmR5aJhJz6
z6KxW/fZxzNO6NzvE/ZDxyEYtBEoMM6Ek3lyoMDqVoqwhrGCjIJfUyKYVkYnbi3C
dUzHOslxY9xklS/RRPrGDcpoQL69d35K6CT2OY2EXzkkq/9ktDVcOBcm4GiPfdMZ
T9JMFlFNi59ygkG/kdATR+SVdb+QEshdTP7u7IDTnlgnc9Pik3TcoLnTFXV8B5yj
FkJl0hudWijqRhLYx+8x7aQ0vlkq5w==
=OZHh
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
