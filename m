Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D1197C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E8C208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E8C208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933156AbeFLMkT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:40:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:53870 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754292AbeFLMkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:40:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5CCe6Z2002872;
        Tue, 12 Jun 2018 07:40:07 -0500
Message-ID: <37ef3ba288b02c1e291a0da8f3ee666e0d7e75c7.camel@kernel.crashing.org>
Subject: Re: [GIT PULL v2]  FSI updates for 4.17
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org
Date:   Tue, 12 Jun 2018 22:40:06 +1000
In-Reply-To: <20180612114442.GB5777@kroah.com>
References: <7c268f5bb58cb45a2868020b3c5b8f48ac6844ea.camel@kernel.crashing.org>
         <5c7f9044fefed8bc0e4ca5688801ffa379f38f62.camel@kernel.crashing.org>
         <20180612111839.GA3536@kroah.com>
         <01ffcf6a777323eb3bde1bbb5cb72dc849f404e3.camel@kernel.crashing.org>
         <20180612114442.GB5777@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-12 at 13:44 +0200, Greg Kroah-Hartman wrote:
> 
> > We are in regression only mode even before -rc1 these days ? including
> > for code that is basically completely unused upstream (which is what
> > this is trying to fix) ? :-) That's rather full-on ...
> 
> For code that goes into -rc1, it has to be in linux-next _BEFORE_ -final
> comes out.  That's been the rule for years, you should know that...

Oh I know and I also know that the rule was always somewhat flexible
for "new" drivers ;-) But heh, it's not biggie.

> > Anyway no biggie, it will just slow down some getting some of the other
> > drivers I suppose, though we can always explicitly list the dependency
> > on this tag to work around it.
> 
> There should not be a rush here, remember, kernel development does not
> have deadlines :)

Sort-of, it does make things difficult to have so much crap piling up
out of tree or in vendor trees as you well know, so the faster that
pile is sorted, the better everybody is. But I can deal with the
dependencies for 4.19 (assuming we get the 2 or 3 other drivers I want
to see upstream lined up as well in the next few weeks).

Cheers,
Ben.
