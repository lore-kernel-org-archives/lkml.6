Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A817DC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7DE206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="T/ESIGIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7DE206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbeKUDL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:11:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53356 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeKUDL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/FjMyZBlC6lGvHBchv3PEKPdgJ53E4xl5f+oIkRsN/Y=; b=T/ESIGIr+OsfRDc9sOBC263Yn
        nYISLXPT8EinHq076AtGz+cWE9RQ5Y7nBzUK21Sdl4nGBwn+5k3osG31LAgyJAZNY9mEDQ5oQGu16
        h3iKrf/fiAygnr0VqOGz9mR64dBqgLPXxL8rjUTOOAD9y+jhagcut7MRgwmeOjIpcK6mQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP95Z-0001nm-Vg; Tue, 20 Nov 2018 16:41:26 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8B56B1124DC2; Tue, 20 Nov 2018 16:41:25 +0000 (GMT)
Date:   Tue, 20 Nov 2018 16:41:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: Applied "regulator: core: add enable_count for consumers to
 debug fs" to the regulator tree
Message-ID: <20181120164125.GK3894@sirena.org.uk>
References: <20181120162808.B73391124DC2@debutante.sirena.org.uk>
 <CAD=FV=W==50GsF+R3_qGbqDH2VF8VKXv3Y6Co90d2GdUbhn69g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pN9MePJoZbRKbUk1"
Content-Disposition: inline
In-Reply-To: <CAD=FV=W==50GsF+R3_qGbqDH2VF8VKXv3Y6Co90d2GdUbhn69g@mail.gmail.com>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pN9MePJoZbRKbUk1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2018 at 08:37:04AM -0800, Doug Anderson wrote:

> Hold up!  How does this compile for you?  It looks as if you landed it
> before ("regulator: core: Only count load for enabled consumers")
> which is the patch that adds "enable_count" to the consumer structure.

> I'm just working on my replies to you about the dependencies on these
> patches but they're definitely not separate...

Dunno, but my script for applying things does a build after each patch
and didn't complain so...  are you sure it's not e-mails getting
reordered?

--pN9MePJoZbRKbUk1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv0OTQACgkQJNaLcl1U
h9AbLAf/SiSjqaluN4JDkketkffMT/ZWnKnoJ9fZdm5lpwlgEDBElHhCDQJPGv80
i6HFi4HR6CsPp1PMEl6U5Y6mkGOyGR68f75ChUE8O45SivKNqve7wM9pKBOe0tBt
sCAtTFewsTrMkRQuzPik64Yv0s38pidJZLN2UrI7JtYI7FUC5c3hwi+Fol0EyQFj
G2JCauHoS8GZD0HKAiktfrmxtT2NSXSHfnM8RBpkGQ9EMZTvZKqnzIOS7YcD21gB
chqkU1Rt17rB0SxEolSODDNfdgO0tYc1+JFZFQ+msaubxLrrgl32lNZDM+u7dh/N
eRTbtEhpkNQp7vvlSIN39G/8/Ip2AQ==
=3KFQ
-----END PGP SIGNATURE-----

--pN9MePJoZbRKbUk1--
