Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25017C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B9220834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjkPZW0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B9220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbeLDTjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:39:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbeLDTjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:39:52 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7B2E2081C;
        Tue,  4 Dec 2018 19:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543952392;
        bh=aVdSRiFETmY9eEUpLNHwuSWx+iPFRxgvcxjDPYH0cIs=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=XjkPZW0g/FaiMcRHCdtwCO16Quce6XxcXgrxOkbFCwdNWfuQWFKs0SgHJvi61BwOP
         +D4BYAuTnovpyqqlQxMVPT7k5yXZwQAQ6IDa1x7HhZyvM2qR5nW+EjlLjP8j72lQtH
         yR6FJXndbFLjAiQ703dO4lASfGfjNtSemLpouy0c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <dbbe1896ba62d2421606fb0807740d9e6090a1df.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
Cc:     mturquette@baylibre.com, cw00.choi@samsung.com, krzk@kernel.org,
        b.zolnierkie@samsung.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, pavel@ucw.cz,
        andrew.smirnov@gmail.com, pombredanne@nexb.com,
        sjhuang@iluvatar.ai, akshu.agrawal@amd.com, djkurtz@chromium.org,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <dbbe1896ba62d2421606fb0807740d9e6090a1df.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <154395239140.88331.1595713170039757326@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 02/10] clk: Add kerneldoc to managed of-provider interfaces
Date:   Tue, 04 Dec 2018 11:39:51 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-12-04 03:33:48)
> Document the devm_of_clk_del_provider and the
> devm_of_clk_add_hw_provider functions.
> =

> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Applied to clk-next

