Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C60C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5670321857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5670321857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeHQJmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 05:42:38 -0400
Received: from verein.lst.de ([213.95.11.211]:33848 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbeHQJmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 05:42:38 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B76A268EEE; Fri, 17 Aug 2018 08:41:30 +0200 (CEST)
Date:   Fri, 17 Aug 2018 08:41:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Ley Foon Tan <lftan@altera.com>, Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        nios2-dev@lists.rocketboards.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nios2: kconfig: remove duplicate DEBUG_STACK_USAGE
        symbol defintions
Message-ID: <20180817064130.GA10811@lst.de>
References: <20180816070518.10441-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816070518.10441-1-tklauser@distanz.ch>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 09:05:18AM +0200, Tobias Klauser wrote:
> DEBUG_STACK_USAGE is already defined in lib/Kconfig.debug
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Looks like some sort of merge error indeed:

Reviewed-by: Christoph Hellwig <hch@lst.de>
