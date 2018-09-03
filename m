Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D83C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAAB2075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xl3/D9nR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EAAB2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeICR40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:56:26 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50754 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbeICR40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=GXHYXyk49vjysLik2B9XGXXaXuKR7d/YxulElcPyCdk=;
        b=Xl3/D9nRMXPWTUHjE2IS+1i9Xx6qKPNocP695cVxQB/pSxZEoBzr3udvYUn+6czm2lWkatW685b5Ob1DcqD3NzGXBv689ccWe33R1rGmk8j6ibipNyZpSqtL4q0AX5kZl5iz9lqvpYIcCyuGPRmpTTflJjW8PZkv3ef1+gvmCkU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fwp1V-0001dr-0Y; Mon, 03 Sep 2018 15:36:09 +0200
Date:   Mon, 3 Sep 2018 15:36:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        f.fainelli@gmail.com, allan.nielsen@microchip.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next v2 6/7] dt-bindings: net: phy: mscc: vsc8531:
 remove compatible from required properties
Message-ID: <20180903133608.GG4445@lunn.ch>
References: <20180903084853.18092-1-quentin.schulz@bootlin.com>
 <20180903084853.18092-6-quentin.schulz@bootlin.com>
 <20180903133020.GE4445@lunn.ch>
 <20180903133358.b2zsdytyjpentnuj@qschulz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903133358.b2zsdytyjpentnuj@qschulz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What do we do? Do I put it in optional properties and refer to the
> aforementioned doc or do I just remove it as it's done in this patch?

Just remove it.

     Andrew
