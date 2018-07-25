Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3D3C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4572820846
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yARonrSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4572820846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbeGZAkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731410AbeGZAkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:40:52 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E455F20833;
        Wed, 25 Jul 2018 23:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532561215;
        bh=chL4mSr5T29yhdRYW+sjOn5wGdJerBv8cBwAUoXJl0c=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=yARonrSUJcXxS3JmrcVKsrdJ3+ZvGyBhWiNDgDkBYYB6ufyvpsrgZ4WCNPiNCIsXI
         CM71d4c/sfGt2txNLoS+S6hbSfckyWzW1QTpm2E5jW0eSkfW0Y5dn+B691EtyvHy99
         0MYFrODNjSFGatBnXr8XKOeQX/g522rO4tVgmGYA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, yamada.masahiro@socionext.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1531977828-8276-1-git-send-email-hayashibara.keiji@socionext.com>
Cc:     masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
References: <1531977828-8276-1-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <153256121422.48062.5510017035047863302@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: uniphier: add clock frequency support for SPI
Date:   Wed, 25 Jul 2018 16:26:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Keiji Hayashibara (2018-07-18 22:23:48)
> From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> =

> Add clock control for SPI controller on UniPhier SoCs.
> =

> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Signed-off-by chain is a little weird, but I'll go with it.

Applied to clk-next

