Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5CCC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253472083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RycrqjLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253472083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbeGZQeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:34:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730105AbeGZQeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:34:23 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 821E92064D;
        Thu, 26 Jul 2018 15:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532618224;
        bh=32L/h3/j420pRrkQFK1VEZFepQoczl/OmYrUs2y4Haw=;
        h=From:To:References:In-Reply-To:Subject:Date:From;
        b=RycrqjLCI+O89HUpCCUYEG4n4suQXbDcDA8Z2+1agvP+dbe5fbgumXM6stJaVCq7t
         NwKQKUyMWq0gBUC0VZSGrzooiX0AOrkERWGrCTIcInQfbU9L4LIyy5p8CmthRBzZi+
         g5tO/mF6wzX+trc816d0cqIIrrWSuCxxGlOrFaIs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20180718195620.5331-1-krzk@kernel.org>
In-Reply-To: <20180718195620.5331-1-krzk@kernel.org>
Message-ID: <153261822377.48062.13389862802943338719@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH] clk: samsung: Remove unused mout_user_aclk400_mcuisp_p4x12
 variable
Date:   Thu, 26 Jul 2018 08:17:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2018-07-18 12:56:20)
> Remove unused 'mout_user_aclk400_mcuisp_p4x12' variable to fix GCC warnin=
g:
> =

>     drivers/clk/samsung/clk-exynos4412-isp.c:40:27: warning:
>         'mout_user_aclk400_mcuisp_p4x12' defined but not used [-Wunused-c=
onst-variable=3D]
> =

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Applied to clk-next

