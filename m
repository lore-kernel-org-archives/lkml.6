Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861F8C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3702025987
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="CFWt1CVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3702025987
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932315AbeFYMsC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:48:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46628 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbeFYMsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uxyz+RcsoaFqbacV2BaB6pOrF4u6txLNuzDesTsq4xE=; b=CFWt1CVI+H9OvW3BJAurnY2v3
        GnHcuWtBSlpHmatkFVOtoOEwxcxlDXfMBTpcCZi6qejoV//2L1+gY+Co001Dk8MD9sX0mFupRH7Hs
        djoFxdUD2IqS7CWxvlYAmhwJMf+uvzC9N7WLktKAq9oP5KJYFsTovZBZzW8kLmXIYvFV4=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXQuU-0007qR-N9; Mon, 25 Jun 2018 12:47:58 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXQuU-0007Sf-9a; Mon, 25 Jun 2018 13:47:58 +0100
Date:   Mon, 25 Jun 2018 13:47:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-spi@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] spi: sprd: Change to use
 devm_hwspin_lock_request_specific()
Message-ID: <20180625124758.GN9413@sirena.org.uk>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
 <1662400fb204bbbe9a36edf580ea267079a2a02e.1529654288.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UExESr5xZTMxdOWv"
Content-Disposition: inline
In-Reply-To: <1662400fb204bbbe9a36edf580ea267079a2a02e.1529654288.git.baolin.wang@linaro.org>
X-Cookie: I'm having a MID-WEEK CRISIS!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UExESr5xZTMxdOWv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 22, 2018 at 04:09:05PM +0800, Baolin Wang wrote:
> Change to use devm_hwspin_lock_request_specific() instead of
> freeing the hwlock explicitly when unbound the device.

Acked-by: Mark Brown <broonie@kernel.org>

--UExESr5xZTMxdOWv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsw5H0ACgkQJNaLcl1U
h9Bbnwf+I+AYIS79+tNB+hmEicRXydey0TKXbPL7tuLJM4PGz2Wu41MYSHCrMPhF
Q+QALphCYNa3gGMvmaSxg5DEV04QK9+v6wXnPk4q/5XdVXb4v54Mo5o6PV5rZpFw
BgqwXL91oQ+7FzqZQiJscj+Jvf5bQFajy47ItPo+1fFHK1fE2kUmIcQs2VetgBz6
ZUBVkOgPs374xVoOL2Kzbkf7wu7FJn9HNdaOwmHi6kWDLy/pCtsSZJC7OqacBgKX
6UIg56z+LAZDqt0kRY4zp60hOwzTp4lQ7ZVTZ43H7Cyl7kwVInIpURyOEr+ujIBY
IrHYSDa8o71lCkZGQ8dbCRMppEY4iQ==
=kvuL
-----END PGP SIGNATURE-----

--UExESr5xZTMxdOWv--
