Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138A3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC20222A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfBKPeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:34:21 -0500
Received: from sauhun.de ([88.99.104.3]:55616 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388569AbfBKOxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:53:11 -0500
Received: from localhost (p54B333B4.dip0.t-ipconnect.de [84.179.51.180])
        by pokefinder.org (Postfix) with ESMTPSA id 5B71D2E3542;
        Mon, 11 Feb 2019 15:53:09 +0100 (CET)
Date:   Mon, 11 Feb 2019 15:53:05 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] i2c:ocores: stop transfer on timeout
Message-ID: <20190211145305.shhuauxwolgnsim3@katana>
References: <20190211083122.32485-1-federico.vaga@cern.ch>
 <20190211083122.32485-2-federico.vaga@cern.ch>
 <20190211102424.5xnzyxvfd2yhf6ui@ninjato>
 <20190211140138.GA19023@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="djp2ddsdvrt2nbom"
Content-Disposition: inline
In-Reply-To: <20190211140138.GA19023@lunn.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--djp2ddsdvrt2nbom
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Could you drop these patches and wait for a new version?  I don't
> think you have pushed it out yet? So it won't be a visible rebase.

Yes, I can do that.

When resending, just make sure you include the fixes I mentioned when
applying.

Thanks!


--djp2ddsdvrt2nbom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxhjEwACgkQFA3kzBSg
KbZbHQ//Yqv7A22GraEDoH49uVK8gWopaQwjVIDuHZ8N5SuwhLgcFdsdHgH8kV+Q
zxAzVQTp+q07HFNr1HN6Kb3+Iwg51Zpw2Fqtit+C4fzoP5ulITiiSQh+FATNDwDc
XT+qQoc6B4S6+4i8hFVi1woi3eVAsRisS3mutW5rpbwgfZRvqOwBfduFCibLbsBR
n+lw0nO4csofRRNdCW/FugU5g7eyVtq6drmMfiBr2eoqImlquMjgSL/gbZIShifn
Rt/dG/hLeQ40WorZhObszcG1kgMNdXLWSHXsP7+/LPc3oUdtxj6+cIWbgmbBgEMM
gX96W7PyvCkhYGb9FpiM3MYAzrqlwttoO2IBtDsCVI9BHB1dYgT3i2rwklrqA5Z8
u1ZHj3dZ/AscaX++DixhzLr7eXbFrzlSpdxbHypMmQy+/X8EzRtnXXJlEYiwgp4k
34gG2S/Cl4b4Q6++l1XeHrcvHUujicZRY9Lf+e8k0ZCn93gFSsbS2jU07flbkgor
csMjkML++wl68g1/WXhFigIQxMGbeMpjzDsFQ5Q+Qw9IxwJiyBgSmoqXZm6D2pBq
WnerHQR9gx22+Uz+VwAKgBrmhtOQz7zWKYwL0Wt6+yt6hJfjtMtzt0hJOGRfcOzQ
pPNm+uzZBvusSKx7ne6hEc6aJCTAMWCOElnSKJk89LBdG8LxRvs=
=x6/Y
-----END PGP SIGNATURE-----

--djp2ddsdvrt2nbom--
