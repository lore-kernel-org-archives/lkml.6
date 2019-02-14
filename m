Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EB8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FC1222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="19NrYpPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392263AbfBNNo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:44:27 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:51829 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729619AbfBNNo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=p9+woFNKw9bBFLpBGKvJoKFn8DVfH2uNVw+3EK0qntE=; b=19NrYpPIpGgruXTtMEGbzKWgwO
        fgVVtEmWbnxwiE1vRUdTp7GIK/JfL8Pmspx1PI6ti9gZ3Gbl/fmFztgfWs68LX5iP+o9vdgv0nDaq
        yUEABdCanoH57MeWmdk/Ec0hF0X9wLH35AYPRMjqQLVVwzxQXY/1pLFIl7l/k/wQxg7Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1guHJG-0001k4-Hy; Thu, 14 Feb 2019 14:44:14 +0100
Date:   Thu, 14 Feb 2019 14:44:14 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christophe Roullier <christophe.roullier@st.com>
Cc:     robh@kernel.org, davem@davemloft.net, joabreu@synopsys.com,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, peppe.cavallaro@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH  7/8] ARM: dts: stm32: Add Ethernet support on stm32h7
 SOC and activate it for eval and disco boards
Message-ID: <20190214134414.GB5699@lunn.ch>
References: <1550126763-22669-1-git-send-email-christophe.roullier@st.com>
 <1550126763-22669-8-git-send-email-christophe.roullier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550126763-22669-8-git-send-email-christophe.roullier@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 07:46:02AM +0100, Christophe Roullier wrote:
> +	mdio0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +		phy1: ethernet-phy@1 {
> +			reg = <0>;
> +		};

The reg value should be the same as ethernet-phy@X.

    Andrew
> +	mdio0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +		phy1: ethernet-phy@1 {
> +			reg = <0>;
> +		};

Here as well.

     Andrew
