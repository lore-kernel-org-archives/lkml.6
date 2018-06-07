Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AEebHqzgGFvlCwAAmS7hNA
	; Thu, 07 Jun 2018 07:57:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 99B86608BA; Thu,  7 Jun 2018 07:57:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 019A6605A2;
	Thu,  7 Jun 2018 07:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 019A6605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932344AbeFGH5I (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:57:08 -0400
Received: from gloria.sntech.de ([95.129.55.99]:33880 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752963AbeFGH5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:57:05 -0400
Received: from ip9234ae78.dynamic.kabel-deutschland.de ([146.52.174.120] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.1:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1fQpn1-0002rm-1X; Thu, 07 Jun 2018 09:56:59 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v1 2/4] clk: rockchip: add dt-binding header for px30
Date: Thu, 07 Jun 2018 09:56:58 +0200
Message-ID: <2233320.o0OUWNYjTa@diego>
In-Reply-To: <1528340786-462-3-git-send-email-zhangqing@rock-chips.com>
References: <1528340786-462-1-git-send-email-zhangqing@rock-chips.com> <1528340786-462-3-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 7. Juni 2018, 05:06:24 CEST schrieb Elaine Zhang:
> Add the dt-bindings header for the px30, that gets shared between
> the clock controller and the clock references in the dts.
> Add softreset ID for px30.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  include/dt-bindings/clock/px30-cru.h | 402
> +++++++++++++++++++++++++++++++++++ 1 file changed, 402 insertions(+)
>  create mode 100644 include/dt-bindings/clock/px30-cru.h
> 
> diff --git a/include/dt-bindings/clock/px30-cru.h
> b/include/dt-bindings/clock/px30-cru.h new file mode 100644
> index 000000000000..db9fc2a0bb21
> --- /dev/null
> +++ b/include/dt-bindings/clock/px30-cru.h
> @@ -0,0 +1,402 @@
> +/*
> + * Copyright (c) 2017 Rockchip Electronics Co. Ltd.
> + * Author: Elaine <zhangqing@rock-chips.com>

				^^ full name maybe?

Otherwise looks good.


Heiko
