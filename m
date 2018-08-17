Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFACC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5814821893
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5814821893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeHQOkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 10:40:22 -0400
Received: from ms.lwn.net ([45.79.88.28]:52438 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeHQOkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 10:40:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B6F8E2EF;
        Fri, 17 Aug 2018 11:37:13 +0000 (UTC)
Date:   Fri, 17 Aug 2018 05:37:11 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Rob Herring <rob.herring@linaro.org>,
        Jonas Oberg <jonas@fsfe.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] license-rules.rst and LICENSES: Use only spdx version 3
 with -only and -or-later
Message-ID: <20180817053711.1f7ef05b@lwn.net>
In-Reply-To: <f9a4cd2b1c1cd7938a4e0b8aa9489a0ad96669ca.1534443693.git.joe@perches.com>
References: <f9a4cd2b1c1cd7938a4e0b8aa9489a0ad96669ca.1534443693.git.joe@perches.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2018 11:26:03 -0700
Joe Perches <joe@perches.com> wrote:

> The current linux-kernel source git tree has a mixture of the deprecated
> spdx version 2 and the newer version 3 uses.
> 
> Update the process/license-rules.rst file to show only the version 3 style
> and use only the version 3 styles in LICENSES.
> 
> Add a script to update all old versions in the tree as well.
> 
> I suggest this be applied and the script be run and applied immediately
> after an -rc1.  The script could also be used at any time after the initial
> use to update any other deprecated spdx license uses.

All seems OK to me, with one question: if we're going to run the script
and fix everything up, do we really need to add that script to the tree
as well?  It seems like something we shouldn't need again.

If we *do* keep it for some reason, it needs a comment saying what it
does and why it exists.

Thanks,

jon
