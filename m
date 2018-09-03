Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ED0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5259E20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5259E20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeIDCwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 22:52:03 -0400
Received: from nautica.notk.org ([91.121.71.147]:41210 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbeIDCwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 22:52:03 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 474B8C009; Tue,  4 Sep 2018 00:29:49 +0200 (CEST)
Date:   Tue, 4 Sep 2018 00:29:34 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: fix spelling mistake in fall-through annotation
Message-ID: <20180903222934.GA25084@nautica>
References: <20180903193806.GA11258@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180903193806.GA11258@embeddedor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gustavo A. R. Silva wrote on Mon, Sep 03, 2018:
> Replace "fallthough" with a proper "fall through" annotation.
> 
> This fix is part of the ongoing efforts to enabling -Wimplicit-fallthrough
> 
> Addresses-Coverity-ID: 402012 ("Missing break in switch")

I'm not a fan of these, as each coverity instance has their own ID, and
I have no idea if there is an "official" coverity for the linux
kernel -- is there?

(Well, I see many patches got landed with that, so I guess there would
be)

> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

I'll take this, thanks.

-- 
Dominique
