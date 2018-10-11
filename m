Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501B0C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39332077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39332077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeJKTea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:34:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:10442 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbeJKTea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:34:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 05:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,368,1534834800"; 
   d="scan'208";a="270445350"
Received: from mrahma3x-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.53.109])
  by fmsmga005.fm.intel.com with ESMTP; 11 Oct 2018 05:07:28 -0700
Date:   Thu, 11 Oct 2018 15:07:27 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        David Howells <dhowells@redhat.com>, zohar@linux.vnet.ibm.com,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] MAINTAINERS: Add me as a keys/trusted maintainer
Message-ID: <20181011120727.GC15767@linux.intel.com>
References: <20180831085504.GB12908@linux.intel.com>
 <20180814145759.11581-1-jarkko.sakkinen@linux.intel.com>
 <22213.1536857154@warthog.procyon.org.uk>
 <20180916191903.GC7473@linux.intel.com>
 <1537162822.3056.7.camel@HansenPartnership.com>
 <20180917204457.GA6716@linux.intel.com>
 <1539251000.11939.6.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1539251000.11939.6.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 05:43:20AM -0400, Mimi Zohar wrote:
> On Mon, 2018-09-17 at 23:44 +0300, Jarkko Sakkinen wrote:
> > On Sun, Sep 16, 2018 at 10:40:22PM -0700, James Bottomley wrote:
> > > On Sun, 2018-09-16 at 22:19 +0300, Jarkko Sakkinen wrote:
> > > > On Thu, Sep 13, 2018 at 05:45:54PM +0100, David Howells wrote:
> > > > > Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > > > > 
> > > > > > David, what do you think?
> > > > > 
> > > > > Which David?
> > > > > 
> > > > > I think you need to ask James and Mimi since they're the current
> > > > > maintainers.
> > > > > 
> > > > > David
> > > > 
> > > > Right, of course, sorry!
> > > > 
> > > > James, Mimi?
> > > 
> > > Not having seen the email thread, I assume it's a patch to add Jarkko
> > > as a Trusted Keys maintainer?  If so that's fine by me.
> > > 
> > > James
> > 
> > Yeah, that. Thanks James!
> 
> Thank you for agreeing!  Have you made the change to MAINTAINERS?  If
> not, I'm about to send James Morris the linux-integrity pull request.
>  I can include the change.
> 
> Mimi

Awesome, thank you.

/Jarkko
