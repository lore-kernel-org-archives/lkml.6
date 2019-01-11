Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4D4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A80F20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RrMKNijP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbfAKN62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:58:28 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:40313 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732911AbfAKN61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:58:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=+sFBc7/hlErLIzqoQUCSkdYCm4sbaAB4oQ049+yIUSc=;
        b=RrMKNijPmjC+vIC8kOYrByP8CSfioDrSLs5h6nQcfUWZKsL1eafwWEuJCqkTnQlXPxaJtXRKdxZPKn4C9nHz2F5Jq2bkR1x1Qtt3P+XUJAbPMzf82HgvssDLochJajxozDJluvIOf/wkLlMFudhzj7rrO96VnFpjIvf4RNJ1T9o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ghxKC-00015D-7u; Fri, 11 Jan 2019 14:58:16 +0100
Date:   Fri, 11 Jan 2019 14:58:16 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the net tree
Message-ID: <20190111135816.GE1895@lunn.ch>
References: <20190111144818.0fe8bde2@canb.auug.org.au>
 <685063fd-a1c2-954a-db1e-b1339ad90e15@gmail.com>
 <6892B6C2-5432-41BD-AAD2-28C8D7233273@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6892B6C2-5432-41BD-AAD2-28C8D7233273@public-files.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 07:27:40AM +0100, Frank Wunderlich wrote:
> Should i make v3 with all tags or me as author?

Hi Franks

The code is already merged. So the patch cannot be updated.

Heiner did the right thing, posting to the list. So it is document,
even if it is not in the ideal location. If anybody ever needed to
check, with a bit of detective work they should find the needed SOB.

       Andrew
