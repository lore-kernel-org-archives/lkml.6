Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545C4C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F5D214D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="HB2OHuNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F5D214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeJIWdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:33:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45204 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIWdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n4+oGBHSsuFEYcEMPKD2u7djK83UxxOwivAa4Dqescc=; b=HB2OHuNhYEZuqcJDtuCmeWhxY
        nVh5PIzyYoj6BW5mDNdJOiJuBHwvnkwblZYElRYcp4lfwpTveXwTXc9WDKAit854nzu/9COqUlPU6
        eJlEezZf3EsIdi7nEubA0RHCPp4CEq9zcz4P/tjeHcKbYZwn+HRfGH8p1vFw+N2RbQptI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g9tjS-0005sk-Fj; Tue, 09 Oct 2018 15:15:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AAEE9112234B; Tue,  9 Oct 2018 16:15:33 +0100 (BST)
Date:   Tue, 9 Oct 2018 16:15:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Silesh C V <svellattu@mvista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 1/2] Driver core: add bus_find_device_by_fwnode
Message-ID: <20181009151533.GC20774@sirena.org.uk>
References: <1539080245-25818-1-git-send-email-svellattu@mvista.com>
 <20181009110210.i6xphyuy5jkcfaug@katana>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline
In-Reply-To: <20181009110210.i6xphyuy5jkcfaug@katana>
X-Cookie: Ego sum ens omnipotens.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 09, 2018 at 01:02:10PM +0200, Wolfram Sang wrote:

> We recently had this discussion in I2C world about using the parent if
> the (logical) device has a NULL fw_node [1]. I don't know if the other
> subsystems you modify use logical devices as well? If no, it seems we
> need an additional check for the parent in the I2C core only. If yes,
> this might be considered in your patchset?

SPI has a logical controller device as well.

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu8xhQACgkQJNaLcl1U
h9AH2gf8C9kz4kG030ID6648vQo9YUHUoHqyzVjXg2u/cPM6H4/AVpiOaeJqSMij
Pl2KZbqPFisjnybJq3lPJaDx3f53TRfGL8/P5Q2AjVPvWMXWDO98JuQ0AA2MhHl2
i7FcqD3mn8QkQu5wbJZOrYj//rnaWXcrVWyDotQXWSKwzHaZp6tBHdfVoUMWgo6w
c45J4E19sRqtAlqFq2/GAR6Mo8Q0nRM410agaluau0zmBIZeTbL1SEDZO0DoVM2p
XgspSOm1lWaSBoRA9wc/+gVG5V/g+5IdLqm+UmOdWasBd4loPAr6Bl9f/CNrlVig
BBjsiPDh9yO9eGKeBQ/CMU7nXOlYqQ==
=Jk+F
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--
