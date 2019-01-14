Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70700C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F84206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HcEw2a4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfANR3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:29:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfANR3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ROx+pQ6vY6tlXOPZK6F0gWoQ8piAyrfmfomgRSylEBo=; b=HcEw2a4jM9dIVkti074Aw9EXO
        IyLZwhNR2yQSTwibWQwSi6THk/gK6h/FE+OruYsGXlD2HCz9aOyXeswFJ+er/Hia2Qsff4j7OGKBi
        2MRX7giELtWHVwjF3rWGJOLUCzveJeTa+7GY3Wj6w2Zzrc991EfAHoJ4eJbZEAfVH/nLL8T6SzD3h
        H8Yu4GY1RalGefZymYFNl/n1Anyhrq0KHacHags+NdgwXY8s4ktgDvzpZC0vneQBkvzOcjY1m91oE
        5vU4fhRawHq/9gHJaBkcx6ZY1PPDv7SLkJcEP3eMAO5obk9KcAoQHvmhGFyazLBTB8lzfGuGuXHSj
        06zXSxNtA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj62q-0000aB-4H; Mon, 14 Jan 2019 17:29:04 +0000
Date:   Mon, 14 Jan 2019 09:29:03 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Andrew Morton <akpm@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH next]: xarray: Fix typo in comment
Message-ID: <20190114172903.GY6310@bombadil.infradead.org>
References: <20190114084047.GE17906@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114084047.GE17906@uranus.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 11:40:47AM +0300, Cyrill Gorcunov wrote:
> Seems copy and paste typo, not a big deal but still
> for consistency sake better to fix.

Thanks.  It's actually in 4.20-rc4, not just -next.  I'll queue it for
a pull request soon.
