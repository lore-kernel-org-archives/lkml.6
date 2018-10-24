Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C42C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8072082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X/iwA4Mn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8072082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbeJXLzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:55:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38412 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJXLzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/5UlGu7AAFkWce6Fklye0qjOCXeh3mXXieyxuBny+IU=; b=X/iwA4MnwBJyJtAtHtsBnm14E
        9RjVr75G36nCqDUsdY74awsJY0m93Tc19zi0gampf0awdtEeR8VSrt9Gu387lpHo4ysv14mmrzFGB
        BE2PkKrCKVFtWNuB1JcPuNo63feSVdw8gKW/xVYuvJeaftes2id20/NobmiE6fqRWEA6+YFdxaaHK
        5bZm3q/ye34YbMpN4/1vfAD/kJWh4G0j9WoWO3jCwGId1sinz1L+SizGDRkFvb6vS59fOZkr+pP4c
        DebtoazRuXQXO1lXq0d92i6Hzn9sHhCaBeVQ7A2ypTZ50db/b36X8lBNXpFvwDCxQGEHx11ZE73NA
        LPazGcz+A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gF9rH-0000Cs-NU; Wed, 24 Oct 2018 03:29:23 +0000
Date:   Tue, 23 Oct 2018 20:29:23 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] XArray for 4.20
Message-ID: <20181024032923.GA32064@bombadil.infradead.org>
References: <20181023200825.GA25444@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023200825.GA25444@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 01:08:25PM -0700, Matthew Wilcox wrote:
> In preparing this pull request, I realised I messed up and pushed a
> rebase from two days ago to infradead.  There's no substantial change
> from the version I pushed out to infradead for linux-next testing on
> September 29th (mostly test suite and documentation cleanups).

I found the git hash from back then and pushed out a branch that is what
has been in linux-next:

  git://git.infradead.org/users/willy/linux-dax.git xarray-2018-09-29

I can send you the fixes later in the merge window, if that's what
you'd prefer.

