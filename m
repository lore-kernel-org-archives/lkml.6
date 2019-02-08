Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8976AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5793720863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iP7/YrwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfBHRB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:01:26 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:44202 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfBHRB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EQT7ROLHDcuaDaxctQUhoQIdwKmMTx5LU/qmvHI1A4M=; b=iP7/YrwP+CIIqc8S/4G7Cgu3iL
        Imub7l+V7eZBPCkotA0c3YB39J2bzWsYF3+RCFrhH868gGB2gCBggBOBjI9gI0+xa3PVxBKzGD/u/
        pUK3z7rt04hjPbdPCst5+h3zuckFP8S4xFz7a+zeu3mg3IzGIrFwUfw4X3C3l0BNy6Cs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gs9Wl-0000ZG-J5; Fri, 08 Feb 2019 18:01:23 +0100
Date:   Fri, 8 Feb 2019 18:01:23 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Peter Korsgaard <peter@korsgaard.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] i2c:ocores: add SPDX tag
Message-ID: <20190208170123.GC1853@lunn.ch>
References: <20190208161201.7860-1-federico.vaga@cern.ch>
 <20190208161201.7860-5-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208161201.7860-5-federico.vaga@cern.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 05:12:00PM +0100, Federico Vaga wrote:
> It adds the SPDX tag and it removes the old text about the GPLv2.
> 
> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
