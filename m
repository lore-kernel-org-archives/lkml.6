Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC236C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CCE20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544714363;
	bh=BZ8s3NeEtJegPWgo8FJVejvAEnmL+/6CnIWx8+1aVvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PgDNSmjJrCsIBsHwtF8LetfuX3mslK3K9946xtOypqoULFG8+XetwV96bB0/LwUZD
	 2v9Br0ptyEB/O0YS+IP+fXkugfrv7DU2EXyqbkXN8KXwLCzw6nXGLCY+5bn6Jz4WxD
	 p5VKy0jZ9MW/hDIKJ8kbx8z/cqgMghsClJqxXHck=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CCE20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbeLMPTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:19:22 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58984 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbeLMPTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BZ8s3NeEtJegPWgo8FJVejvAEnmL+/6CnIWx8+1aVvg=; b=rRqBGNYOzyJJ1XqvhuMIXL8Pw
        7HIY1l1VJ1yn+En36iTTgdF3fTsHIOasomag+USc/qlgpJIfS8hRpecledJSpX1/ATmYq7GTirYtc
        0A6uTRuZcvadsXATNbGiO2D6ZZnrIF4nAm/ssUNuR4Ibrj9bJNn2jG/wGzgI2XKqEfZUs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXSld-0001fD-Te; Thu, 13 Dec 2018 15:19:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 962A611254D1; Thu, 13 Dec 2018 15:19:13 +0000 (GMT)
Date:   Thu, 13 Dec 2018 15:19:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu.Beznea@microchip.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/5] add PM functionality for act8945a PMIC
Message-ID: <20181213151913.GL10669@sirena.org.uk>
References: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
 <0291f79e-b8df-f7ae-1ded-cacd404bc5fc@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bzq2cJcN05fcPrs+"
Content-Disposition: inline
In-Reply-To: <0291f79e-b8df-f7ae-1ded-cacd404bc5fc@microchip.com>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bzq2cJcN05fcPrs+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 12:59:00PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> Hi Mark,
>=20
> I saw that previous version of this series was applied to your tree just
> after I've send this new one. The only difference b/w them is in the
> documentation patch where I moved the new header. No functionality change.
>=20
> Sorry for the noise,

No problem.

--Bzq2cJcN05fcPrs+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSeHAACgkQJNaLcl1U
h9ACcwf/f1jbeM50E48CoRS/p3byESPME9qFXzlzSPlBieoND1AP4rYAg5rZK7Dh
8GqyVtXBN5kUU201y0DRmsxgM7C6qGvi5YEHZGx87e7ty7H5hbc+ZjySMSjZRs4n
fONSaIP1v9owsc0JLafzy2U5N+nAs5m+tbFKmXwb3+8WImGCpmD6SKOgoT/xV1Ds
Hn0/UjuQeivg3z+uPUrAjRRlqPk1nztYvp77wxwuUq5nxPUIa8yr8bnPTTzurNsZ
M/cJKyW8THH68yh4le8f4p0TNWIjCl9yNWjsBlOjfS0xEwsn+HUb2CM85Vxe/MUz
yf0BSk/EqpFl9pKKPs+oS9D4vcpMbA==
=C7zy
-----END PGP SIGNATURE-----

--Bzq2cJcN05fcPrs+--
