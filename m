Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D270CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DDF20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551117386;
	bh=P9OH65kV8U3IhSjFKR9DjUxyW4MBJie/K+8gruf3Lfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rT2MyGifUjmOzU67VoXWMjCxmcn8fogcan+cB1gwMrjV69/40NRybY8V9A300dcSC
	 6FbcU0w+5KP5kMH14N6WvPjvRdZ6qUfGiu1fnS7mJg18erNgpwr/onbS6Ax3m4Loe6
	 96nz4ITb/xN0wSlhRMI0FR7a/amQdBiWD97oF67Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfBYR4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:56:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfBYR4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:56:24 -0500
Received: from localhost (unknown [122.167.64.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB37720645;
        Mon, 25 Feb 2019 17:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551117384;
        bh=P9OH65kV8U3IhSjFKR9DjUxyW4MBJie/K+8gruf3Lfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPZ6iKDmZ+Pi7mGaJcyoYiABOyumkPMGwfjewebMCu1KiVJ1TmQIxCQpudxqAhC3z
         B74CkfUbbvLj69PQgZ7gXxxqiN6aAvhDB0FJMwq/j/+vktj4bN2Uncxck0LyWQgAd8
         sjZGJJIC2i/BksOMba0xCtfKB/ITzScaqPEdF440=
Date:   Mon, 25 Feb 2019 23:26:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, dmaengine@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v6 0/3] dmaengine: imx-sdma: add the sdma engine to the
 imx8mq
Message-ID: <20190225175618.GL31146@vkoul-mobl>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190128160323.28170-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128160323.28170-1-angus@akkea.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-01-19, 09:03, Angus Ainslie (Purism) wrote:
> Add sdma support for the imx8mq
> 
> Changes since V5
> 
> Dropped device tree bindings.
> Added reviewed by tags.

Applied, thanks

-- 
~Vinod
