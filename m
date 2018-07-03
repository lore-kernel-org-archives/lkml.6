Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429C3C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8B724D2D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="omlnFYKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8B724D2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeGCGkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750764AbeGCGkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:40:05 -0400
Received: from dragon (unknown [104.237.91.44])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 706E924D25;
        Tue,  3 Jul 2018 06:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530599998;
        bh=h1qA3wl9UaDNsT7evcuzqzXbaT60jqkNzNWk8KjFeKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=omlnFYKu/44aaOy7BCgM4cBB6Zk0EDpsbE3H10u0lIByM9wjDftc6OkKJJIm+R0ki
         5Y8MOzUh60VS7EohWU/vt7rv8yl93jgoPEaywN7aIzlGgd+6HVMfKsJxSowX+y2YjQ
         Vdvcq+mFkJpp3hJCAbUvAoF6QTzGZbnBQQpV0LEc=
Date:   Tue, 3 Jul 2018 14:39:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.stach@pengutronix.de,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2] ARM: dts: imx6: correct anatop regulators range
Message-ID: <20180703063942.GK4348@dragon>
References: <1530497076-15509-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530497076-15509-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 10:04:36AM +0800, Anson Huang wrote:
> According to i.MX6 datasheet, the LDO_1P1's typical
> programming operating range is 1.0V to 1.2V, and
> the LDO_2P5's typical programming operating range
> is 2.25V to 2.75V, correct LDO_1P1 and LDO_2P5's
> regulator range settings for i.MX6 SoCs.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
