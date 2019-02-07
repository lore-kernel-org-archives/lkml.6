Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C32C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4564B2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549548044;
	bh=dtf7KLR1v/GNxKVdL6hwWl0Zptxytb7CclxItOW9Y50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O3M5KZQ380qXgM+2Fci35KcNWc2AX6I52CT+pcQI0avjZbZHnX9Bzay11uXMRQQCE
	 p/anEXLR0RdRyTW6J7ssrFsjHoUoqqvuCBojrJgNSIoKmZ9bKnj0WUD/OvA7WUottP
	 9qYwTOrHT2smtZZGZkXUZ+D4tWD2RL2KpU+nSOEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfBGOAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:00:42 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47274 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfBGOAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6WysUK9ReRUXs6kzcHd/rDMxUSHx3K+UoSnlX42mIqA=; b=j0+pddZZmowAH6f/GUX7BSaQR
        fCkMkQUF4eOeqxxSyZUHQ6cB3bv+U/pOngyMtBNyjJcYe/wgRD7lLocxRzubdODD2SQnxHgHm+3NJ
        2o8a6cpm3JvKq1Rux6Bs+7749nSaodquwvYcsWScgU54UlKKWV+lpz3vA4IRtBDCHVvYI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grkEB-0005qG-SK; Thu, 07 Feb 2019 14:00:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6123E1127EF9; Thu,  7 Feb 2019 14:00:31 +0000 (GMT)
Date:   Thu, 7 Feb 2019 14:00:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: sound: Document jz4740-codec bindings
Message-ID: <20190207140031.GB6190@sirena.org.uk>
References: <20190207133143.5232-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <20190207133143.5232-1-paul@crapouillou.net>
X-Cookie: A day without sunshine is like night.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 07, 2019 at 10:31:38AM -0300, Paul Cercueil wrote:
> Add documentation about how to probe the jz4740-codec driver from
> devicetree.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxcOf4ACgkQJNaLcl1U
h9BCKAf/UxTyiQiKVJAGlJ01QhgnGsVSha+VJSRvllTopSzPMhz1TXqEQHyUnFP7
A849Njc1YCAr5BKPJ3aujPh/I2tOj+z7NGxVmcKwtugwu0M/IqaGFIs9iYKafIoW
aHo0PrySKCCnH6b6tqGXXToVlEy3GxlOzHnpslLDXBB5ifNFPUZvW7qQPjEewTFU
j4kUgB8r6t0bkIXbqm/0LPUG7HTNKsDhbC2MBKHnia2PZYdwPSaakF0NXn1BuKop
YlfP3gDwjk9YPnr6W9HJaIAauh6PrPOk7hv2grZ1slmP5qWXsQIyZQN8WyTbbOr8
RTuqMBveOcEsWoV9gEicNu/jZc3l/Q==
=/Tjd
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
