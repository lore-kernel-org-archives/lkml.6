Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADA2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61FF205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L2mYB7xa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfAQBQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 20:16:35 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:46080 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfAQBQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 20:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=odN7g1p/oJkRe1tPPcceSY70mArV7T1S6+b18qiDKGM=;
        b=L2mYB7xaixK5g7n1HBNuYPcVpIQzwiwXE4AySgBap2leiT0U9m3mbBXlcoxtUl1gkJOBfgCU8J6YzBXiyKqYTDFknh+aSOSkjMDGu1QcyLW11Nz8OJKiAKzv6TAHz9SgfBKXGc7OMnDMESPAc6M3PIP2Hzf+X1i95wlOjLjsozI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gjwI9-00047O-AA; Thu, 17 Jan 2019 02:16:21 +0100
Date:   Thu, 17 Jan 2019 02:16:21 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        "moderated list:ARM/Marvell Dove/MV78xx0/Orion SOC support" 
        <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH net-next 0/3] net: dsa: Split platform data to header file
Message-ID: <20190117011621.GH24870@lunn.ch>
References: <20190115230613.28334-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115230613.28334-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 03:06:10PM -0800, Florian Fainelli wrote:
> Hi all,
> 
> This patch series decouples the DSA platform data structures from
> net/dsa.h which was getting used for all sorts of DSA related
> structures.
> 
> It would probably make sense for this series to go via David's net-next
> tree to avoid conflicts on the ARM part, since we cannot obviously
> include a header that does not yet exist.
> 
> No functional changes intended.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
