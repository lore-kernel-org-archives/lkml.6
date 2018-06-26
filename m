Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BD7C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8808C216C1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="CsAW2L8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8808C216C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935441AbeFZMOL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:14:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34874 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933814AbeFZMOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XIP4ePtoqepWq6J8GLzgApKJWGNw7cEwdK7pNbymJxw=; b=CsAW2L8nZgClHZqJ/O01pM43I
        xKEWHNonBltiehLhKwEfgnp1R0Z3cGRIuxdg3Z2Qtb7NwAQcfXIExbowuRDH+civeTlxPWO08kTvE
        pRtvX4uqHYxpytLsV1yoH2A1G/VuVc3qCWfGAv7mxuc0Q9/1o7FD9jkWit1mtB7MDlg1s=;
Received: from 188.29.165.85.threembb.co.uk ([188.29.165.85] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXmr9-0001E6-N3; Tue, 26 Jun 2018 12:14:02 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 89223440071; Tue, 26 Jun 2018 13:07:33 +0100 (BST)
Date:   Tue, 26 Jun 2018 13:07:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180626120733.GD1779@sirena.org.uk>
References: <cover.1529712888.git.collinsd@codeaurora.org>
 <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
 <CAD=FV=XVEEPgjBXxR+-46RgxLOq63Xvq-jtruoaCxccmMoKUuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <CAD=FV=XVEEPgjBXxR+-46RgxLOq63Xvq-jtruoaCxccmMoKUuA@mail.gmail.com>
X-Cookie: PARDON me, am I speaking ENGLISH?
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 25, 2018 at 11:50:52AM -0700, Doug Anderson wrote:

> ...to this patch.  Speaking of which it might be getting very close to
> time for this series to land along with David's other series, AKA:

> * [1/2] regulator: of: add property for allowed modes specification
>   https://patchwork.kernel.org/patch/10395731/

> * [2/2] regulator: of: add support for allowed modes configuration
>   https://patchwork.kernel.org/patch/10395725/

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsyLIQACgkQJNaLcl1U
h9A3mQf7BbinIiX/WnJKrr4+my+I3hHicVubnBVayQLn5dXhoqJdolPD/4I39ig/
0OBI2Xz6IAuEByEmZKC5cFlV9x7VQaMvfPjjD9vYQJbQmAkd1kwUrKrutjXhtkKn
yStHJBE9mxuxzbIRnonjAwj+TGSGRsnRhVrZaO8xJ8MejTntnCKtSXA55XdqZ5QT
e0IckrY+pD5C1sC9gvCbr6tgHyYRpml7ZkhC6JGPwseoFXVvv2lZdmR6iZ7SUqKy
RzMv6XpdOWESd7I8MMbkYKntbOENYY2hyJRPUApm391hcHFWoOpYi7cO+2K/VDI7
2JrEXzzQX5KyGo80Yy648/8tlqxYqQ==
=e0zs
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
