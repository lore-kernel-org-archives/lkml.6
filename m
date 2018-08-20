Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADFBC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3E1208D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3E1208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeHTOaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:30:02 -0400
Received: from sauhun.de ([88.99.104.3]:58522 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeHTOaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:30:02 -0400
Received: from localhost (p54B33943.dip0.t-ipconnect.de [84.179.57.67])
        by pokefinder.org (Postfix) with ESMTPSA id DFFEF2D46B2;
        Mon, 20 Aug 2018 13:14:48 +0200 (CEST)
Date:   Mon, 20 Aug 2018 13:14:48 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Esben Haabendal <esben.haabendal@gmail.com>
Cc:     linux-i2c@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm: dts: ls1021a: Enable I2C DMA support
Message-ID: <20180820111448.5njestngbsupcpwl@ninjato>
References: <20180816084315.7857-1-esben.haabendal@gmail.com>
 <20180816084315.7857-4-esben.haabendal@gmail.com>
 <20180820091531.komc6ypyybnq22nw@ninjato>
 <87zhxhgzmm.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p36gfmphq3omwcpo"
Content-Disposition: inline
In-Reply-To: <87zhxhgzmm.fsf@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p36gfmphq3omwcpo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Ok, do I need to send to additional list(s)?
> linux-arm-kernel@lists.infradead.org?

I'd say resend this patch after rc1 is out and the other 2 patches are
upstream.


--p36gfmphq3omwcpo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt6oqQACgkQFA3kzBSg
KbZTehAAkNpisXhL/VDgIfEQ734n6+rqFsegC8LNNttXaJ/7OaQYe/S/I8HeY4ZG
BoIU8haBmHDV5Jdpv9PMDNzC7MecoVQqafo1FFO9xD8UyOUVIg40tdOuv59ux8eF
oCn6ZFsEG9ZheutO0lx1GF3A20TorIeaLj9MlceLjbdAsst+V9hBeZA+gCp2Q5cC
1UO74ACv1S9cO35q/qRQGq11rsaEUpqMLifAi5uH4avrH+dLROVRuVY8+VbdW29O
MdsWTFvwilB4bU2NLwFCbGVhT5VxxXYtkFmxSX8fzeHoI0b2AAE46YAJIgzHzqz1
7n8fF0oUtEpT2i7bUSlcep7XhMmwoX3kg0E9FgQONfRk8LL0t2egWvwWfDuua8tp
RROD7kP83eYsjj75euG/Glmgjk371Did8JU01yFleDdzLHCbZGJ5ZoIrSlWGAtqj
DFOj/KuGZ/v1hgrLaSLrBe5QrXGXGz0iGLk9Oig2yLp6/n4sX5qslgx6oEb4x9mq
lnNVERxUkfwEbBewvKrYQ+TOtWol5qB7QFpqedeu+uHWVgKqBHfMmkg+e2kgAdp7
3ut6IZacZuW9LvWZPBzljahMwJZDrVLGgIdyOWwT5UT1VyLdnyCj8DZ+67ApC7DS
cDZosmMvmrwt4rM1ppLwqNt6sFTzoklLDI87txw6zo+6g0GWBgY=
=6hns
-----END PGP SIGNATURE-----

--p36gfmphq3omwcpo--
