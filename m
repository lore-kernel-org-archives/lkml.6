Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC03C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 21:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFD221929
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 21:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GWMyhNAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfBIVlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 16:41:06 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45492 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfBIVlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 16:41:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8EKuGoUm8PnERBpJR1EKD3Nh0PCM4C87n/8hT7pvbbA=; b=GWMyhNAsXHFD7EYG1HstAVGY8O
        ecipYugfajzNc1TvqVomvBeYAF5fhOGh32Okzh2jlCUAesWcL1Yf9aPxZSdx8906hwJfY8+KglD8j
        aUKX+4llLB5gQYoo1glPVl3i0kptcfzAKR8jTUEIpcVqRerCA/Xmc47BNKZTipxZD9iI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gsaMx-0002T9-J4; Sat, 09 Feb 2019 22:41:03 +0100
Date:   Sat, 9 Feb 2019 22:41:03 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Peter Korsgaard <peter@korsgaard.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5]
Message-ID: <20190209214103.GB9061@lunn.ch>
References: <20190208161201.7860-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208161201.7860-1-federico.vaga@cern.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 05:11:56PM +0100, Federico Vaga wrote:
> This patch set provides improvements to the i2c-ocore driver.

Hi Federico

Please could you fixup the SPDX patch, add my review/tested by tags,
and i think we are good to go.

Thanks
	Andrew
