Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EBAC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50936208A4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0tDWxRZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50936208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeG3Ghz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 02:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbeG3Ghz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 02:37:55 -0400
Received: from localhost (unknown [171.76.121.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC42320892;
        Mon, 30 Jul 2018 05:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532927085;
        bh=S7+QI3hZfxqmXEtYl92IJaIJozv2zcJxMf+cztb3/GM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0tDWxRZHxtpyHqjBe/6G5hIDzlrnlW9vqSUNLXYRDHl+E6aOI6OMLNLRmTlaTq6vc
         qfUzvStnKj+kmKpVmqjbZRy2qaOflyjkT/ytMhR+4tgGWbssSo43YbL+7AokBKChFQ
         tXcQyG8J3dQXACLdM5ZY0CT6enY/6rhk4o9EiR/k=
Date:   Mon, 30 Jul 2018 10:34:42 +0530
From:   Vinod <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     dan.j.williams@intel.com, s.hauer@pengutronix.de,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v3 2/3] dmaengine: imx-sdma: add memcpy interface
Message-ID: <20180730050442.GG3661@vkoul-mobl>
References: <1532367972-29707-1-git-send-email-yibin.gong@nxp.com>
 <1532367972-29707-3-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532367972-29707-3-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-07-18, 01:46, Robin Gong wrote:
> Add MEMCPY capability for imx-sdma driver.

Applied, thanks

-- 
~Vinod
