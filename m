Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110F7C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DAB20863
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vlql/jjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DAB20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeK2JLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:11:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbeK2JLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:11:39 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD682081B;
        Wed, 28 Nov 2018 22:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543442913;
        bh=ErsiQD1RcML32BmCCHJbSzy3rXr2D+fJzqaCqNzHxuk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Vlql/jjYDNZeaWRMK5X72Hzhd2EBuI7a8OUEnKuXdx5wBbX8Pd55H0Ys6RMy1Fe0N
         +xoZ8Kxf2CtB4xdNC6p3j40FXouRWon7CJm4MOrahp4oJLwtyY/I6bm3CZyxK/QtnV
         IMk4/opOoiIdtLor8aqYBROmy9CFmrArc8L3K4EE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Yangtao Li <tiny.windzz@gmail.com>, linus.walleij@linaro.org,
        mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181123150600.27445-1-tiny.windzz@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
References: <20181123150600.27445-1-tiny.windzz@gmail.com>
Message-ID: <154344291239.88331.14159206270303255502@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: nomadik: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Wed, 28 Nov 2018 14:08:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yangtao Li (2018-11-23 07:06:00)
> Use macro to simplify the code.
> =

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Applied to clk-next

