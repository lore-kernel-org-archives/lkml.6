Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-763755-1524466897-2-11039577916553587249
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES daenca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524466896; b=I7bFNhanEGPzUBdu4DgcslTGu6sQhEBIY3zlPGUgYdpZM/u71J
    MOPwxhrIlBQ+6OAUWqkpTZyM++2D2XIx1+qbsZtc8O+ux/3bIv7Ex9CzCKo6uMaK
    2O5z/NdgneYl6WvV60EpQT/DMFnW8NKSEfvIzyURiuLB8eOwX9ygUzd1O8ZCv4Mz
    I0KCt3IPyScOMiw1Cfvt58UA6QxXVIHEmcH3mA3SpPpSxTnku9F+MWhX8U9OofgC
    l7Ey8nTPpxcOjx5mF+LVZZITKm4hjeqbZvR88prw0V0FVyWxC5x4Zp5KL4ufnDyN
    L6pQ0n9YPanRCz7TT0PDy8we0dns3XeS3oPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524466896; bh=xS7qGTSaWXhM7XhH8usAgn9wHIi9eB
    1BN6KHbsts+mE=; b=psdgqzId6d3JwKJvUZtwIcD1tb784BiPJwhx6lSaRPkuFG
    FQbGyRO+PCVySoeYLVzE06m7jxozKcWtvE7tsIpMUrMsY1aIjFw40pEpbemppsMB
    /5qK7NcbGy62/G6+FFiDZslWota50cCbvEkFnkCegYzofLjRPlMtWqZ0T5Fcvrjd
    L3kZxGFTE6l7BwI8ZcF9oCrNAU9H/EhBZhbwtuCeW6U6TYCxY1I1+BdGNtjql39Z
    h4/Tmbm/SQXOaeNmzkK8jfOByRUOwK1pesY7i+el4+NAlPmjP41ptLloH90glFv4
    KKjWy9G0PEwnB6/xq3ZZycsjQ9Fi/cxpy6IKG76w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPCBUtRXPP1z/wk1lVTulE0NYHwHn/UrBz1QXNqdT9PILteONx0aqXccyfTVTCxD8wqt/Vf57+kotjuis9UBwGm+/a5LsQKga6gKM4GrlMqe2mpA8h+q
    Xs2+3uJAvAx0JhnmOkhWoNssu3xCdkWst5loiH1x69fQAGgoFthwV8XhkScrlWdVcTJAy9eFASsHzAfndsDqQvK71yVzLgosLUslm5Nx142WIGlfFzU8evNC
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=cm27Pg_UAAAA:8 a=uP1ucDPQAAAA:8 a=LpQP-O61AAAA:8 a=hD80L64hAAAA:8
    a=P1BnusSwAAAA:8 a=P-IC7800AAAA:8 a=EjIUdSSjv0o5tt0d6IgA:9 a=CjuIK1q_8ugA:10
    a=2ISSbUf8AdmjFs2nywcA:9 a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=xmb-EsYY8bH0VWELuYED:22 a=9a9ggB8z3XFZH39hjkD6:22 a=pioyyrs4ZptJ924tMmac:22
    a=D0XLA9XvdZm18NrgonBM:22 a=d3PnA9EDa4IxuAV0gXij:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeDWHBe (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 03:01:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53380 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751519AbeDWHBd (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 23 Apr 2018 03:01:33 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT,
        URIBL_BLOCKED shortcircuit=ham autolearn=disabled version=3.4.0
Date: Mon, 23 Apr 2018 09:01:21 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sean Paul <seanpaul@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        stable@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: vga-dac: Fix edid memory leak
Message-ID: <20180423070121.llolaxnobue2ife6@flea>
References: <20180420190007.1572-1-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ex7kngj7bmlyjpcu"
Content-Disposition: inline
In-Reply-To: <20180420190007.1572-1-seanpaul@chromium.org>
User-Agent: NeoMutt/20180323
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--ex7kngj7bmlyjpcu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 02:59:59PM -0400, Sean Paul wrote:
> edid should be freed once it's finished being used.
>=20
> Fixes: 56fe8b6f4991 ("drm/bridge: Add RGB to VGA bridge support")
> Cc: Rob Herring <robh@kernel.org>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: <stable@vger.kernel.org> # v4.9+
> Signed-off-by: Sean Paul <seanpaul@chromium.org>

Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ex7kngj7bmlyjpcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrdhL0ACgkQ0rTAlCFN
r3TK1xAAmBkJHE5qkeJuK8lcpuEWaP0ZgD7gkeiFJtzvzyI5Ge+AbVTV5sn+EgH6
Q6MV9tU8O4rpUAy2NkPOLmQ3OkyLb/071N1Z/ki0fLimihPySEpmMsoyUcab/UWE
R4B9Ndkon/07fRVzWxoT7k1OmnonsfxodXHnQMDxnII6klFXJpm2iytDoRlQGpln
y3frz1m2QI2FWbnZkzu+tqwE+lntpTtpGKyMgmGEEgqhKvzYXl0RQXuf/9vDpoky
gzG0Qd1gkyIv7/GbojZvDH+H06l7GO+9G45ZkC5N0uRoxU+zDcHhOwMuYokkXsZU
dIr7mqgC/qSTDSWv4lgY9y8mQYlGY64zAITR2rLrG68oSV9GjTuTPYaUJVbDThu9
0LXGhcB5Wqdha+tYqV2dGTHOZJzm4/z7AVkPFHoI9AsRHOLLgTm351mQmHF4TKeK
4KHrVaxzxKnjq5njPVBdeBXMm/s0IdXTf//kIhLnaSzaZa8/abSxsZm6yIUtCMDX
bcuemsLpQSibqHcQbPbhHnh0RuwOUv5hJ6naR/rnZWrZgcWooIkaOTGgnDdgYpBF
IFFqDgPHbQDXXw4iFFmMAI6IU886qVIMxzOTBGq43O9pd/R4QPPdyPf9WRWEnrwm
sVTvmqwTyBekDfm2GseFLIwfTdaWKlPlWF0Uif+bwayjnoecNzY=
=CvwE
-----END PGP SIGNATURE-----

--ex7kngj7bmlyjpcu--
