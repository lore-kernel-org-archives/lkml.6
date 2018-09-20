Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9F3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF212150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF212150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbeITWt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:49:27 -0400
Received: from ms.lwn.net ([45.79.88.28]:46878 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeITWt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:49:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DA0D9866;
        Thu, 20 Sep 2018 17:05:00 +0000 (UTC)
Date:   Thu, 20 Sep 2018 11:04:58 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] docs/core-api: add memory allocation guide
Message-ID: <20180920110458.07d5a1c7@lwn.net>
In-Reply-To: <20180920042930.GA19495@rapoport-lnx>
References: <1536917278-31191-1-git-send-email-rppt@linux.vnet.ibm.com>
        <20180920042930.GA19495@rapoport-lnx>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2018 07:29:30 +0300
Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> Ping?
> 
> On Fri, Sep 14, 2018 at 12:27:55PM +0300, Mike Rapoport wrote:
> > Hi,
> > 
> > As Vlastimil mentioned at [1], it would be nice to have some guide about
> > memory allocation. This set adds such guide that summarizes the "best
> > practices". 
> > 
> > The changes from the RFC include additions and corrections from Michal and
> > Randy. I've also added markup to cross-reference the kernel-doc
> > documentation.
> > 
> > I've split the patch into three to separate labels addition to the exiting
> > files from the new contents.
> > 
> > v3 -> v4:
> >   * make GFP_*USER* description less confusing

Sorry...but it's been less than a week.  And this week has been ...
busy ...

Anyway, I've applied the set now, thanks.

jon
