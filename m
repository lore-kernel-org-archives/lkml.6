Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD4BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3245A2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tY1Tfumj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfBTOqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:46:22 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:59789 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfBTOqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FBSGO7mNl/Pi41kqMJI6nQsXA6eeq25iro3uZA1HouE=; b=tY1TfumjBTSrc3bM+BDdF7d+IY
        fuvGf4liP/fROP/9hDXIbhiNxkBE4CabUyFtX+OBCME2JJnqky/TZt9eZow5NbeFS8cRKbTFjo8q4
        ah6/cafI1yhSF5Q2mxQNbOt0rgaP7bV3qRAZo+dn04N0ujmB35SJkjWFGvGeauNEu+jw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gwT8Y-0006a8-Tr; Wed, 20 Feb 2019 15:46:14 +0100
Date:   Wed, 20 Feb 2019 15:46:14 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Himadri Pandya <himadri18.07@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, julia.lawall@lip6.fr,
        f.fainelli@gmail.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: add missing of_node_put
Message-ID: <20190220144614.GG13075@lunn.ch>
References: <20190220032432.2878-1-himadri18.07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220032432.2878-1-himadri18.07@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 08:54:32AM +0530, Himadri Pandya wrote:
> Decrement the reference count on port while returning out of the loop.
> 
> Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>

Hi Himadri

Thanks for the patch. The code changes themselves look good.

Netdev has a few additional processes for submitting patches. Please
take a look at

https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt

Please base this patch on net-next.

Thanks
	Andrew
