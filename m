Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77659C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 16:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A7E206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 16:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SRcIzgtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfAMQKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 11:10:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfAMQKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 11:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2jEw7DQx/zgTT6Qa8x/YpkxR+Y5h8W52vhcmkMl1T1g=; b=SRcIzgtzKJIFK+hp7/648/4uA
        i4WOwd/2iy0OSyfQNRXfoEWBhPtUZuEuDHzU7P8wvTLjv/0v4aDMGAsNC/9ZNC+APrBZJNjCi0UH/
        iWeY+310RL9+Xb4MQkCOX7wGoVzW5te+aAEWKj/X89EzKoGQHq1EDTkyFFJHXJl4ZFF82AlNpyOfI
        ENQG4AfwYONBokmiiXjLXhSNAQOCbz0s2DVTbQB/aswCfWpLcHN9dFUEB+/2+ZXCwi4+9Y41wSKa4
        Y4t/m9WSThz40ge6bJgm9gi70U5EAMmbhVhyGnGYRdSVeYrVN+mFyCWZzEEUMpGOzfCDn0KCUuDBk
        zyTVDzOkQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giiKq-000809-Ru; Sun, 13 Jan 2019 16:10:04 +0000
Date:   Sun, 13 Jan 2019 08:10:04 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Joel Nider <joeln@il.ibm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs-rst: doc-guide: Minor grammar fixes
Message-ID: <20190113161004.GV6310@bombadil.infradead.org>
References: <1547385359-27927-1-git-send-email-joeln@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547385359-27927-1-git-send-email-joeln@il.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 03:15:59PM +0200, Joel Nider wrote:
> -A way to get rid of that is to use a different version than the one shipped
> -on your distributions. In order to do that, it is recommended to install
> +A way to avoid that is to use a different version than the one shipped
> +on your distributions. In order to do so, it is recommended to install

s/on/with/

Other than that, Acked-by: Matthew Wilcox <willy@infradead.org>
