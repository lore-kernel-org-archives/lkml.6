Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D8EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD67521773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D+g4HPiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfBLHL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:11:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35966 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLHL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:11:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jdQh2wnDdQq4XQAJTu7Etb4lbvdKRMZwGuguU8HZPOc=; b=D+g4HPiTn4TkueH+hdBARRX9S
        9MHupyKkee4I3JI/D822MmuxuoitJlGzjkJr+5pzuIcVYShoLyYVn+uHMyBYpuh2Jz/77qhyg3wBi
        8AdhFuP/m89opbJAi0hU2PidrGW6+6MHRdrcVAuyDBWhbeqA5fzlOIx8laolgxZSHL2xOHIV4gtIP
        GyGV0Jfqbm0+0k5ktBTgCqdZ+BPTJY8iRNVkpv7oiTkYaYYVfX8jrK4BPrWG6+0zmk9wRsEsLMK3s
        GTMJMs8mthJMUzVajBfkO36yI6Vsx1eHBB2Eldr2Eqscs9EdTn2DRlJt948D5RkyYeoIxcMvBxdmh
        LZoFtpSGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSEX-0002hv-Hg; Tue, 12 Feb 2019 07:11:57 +0000
Date:   Mon, 11 Feb 2019 23:11:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/5] riscv: use pr_info and friends
Message-ID: <20190212071157.GI26747@infradead.org>
References: <20190118140308.9599-1-johan@kernel.org>
 <20190118140308.9599-3-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118140308.9599-3-johan@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 03:03:05PM +0100, Johan Hovold wrote:
> Use the pr_info and pr_err macros instead of printk with explicit log
> levels.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
