Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40234ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E722C208A5
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="rTm1pPMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E722C208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbeGNXFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 19:05:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58144 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731583AbeGNXFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 19:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bkEM420ENpdthYaYnih5J3UZVlN8wWf2aVTIHJrSkLM=; b=rTm1pPMvKg6eusMWRxSyWbyC6
        L0tIJ8Z/zdGGNPnDolaZ8aFt4Q/2HZonmSM9YN7u4U2UQTCq4Cq16Ag8eyvUrisSRxbKMCSvSmGBy
        cba37HGVmWEvlvSoxnXWc/xSW8FbG6k/aQcM4PpKOmsiumU078Nwoswa3mDuODx7RMIh4=;
Received: from host86-174-189-173.range86-174.btcentralplus.com ([86.174.189.173] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1feTH5-0006hp-5o; Sat, 14 Jul 2018 22:44:23 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C44B144008C; Fri, 13 Jul 2018 17:14:08 +0100 (BST)
Date:   Fri, 13 Jul 2018 17:14:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     gregkh@linuxfoundation.org, p.paillet@st.com,
        linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] base: core: Remove WARN_ON from link dependencies check
Message-ID: <20180713161408.GE16228@sirena.org.uk>
References: <20180712080623.21203-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Content-Disposition: inline
In-Reply-To: <20180712080623.21203-1-benjamin.gaignard@st.com>
X-Cookie: Reactor error - core dumped!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 12, 2018 at 10:06:23AM +0200, Benjamin Gaignard wrote:
> In some cases the link between between customer and supplier
> already exist. Do not warn about already existing dependencies
> because device_link_add() take care of this case.

Reviwed-by: Mark Brown <broonie@kernel.org>

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltIz80ACgkQJNaLcl1U
h9Bf2wf9FaEv16B8u9bsimEyjM8Hx4GGUEP9LMXHMIzhyUfUoVGy90eE3GTTV/+c
3GKJb2yx9blLkIvwmOsZRXSKQqznNla1i4zATJNQC0PE1GWQUsAfticIE5cWIL7m
xj0zcYDQw5bGXxbxMBNNgMQbZakRNCd2zHZ9DhQpYx4GwkzUp/FVPsqomxPVvfJ/
3rgCs75qTr2c2gtygqSb+rCgCJ+ESfsyHxq2E0A0u6tID7HIVXZSgR2JnhaMXe4q
tlORn7b/Ig6bamppVRQqZuvsvSx6bgGcrfk1eA24P+DzXRybmW4q9Cbp1YeBCQjH
f8FSgpiPZvUQyS6g/qRzTaM+1MKLBQ==
=0ghM
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
