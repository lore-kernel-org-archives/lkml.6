Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98420C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E3C21A5A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oU/48pk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E3C21A5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933204AbeGCFqE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:46:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932917AbeGCFqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:46:02 -0400
Received: from dragon (unknown [104.237.91.44])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1131A2087C;
        Tue,  3 Jul 2018 05:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530596762;
        bh=nuADOc3uw+LlLMhmkoc7eWw125nmclFtVEVgMs8TFs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oU/48pk9HIilrBBIGvDAP27FDolpQd3EPPnOpm/wZrLxAyWud2VuGf+niTLmwbpa9
         Yd3gP2e5LNVFvYhbTvbAVsnll7ZnFke+az6845KvptvwTtY09SXAl1IKyS6H5kkirv
         0niL7S7SrA5c3482JLpVkzPTURoiBer99yfku9F4=
Date:   Tue, 3 Jul 2018 13:45:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: imx51-babbage: Make use of pinctrl_usbh1reg
Message-ID: <20180703054547.GD4348@dragon>
References: <20180628043713.14425-1-andrew.smirnov@gmail.com>
 <20180628043713.14425-2-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628043713.14425-2-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 09:37:13PM -0700, Andrey Smirnov wrote:
> Pinctrl_usbh1reg defines pinmux setting for reset GPIO used by
> usbh1phy, but is not referenced by that node. Fix that.
> 
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Applied, thanks.
