Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F31C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E080C2148D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E89FoWA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E080C2148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeJQGgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbeJQGgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:36:45 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 725AB214AB;
        Tue, 16 Oct 2018 22:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539729850;
        bh=Lx6V9Lbbjz6DoQKC1N9Qwxkz+Da67SoJ6i1Eusbablo=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=E89FoWA1bOQLius7KJvClvxR4R5Ik2aUoNaobuBLFHJvCPpqXozIPiGcIzjduGBBy
         gIe+vAe68eQvSczH0yhKl7f34Dpb43VB4MOIl+zojUs34MaqGAsczGnkaK/5s6oLlU
         1katdcyIhVAcZ5Ca4nSYtdFrgrv8nedxirVCby/Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1535690756-22234-4-git-send-email-aisheng.dong@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, shawnguo@kernel.org,
        thor.thayer@linux.intel.com, linux-imx@nxp.com,
        hdegoede@redhat.com, Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
References: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
 <1535690756-22234-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <153972984990.5275.5447030920657414809@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V6 3/4] clk: add managed version of clk_bulk_get_all
Date:   Tue, 16 Oct 2018 15:44:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dong Aisheng (2018-08-30 21:45:55)
> This patch introduces the managed version of clk_bulk_get_all.
> =

> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Tested-by: Thor Thayer <thor.thayer@linux.intel.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Applied to clk-next

