Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD80CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E5D218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfBGR3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:29:10 -0500
Received: from muru.com ([72.249.23.125]:37922 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfBGR3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:29:09 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8228B8126;
        Thu,  7 Feb 2019 17:29:18 +0000 (UTC)
Date:   Thu, 7 Feb 2019 09:29:06 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH] arm: dts: gta04: add pinctrl settings for wkup domain
Message-ID: <20190207172906.GE5720@atomide.com>
References: <20190131062338.27547-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131062338.27547-1-andreas@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190130 22:24]:
> There is one button and a notifier for incoming phone
> calls/text messages for which we should wakeup from
> suspend.

Applying into omap-for-v5.1/dt thanks.

Tony
