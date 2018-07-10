Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E00C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA1120840
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA1120840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeGJGmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:42:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57416 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeGJGmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:42:38 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AF5A9A73;
        Tue, 10 Jul 2018 06:42:37 +0000 (UTC)
Date:   Tue, 10 Jul 2018 08:42:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] docs, debugfs: start explicit debugfs documentation
Message-ID: <20180710064234.GA2053@kroah.com>
References: <alpine.DEB.2.21.1807091459410.118937@chino.kir.corp.google.com>
 <20180709151248.2e124971e8af515fd95b9319@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709151248.2e124971e8af515fd95b9319@linux-foundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 03:12:48PM -0700, Andrew Morton wrote:
> On Mon, 9 Jul 2018 15:00:17 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:
> 
> > There is no canonical location for debugfs docuemntation, so start one.

What is wrong with Documenation/filesystems/debugfs.txt?

> > This is primarily motivated to describe the oom_free_timeout_ms interface
> > but it is extended for all the debugfs files that I am personally
> > interested in.
> > 
> > Hopefully this can be expanded in the future for better insight into how
> > the various interfaces can be used.

Ah, you are talking about the contents of debugfs files, right?  Just
use Documenation/ABI/ if you really want to document these things.  But
really, it's debugfs, so things can, and will, change, you should never
build tools that rely on the specific information contained in those
files.

thanks,

greg k-h
