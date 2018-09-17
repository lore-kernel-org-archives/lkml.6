Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5B9ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 05:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA6F2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 05:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QMC6uOEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA6F2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeIQLGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 07:06:14 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55384 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727944AbeIQLGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 07:06:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id ACCC68EE23D;
        Sun, 16 Sep 2018 22:40:26 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RBgPjUffedvv; Sun, 16 Sep 2018 22:40:26 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6B9D88EE0FD;
        Sun, 16 Sep 2018 22:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1537162826;
        bh=jSDEgVhEBsPOY0yOCjNxovq+krqD/E+SYVyXfNrdMOA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QMC6uOEis8OtzQe3N5SgU8lJmtMlHbfcy2DuqlzILkFdRhvrYp6UvcOSYl3pV7S0R
         xezWMjb7nNP3NtjD3Lq/7BI5uSXVWNtkEMyiXME4oWIyORdZXuby3XA0m6+xyCT4ID
         /llidJwT1fknvY/itJLlJW/F0la2JbjsOi/3pI+A=
Message-ID: <1537162822.3056.7.camel@HansenPartnership.com>
Subject: Re: [PATCH] MAINTAINERS: Add me as a keys/trusted maintainer
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Howells <dhowells@redhat.com>, zohar@linux.vnet.ibm.com
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 16 Sep 2018 22:40:22 -0700
In-Reply-To: <20180916191903.GC7473@linux.intel.com>
References: <20180831085504.GB12908@linux.intel.com>
         <20180814145759.11581-1-jarkko.sakkinen@linux.intel.com>
         <22213.1536857154@warthog.procyon.org.uk>
         <20180916191903.GC7473@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-09-16 at 22:19 +0300, Jarkko Sakkinen wrote:
> On Thu, Sep 13, 2018 at 05:45:54PM +0100, David Howells wrote:
> > Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > 
> > > David, what do you think?
> > 
> > Which David?
> > 
> > I think you need to ask James and Mimi since they're the current
> > maintainers.
> > 
> > David
> 
> Right, of course, sorry!
> 
> James, Mimi?

Not having seen the email thread, I assume it's a patch to add Jarkko
as a Trusted Keys maintainer?  If so that's fine by me.

James

