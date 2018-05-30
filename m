Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932315AbeE3UZN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:25:13 -0400
Received: from sauhun.de ([88.99.104.3]:37236 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932233AbeE3UZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:25:10 -0400
Date: Wed, 30 May 2018 22:25:08 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: tegra: Remove suspend-resume
Message-ID: <20180530202508.raee7klc2q3qoddo@ninjato>
References: <20180513211347.7187-1-digetx@gmail.com>
 <20180530201831.6327alcmr2stgr3a@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x4anpeq22o24y36s"
Content-Disposition: inline
In-Reply-To: <20180530201831.6327alcmr2stgr3a@ninjato>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x4anpeq22o24y36s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Applied to for-next, thanks!

I removed the stable tag, though. I am not 100% sure if there are not
any side-effects for other users. If you still think it should go to
stable, please mention this patch to stable@ after it was applied to
linus tree. Maybe with a word or two about regression safety.


--x4anpeq22o24y36s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsPCKQACgkQFA3kzBSg
KbZxOQ//emYo+b3hmRs3Wbwpgfd2uJMFBOLHtdlcf2q/8BgPgrp4Ki0aDwJ2d6ut
oYpFGBZFqbidgxoWw1fxa5dBTRX/QA1zRcTBy11dJQebI7XWR1ou2Zp0u7fBk61P
/EFhzvEjQavRUCn4l76oGgNM9wKuAQ3Cz6If7tgx+o7/ylDSj1PNvr2nWnqb28xe
xYJyZUHSni/IcQ1b2XN3RGCe8F6YYjqKP1JP6pV0lrgAvLxl8hZP3TPGPNisTMDv
fLbdRL/ITfPvshga+iYgQc/+q/mgfw3fG4wNxCmePLVBoMN9Vr8jFWDyBkBp+uHe
Rq2CmvvRtWDpSpxTf/mo+OecJMp+ni8D3JwRoupIAjW99Q0yVMyNWBZU0VNXDzQX
vdbJWR5UfkmagqIx5kdFvcjgq+8P4KV7MPyVeQS2xGK8hFAp4H2/esBzHDib9vck
MAn8B6oVIoT6foCJgTMzgCY5Ast9JQwcdCWQtaJfujVzN5Z2tZJD2QfNtWIAfBhp
pFzvl6606HPOnwfytj45wFvrJxBy+J8McQ4QbzTY48hrtkLGgVETpnDCn+iq56ge
BokorHr80O7hXrWg91QMtdd3OWeynzFS0HU4uAWVYIA8YKi0Ofo2C6YyyOP7Fq+M
ODoEtSqMAD4stJbB53TsM+PhZ67Ek3R7AXDbJsLbZI39YS3eRuA=
=0dGz
-----END PGP SIGNATURE-----

--x4anpeq22o24y36s--
