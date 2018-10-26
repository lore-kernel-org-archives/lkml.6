Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1437EECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09F12064C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09F12064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeJZXmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:42:47 -0400
Received: from ms.lwn.net ([45.79.88.28]:48812 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbeJZXmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:42:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 36A822B7;
        Fri, 26 Oct 2018 15:05:20 +0000 (UTC)
Date:   Fri, 26 Oct 2018 09:05:18 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] prmem: documentation
Message-ID: <20181026090518.6f3c064e@lwn.net>
In-Reply-To: <20181026092609.GB3159@worktop.c.hoisthospitality.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
        <20181023213504.28905-11-igor.stoppa@huawei.com>
        <20181026092609.GB3159@worktop.c.hoisthospitality.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018 11:26:09 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Jon,
> 
> So the below document is a prime example for why I think RST sucks. As a
> text document readability is greatly diminished by all the markup
> nonsense.

Please don't confused RST with the uses of it.  The fact that one can do
amusing things with the C preprocessor doesn't, on its own, make C
suck... 
> 
> This stuff should not become write-only content like html and other
> gunk. The actual text file is still the primary means of reading this.

I agree that the text file comes first, and I agree that the markup in
this particular document is excessive.

Igor, just like #ifdef's make code hard to read, going overboard with RST
markup makes text hard to read.  It's a common trap to fall into, because
it lets you make slick-looking web pages, but that is not our primary
goal here.  Many thanks for writing documentation for this feature, that
already puts you way ahead of a discouraging number of contributors.  But
could I ask you, please, to make a pass over it and reduce the markup to
a minimum?  Using lists as suggested by Markus would help here.

Thanks,

jon
