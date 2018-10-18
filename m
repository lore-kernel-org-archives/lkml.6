Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E9BECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DC72098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgO0jdwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DC72098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeJSGcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:32:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725751AbeJSGcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:32:50 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 890A12087A;
        Thu, 18 Oct 2018 22:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539901783;
        bh=4BkjOO9hFWhTlrNyluHQQdr5XjA8RUBr8uwlUYAIwBM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=PgO0jdwoVOOskkyMmWukrQGcJlaxfXafwwSNxepu5m2WiLAb1sllyq6Kk2ySQDQJT
         itNWSNQRnS8EfHGU2UEWdZ74RebaJN/iEpvDj2rwGpy32y1KuF4CuKsen5evbx1h1P
         14q2HRyqeH8h+bNFjc9yzmBm6+dmY+M5QWOR9ZoM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181018220350.220357-1-evgreen@chromium.org>
Cc:     Evan Green <evgreen@chromium.org>
References: <20181018220350.220357-1-evgreen@chromium.org>
Message-ID: <153990178286.53599.2223333358659390565@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: Remove unused arrays in SDM845 GCC
Date:   Thu, 18 Oct 2018 15:29:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2018-10-18 15:03:50)
> This change removes a parent map and parent name array that
> appear to be completely unreferenced.
> =

> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---

Applied to clk-next. Can you change your commit text style going forward
to match Documentation/process/submitting-patches.rst, section 2, for an
"imperative mood"?

