Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED35ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE52B207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="fjB/A+vB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE52B207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeJ0FMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:12:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37708 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeJ0FMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o9gp02jmBsVMkaI6NqsPZDIdxt/USSmbywVQ5i6/iwo=; b=fjB/A+vBAuER/rTmCN5iwg5ip
        EUo8b4s6xZqVuCLfSDBuw3+Ux+8MTcwRrug6DozFbEQt/NIQvV9aC63tMGEIZ83K7syEdO0f8irNn
        H0cM/IdzmE5zS5rLYKT7lPoLkkUb6M7YF/fQgI1O+kD7bHDGw5kIFanXKVhssm6aEeWJk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gG8ng-000447-L5; Fri, 26 Oct 2018 20:33:44 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 63F281122667; Fri, 26 Oct 2018 21:33:44 +0100 (BST)
Date:   Fri, 26 Oct 2018 21:33:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
Subject: Re: [PATCH v4 4/8] regulator: stpmic1: add stpmic1 regulator driver
Message-ID: <20181026203344.GD27137@sirena.org.uk>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-5-git-send-email-p.paillet@st.com>
 <20181019115015.GC5895@sirena.org.uk>
 <5BD06B96.3080809@st.com>
 <20181024131716.GQ2103@sirena.org.uk>
 <5BD1C3BB.6060500@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Content-Disposition: inline
In-Reply-To: <5BD1C3BB.6060500@st.com>
X-Cookie: Kin, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25, 2018 at 01:23:08PM +0000, Pascal PAILLET-LME wrote:

> I have reworked the code so that we don't touch any more to the init_data.
> the new loop to register the regulators is below:
>=20
>      for (i =3D 0; i < ARRAY_SIZE(stpmic1_regulator_cfgs); i++) {
>          ret =3D stpmic1_regulator_register(pdev, i, &stpmic1_matches[i],
>                           regul);
>          if (ret < 0)
>              return ret;
>          regul++;
>      }
>=20
> Each regulator is registered, even is it is not described in the=20
> device-tree.

Looks good.

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvTeicACgkQJNaLcl1U
h9BNawf/cbL/eN87EoAK84d4Blf5KW/72h2ON2hIQ4Zz17sppoHuiZaArEUDLbjv
tDanZ8eCfCKDWaysFbU8014ck8IO74gnCgehAh9RAu4UMmFHBX3JBpfgnWtOhYYX
Kw3MuAnBzFqeDq11wTdjUW3vfd6SZsm+/Zaezw/Py7btUesDIbo4Rg7OAtaG5Rkn
2xnh/Upm2W0dHxwN3aH1Y9zxxJrr6xyROTO5LZnkkPmYNewAgW9UFuyzsmqJq8+N
W7u9b900oQWhEa7cwxlwDMeVV+TPb5SOU8xTP0soHgLKf8ymDvom6Xf2Oi9jsKLX
73RVLYgMgNl607gHIfWVbpaX61LQIg==
=Uxw5
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
