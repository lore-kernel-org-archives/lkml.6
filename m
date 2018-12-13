Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF2EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C5E2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544718278;
	bh=o/9tACS+SRHR7amjINqGxkt4nlrIut9GV92xAM/No2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lrws+1m2NCso5cpI03mDk12Q04/E38AALK0pH/7oXLyaRmhqJTH9wJAemzRy27X+Z
	 SI3hfZcDzUU5E5zQwnFtm0AnIdJ4Q9AOdoJGF16hmHK8wC3A/wM48hBQRkL2a7+IFY
	 YgwjwcFY0za9bAY8SONwUK79i98FD98ZVSk4iwxk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C5E2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbeLMQYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:24:37 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55532 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbeLMQYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ugZac0aqYMrkj+HqEFYsF6ya73qUvTzvI6NrdYAoYd4=; b=EMFPgAlHxIeyWWUbGbI6ZPmFI
        ajNQnCcdv9dLWylotupoAC8MZ0m0h2k1rZybxJGFNV7zlSpk+7ccgTOSSNN20QBjLXbCBY5kz5gsb
        CUgDdRD0zx5UztwZ/sasF2y4CD3xmYcsb/ne7ZZCJdSYFMi4EhxKmmu4t5IOtf4cAusWc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXTmm-0001sS-Vp; Thu, 13 Dec 2018 16:24:29 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9E69311254D1; Thu, 13 Dec 2018 16:24:28 +0000 (GMT)
Date:   Thu, 13 Dec 2018 16:24:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: ASoC: About graph node issue without 'reg' property
Message-ID: <20181213162428.GR10669@sirena.org.uk>
References: <20181213193944.CCC9.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IUSVF+LtaR4kWxuH"
Content-Disposition: inline
In-Reply-To: <20181213193944.CCC9.4A936039@socionext.com>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IUSVF+LtaR4kWxuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 13, 2018 at 07:39:45PM +0900, Kunihiko Hayashi wrote:

> Maybe I think that we'd better add 'reg' properties to each port,
> however, there might be same matter in other SoCs, so I'm not sure
> whether your patch breaks the backword compatibility or
> our devicetrees are wrong.

> I'd be glad if I could hear something about this issue from you.

There's an ongoing thread between Morimoto-san and Tony Lindgren around
the graph card including this issue, there Morimoto-san proposed some
code which would let the reg property be optional.  Device trees should
still be updated but that way we wouldn't actually break anything which
would be good.

--IUSVF+LtaR4kWxuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSh7sACgkQJNaLcl1U
h9Bfbwf8CZwXDJ0O1VnVPP7joVWcrQp5GZJHKL6PohHC4wnYTxdL1upa7gVxSBan
K2KxWJrne+6gyNqnToMgQtO8kXuWvOz7VUrhNeO1GdLx+exyJpDTP89eKT9sV6Rz
2uCxx/Tzzd1B1g7uUPm7nqHvPgxVQive0+LHOEtLG6X732sw4YWgzZ5dX0gvYk6Y
ouVfi+jhEDWmbyW7lphF5KqExsM0+m5WSOdd7iYtdXGe5AFLrJPBGiG8dCsMd/KU
jCjrs1Z7u60yDcOj5gJ5tTy4RTt+JEtCipEC7w+n5RIfxc1d//A/qIwzBeIY5/vb
EVEoARP7HPmnD7EPpo2lUxLXlpyHXw==
=tPIe
-----END PGP SIGNATURE-----

--IUSVF+LtaR4kWxuH--
