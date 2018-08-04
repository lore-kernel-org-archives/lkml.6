Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92643C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C6F217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C6F217CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbeHDX3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:29:30 -0400
Received: from sauhun.de ([88.99.104.3]:59138 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbeHDX3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:29:30 -0400
Received: from localhost (p54B337AD.dip0.t-ipconnect.de [84.179.55.173])
        by pokefinder.org (Postfix) with ESMTPSA id 7BFDD684EB3;
        Sat,  4 Aug 2018 23:27:28 +0200 (CEST)
Date:   Sat, 4 Aug 2018 23:27:28 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] i2c: rcar: use core to detect 'no zero length'
 quirk
Message-ID: <20180804212728.y66bnjiudsuazs4c@ninjato>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-11-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2xc55qy6jrjdy4k5"
Content-Disposition: inline
In-Reply-To: <20180723202617.15230-11-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2xc55qy6jrjdy4k5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 10:26:14PM +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--2xc55qy6jrjdy4k5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltmGj8ACgkQFA3kzBSg
Kbbr5BAAnB3IhW255sok350P6uIA1lldIR8dQFkdVexXEFnJqaolwaSptYaFGpnw
/gFNPZRG8tbQACOIAOpDNc0GNQXk1hMzXVaq30oLHwcY5ygO/1HiG7QzLeabz8LI
FY1SX6RLLsKfRhr/tRIspaGLH3YgjMvM6iRV0Tmf/szzmkDExEy8/+omlLThGX7Q
4m7Gx2FWudV9n4D6K1DPwGDx5deShRrttN2jy4usl2LSjt3SAhbR1a9271t02a4O
vmYEDkSLWuOhedkOBqbBhLBtioipnrBpj6bGwcm3tEfbtNebOOZI5w9MUPfu+yfY
tg77ogpFO2UZHt0+1GU2HW839Ofk3ymn28A4XHe+NG6cB+PpoY4xWRuDUTUs7u+9
ZX8o/HR3YUURs/Mgx1OF1ETRvGlruKtMCD9Pzj3n3dx0oojNNim6TmN50uk1d8Pf
JQxWcKwqSLHuTlwf5PG92dDfXb3K6ca/nIey5UjscwYV1TnfolJyIcD6vdvjwknn
CHhQSay2K9LV77rL3yfNc8CwYJQG5IiXJHX/Qjzm4Aym1zqFPvHJX5IHCLXFuXyA
SjpVrcGROpWRZHvZwNRHfZLSZq5PdUfHBnhJ0k4PE4tDy23xew9/OjX5rElShMrT
p5mKlPWSlRxrZyhAdZc69kLTn6R5hDQSpIDFHxSYhz/FawnqY3o=
=LGFa
-----END PGP SIGNATURE-----

--2xc55qy6jrjdy4k5--
