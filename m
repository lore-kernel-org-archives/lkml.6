Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C396BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9165920855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9165920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeLKQgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:36:23 -0500
Received: from muru.com ([72.249.23.125]:57452 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbeLKQgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:36:22 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E9BAB8027;
        Tue, 11 Dec 2018 16:36:24 +0000 (UTC)
Date:   Tue, 11 Dec 2018 08:36:18 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Felix Brack <fb@ltec.ch>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        bcousson@baylibre.com, mpfj@newflow.co.uk, mark.rutland@arm.com,
        robh+dt@kernel.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: am33xx: Remove unnecessary properties
Message-ID: <20181211163618.GU6707@atomide.com>
References: <20181210132448.7865-1-fb@ltec.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210132448.7865-1-fb@ltec.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Felix Brack <fb@ltec.ch> [181210 05:25]:
> Remove the unnecessary properties #address-cells and #size-cells
> of node pinmux as there are no child-nodes with property reg.

Applying into omap-for-v4.21/dt thanks.

Tony
