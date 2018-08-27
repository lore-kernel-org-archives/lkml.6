Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7D6C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E26121735
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsM8A0HT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E26121735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeH0KhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 06:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbeH0KhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 06:37:23 -0400
Received: from dragon (unknown [45.56.155.152])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F1C4216FA;
        Mon, 27 Aug 2018 06:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535352725;
        bh=DjktWBlJY0p7p14xHaXoQ0Vs0/tQDTO9kOvwCh/llP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DsM8A0HTkr9mhrvDa4hsqJnJVgEbNHzX7itYRtHyJdm2ohVFmThJb8ODL8OZqzYbe
         A28R/6MnXiL/PqYX23YHWy4kfs8UTtmgkVVvldvUZ4/T4MBPRRQUNNMLqJ94dfbg2h
         cjtAsx3kq/yEae28gze22t90tF/p3NF50uPlXr14=
Date:   Mon, 27 Aug 2018 14:51:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Esben Haabendal <esben.haabendal@gmail.com>
Cc:     linux-i2c@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm: dts: ls1021a: Enable I2C DMA support
Message-ID: <20180827065106.GD3850@dragon>
References: <20180809123207.9732-1-esben.haabendal@gmail.com>
 <20180809123207.9732-4-esben.haabendal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809123207.9732-4-esben.haabendal@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 02:32:07PM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
> 
> Gives substantial performance improvement for transfers larger than 16
> bytes (DMA_THRESHOLD).  Smaller transfers are unaffected.
> 
> Signed-off-by: Esben Haabendal <eha@deif.com>

Applied, thanks.
