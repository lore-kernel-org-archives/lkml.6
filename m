Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AE8C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C55320851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544723611;
	bh=LvikiDeBaWvubPYYgWVhf0GhkbifHO3G7yJmINbgB2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AoAXwTYfpMO1+0h7TjFht265tsQNLw/jehk+KWtrTCyWF12V6qpG72tCTpRN8Hsbk
	 /jV0Jbfp+Zs108oAtnIcsJMMESrJJpcBQuwxAPiU2VJR9lDBz5gpodLI82nDwjJoRl
	 9JkLRthpmvEreYFuII+N8cEsTdQh0LSc7jfK+TG4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C55320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbeLMRx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:53:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35126 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbeLMRx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xD9A1dvLlUF98KCbGxjL/GKwM5mY2szgN2hWP6B3sbE=; b=FLGv5Qj0TH2sBvD0WVIml55nL
        rxGM68gvYSSzAAzw48YvZFvvUEYMB0bNzoxq4m/YlTMUiawtHA5oSpm0AmWZ3SmDfoSmda0CvX8BU
        Kf7xbaxIMXuNkh8to07zrn4Sw/hGfXmebhx1glRxmmSWtv8i/ftBVQ6mMg0UKpHBOZD0w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXVAt-0002Ne-IQ; Thu, 13 Dec 2018 17:53:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 08CE411254D1; Thu, 13 Dec 2018 17:53:26 +0000 (GMT)
Date:   Thu, 13 Dec 2018 17:53:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     zoro <long17.cool@163.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator/of_get_regulator: add child path to find the
 regulator supplier
Message-ID: <20181213175325.GV10669@sirena.org.uk>
References: <1541655635-11574-1-git-send-email-long17.cool@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FZIkiClxIZ9JeWSb"
Content-Disposition: inline
In-Reply-To: <1541655635-11574-1-git-send-email-long17.cool@163.com>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FZIkiClxIZ9JeWSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 08, 2018 at 01:40:35PM +0800, zoro wrote:

>             ldo0_vir: ldo0-virtual {

>             ldo1_vir: ldo1-virtual {
>                 regulator-compatible = "VIR_LDO1";
>                 regulator-name= "VIR_LDO1";
>                 regulator-min-microvolt = <1000000>;
>                 regulator-max-microvolt = <3000000>;
>                 ldo1-supply = <&ldo0_vir>;

> when the VIR_LDO1 regulator supplier is it's brother,
> we can't find the supplier.
> so we add the child ptah to find the suppier.

The supplies for the chip (even if they happen to be supplies for a
regulator on the chip) are supposed to be defined at the chip level so
your ldo1-supply property ought to be at the top level for the chip, not
in the individual regulator node.  This keeps the regulator supplies
consistent with other supplies and is especially useful if a single
physical input is used by multiple things.  As far as I can tell the
issue isn't the fact that the parent regulator is defined as part of the
same chip, it's where the supply property that LDO1 is looking up has
been placed in the DT.

Sorry for the delayed response here, I had some travel and it took a
while to figure out what was going on with this change.

--FZIkiClxIZ9JeWSb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSnJUACgkQJNaLcl1U
h9C0LQf8D8DptGv2uBwsRvA31+m77qaWQ2EB9W8eKyvCJ0QJegfaPbdAV2/xMhBp
83aVM2dVLGExNE1USKtdzNXW3VNng+njKE2jxbMwhKVsxDH5mml97Lf+1BewMhI5
b4UMo3cfiY+F8IwpcPZLKEUPF786zncqCPMXVM6dZAmKGZzjFZPIYN6/0CaofZHF
44wgRFIU3nybPsAP/wTJJ0e3amAn7ebIKce3Wbtz1nw0ZDQibXD5JfE3RC6wDSda
sahyGV8sDkl+eTkEY+RRjhKZreQ/zdUCUhEpyjnQb7jfVmYci3yPHbzdcPDHeQcC
k2JKDJXmgBpoHuSljwyYxOPnqCynVA==
=tIqL
-----END PGP SIGNATURE-----

--FZIkiClxIZ9JeWSb--
