Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6363FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D26A208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D26A208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeIXNTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:19:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57494 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeIXNTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:19:50 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C56AD8F5;
        Mon, 24 Sep 2018 07:19:07 +0000 (UTC)
Date:   Mon, 24 Sep 2018 09:19:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] UBIFS fixes for 4.19-rc4
Message-ID: <20180924071904.GB7871@kroah.com>
References: <2bdd37c6-17af-e216-d865-fad2c6ff6dae@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bdd37c6-17af-e216-d865-fad2c6ff6dae@axentia.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 09:11:55AM +0200, Peter Rosin wrote:
> I fredags, den 21 september 2018, 15:53:42 CEST skrev Greg KH:
> > On Fri, Sep 21, 2018 at 11:33:15AM +0200, Richard Weinberger wrote:
> >> Greg,
> >> 
> >> The following changes since commit ae596de1a0c8c2c924dc99d23c026259372ab234:
> >> 
> >>   Compiler Attributes: naked can be shared (2018-09-20 15:23:58 +0200)
> > 
> > Wow, bold move, new patches with less than 24 hours in your tree.  That
> > means linux-next didn't see them :(
> > 
> >> are available in the Git repository at:
> >> 
> >>   git://git.infradead.org/linux-ubifs.git tags/upstream-4.19-rc4
> > 
> > Now pulled, but really, don't you think that they should at least go
> > through 0-day first?  Maybe no one runs ubifs on mainline kernels...
> 
> FWIW, we do...

That's good to know.  I was just trying to say that patches asked to be
pulled in, less than 24 hours from when they were added to the
developer's tree, is usually a little "suspect" as they normally have
not had the chance to go through our "CI" systems.

That's all, I wasn't trying to disparage the UBIFS codebase at all :)

thanks,

greg k-h
