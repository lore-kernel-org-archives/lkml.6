Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C7AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCB820652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Vbj/SKSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCB820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeICRuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:50:37 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50728 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbeICRuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=GpokNiW6b+S5n4ipdL2jr7hhvZY1DPbYljnfPld9NHA=;
        b=Vbj/SKSleqkikrh1s9F5o7e/Re16dGPhiTLD7F8rXXiPSKWIOGtwZnY1NwAHaWQh1+FSt2yo0ycnbE7Q1Upeb122W8eFm4mwiiPNO+DdArkeN/PQ8bRY6suB7sq2Bhl9yMyyR8B+AKAm0SMcZyVDlJzeHSCVRpLSmyI5IqJRclM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fwovs-0001Wg-7q; Mon, 03 Sep 2018 15:30:20 +0200
Date:   Mon, 3 Sep 2018 15:30:20 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        f.fainelli@gmail.com, allan.nielsen@microchip.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next v2 6/7] dt-bindings: net: phy: mscc: vsc8531:
 remove compatible from required properties
Message-ID: <20180903133020.GE4445@lunn.ch>
References: <20180903084853.18092-1-quentin.schulz@bootlin.com>
 <20180903084853.18092-6-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903084853.18092-6-quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 10:48:52AM +0200, Quentin Schulz wrote:
> Compatible isn't a required property for PHYs so let's remove it from
> the binding DT of the VSC8531 PHYs.

Hi Quentin

It is actually a optional property. So you could move it into that
section of the binding documentation. But removing it is also O.K.

	Andrew
