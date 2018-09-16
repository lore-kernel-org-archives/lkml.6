Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7814CECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147DC2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147DC2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbeIQAnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 20:43:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:61605 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728449AbeIQAnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 20:43:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2018 12:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,382,1531810800"; 
   d="scan'208";a="233394404"
Received: from vbsuresh-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.48.189])
  by orsmga004.jf.intel.com with ESMTP; 16 Sep 2018 12:19:09 -0700
Date:   Sun, 16 Sep 2018 22:19:03 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     David Howells <dhowells@redhat.com>,
        James.Bottomley@HansenPartnership.com, zohar@linux.vnet.ibm.com
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] MAINTAINERS: Add me as a keys/trusted maintainer
Message-ID: <20180916191903.GC7473@linux.intel.com>
References: <20180831085504.GB12908@linux.intel.com>
 <20180814145759.11581-1-jarkko.sakkinen@linux.intel.com>
 <22213.1536857154@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22213.1536857154@warthog.procyon.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 05:45:54PM +0100, David Howells wrote:
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > David, what do you think?
> 
> Which David?
> 
> I think you need to ask James and Mimi since they're the current maintainers.
> 
> David

Right, of course, sorry!

James, Mimi?

/Jarkko
