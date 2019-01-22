Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED9EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105C420854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfAVJHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:07:54 -0500
Received: from sauhun.de ([88.99.104.3]:50674 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbfAVJHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:07:53 -0500
Received: from localhost (p54B333AA.dip0.t-ipconnect.de [84.179.51.170])
        by pokefinder.org (Postfix) with ESMTPSA id 3BF072C78FF;
        Tue, 22 Jan 2019 10:07:51 +0100 (CET)
Date:   Tue, 22 Jan 2019 10:07:50 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Alok Chauhan <alokc@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        andy.gross@linaro.org, david.brown@linaro.org,
        georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH 3/6] i2c: i2c-qcom-geni: Add interconnect support
Message-ID: <20190122090750.GA1012@kunai>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-4-git-send-email-alokc@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <1548138816-1149-4-git-send-email-alokc@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 12:03:33PM +0530, Alok Chauhan wrote:
> Get the interconnect paths for I2C based Serial Engine device
> and vote accordingly based on maximum supported I2C frequency.
>=20
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxG3WIACgkQFA3kzBSg
KbY+6BAAl5xhp7jUSOyFJXSafZGLgnJuYx3N01zZJhuCm2sGhGhKQcGH2M0EcfUK
YMTYKp0bvzOjpa9WvJEceZM/OrHSmFMoMzMbsdUC3oxvrN6USnuDIlmkBo4zKGx+
srmS5YMtb7ekOXsI0rSFJb5VRX3BULLpD/V5vYsysihZsoS6ReFtwqdMWS1uR/JP
HLpwgPsvynzIblq1TZM0UfTXvz1QBxRAQjKkJcaoXAUGBFZuL5lEmis3yd5amY4N
Mvwax2A7s6qB9hOazOUwyutoqLZfChk4AtnH07wnvpuf0fFkiv6FeK9BjpwEwXJe
ofty1FDAF9/KlkohN9TzVJRhITAAbJFLiwXU+yot69bEehGvaVF13qgZkvgDrElF
vDC2AlBhvlqdfnLetOVdrsbAErUeaj8XDf19y2NzaF9S/cD69aobLlQ3x784ZRch
JNz3N0J+IgZeCh2ZK9NQxiiiG0XFMJAASY2dyJqR0MFdr7oNFS/rhQTKS2HqwvWx
012gPahU1GdcQUeo6dx9ZJfd43dGEbe32GPv5JQWtf9lNBvVcGiEXCoH4wMehvxK
YlixJOpkdTb263JRy335ACAB14A8caTBDHmR1Vhvtw3Rvn3txSldNHrF0ENQ0N9j
/ZpWV8NT3GhKvUj5v9Erucjn1wTegBlmU4w6aGJI59JPDsr/2as=
=C1RA
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
