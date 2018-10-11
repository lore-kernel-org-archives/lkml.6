Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8890C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D6320644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D6320644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeJLEk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:40:27 -0400
Received: from sauhun.de ([88.99.104.3]:41704 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbeJLEk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:40:27 -0400
Received: from localhost (p54B3377B.dip0.t-ipconnect.de [84.179.55.123])
        by pokefinder.org (Postfix) with ESMTPSA id 752DA2E3577;
        Thu, 11 Oct 2018 23:11:22 +0200 (CEST)
Date:   Thu, 11 Oct 2018 23:11:21 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 2/3] i2c: i2c-qcom-geni: Simplify tx/rx functions
Message-ID: <20181011211121.6k525ixa2cbemm5w@katana>
References: <20180924235235.182649-1-swboyd@chromium.org>
 <20180924235235.182649-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="taemko2ixbpiv2iq"
Content-Disposition: inline
In-Reply-To: <20180924235235.182649-2-swboyd@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--taemko2ixbpiv2iq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 04:52:34PM -0700, Stephen Boyd wrote:
> We never really look at the 'ret' local variable in these functions, so
> let's remove it to make way for shorter and simpler code. Furthermore,
> we can shorten some lines by adding two local variables for the SE and
> the message length so that everything fits in 80 columns and testing the
> 'dma_buf' local variable in lieu of the 'mode' local variable.  And
> kernel style is to leave the return statement by itself, detached from
> the rest of the function.
>=20
> Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Cc: Sagar Dharia <sdharia@codeaurora.org>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied to for-next, thanks!


--taemko2ixbpiv2iq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu/vHkACgkQFA3kzBSg
Kbb83w//eCKnP//hTPObrMhJ+Mmp6HU5Tp89ikmciHnAQvwdlV9LhNNikmnT70D/
9mpOxz2MA56I1sX/adMQgkb6+pT5i3/fvvABoH5ZKpPs6jxjTWulRX/e9pIRAKtA
FJeko90KbyPd2IlldY0cawzZmsgwVnbLxnfO5ZBoozLaJnMRxUggWz7UbrsGN1DB
T1khYEPSeqBcr3tOtKjPeG8oSj4pzX5LWa356Tn1X54cpUDZPqZEDy+d3m42/piH
LUS4h5qVajbL1dWErX64hFXIDYJ6QSwxnfJwfnoOH7nHNpzdcdBkb/g78asei4Fq
Y3V04h/XowgAUyJHb4PDAL32/gGPHMFwR+D0zNCCYgvGKFDG4HA+tkeXAEQMu/hL
YAGIqNfPTKgtuewM/Va/FtlXlgCK7ey/Kjz/r+hiQBJdgJ9+dqcgzbVspvrl95SC
XE3kMilcSeBGr/UaTGU2N6o6YxW5XoncUtJwX936jIH/LZY2m5IkTFmvlIpDrtDq
SJIW1NjbfTZuiS118DKVFXwGMIN65HA2ATHJvPEhlRcZ/LkqBuxdXCrC9s62Xa8r
6mEDL0bkmJoCmFTlHF8a1hpbfpZxfQHST8od4/GJBpglSCucbD9TkiidKGD3yST3
2+i4p+7Y9Ujq31r9Fug4DMRQib4B3Ukpqxxs3VUlh1wz9VWLxA4=
=f4rs
-----END PGP SIGNATURE-----

--taemko2ixbpiv2iq--
