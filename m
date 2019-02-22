Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AB6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D15206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4kRa8yVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfBVVlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:41:45 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:35360 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBVVlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 16:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uGwVWVVp01gUyNU5SZe+ZwFn9VTFAdKVdq7n6xT37HE=; b=4kRa8yVBGwYNzTEAKoJLOHr0Df
        sp+1q3LpynH1hjsz6EyuPn9h1nJAbvptlNYuSHcRgNOKtdWPOfXfR5odZJDkABwzxTWLwxWqK8BdW
        3hnfDCmflovXiyjWDZkY/BVvXdO/bHVv5ac1nh7RzWi/sJcUATCACJKOsw8wo6J6fBuQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gxIZg-0003Xi-MR; Fri, 22 Feb 2019 22:41:40 +0100
Date:   Fri, 22 Feb 2019 22:41:40 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        netdev@vger.kernel.org, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, rafalc@cadence.com,
        piotrs@cadence.com, jank@cadence.com
Subject: Re: [PATCH 2/3] net: ethernet: add c45 PHY support in MDIO
 read/write functions.
Message-ID: <20190222214140.GO5894@lunn.ch>
References: <20190222201242.GA20889@lvlogina.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222201242.GA20889@lvlogina.cadence.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 08:12:42PM +0000, Parshuram Thombare wrote:
> This patch modify MDIO read/write functions to support
> communication with C45 PHY in Cadence ethernet controller driver.

Hi Parshuram

Are all versions of the MDIO controller capable of doing C45?

    Andrew
