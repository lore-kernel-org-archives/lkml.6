Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2639C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74202148D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyEEGxpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74202148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeJQGgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbeJQGgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:36:42 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C76432148E;
        Tue, 16 Oct 2018 22:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539729847;
        bh=D5iv/C4UHJ006ZkNPaUhsqI4IcxIOSP9pgXtpQfwe5E=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=qyEEGxpG6CNfwnkrxk5w82VjYD2P7DSvhkd5PMw4RXNb9BKkNe75mmRia2BmOtQJc
         GvPWWXeP4S22Ctfptto6q8ZAZTlaIXkVgmcTwjNjGywyoyIlutVtYrZbG/t/QNFp5M
         DyrjgX3kIe692wX80vS+8iE3lA1in4IFcpSAEEns=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1535690756-22234-3-git-send-email-aisheng.dong@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, shawnguo@kernel.org,
        thor.thayer@linux.intel.com, linux-imx@nxp.com,
        hdegoede@redhat.com, Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
 <1535690756-22234-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <153972984725.5275.508428182184772125@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V6 2/4] clk: add new APIs to operate on all available clocks
Date:   Tue, 16 Oct 2018 15:44:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dong Aisheng (2018-08-30 21:45:54)
> This patch introduces of_clk_bulk_get_all and clk_bulk_x_all APIs
> to users who just want to handle all available clocks from device tree
> without need to know the detailed clock information likes clock numbers
> and names. This is useful in writing some generic drivers to handle clock
> part.
> =

> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Tested-by: Thor Thayer <thor.thayer@linux.intel.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Applied to clk-next

