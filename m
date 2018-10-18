Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833EBC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9D02148D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Wr/n72mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9D02148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeJSBUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:20:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59772 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeJSBUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5+NihUxxGU5uF5nQiGGyG8RQduKZ1JNkl6xylZY9H7s=; b=Wr/n72monYadc+zvDUxPRKDlV
        C/yGcE+qHya7YK2URffjJZw9bwlNS0Nl0FuABSBZbDwJoC/slS7BaPmJhOex1zgoZBw9RpweNjJ82
        OKp41NXTnbVcv8t09R0PvWAC+4ofKeGzNrP1jfbBBaXY4Xv0mmtK/QDbqhEM21AyA8xIk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDBvx-000708-HF; Thu, 18 Oct 2018 17:18:05 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 066E81122510; Thu, 18 Oct 2018 18:18:05 +0100 (BST)
Date:   Thu, 18 Oct 2018 18:18:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Ben Whitten <ben.whitten@gmail.com>, starnight@g.ncu.edu.tw,
        hasnain.virk@arm.com, netdev@vger.kernel.org,
        liuxuenetmail@gmail.com, shess@hessware.de,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Stefan Rehm <rehm@miromico.ch>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v3 lora-next 1/5] regmap: Add regmap_noinc_write API
Message-ID: <20181018171804.GD25340@sirena.org.uk>
References: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
 <1539361567-3602-2-git-send-email-ben.whitten@lairdtech.com>
 <2908e406-a2e3-29cb-579c-949ddd383e97@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline
In-Reply-To: <2908e406-a2e3-29cb-579c-949ddd383e97@suse.de>
X-Cookie: Pushing 30 is exercise enough.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 06:59:52PM +0200, Andreas F=E4rber wrote:

> Mark, please take this one through your tree - I'll rebase the LoRa
> parts on linux-next then.

I don't have a copy of it, if I didn't apply it already and send a pull
request I probably got confused and thought I'd done that already, sorry
- can someone resend please?

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvIwEwACgkQJNaLcl1U
h9DDuAf+Pt2HLaplxmuFbcp9svmodeVogLA7yzwMi8BIBpYy5W6KBRWmQhofb0b4
Lw7yfyWMCe8CEMnkzSBzuqeLHLOlPMhmOpVzL1d5andcBEYUxda6Aq/+lwZVR0D5
3ZEgqjvoCiQpJieuoiJbMK0aiZFSeUkjths0zuAFWpuscN+oeNlL2dmYjK8tl1gn
8QSCZqKtIryODavgzDodxDESBR70wQ8g7JacIdpdlp8fUXYB5dCUkiQ4WUBRp8Af
RRmGTUjnvI/Hc+HX4QwcqseNZ36Wx+iCDtEYJZ6QJnERnJs1NgDVGTYjTM0XoDjp
9a5DYcrI+eFogbrZ8YjUFo2CwOTr5g==
=o83J
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
