Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7935ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5310920852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5310920852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbeGXPo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:44:28 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:46000 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388495AbeGXPo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:44:28 -0400
Received: from ravnborg.org (unknown [158.248.196.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 33E81802CD;
        Tue, 24 Jul 2018 16:37:38 +0200 (CEST)
Date:   Tue, 24 Jul 2018 16:37:36 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Hanna Hawa <hannah@marvell.com>
Subject: Re: [PATCH 1/2] sparc: move MSI related definitions to where they
 are used
Message-ID: <20180724143736.GA22088@ravnborg.org>
References: <20180724115305.11289-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724115305.11289-1-thomas.petazzoni@bootlin.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=i0zq2te3G3bxFR0hK4QA:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas.

One nitpick below.
But other than that this is a nice cleanup:
Acked-by: Sam Ravnborg <sam@ravnborg.org>
> +/*
> + * Locations of MSI Registers.
> + */

The SPARC way to format comments follows netdev style.
So put it all in one line and everyone are happy:

    /* Locations of MSI Registers. */

> +#define MSI_MBUS_ARBEN	0xe0001008	/* MBus Arbiter Enable register */
> +
> +/*
> + * Useful bits in the MSI Registers.
> + */
Likewise

	Sam
