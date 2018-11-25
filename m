Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E941FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 02:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9927120867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 02:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HqZ/y1j8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9927120867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeKYN2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 08:28:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbeKYN2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 08:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OnJtOBe52U7faoApiooKpigX5xapjh0GU8wOwa69F5s=; b=HqZ/y1j8kcdN/VmXaArH0x5As
        zJMD7i4ph31LitRJA7SXErNmyB/X/7Kqn9/wGSpN2Lq6itSnFt1T075jABWSHhnC2x255LNlRdPmF
        GsjtlicwbLec7J2QJlxLCBdmUqMr1jDFU3RzvbiemAB9G6AtOyae0YEXAb+XrpVtsexyZyIwKFZe5
        dBVc6RsPd/YFc2VNCtjGrNMaH2oqI5gaKhCirMAruEpcxC4nJMCZasD1ecEM2NwwGZbBzx4EpWKce
        +V/mqmId3E8zbg2dkUsji9ksevYeJpAoCABtXtj66i0CTz347WmRsMydT0+k1wR/4UAiUDu68g7pM
        1p/nheg5w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gQkJK-0001Kr-Bu; Sun, 25 Nov 2018 02:38:14 +0000
Date:   Sat, 24 Nov 2018 18:38:14 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        dan.j.williams@intel.com
Subject: Re: [GIT PULL] XArray updates
Message-ID: <20181125023814.GB3065@bombadil.infradead.org>
References: <20181124173209.GZ3065@bombadil.infradead.org>
 <CAHk-=wgHTcLXY4P-EJiXd4MbwXjp9QdEfQ+udVUGRuUzT-8ZFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgHTcLXY4P-EJiXd4MbwXjp9QdEfQ+udVUGRuUzT-8ZFA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 10:04:30AM -0800, Linus Torvalds wrote:
> On Sat, Nov 24, 2018 at 9:32 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> >   git://git.infradead.org/users/willy/linux-dax.git xarray
> 
> Can you *please* make that a signed tag.

Sure!  I hadn't been paying attention to the signed tag side of things,
so I hope I've done everything OK.

I generated a new key 5EC42E41545C1F5E and signed a new tag
xarray-4.20-rc4

I've signed that key with my old DSA key 2218C81E8E7C03FF which has
about 400 signatures on it, but I understand is not terribly trustable
these days.
