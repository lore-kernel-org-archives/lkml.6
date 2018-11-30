Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11526C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D6220863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D6220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeLAK07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:26:59 -0500
Received: from sauhun.de ([88.99.104.3]:34452 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbeLAK06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:26:58 -0500
Received: from localhost (p54B334EC.dip0.t-ipconnect.de [84.179.52.236])
        by pokefinder.org (Postfix) with ESMTPSA id 6794D2E3542;
        Sat,  1 Dec 2018 00:16:03 +0100 (CET)
Date:   Sat, 1 Dec 2018 00:16:03 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-i2c@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] i2c: i2c-stm32f7: add PM Runtime support
Message-ID: <20181130231602.GB860@kunai>
References: <1543329331-2471-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <1543329331-2471-1-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 03:35:31PM +0100, Pierre-Yves MORDRET wrote:
> Use PM Runtime API to enable/disable clock
>=20
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Applied to for-next, thanks!


--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwBxLIACgkQFA3kzBSg
KbbFUBAAh8qdHFxWwwJtTmJtHchfy31L3bwIYg4O9x4mHdo6CcAyBWQ69gSaFM1Y
S7cUti+/UyNj61umr6rXiy7/FlOSGKOOvV3KeSEfvJ9ElEiMtE9fRdNcft2NOGin
aAy9O2gm7TuIRf2V/kmylQkCyVbMUxH9J8N3huwM99/BcBmxl9IDTFMtWCL3GLel
cckpFJ3c4ZbF1VRfFPVKhYJ4gvGCt3xG2EdTUNvf6lHizZShIuAFLXlnyVnxh0+o
qKFWTBaDQNnnwiBQXV3FYyrpSpHrJwkcDf9QQoaL1uvF+ngh47W8cY7GPOt2sAtI
46OxieAkBte8fitAavZAI5WArtMY4IPITAuwrQyqEpErKQTNhbXM7nNUUsG5XLwK
1h86+cvOTZawSAuoMqdmnxAocyLIq0AvxIT5gxf05JUjZrQ4hIOO5CzTUe/Yvq1T
8PQzyuvCYjDbHae2lhOGUhffdLRyoWwwEqD9uFGhmxXoSMsIEN0UsRi7+XRvifcc
ulMjVNTaV/3HQY2aMl0Fv86LLCMboHJudO03tOeWTDA1rD6b1lJQI1WBydYfVJaB
Yf+T7kmWydYCzYIhT8kr91ALPitBGGIeIYt0ZxkkEPTKonGfty93tBgzWuGxCwJX
mPJt3W8jm8uWUKxzvbRSB7b3IV2qcsEHxlJjVI33C4kWvNMQU88=
=Zt3W
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
