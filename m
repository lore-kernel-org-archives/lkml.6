Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CCEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D372075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D372075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeICSkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:40:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38060 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbeICSkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:40:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A1E17208A1; Mon,  3 Sep 2018 16:19:53 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7191D20799;
        Mon,  3 Sep 2018 16:19:53 +0200 (CEST)
Date:   Mon, 3 Sep 2018 16:19:52 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM: dts: at91: nattis/tse850: drop 3 indentation
 levels
Message-ID: <20180903141952.GD13888@piout.net>
References: <20180831204403.14653-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831204403.14653-1-peda@axentia.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2018 22:44:01+0200, Peter Rosin wrote:
> Hi!
> 
> I just noticed that the pinctrl and watchdog nodes in sama5d3.dtsi have
> gained labels, something which I have had a plan to add myself at some
> point. But now that they are here, I just have to make use of them...
> 
> Cheers,
> Peter
> 
> Peter Rosin (2):
>   ARM: dts: at91: nattis: drop three indentation levels
>   ARM: dts: at91: tse850: drop three indentation levels
> 

Both applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
