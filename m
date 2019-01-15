Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E694C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C06820657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="XNfJYO+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfAOBYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:24:39 -0500
Received: from onstation.org ([52.200.56.107]:47570 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbfAOBYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:24:38 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id CA47214D;
        Tue, 15 Jan 2019 01:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547515478;
        bh=mGEX2dCJEKr5qMDkCk7d067aSB34qAvk+IEb0QaXLFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XNfJYO+wibBz/uaLmJG6gJTFlAZC0+waej0R/W1xT3IbSewtPZD51/u3ZxE3pwZA3
         ffEBEHQBobNR6ZCu+dYJvlNSlMbmo6YJqRbaVoxl0mN7dFfSjViCTvdfeu30HyPqhT
         /YxMm4ML/HsWDHgUccr5tvXV91BYHaysrSbz+GiY=
Date:   Mon, 14 Jan 2019 20:24:37 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 03/14] pinctrl: qcom: spmi-gpio: hardcode IRQ counts
Message-ID: <20190115012437.GA8505@basecamp>
References: <20190113154716.5145-1-masneyb@onstation.org>
 <20190113154716.5145-4-masneyb@onstation.org>
 <20190115003428.GJ9278@minitux>
 <20190115011432.GA7900@basecamp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115011432.GA7900@basecamp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 08:14:32PM -0500, Brian Masney wrote:
> I'll also convert SSBI based on this series.

... as a separate patch series. No need for this one to get bigger.

Brian
