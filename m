Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3D4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C5B20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="s2H+h6CM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C5B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388665AbeGXQEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:04:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38046 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388522AbeGXQEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QaIGAnOQqltzxREeKQrguciLBbcS3j040utmxlfsyYY=; b=s2H+h6CM0q0PDrni7QuuPrXyE
        5QTpJ5myco9gqL/5dxpSIydy4lXelCO7JJ6/0HGPGsR9IalNUw9FRFsHcF0s7mV5XOpMPbuHdsTks
        juyX9AYJaSLOMT+Lg9WbUHpji0v2kynQY7oBbKtQzb+VvcFu9VRhvDIXP/UNsWRmXO7+g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fhyl9-0005XJ-Ta; Tue, 24 Jul 2018 14:57:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 43B271123A86; Tue, 24 Jul 2018 15:57:55 +0100 (BST)
Date:   Tue, 24 Jul 2018 15:57:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v9 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
Message-ID: <20180724145755.GF13268@sirena.org.uk>
References: <cover.1531531808.git.collinsd@codeaurora.org>
 <56b9d5c38cfe46da1228c54f001a49773c3e31dc.1531531808.git.collinsd@codeaurora.org>
 <CAD=FV=VmfqWRGRMEn+0dzZ8x4R5vVaHbkthXAN91Lm-XmP9Gqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oPmsXEqKQNHCSXW7"
Content-Disposition: inline
In-Reply-To: <CAD=FV=VmfqWRGRMEn+0dzZ8x4R5vVaHbkthXAN91Lm-XmP9Gqg@mail.gmail.com>
X-Cookie: Join the march to save individuality!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oPmsXEqKQNHCSXW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23, 2018 at 01:09:05PM -0700, Doug Anderson wrote:

> I know you are still looking for time to review the RPMh-regulator
> driver and that's fine.  One idea I had though: if the bindings look
> OK to you and are less controversial, is there any chance they could
> land in the meantime?

This appears to have a bunch of dependencies which I've got no idea
what's going on with the merging of and no idea if they'll affect the
bindings or anything, nobody's said anything and last I looked it was
unclear what was going on.  I'm kind of hoping that things might have
sorted themselves out of the merge window.

Some of the decisions in the code have flowed out into the bindings
before so I'm not keen to merge the bindings separately, and if the
driver for the thing used to communicate with the device is still in
review then that's definitely a red flag.

--oPmsXEqKQNHCSXW7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltXPnIACgkQJNaLcl1U
h9Cnlgf/Us+o70Zq0Iaws8EPizNkIFJTyo9hKNBJLy2nFBa6j3aAcDXTget3QCfT
2Pii23L4yQvr+6M2JoO4eOcuL9HtiJKkbKtqdf/P0MfMWGRSmI9IBVypILXlb95n
qsqghZ6Fd2Iu16zelRHgpfxlezB1vz+O3/Z3TURqmPH/ntaY/FVjZu31+ciaA6xR
zn5MfgmJpnYPQNJpLFndEc7AS6aszgvxKwgZ3rggIhG/uMJd0lrAGBsA2/w1Mrd+
umLdkg53zKwjVN3wnqdaqKlwh7d3eQdbw9uL+lS+p1JXZXgHQTmZnHw0nCkEcu88
do3PmjMP3V6yplJh9S6pRNTMgn+/ag==
=ElU3
-----END PGP SIGNATURE-----

--oPmsXEqKQNHCSXW7--
