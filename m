Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360FAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37FE24FFD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MV9MVKRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37FE24FFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754729AbeFZTht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:37:49 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43722 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751867AbeFZThs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=l4m7si/svWPqpIGfxagVgwxK6nwQ3gq+O8XmLHTd3TM=;
        b=MV9MVKRraTGh3a58MvDWYGUpP4/pX5KS5J9zg9dVnOV6QUWndmX/PQAA1g+WPielc56f3JniU3OMxbD3gExEcy8BiUv3S3TTVAEJcWFAz86DWhDXQwH66T2kMqwA2i4k4Z3kY0tM4N71o0R3sDiAWHyEHHWbmCl+5tC4okxnWMc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fXtmW-0004JJ-PO; Tue, 26 Jun 2018 21:37:40 +0200
Date:   Tue, 26 Jun 2018 21:37:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Brandon Maier <brandon.maier@rockwellcollins.com>
Cc:     netdev@vger.kernel.org, f.fainelli@gmail.com, davem@davemloft.net,
        michal.simek@xilinx.com, clayton.shotwell@rockwellcollins.com,
        kristopher.cory@rockwellcollins.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: phy: xgmiitorgmii: Use correct mdio
 bus
Message-ID: <20180626193740.GD9800@lunn.ch>
References: <20180626175050.71165-1-brandon.maier@rockwellcollins.com>
 <20180626175050.71165-2-brandon.maier@rockwellcollins.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626175050.71165-2-brandon.maier@rockwellcollins.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 12:50:49PM -0500, Brandon Maier wrote:
> The xgmiitorgmii is using the mii_bus of the device it's attached to,
> instead of the bus it was given during probe.
> 
> Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
