Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E67C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECE922464
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECE922464
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbeGCNjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:39:22 -0400
Received: from verein.lst.de ([213.95.11.211]:44296 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752700AbeGCNjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:39:20 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A91F968D52; Tue,  3 Jul 2018 15:39:59 +0200 (CEST)
Date:   Tue, 3 Jul 2018 15:39:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/Kconfig: use a menu to reduce clutter
Message-ID: <20180703133959.GC15589@lst.de>
References: <20180702144711.22111-1-hch@lst.de> <6ba546f8-42bd-4400-131f-bb389812cb56@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ba546f8-42bd-4400-131f-bb389812cb56@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, folded into the original preempt patch.

