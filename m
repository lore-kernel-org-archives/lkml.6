Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01EDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B392086D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B392086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeJKHqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:46:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeJKHqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:46:00 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 73A87D57;
        Thu, 11 Oct 2018 00:21:24 +0000 (UTC)
Date:   Wed, 10 Oct 2018 17:21:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the akpm tree with the jc_docs tree
Message-Id: <20181010172123.cf95ff7f81ad86f3a1c119d3@linux-foundation.org>
In-Reply-To: <20181008083228.33ec7c1d@lwn.net>
References: <20181008183840.70ebfe94@canb.auug.org.au>
        <20181008081315.GB6772@rapoport-lnx>
        <6ab76538-b836-3b22-cb29-102c613091cf@redhat.com>
        <20181008083228.33ec7c1d@lwn.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 08:32:28 -0600 Jonathan Corbet <corbet@lwn.net> wrote:

> On Mon, 8 Oct 2018 10:38:29 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
> > > I can do the renaming and add the patch
> > > 
> > >   "memory-hotplug.txt: add some details about locking internals"
> > > 
> > > on top of the jc_docs tree.
> > > 
> > > Does it sound Ok?
> > >   
> > 
> > Fine with me.
> 
> Works for me too.
> 
> Andrew, what is your preference for mm docs patches going forward?  It
> seems we should try to focus them on one tree or the other.  My preference
> would be to keep carrying them to avoid conflicts elsewhere, but I can
> certainly direct them youward if you'd rather they went that way.

Gee.  Case-by-case, I guess.  A lot of these changes are three-line
alterations as part of a larger patch which necessitated that
alteration.

