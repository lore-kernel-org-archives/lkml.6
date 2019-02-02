Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36448C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 20:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7932084C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 20:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cEs+CMcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfBBU4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 15:56:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59850 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfBBU4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 15:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M243DSMfdijggio3CMfPh2Nru9m2Wu7hx9OpFqVoJqk=; b=cEs+CMcwTllLbxE6h98rlTi3x
        +M8ZutbKQDOtXbA+QvnOO6z2317m2Vg7A/VL/jHQi2O6cw6RXX+AioZE+3GBLskMVW1qsMaQm8h8P
        s96KoNqtbKjG7YAxi8K0r6+wKM2mJvZiqE7qG/PitsK961RLrdH4tct0QziX6/uo7jgBPsF4Clzir
        q9mQWcX9JilQUp0jiTGldFzhcJKt8YR/zx9elhbiuCeFOBsvFeeRbysZvr1gMJAZ+FkfpPka3DyRG
        Wlv+W4MIhQ4d8rhqh8bw3fzqHKzXLfIj2104w8nyLscLUcdokZJGA0v4Wf26UtUz1cJ3blTA3MrLn
        mS96KK4Nw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gq2Kr-0004yq-1u; Sat, 02 Feb 2019 20:56:21 +0000
Date:   Sat, 2 Feb 2019 12:56:20 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     frowand.list@gmail.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Joris Gutjahr <joris.gutjahr@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kernel-doc: typo "documentaion"
Message-ID: <20190202205620.GA13285@bombadil.infradead.org>
References: <1549058656-11119-1-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549058656-11119-1-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 02:04:16PM -0800, frowand.list@gmail.com wrote:
>    Include documentation for each *function* in *source*.
> -  If no *function* if specified, the documentaion for all functions
> +  If no *function* if specified, the documentation for all functions
>    and types in the *source* will be included.

Could you fix the if/is mistake while you're at it?
