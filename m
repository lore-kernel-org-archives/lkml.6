Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0866EBA01C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD8A2124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD8A2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeGLSqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:46:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43802 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbeGLSqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:46:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fdgRV-000129-Sq; Thu, 12 Jul 2018 18:35:53 +0000
Date:   Thu, 12 Jul 2018 19:35:53 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
Message-ID: <20180712183553.GD30522@ZenIV.linux.org.uk>
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <20180712171505.GA23780@kroah.com>
 <20180712172024.GZ30522@ZenIV.linux.org.uk>
 <20180712180304.GA27758@kroah.com>
 <76211EBC-05ED-4FBA-A136-F5EEBFDD9FDF@amacapital.net>
 <20180712183426.GC30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712183426.GC30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 07:34:26PM +0100, Al Viro wrote:
> On Thu, Jul 12, 2018 at 11:30:32AM -0700, Andy Lutomirski wrote:
> 
> Andi,

Apologies for misspelling - finger macros strike ;-/
