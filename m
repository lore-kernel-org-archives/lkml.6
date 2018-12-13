Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A11C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D585204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544715110;
	bh=aMi9RppRMGrt48yb6riDizpSKO27weat1ADl7FM93Gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rOshp1by1bEppgZFY1q/dwxKElowrabHzHXsAceWghwxPQpwIR9+D7n9+GiyPFjVX
	 qhgmTu2LJa394+7q0mEbB3bYy7QZOD0s/plAY+GPYSTX7LTV9BBykroTL+6x6+7h8O
	 PUPiN9kEg7rvq5oVnMzv/7w5/iElfxZashLr88a4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D585204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbeLMPbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:31:49 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51618 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeLMPbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aMi9RppRMGrt48yb6riDizpSKO27weat1ADl7FM93Gs=; b=woOE716yUQmMCt6N90z08oOKL
        xDAEpl8UY2G2tGmJdpHJgE09ZQJJXT2zBJX9ErFDny7Kg324txItCFSH3ojQ5gMLPLS3Z7xLO/zXw
        rMdGdrL2o4vA3VAGaKaegTY7T2QNsZo1CHAAZC6DibkoAz0SL8mlTwyTPgMYW4+mlIsbw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXSxT-0001hf-Lp; Thu, 13 Dec 2018 15:31:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4F4FE11254D1; Thu, 13 Dec 2018 15:31:27 +0000 (GMT)
Date:   Thu, 13 Dec 2018 15:31:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vishal Sagar <vsagar@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] ASoC: xlnx: Add i2s driver
Message-ID: <20181213153127.GN10669@sirena.org.uk>
References: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <1544207558-72508-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o+ZCuNqY+dEAKBWl"
Content-Disposition: inline
In-Reply-To: <1544207558-72508-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o+ZCuNqY+dEAKBWl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 08, 2018 at 12:02:37AM +0530, Maruthi Srinivas Bayyavarapu wrote:

> @@ -0,0 +1,185 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx ASoC I2S audio support
> + *

This looks otherwise good so I've applied it but please send a followup
patch converting the entire comment block to C++ style so this looks
more consistent.

--o+ZCuNqY+dEAKBWl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSe04ACgkQJNaLcl1U
h9AApQf/ZYZreo/i4fqhX4ZisqCS87wTmjedquBnDbFr4A908f5mKat+VrZEor9g
qfdXB6YMTRb1BPFQrFqv93f/OxjbZeM7Gztv8B7n7shGQ9Oh1Xg0pPLYSsvZLZEm
ZTt2TwTyXgm2A0xiiLbTuXlin/tilgBcNUK2GvMPaD0vEftBJJplV+WkxTe71U4F
T5Umnu41+7kcm0EGdNyIu2q1/NZAVkvvyZGKeJtRIHNdT6XKbczxHsN/tDp8Xalv
LqTlJiSNDOsG+G5zKuTZc3Ae1M8sx3NNWs3Tybe0dyC3tbuGiny6pNkkOYNs2OoV
rxwnrk5IqefawbCi6uDMdfNRXwMvxQ==
=36PQ
-----END PGP SIGNATURE-----

--o+ZCuNqY+dEAKBWl--
