Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C3B13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CF320873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xEIyIE6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CF320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeG3P2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:28:20 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50440 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbeG3P2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=I4VdOCFAoDSskqCpAg3eyvGeqr/xQm9fp+4aQuYdJrk=;
        b=xEIyIE6s7gZo/sOcL2K8g6levO56+yDlbjIWnYPyN8X9301eIxaSJJnRdpIHkJcC6weECcJ2eW73yopsVknfIpi580KZfdeqkyJrQmath30xmETv59W4MTbOg3WtFKmU6ZVeSYGSRh5JSWBicj7sluwRXA9wX3y5apvgR1EJqxU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fk8bm-0008GT-8W; Mon, 30 Jul 2018 15:53:10 +0200
Date:   Mon, 30 Jul 2018 15:53:10 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     f.fainelli@gmail.com, davem@davemloft.net, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 2/4] dt-bindings: net: phy: mscc: vsc8531: remove
 compatible from required properties
Message-ID: <20180730135310.GG13198@lunn.ch>
References: <20180730130236.3837-1-quentin.schulz@bootlin.com>
 <20180730130236.3837-2-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730130236.3837-2-quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 03:02:34PM +0200, Quentin Schulz wrote:
> Compatible isn't a required property for PHYs so let's remove it from
> the binding DT of the VSC8531 PHYs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
