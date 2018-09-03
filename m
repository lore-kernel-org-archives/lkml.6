Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658C2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 00:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0907820857
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 00:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5K66M4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0907820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbeICETb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 00:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbeICETb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 00:19:31 -0400
Received: from dragon (unknown [45.56.155.166])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B662520856;
        Mon,  3 Sep 2018 00:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535932919;
        bh=+FBibCbkmhPLv6ooRm9FyS47ogku30jiPhnNwU1auyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P5K66M4DbumlxA9cf6CUCrJN126GDarzqxw0D3T0QzCWgR5wLEjsDTnQfqIgFoizL
         NWKwvkrUvr7xusHw8C6VNIZKowtBBynSDG+ock2mJn1tLTvARj4gyVhHfsT4aCs/jK
         kVTnHEhr/Ka/3Cs0pjl/s7NKTcVOaHFtZETHHdFU=
Date:   Mon, 3 Sep 2018 08:00:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, andrew.smirnov@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/2] soc: imx: gpc: use A_CORE instread of A7 for more
 i.MX platforms
Message-ID: <20180903000048.GT3850@dragon>
References: <1535445406-19633-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535445406-19633-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 04:36:45PM +0800, Anson Huang wrote:
> gpcv2 driver is NOT just used on i.MX7D which has Cortex-A7
> cores, but also on i.MX8MQ/i.MX8MM platforms which use Cortex-A53
> cores, so let's use A_CORE instread of A7 to avoid confusion.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Applied both, thanks.
