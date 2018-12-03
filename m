Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF80FC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A517A2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="teigWV4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A517A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLCTcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:32:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbeLCTcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:32:07 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB7B22146D;
        Mon,  3 Dec 2018 19:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543865520;
        bh=0AQWOrgWs0UkcEQM1R0AhlyvlXevSM7AopcRRBmEYGw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=teigWV4Eqa/FEdeD+DoA7/V05wWPwpzlxBf1Tbg+sHgLe8S+TV5NEcVrNzxBO9g6G
         JpmO3MmC4F/08os084rR/SA0hbw/2HJ89q63QXoayPL/K62482vEivhHJXa+qh9TAv
         cK6mT8yULgCDae5NAv4dr8evhDu+Ak6c/tghNZ0s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542200198-3017-7-git-send-email-aisheng.dong@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@codeaurora.org>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
 <1542200198-3017-7-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154386552031.88331.16363663980695801483@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V6 6/9] dt-bindings: clock: add imx7ulp clock binding doc
Date:   Mon, 03 Dec 2018 11:32:00 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting A.s. Dong (2018-11-14 05:01:56)
> i.MX7ULP Clock functions are under joint control of the System
> Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
> modules, and Core Mode Controller (CMC)1 blocks
> =

> Note IMX7ULP has two clock domains: M4 and A7. This binding doc
> is only for A7 clock domain.
> =

> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Anson Huang <Anson.Huang@nxp.com>
> Cc: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> =

> ---

Applied to clk-next

