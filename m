Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44F2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615C622BD3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAKSNJ4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615C622BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934375AbeGFU5O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933982AbeGFU5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:57:12 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 952B222AE3;
        Fri,  6 Jul 2018 20:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530910631;
        bh=sIR1iIOJQYcMwQO/PrG2R/B8oMcyPgeLtcKZeTR9IcY=;
        h=From:To:References:In-Reply-To:Subject:Date:From;
        b=iAKSNJ4i1J49b7vuTpOXAhMcKKpPPCZEeXDtX3tuyyGfPYRtnoy2qlOm6xo9V0YVP
         9QBvE+c18AcQfYyPW8ZgWK5Lz1Ig1rzcoPa+O0ZWrWN/cV0xXf6Dc1pecJBncfOKA/
         OihYAwTFkJSPfpGf1ahIx7x6At9PXSswBTow822Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
To:     Andrew Jeffery <andrew@aj.id.au>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>, Lei YU <mine260309@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1529978125-28712-1-git-send-email-mine260309@gmail.com>
In-Reply-To: <1529978125-28712-1-git-send-email-mine260309@gmail.com>
Message-ID: <153091063090.143105.8837363425750284918@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH] clk: aspeed: Fix SDCLK name
Date:   Fri, 06 Jul 2018 13:57:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lei YU (2018-06-25 18:55:25)
> The SDCLK was named SDCLKCLK, and no one has used this yet.
> Fix it.
> =

> Signed-off-by: Lei YU <mine260309@gmail.com>
> ---

Applied to clk-next

