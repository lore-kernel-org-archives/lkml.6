Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7CBC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D728920892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="FvSqmL0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D728920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeKHVf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:35:59 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36586 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeKHVf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oDB5ESdlEd1AUvYQZ6+MrH0HDe6+2XvpP/jdcsk7x4Q=; b=FvSqmL0h2wKzGruU/c/+1b0I0
        iMBpO/Dlr5lrdGChwOzqlRxy+Obnx/1uylEb81R9jWtrotrUiTmeMZTRij5BJy2Q7+pnzWJSvH4b7
        48Uzt6U+q3SGdaqQkA+f1Y/EIq1WNNsD5Wj3UF2cCyz0Bk3UlNLgx45B9MdzFi3BFpSoE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKiyw-0008HB-Ap; Thu, 08 Nov 2018 12:00:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 021901124E16; Thu,  8 Nov 2018 12:00:17 +0000 (GMT)
Date:   Thu, 8 Nov 2018 12:00:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Olof Johansson <olof@lixom.net>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>, rmk@armlinux.org.uk,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [TECH TOPIC] SoC maintainer group
Message-ID: <20181108120017.GB6675@sirena.org.uk>
References: <CAOesGMgVPsK9YsV2nGoBptWwtHYv=3yMytLx2_tF_ujS5c5p3Q@mail.gmail.com>
 <20181107171723.GI9919@thunk.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20181107171723.GI9919@thunk.org>
X-Cookie: I'm having a BIG BANG THEORY!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 07, 2018 at 12:17:23PM -0500, Theodore Y. Ts'o wrote:

> Could the poeple listed on this list please list potential schedule conflicts?

> I'm going to assume we should avoid: Andriod uConf, RISC-V uConf,
> Device Tree uConf.  What are other potential conflicts.  I'm going to
> guess this might be "interesting" to schedule.  :-)

The clang BoFs, RT and testing would be bad for me.  Possibly some other
stuff but I've not seen the schedule yet.

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvkJVEACgkQJNaLcl1U
h9Adywf9GyoY0UZYREXkaC5CCJhw3ZhxhUYk8hx1KGUeuzSfvnhzAzEcVY2UkXcT
yxDZsQSeI0DsyvHM2pyRcGGSXaTIweK/zRUzoBpEUACs9fUTy7HfI6KoW89JYXhk
kv6mF7BxxTsKzq7eLp0L6LxPTUw6CIwlc3LkFFf/wJet4OAL0P4hItTdA2Hm/pu8
W2Zqd/DyEAORzJzz4WYfo8gtMXKwi50KWW4Z0gHDLViYghJLOYKDKBNpQEEEwfF4
qrMle5CebGGbNFbutCsET0cD60CSitfr7RSWYwaujy8cQugLeS9gK1RvWsgvw7wi
SM4lSkB5qoanBUZb2uFQbXQcKFTQMQ==
=VxM9
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
