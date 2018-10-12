Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074FAC71123
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72DF21480
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5xqZinX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72DF21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeJMD14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeJMD14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:27:56 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2CB920868;
        Fri, 12 Oct 2018 19:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539374030;
        bh=xo+/lQt0Ps4xGinfnAlSaLifVWv/9MbgI1uM8QYTUcM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=R5xqZinXQk3N/PBkCKaidI4H5Q3Cg5OC9rZUfAluBcpBtAF1Wpjk+jz/Qr7J3FM9s
         C+PxvDRvBCY89jcfLDbDEtccXwAbfC9aQzp1TupDdZjWCNMN5teKCMM239i3gy8UUi
         kLpz5iON/QVUF+2zuZy+Wx1Q1qyxoMSlDwM5Jd/I=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Tony Xie <tony.xie@rock-chips.com>, heiko@sntech.de
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1535969040-19528-1-git-send-email-tony.xie@rock-chips.com>
Cc:     broonie@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, linux-clk@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com
References: <1535968829-19418-1-git-send-email-tony.xie@rock-chips.com>
 <1535969040-19528-1-git-send-email-tony.xie@rock-chips.com>
Message-ID: <153937403016.5275.3088992157058683483@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 5/5] clk: RK808: add RK809 and RK817 support.
Date:   Fri, 12 Oct 2018 12:53:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tony Xie (2018-09-03 03:04:00)
> RK809 and RK817 are power management IC chips for multimedia products.
> most of their functions and registers are same, including the clkout
> funciton.
> =

> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

