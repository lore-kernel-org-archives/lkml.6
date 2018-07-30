Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3971F13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F8020881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RXy/8zdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F8020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbeG3PjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:39:09 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50463 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbeG3PjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=npDLfcFGj2Ft0amt9BvIZMy3hjPQgdKRx/nZx3N0oGY=;
        b=RXy/8zdn248Q9bQ4HRKe+shZkWFjnOxiajPe6nRYm9uyzysEKF1wwBwaa/8eawJd7JBxaHnfjbsH7LYlWDb3VcVUYnWLPsG+G3L6s6tL9gaJsAHXU/sL6j+yrHq+MhA87NnZXW8yuB0RP1MnqQSkhE79TtYG/XQgv9FletmBR6A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fk8mD-0008PF-Dp; Mon, 30 Jul 2018 16:03:57 +0200
Date:   Mon, 30 Jul 2018 16:03:57 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Onnasch, Alexander (EXT)" <Alexander.Onnasch@landisgyr.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/phy: Micrel KSZ8061 PHY link failure after cable
 connect
Message-ID: <20180730140357.GJ13198@lunn.ch>
References: <1528272198-10825-1-git-send-email-alexander.onnasch@landisgyr.com>
 <20180606123947.GB14898@lunn.ch>
 <AM6PR01MB4262F8BB6004D246DFF5C3FEF0700@AM6PR01MB4262.eurprd01.prod.exchangelabs.com>
 <20180619152858.GD26796@lunn.ch>
 <AM6PR01MB4262FB2EBD4AFBC05C02F9B6F02F0@AM6PR01MB4262.eurprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR01MB4262FB2EBD4AFBC05C02F9B6F02F0@AM6PR01MB4262.eurprd01.prod.exchangelabs.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 02:00:44PM +0000, Onnasch, Alexander (EXT) wrote:
> Hi Andrew
> 
> thanks for your feedback. I was on holiday, thus just delayed, not forgotten...
> Sorry for top-posting - odd company default mail setup.

But you did it again....

Your email client should not be forcing you to top post. So please
don't.

	Andrew
