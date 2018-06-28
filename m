Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655AEC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E2925C12
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBYOARqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E2925C12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeF1CV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:21:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbeF1CVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:21:24 -0400
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08FAC25610;
        Thu, 28 Jun 2018 02:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530152484;
        bh=jO+kKrY4jLrP7IF4mbrT8nI5oor2RgNJt1JgTm1ihoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBYOARqoihc6+vaPh+7sw60WBH9Hk5aXYg+2tWR3kgMn8BaD5AE1j8/h53jE/Z9iA
         kBxlpLuXCSWlxS9UkzYdr8TEGyA9jLbHD2k3TRphjom2U47Khh2kP87QWpCHiJDjA9
         Lj4f37O53lr5XMlkP7bgT+0VWbytULf2lgMzluDY=
Date:   Thu, 28 Jun 2018 10:20:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6: RIoTboard Add chosen stdout-path property
Message-ID: <20180628022005.GF22683@dragon>
References: <20180618154257.16919-1-manu@freebsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618154257.16919-1-manu@freebsd.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 05:42:57PM +0200, Emmanuel Vadot wrote:
> The RIoTboard debug uart is connected to serial1.
> Add a chosen property in the DTS so OS knows what serial port to use for
> the console.
> 
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>

Applied, thanks.
