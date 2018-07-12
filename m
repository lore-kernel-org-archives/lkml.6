Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5C4ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE60208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE60208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbeGLWGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:06:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43910 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbeGLWGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:06:16 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 53895208C4; Thu, 12 Jul 2018 23:54:45 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 22D1620876;
        Thu, 12 Jul 2018 23:54:35 +0200 (CEST)
Date:   Thu, 12 Jul 2018 23:54:35 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com,
        Ben Whitten <ben.whitten@lairdtech.com>
Subject: Re: [PATCH v2 4/6] arm: dts: add support for Laird WB50N cpu module
 and DVK
Message-ID: <20180712215435.GL16084@piout.net>
References: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
 <1529070055-18701-4-git-send-email-ben.whitten@lairdtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529070055-18701-4-git-send-email-ben.whitten@lairdtech.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've now applied the whole series after fixing two small whitespace
issues.

On 15/06/2018 14:40:53+0100, Ben Whitten wrote:
> +&usart1_clk {
> +	atmel,clk-output-range = <0 132000000>;
> +};
> +

But this is not actually allowed by the hardware (well, it is but it
will lead to issues) and will be removed once the clock binding is
reworked.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
