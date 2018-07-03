Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6FEC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAE521759
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oIlRa8XD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAE521759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeGCA2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 20:28:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752769AbeGCA22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 20:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2LYeg2tc17tWzqxQzz6ux7WPAmZOzyOxnKU+jA/qzYQ=; b=oIlRa8XD06YW2YIVvNnb9rHZc
        KM4vUj9z5mpVwe9cLoqBDcUf9HO1bqF4c2zjJwXkKEPNbZyZZAoZshjE+M+h/L78AqDDz+s942Bl+
        2QoKiwiOHUJsfzK0juDKLQcdsG4nLqPCfSgiJi60ZwSHSKlgv1JVgtcq6UiujptOSlpnZERvupZRQ
        oKFuV5yELoTzYZvTMgC+025sZj+QjrkIS2Htio6Mwt1tbu19ddeJ4hlQwZQU0pS71GQOZFRCBGOcH
        4POssDjEWMfjqb7YIDAfzZhrI3Gbsc7WRUz/Jy3vlr+GmLmVBhVyYeBKz7XY49iktJBfnSIE6wnGJ
        NvB93fsTQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa9BD-0004Ox-7m; Tue, 03 Jul 2018 00:28:27 +0000
Date:   Mon, 2 Jul 2018 17:28:26 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] kernel.h: Documentation for roundup() vs round_up()
Message-ID: <20180703002826.GB2438@bombadil.infradead.org>
References: <20180703000907.GA27014@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703000907.GA27014@beast>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 05:09:07PM -0700, Kees Cook wrote:
> + * The `const' hereprevents gcc-3.3 from calling __divdi3

missing space
