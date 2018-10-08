Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1C8C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB7E213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB7E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeJIAgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:36:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56924 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeJIAgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:36:36 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1c06::4572])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7AADF13E9999C;
        Mon,  8 Oct 2018 10:23:52 -0700 (PDT)
Date:   Mon, 08 Oct 2018 10:23:51 -0700 (PDT)
Message-Id: <20181008.102351.2206107734502602729.davem@davemloft.net>
To:     yangbo.lu@nxp.com
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        netdev@vger.kernel.org, richardcochran@gmail.com,
        ruxandra.radulescu@nxp.com, gregkh@linuxfoundation.org,
        andrew@lunn.ch
Subject: Re: [v3, 3/6] net: dpaa2: fix dependency of config FSL_DPAA2_ETH
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181008074430.34379-3-yangbo.lu@nxp.com>
References: <20181008074430.34379-1-yangbo.lu@nxp.com>
        <20181008074430.34379-3-yangbo.lu@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 08 Oct 2018 10:23:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangbo Lu <yangbo.lu@nxp.com>
Date: Mon,  8 Oct 2018 15:44:27 +0800

> The NETDEVICES dependency and ETHERNET dependency hadn't
> been required since dpaa2-eth was moved out of staging.
> Also allowed COMPILE_TEST for dpaa2-eth.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied.
