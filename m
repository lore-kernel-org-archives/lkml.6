Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D0EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6992F20839
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMigz7q5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6992F20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeHaCXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbeHaCXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:23:31 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 193FA20834;
        Thu, 30 Aug 2018 22:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535667550;
        bh=TPRNVCNODiQOYR8/+N9YEb1giO46CeZ/2CRHGfBQFLI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=cMigz7q5kPYLx7yoM/7ieBVnyPS4+tUiXXXlPbxEqFsm2IoVmBzy0jpVW2e7xtwB2
         YBT/cfcIOmlGYDk+sQjJB8aoIkZ0ptrP4oSZtY9hBr/8NPovFDXQtkWZA7XWFbNFSS
         Mxg77PsTmieO11t7Gb5UDYi1+c7zwF+fm/T2YrF4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180805002222.GA24789@embeddedor.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20180805002222.GA24789@embeddedor.com>
Message-ID: <153566754942.93865.16064112317062824567@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: clk-branch: Use true and false for boolean values
Date:   Thu, 30 Aug 2018 15:19:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gustavo A. R. Silva (2018-08-04 17:22:22)
> Return statements in functions returning bool should use true or false
> instead of an integer value.
> =

> This code was detected with the help of Coccinelle.
> =

> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Applied to clk-next

