Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA0CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB7221501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="c9od3+V8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB7221501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbeHBQ1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:27:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60394 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732419AbeHBQ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vb4hG/gsbw2IJd9I4cG6pbmpBpApWGiogn/SQi86jbc=; b=c9od3+V8yneC8ZIP79fuii/Jq
        8LPrfaxREHb0molMAaai8w832zVVQOREp5SevVcmE7GZGGm0o1/c4t20FEyWWN9XMzABvnRQhcsR4
        P8sfjNyeaG9eQlpQbAu+w/z+pzLb6x4jsjHPgnZLYq3LGnA+Kr5E6Iz1wdmTfMUlkka2k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1flEh7-00025G-Vv; Thu, 02 Aug 2018 14:35:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6BD841121BE5; Thu,  2 Aug 2018 15:35:13 +0100 (BST)
Date:   Thu, 2 Aug 2018 15:35:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        cyrille.pitchen@wedev4u.fr, pp@emlix.com, Zhiqiang.Hou@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] spi: spi-mem: Fix a typo in the documentation of
 struct spi_mem
Message-ID: <20180802143513.GN9117@sirena.org.uk>
References: <1533214434-28761-1-git-send-email-frieder.schrempf@exceet.de>
 <1533214434-28761-2-git-send-email-frieder.schrempf@exceet.de>
 <20180802150945.44cc8328@bbrezillon>
 <8a365fb9-ab9b-b8f1-6dbe-587c6b9b8ad2@exceet.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e8/wErwm0bqugfcz"
Content-Disposition: inline
In-Reply-To: <8a365fb9-ab9b-b8f1-6dbe-587c6b9b8ad2@exceet.de>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e8/wErwm0bqugfcz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 02, 2018 at 03:39:18PM +0200, Frieder Schrempf wrote:

> Mark, can you add it when you apply the patch or should I send a new
> version?

I'd applied before I saw this subthread, Boris is right that it is
better but for something this obvious I'm not sufficiently bothered by
the missing log.

--e8/wErwm0bqugfcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltjFqAACgkQJNaLcl1U
h9Cucwf9Eq5W07YgIQUThfSaDto17fsDHLSKM9QyVkpuSkt21YRWHm9/q+T3Uou3
2+uQNFUu7Or2Zoebzr5CcYcKhxfZYPIbFt+sEaGynkHcGBI5GZTdNbBpboAuakpT
m3mokR3t6Of1TjfjF+i3CmAev1u/mTDoEMMz4hcyRQXRhF53EseX/rqgFUJ4YdwE
IfyV5VNJpzhuogmvN+Pv5WspM+yEg8y7ay6gDfWns0SzCrgkU+H7HjdHerwwzTRP
5psB9f3QVNZb6Zu5r538bsyT65UbJ1ZwnA/UwYz8JOC+c1v1xVRQFtEhpI6WJSVL
sb5PoaH6D64uC3Gt18zYmhMqHHhV/Q==
=vm3O
-----END PGP SIGNATURE-----

--e8/wErwm0bqugfcz--
