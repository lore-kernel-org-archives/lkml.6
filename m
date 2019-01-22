Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A83FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2642321726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfAVW7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:59:42 -0500
Received: from muru.com ([72.249.23.125]:34782 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfAVW7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:59:42 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 084B280F6;
        Tue, 22 Jan 2019 22:59:48 +0000 (UTC)
Date:   Tue, 22 Jan 2019 14:59:38 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Heiko Schocher <hs@denx.de>
Cc:     devicetree@vger.kernel.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/2] ARM: dts: am335x-shc.dts: fix wrong cd pin level
Message-ID: <20190122225938.GB5720@atomide.com>
References: <20190122052623.1779840-1-hs@denx.de>
 <20190122052623.1779840-3-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122052623.1779840-3-hs@denx.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Heiko Schocher <hs@denx.de> [190121 21:27]:
> cd pin on mmc1 is GPIO_ACTIVE_LOW not GPIO_ACTIVE_HIGH

Thanks applying into omap-for-v5.0/fixes.

Tony
