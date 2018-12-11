Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2612AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E708020880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E708020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbeLKTi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:38:59 -0500
Received: from sauhun.de ([88.99.104.3]:45118 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeLKTi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:38:58 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id 8AFDE4C0E8F;
        Tue, 11 Dec 2018 20:38:56 +0100 (CET)
Date:   Tue, 11 Dec 2018 20:38:55 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     jun qian <hangdianqj@163.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: i2c-tegra: replace spin_lock_irqsave with spin_lock
 in ISR
Message-ID: <20181211193855.ftzvyz6ilrzujywv@ninjato>
References: <20180911145446.53621-1-hangdianqj@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cywaxr3kdeeyjeyn"
Content-Disposition: inline
In-Reply-To: <20180911145446.53621-1-hangdianqj@163.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cywaxr3kdeeyjeyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 11, 2018 at 07:54:46AM -0700, jun qian wrote:
> As you are already in ISR, it is unnecessary to call spin_lock_irqsave.
>=20
> Signed-off-by: jun qian <hangdianqj@163.com>

Applied to for-next, thanks!


--cywaxr3kdeeyjeyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQEk8ACgkQFA3kzBSg
KbYqTBAAkZx0GrhtB1+bO2FIxI5bhr05iDZBwcXCFEF0Qv3XEXHaXT1TLHJ865IB
1bjhnnLLHzA+79gddaaHais5xsDL2AB93rz8pL6GZOVaDCB2qxJ0TK8zE489NzxD
cOX2Q3dFEVE6FqKdbawnmt/IAHyoc9m0b8sNHM19Sea1GjaRL12Frg/tGzMFLA5K
fS5NwXL5c0sPgVYZdCRppz1D9pak0mhABF1ORb+hYQf8Udfii0V+7+d3TNwrdTjB
GbNcEGQiAHT+YoDGPjw4f8ISTGDOXZyK+BKPnapHWHtQca2XD01VEX0N/UbENaAV
cru4opSBacYJBKHU4+qVp1cWbn6TK+8s2E7+Vfor4/oheMPWQKaJ995uvEkLF1Ne
z7Zve83DbWuY+HsNgHKkUFbAsR26bA/yNjmZM+rhtt2Gxy4itkQTKE/jc7DYcC7/
3Tk3oHIprp1Q5FYP48GAw/tWyu4hpaSn3NEXkGhWeK2PpatWlgx6sD68EXEFT1Gi
JrQBaRlqBjW6gGq9QFx4d+9xzbuIxdC/PwhDkM4HL2U2PFBztyBdbHi7KrkYfPYB
g6NSLmZksjTiugR0DogD3ScsjMHQsgmopreYOpVvTEDNnPXcKrwSZw03vdPGX8WT
tn8yLS2JnhrH+VN+gILR6uo6r4lbsH1d3NhXdcY1VJgxJRNzrK8=
=8JzN
-----END PGP SIGNATURE-----

--cywaxr3kdeeyjeyn--
