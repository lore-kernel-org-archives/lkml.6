Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261A2C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC57920852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8O7HP5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC57920852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbeGZAhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731431AbeGZAhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:37:04 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0946720844;
        Wed, 25 Jul 2018 23:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532560988;
        bh=7ZDxPWxcK6ujoznQyAq0PVx6mYqwfMTDXyW3B2XgR8Y=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=i8O7HP5k2BsksWi0r8BOU3LATYq7c113bxzaJRDQWwGQAPSb1VxEBV0HFCKrl0ZHf
         KNuBovgIZc4/JR8ixpSNJqyXY3WbW6X+zd2iShYzIyhYOjr73gQTTRsiO3TQq6cgEy
         wQSrF7Ucc2ioxg0BAccZ1QuDC/Oarx+GnbMxY8R8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1532075856-1723-2-git-send-email-yamada.masahiro@socionext.com>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <1532075856-1723-1-git-send-email-yamada.masahiro@socionext.com>
 <1532075856-1723-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <153256098739.48062.2834824594130786288@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: uniphier: add more USB3 PHY clocks
Date:   Wed, 25 Jul 2018 16:23:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Masahiro Yamada (2018-07-20 01:37:36)
> Add USB3 PHY clocks where missing.  Use fixed-factor clocks for those
> without gating.
> =

> For clarification, prefix clock names with 'ss' or 'hs'.
> =

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to clk-next

