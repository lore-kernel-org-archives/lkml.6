Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA9EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5622082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5622082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeH3M30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:29:26 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50056 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbeH3M3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:29:25 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fvIJN-0005b2-As; Thu, 30 Aug 2018 10:28:17 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sandy Huang <hjc@rock-chips.com>
Cc:     seanpaul@chromium.org, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] Add support rockchip RGB output interface
Date:   Thu, 30 Aug 2018 10:28:16 +0200
Message-ID: <38391933.H7ebZMqo79@phil>
In-Reply-To: <1535512364-80764-1-git-send-email-hjc@rock-chips.com>
References: <1535512364-80764-1-git-send-email-hjc@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 29. August 2018, 05:12:41 CEST schrieb Sandy Huang:
> This patches add support rockchip RGB output, Some Rockchip CRTCs, like
> rv1108 and px30 can directly output parallel and serial RGB data to panel
> or to conversion chip.
> So add a feature-bit for vops to mark the ability for these direct outputs
> and add an internal encoder in that case, that can attach to bridge chips
> or panels.

I'm obviously ok with this series, but let's give it till monday or so
before applying to give people a bit longer to comment if necessary.


Heiko


