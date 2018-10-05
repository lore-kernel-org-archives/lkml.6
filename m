Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78174C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43ABF2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43ABF2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbeJETXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:23:13 -0400
Received: from sauhun.de ([88.99.104.3]:38968 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbeJETXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:23:13 -0400
Received: from localhost (p54B3360B.dip0.t-ipconnect.de [84.179.54.11])
        by pokefinder.org (Postfix) with ESMTPSA id 04F9D2C146C;
        Fri,  5 Oct 2018 14:24:41 +0200 (CEST)
Date:   Fri, 5 Oct 2018 14:24:41 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] i2c: zx2967: use core to detect 'no zero length'
 quirk
Message-ID: <20181005122441.GK5433@kunai>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-10-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VJJoKLVEFXdmHQwR"
Content-Disposition: inline
In-Reply-To: <20180723202617.15230-10-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VJJoKLVEFXdmHQwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 10:26:13PM +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Ping.


--VJJoKLVEFXdmHQwR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3WAkACgkQFA3kzBSg
KbYmpQ//e6nmQvTjCWRh7LS9JE000cykPyJOwaqt6FxuJgYju8t9qySyWpeUZ9lr
EX4a6kXCJj82VIj5aBrpBGcrkQR9B6S0coK3QfLeoyrpdbxPf/p5vn2PBHpxqarO
BiqBztHaGXQPsI+VTMsShigwuF1nqTdUjEtFfT4VGe65sl2fVGKAnlMRKkzAd63U
I4w2yhxr5E9ERhkDyq/N06eQADno33L7YXYjrdNnNCqh6BaGqTaR15EmHQa4nPuN
fEkeF91tX6p64QqdL5dloA2HHWZtBF8NqyptvpokFU1H6/uQPPtv6XGL8TK2m+Vb
7aYOGCJYiorz2SRRbNkslRtyLPWbOYuwTRWfm+5GGdazCoaYB400QZFfIz19FwtH
u6dCocwtsx8duBCnXU/bbId4rlwDeUVEC7VuR+Ca3gB0YYRpGGVFvW1xNlM5U0Dm
ijlHF+ZWaEXTAFO51goOK4G01uDQ5T4jdV/4Qq7Qx2hQMYKspnxnWvP+4sBx1Avg
Q7D3RB/oIRX9e6DMA5Q0gzOBgpLiT/5mw1JbA0Vn5TmikGIfJKgg58enEGU/Prcg
wCpI+UGnxEPLFh7Etxpl9t5xJurt6DI/NE25SIZkHwJrTv964bugEu5ERPTW+nSz
3kZnVHgYIi14FsVQZDGYJJrpBVnNclphHbW3ye4nalBxYfxHifc=
=GxZL
-----END PGP SIGNATURE-----

--VJJoKLVEFXdmHQwR--
