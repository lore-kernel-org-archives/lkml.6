Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289F1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD68C2086B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD68C2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932208AbeGCNep (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:34:45 -0400
Received: from verein.lst.de ([213.95.11.211]:44280 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752700AbeGCNen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:34:43 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 87D7468D52; Tue,  3 Jul 2018 15:35:22 +0200 (CEST)
Date:   Tue, 3 Jul 2018 15:35:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] kconfig: include common Kconfig files from
        top-level Kconfig
Message-ID: <20180703133522.GA15589@lst.de>
References: <20180702144711.22111-1-hch@lst.de> <20180702144711.22111-2-hch@lst.de> <5c090e3f-ced0-62c5-c511-f4c66804ed32@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c090e3f-ced0-62c5-c511-f4c66804ed32@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 01:03:57PM -0700, Randy Dunlap wrote:
> Looks good overall.  I'm still doing some testing on it.
> 
> I would prefer to have init/Kconfig before arch/$(SRCARCH)/Kconfig.
> Is there a reason that you chose the ordering above?
> Any known dependencies?

I don't think there are and I'll give it a spin.

The series needs a resend due to arm and user mode linux issues the
builtbot found anyway.
