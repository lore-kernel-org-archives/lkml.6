Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC57C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5963D208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/VdPNpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5963D208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934327AbeGFUf6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932884AbeGFUf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:35:56 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 818E8208C4;
        Fri,  6 Jul 2018 20:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530909355;
        bh=B612UFIjjGiAM1kZ8NW7tPtSU//mezZBUhIPV0wTIvM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=I/VdPNpa+Z7WDmfgo/B/xqWKATYOy3n8+ScfJ4Si2Hauumri5FgLmAhh9CJyKCZlk
         eoQeGsjg2n2WBRk3bMzkL9Zte6NNw+hJK9c0M5tP0lV0nK15pJ3cIgBDZTv3daiPEj
         c8Z3JIy0Rae7WQBu2KTJKfJDpiPTMq15wdHCb/jw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180627121459.13987-2-paul@crapouillou.net>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
References: <20180627121459.13987-1-paul@crapouillou.net>
 <20180627121459.13987-2-paul@crapouillou.net>
Message-ID: <153090935492.143105.6442521447151039533@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: ingenic: Add missing flag for UDC clock
Date:   Fri, 06 Jul 2018 13:35:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2018-06-27 05:14:59)
> The UDC clock of the JZ4740 SoC can be gated, but the data structure
> representing it was missing the CGU_CLK_GATE flag to make it work.
> =

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next

