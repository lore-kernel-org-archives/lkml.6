Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id N7OwN05FGFtRaAAAmS7hNA
	; Wed, 06 Jun 2018 20:34:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EBFE2607F7; Wed,  6 Jun 2018 20:34:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5DA7160290;
	Wed,  6 Jun 2018 20:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5DA7160290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeFFUe3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 16:34:29 -0400
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:47576 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932240AbeFFUe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 16:34:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E113F18076248;
        Wed,  6 Jun 2018 20:34:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mom04_26be63797fa25
X-Filterd-Recvd-Size: 1839
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Jun 2018 20:34:26 +0000 (UTC)
Message-ID: <7c74bfa6d22635a2948bd70c64a50d9e3b29c99b.camel@perches.com>
Subject: Re: [PATCH] clang-format: Set IndentWrappedFunctionNames false
From: Joe Perches <joe@perches.com>
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Whitcroft <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 06 Jun 2018 13:34:24 -0700
In-Reply-To: <20180606202528.GX2233@mellanox.com>
References: <20180606201556.GA10832@ziepe.ca>
         <22cb30ea19ad4ab1b341836c5f672ba406cb2b4e.camel@perches.com>
         <20180606202528.GX2233@mellanox.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-06 at 14:25 -0600, Jason Gunthorpe wrote:
> I saw your note in the original mailing-list thread and just wanted to
> say the way I use clang-format is editor based.
> 
> I have a hotkey that triggers clang-format to reformat the current
> statement, or current hi-lighted region. If I don't like it, then
> 'undo' puts it all back for manual adjustment..
> 
> This way I am selective of where I apply it, and I find it is
> something like 95% of the time good, IHMO.
> 
> Big time saver for wrapping long lines, moving code around (eg
> indent,de-indent) and other mundane daily tasks.

Cool for you.

I do most of that via emacs indent-region but perhaps
for rewrapping content and such, clang-format-region
could be even better.

I'll give it a go one day.

cheers, Joe
