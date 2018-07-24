Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33FEECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2F520880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="dSuwEy1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2F520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeGXQcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:32:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55630 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbeGXQcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kP6fQBvk68k0r5Fkbzxfz48WqjXx/QC19IRv2y+R0NA=; b=dSuwEy1PMSp3B2tzfJi92LztU
        RBrI9d2ZWXtxZ4Jz8Q4HnipKRnYtwMNfAXkQCHLcQSErhwHDziZLGgJYcwvqUd6/FMaKpE8W95ooq
        78c7YKzwYnG2YM87LEWBcjfO3vziS+Z0TfDEORRrEigLMYCMgzB1Sh5X+T5u95q6IhcFg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fhzBa-0005Yl-Lo; Tue, 24 Jul 2018 15:25:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4CE761123A86; Tue, 24 Jul 2018 16:25:14 +0100 (BST)
Date:   Tue, 24 Jul 2018 16:25:14 +0100
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
Message-ID: <20180724152514.GJ13268@sirena.org.uk>
References: <cover.1531531808.git.collinsd@codeaurora.org>
 <56b9d5c38cfe46da1228c54f001a49773c3e31dc.1531531808.git.collinsd@codeaurora.org>
 <CAD=FV=VmfqWRGRMEn+0dzZ8x4R5vVaHbkthXAN91Lm-XmP9Gqg@mail.gmail.com>
 <20180724145755.GF13268@sirena.org.uk>
 <CAD=FV=Uo8sT72a0gRitOVoK0SfC-_QixsovW94_LnL6H7QdKvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vkEkAx9hr54EJ73W"
Content-Disposition: inline
In-Reply-To: <CAD=FV=Uo8sT72a0gRitOVoK0SfC-_QixsovW94_LnL6H7QdKvA@mail.gmail.com>
X-Cookie: Join the march to save individuality!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkEkAx9hr54EJ73W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 24, 2018 at 08:11:30AM -0700, Doug Anderson wrote:

> RPMh itself landed in Andy's tree and he sent a pull request on
> Saturday.  Feel free to refer to the request ("[GIT PULL] Qualcomm
> Driver updates for 4.19") AKA
> <https://patchwork.kernel.org/patch/10539125/>.

> It doesn't look like arm-soc has picked up Andy's pull request yet
> though.  If having it in arm-soc is a requirement then I'm happy to
> monitor arm-soc and ping this thread again when it's there.

There was also some other thing called command DB as well which was a
separate series.  Ideally there'd be a branch I could pull as there's a
build dependency on rpmh so I can't apply until the code has landed in
my tree, don't know what command DB is exactly.

--vkEkAx9hr54EJ73W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltXRNkACgkQJNaLcl1U
h9B3bwf+La4kf/5PmQL+J1NQkMHGXm91bKmR8eDDzkpswmiG1B1RLB/AcEIHjQGG
O+4kg+zfIT25E1bdVzcKvjJO4rwSHpXMpIIdgJc0NAGVCO4rb0Jh9qyWJnNzStMW
cVcRGg09wXvTzY11DT5LFLA//oqx3Dsw++sfGg+h2JoYsR0evnpHNXHQkRIlgDCa
PkNmkkTfPh4lPJjr99znmyuox8Llg+rwI9MmcqzDzuJTW2yj517Dyh07FXbcHU0X
GTVo10ah2mYE2RecDa3gRxNizHq8+qqhFnIA9zXITZfZCwVtFRajTw2ddFCxs518
6VoHO9Jy76VEYE7eQMc7bzeMYlhtlg==
=AohO
-----END PGP SIGNATURE-----

--vkEkAx9hr54EJ73W--
