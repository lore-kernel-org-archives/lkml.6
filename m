Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B589C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82D320842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4hwvT75M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82D320842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389711AbeG0WdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:33:01 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48974 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389211AbeG0WdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=GNhBJgR9pMVqO0HzSLV6yH50z5JIMoWr04yLn/RmciA=;
        b=4hwvT75MdsUSs1tIm7xBNvgV5r8OBQKlB7+DXmnjr/JJu9VseeQyl9n+s/b51OVSa9JCC1AR4q3cBkW3jpqAOqQy9oqOvn98sXHvz0dyNT37yYgIfxqVWiM1L60R8JU1cMXYlM1B2LiYcrQrmpJzsOXZMqPusnaYXHjIR38bZI8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fj9z8-0005It-Kd; Fri, 27 Jul 2018 23:09:14 +0200
Date:   Fri, 27 Jul 2018 23:09:14 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc:     grygorii.strashko@ti.com, davem@davemloft.net, joe@perches.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net: ethernet: ti: cpsw: replace
 unnecessarily macroses on functions
Message-ID: <20180727210914.GB19398@lunn.ch>
References: <20180727204958.23658-1-ivan.khoronzhuk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727204958.23658-1-ivan.khoronzhuk@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 11:49:58PM +0300, Ivan Khoronzhuk wrote:
> Replace ugly macroses on functions.
> 
> v2..v1:
>  - removed inline for cpsw_src_port_detect()

Hi Ivan

Comments like this should be placed under the ---. Otherwise the
appear in the commit message.

	 Andrew
