Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4409AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C61D20823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfBEV5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:57:25 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35613 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfBEV5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:57:25 -0500
X-Originating-IP: 86.202.150.119
Received: from localhost (lfbn-lyo-1-59-119.w86-202.abo.wanadoo.fr [86.202.150.119])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 6CD311C0005;
        Tue,  5 Feb 2019 21:57:21 +0000 (UTC)
Date:   Tue, 5 Feb 2019 22:57:02 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Oliver.Rohe@wago.com
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: rs5c372: r2221: fix to use the correct XSTP bit
Message-ID: <20190205215702.GI24598@piout.net>
References: <1547031572-7097-1-git-send-email-oliver.rohe@wago.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547031572-7097-1-git-send-email-oliver.rohe@wago.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2019 10:59:40+0000, Oliver.Rohe@wago.com wrote:
> The Ricoh chips have slightly different register layouts
> and the r2221 chip uses bit 5 as the oscillator halt sensor bit.
> 
> Signed-off-by: Olive Rohe <oliver.rohe@wago.com>
> ---
>  drivers/rtc/rtc-rs5c372.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
