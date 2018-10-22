Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A77C7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9096F205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9096F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeJWAMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 20:12:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54037 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbeJWAMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 20:12:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E9B1920DFF; Mon, 22 Oct 2018 17:53:46 +0200 (CEST)
Received: from localhost (unknown [185.7.230.214])
        by mail.bootlin.com (Postfix) with ESMTPSA id B49F6208B5;
        Mon, 22 Oct 2018 17:53:36 +0200 (CEST)
Date:   Mon, 22 Oct 2018 17:53:35 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Joshua Kinard <kumba@gentoo.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/1] rtc: ds1685: simplify getting .driver_data
Message-ID: <20181022155335.GT17341@piout.net>
References: <20181021200042.1993-1-wsa+renesas@sang-engineering.com>
 <20181021200042.1993-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181021200042.1993-2-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2018 22:00:41+0200, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy.
> 
>  drivers/rtc/rtc-ds1685.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
