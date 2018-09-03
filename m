Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9F6C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5724620856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6XgQjjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5724620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeICJGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 05:06:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbeICJGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 05:06:02 -0400
Received: from dragon (unknown [45.56.155.117])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C6F920645;
        Mon,  3 Sep 2018 04:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535950057;
        bh=Hj8i+CjugAI4NWWAkTPB0+zeSd5eZ4jCSj1buAqXIzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L6XgQjjspynhCort/fC+Uy4h4HtgGzt6YbFblcmSlrwLSziTK2Qx/k0EX6sU73Pz2
         1tLKc4BA3DOGJbBdWmJttimxbGaQMK5b5mIm9h17LxweSeG+bQ3LPo/xPNA7qqaoNX
         pWRVWACXDfjp0tDkiWxgFzcaaHbLUmhW0QeW/7oU=
Date:   Mon, 3 Sep 2018 12:46:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2] ARM: dts: imx7s: enable cpuidle driver
Message-ID: <20180903044619.GL3850@dragon>
References: <1535939141-14338-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535939141-14338-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 09:45:41AM +0800, Anson Huang wrote:
> Enable cpuidle for i.MX7S/D using generic ARM cpuidle
> driver, below 2 idle states enabled:
> 
> 1. ARM WFI;
> 2. SoC WAIT mode.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
