Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D33C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACAF21567
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACAF21567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbeHBU3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:29:08 -0400
Received: from ms.lwn.net ([45.79.88.28]:56436 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbeHBU3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:29:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B23DA6D9;
        Thu,  2 Aug 2018 18:36:48 +0000 (UTC)
Date:   Thu, 2 Aug 2018 12:36:46 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/11] docs/mm: add boot time memory management docs
Message-ID: <20180802123646.4cc299b5@lwn.net>
In-Reply-To: <20180726154557.7a1677d8@lwn.net>
References: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
        <20180702113255.1f7504e2@lwn.net>
        <20180718114730.GD4302@rapoport-lnx>
        <20180718060249.6b45605d@lwn.net>
        <20180718170043.GA23770@rapoport-lnx>
        <20180726154557.7a1677d8@lwn.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 15:45:57 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> It seems this hasn't happened - at least, I don't see the patches in
> linux-next.  Unless somebody says something I think I'll just go ahead and
> merge the set.  It all still applies cleanly enough, no conflicts against
> -next, and I'd hate to see this work fall through the cracks.

So I have now merged this set, thanks.

jon
