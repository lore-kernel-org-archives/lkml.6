Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F56C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A5C25987
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="biYl9/6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A5C25987
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755445AbeFYMrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:47:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46314 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbeFYMrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1hI5Kr0I71Bu6Lwm6YLAc4h79V14lHKGBVizzQECwm4=; b=biYl9/6VqSPeikAQHpix3Oqy/
        Gl7DtaKcpmQOupAq1duJXdEPXRAj+l5Q4fwyPUF4lJI3MQDw6OJBAhUI4oJhfBWShw9UoUjfu+5ym
        VXTuiQGzj2yjulC36mOh0UYw4lMbZYWZmarWQLmDUhCORvgRt3uT0hsRMLef1hlXwPS1c=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXQuJ-0007qL-85; Mon, 25 Jun 2018 12:47:47 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXQuI-0007SE-RM; Mon, 25 Jun 2018 13:47:46 +0100
Date:   Mon, 25 Jun 2018 13:47:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-spi@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] spi: sprd: Replace of_hwspin_lock_get_id() with
 of_hwspin_lock_get_id_byname()
Message-ID: <20180625124746.GM9413@sirena.org.uk>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
 <c08a834989a8ffa841c457129d13b7a11361ec51.1529654288.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cGfB/trNgB3WtPHu"
Content-Disposition: inline
In-Reply-To: <c08a834989a8ffa841c457129d13b7a11361ec51.1529654288.git.baolin.wang@linaro.org>
X-Cookie: I'm having a MID-WEEK CRISIS!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cGfB/trNgB3WtPHu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 22, 2018 at 04:09:04PM +0800, Baolin Wang wrote:
> Now the hwlock core has supplied new function to get a specific hwlock id
> by one hwlock name, which is more clear for users. So change to use
> of_hwspin_lock_get_id_byname().

Acked-by: Mark Brown <broonie@kernel.org>

--cGfB/trNgB3WtPHu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsw5HIACgkQJNaLcl1U
h9D32wf/WJzH7SS7t6UorY3hEadoLBgmENS8DYT+wpi5gJpMbC3plZULUD++pNKw
g9wtWOqfkIqvzwLQtpJIlNDtuC53AJOYQqf5+7IhsmJg5S9rI9twV5XoS2fS4eUE
IX7PJTQHg8eWwwnLyqKbLJO2K58s25RAerFZjVsiU9X+DerAc19lXCqV0COhxprr
gbyETR6F1pKf01DPrkh4HXLDSa5ZVrCJWLPbqML1d+5o/P4PQ9Muh7fFp/4cqtG1
zRQR9vdTZ2KDsfw/uSz6KEb+SYHxDbXVwBqMc4xxY82rAchfitpH9Degep26GnWg
OpaRcuwJEUPg//UNzFKQhSpsJugOsg==
=Xdrq
-----END PGP SIGNATURE-----

--cGfB/trNgB3WtPHu--
