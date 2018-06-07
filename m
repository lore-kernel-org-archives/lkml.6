Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id E7b3A3tfGVtTOAAAmS7hNA
	; Thu, 07 Jun 2018 16:43:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1D140608B8; Thu,  7 Jun 2018 16:43:25 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wqQu698V"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6332B607E7;
	Thu,  7 Jun 2018 16:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6332B607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933439AbeFGQnW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:43:22 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56954 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932523AbeFGQnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=TOVnWm57yoIbB9pxlLYDIvtDjEclImBSZPE9JW+WBcU=;
        b=wqQu698VmCAQSJUSQ/1Rme1eJ9tYeRWuXXRHUiIpk3dew/lFWl8Qni0anCSaJkLYQ/ays2htURuXT1rWYgNeipOJFBCSGCD+nKyqtvJxwvT1LwBibYShgCAz6CbiTBeQW+Iz40Ppc3Igy/9pPYwkpSCZIyYuVGWh3ZLCJ0jHjzs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fQy0E-0001bL-GT; Thu, 07 Jun 2018 18:43:10 +0200
Date: Thu, 7 Jun 2018 18:43:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Brandon Maier <brandon.maier@rockwellcollins.com>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, davem@davemloft.net,
        michal.simek@xilinx.com, clayton.shotwell@rockwellcollins.com,
        kristopher.cory@rockwellcollins.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: phy: xgmiitorgmii: Check read_status results
Message-ID: <20180607164310.GB25513@lunn.ch>
References: <20180607155348.149665-1-brandon.maier@rockwellcollins.com>
 <20180607155348.149665-3-brandon.maier@rockwellcollins.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607155348.149665-3-brandon.maier@rockwellcollins.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 10:53:48AM -0500, Brandon Maier wrote:
> We're ignoring the result of the attached phy device's read_status().
> Return it so we can detect errors.
> 
> Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
