Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D356AC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FC620811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544725668;
	bh=AZSAQeSq4lYxIuGQ+MCgDEP6CR8O59SzUecbq9vfNVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CtcWrMebrq1TSyQr2GnokSSnr5rRf68vr+fVhjFidPBXtpkn5lyQJGtBgss+f8Xn3
	 mdgrMXlvibffdqP6doTEYLPDWLCKSXO7K41m+QAvsiR7UBAyk5iMFEV8+L/UM7vMnx
	 4MzZHCNG/IbvGesmXIe5oYWc803kWqqEBX4IykfI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FC620811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbeLMS1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:27:47 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36572 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeLMS1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O8kvuk2P9HOhrZDmsBhGRblUKubDsO5nzVh68hmO+Y0=; b=gSXReMvBD62B9ySv7548eEJrA
        Dm0v8EtId/sKCOvn6+SYBC71XinhsewsD83D/MaQrpsY1/QZZB1gNuqVPCLA3TdI8W3PyVsC6zesr
        EPBXIljpdH4TUeljKXbn1C61iAssjgbd4voiDhJN6iuivJ0gC52ucYVBAHWJx2saIpItQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXVhz-0002Sp-JP; Thu, 13 Dec 2018 18:27:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1DD2D11254D1; Thu, 13 Dec 2018 18:27:39 +0000 (GMT)
Date:   Thu, 13 Dec 2018 18:27:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: ASoC: About graph node issue without 'reg' property
Message-ID: <20181213182739.GZ10669@sirena.org.uk>
References: <20181213193944.CCC9.4A936039@socionext.com>
 <20181213162428.GR10669@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+vcRm3WFmV0Q/ShD"
Content-Disposition: inline
In-Reply-To: <20181213162428.GR10669@sirena.org.uk>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+vcRm3WFmV0Q/ShD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 04:24:28PM +0000, Mark Brown wrote:
> On Thu, Dec 13, 2018 at 07:39:45PM +0900, Kunihiko Hayashi wrote:
>=20
> > Maybe I think that we'd better add 'reg' properties to each port,
> > however, there might be same matter in other SoCs, so I'm not sure
> > whether your patch breaks the backword compatibility or
> > our devicetrees are wrong.

> > I'd be glad if I could hear something about this issue from you.

> There's an ongoing thread between Morimoto-san and Tony Lindgren around
> the graph card including this issue, there Morimoto-san proposed some
> code which would let the reg property be optional.  Device trees should
> still be updated but that way we wouldn't actually break anything which
> would be good.

There's a patch now - "[PATCH][RFC] ASoC: simple-card-utils: fixup
asoc_simple_card_get_dai_id() ID method".

--+vcRm3WFmV0Q/ShD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSpJoACgkQJNaLcl1U
h9AZSgf8DJV2egX6ENTCZAe8EPXaS+WF0cef6t51L9ocKvhAOeHoUehO7HvT9gMG
xBO9cd7tIfw7+HwqH0sBSdDAKBP246DDM08+oQyVKhr+w61RVd8mV/nUA9JBtNVC
yA9H3bryGOQck8Z01mHvL9D+ksFdsVQSBXprSiHb/YjxVcVwJSeoS5rXOZbrB+qL
VP9+z5P6dqs3Fbw21dE3TrfayK32TyYPbGrV138KpQRjdNDSVDkTrnivlg8sMrfV
MbEWHxcTcAOYxJIHSudYnXzNyea5c6YTFrz+0eCWSMGISEQ8GFtqcL+AMhb9fsWk
qJmrndRUNuiWBbOkVM0tngVTGdd8Bg==
=/9Qs
-----END PGP SIGNATURE-----

--+vcRm3WFmV0Q/ShD--
