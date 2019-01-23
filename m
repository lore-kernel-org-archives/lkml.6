Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBE4C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CD220870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548227188;
	bh=pMRtiV+eKYNYWl3KqQuT9KdgOqO/6voqKLvnu2XJfWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZEq9iXnptM5Un98wsJNyfKHW+v9ND1UpQUYG932xEBbBlFzWRIb+GrjIgVTosgr4n
	 vnkUtRkdRDmVhTjwBMOVfgke6xeF8XLC1frlcfBNldwALF4qBo3PtSHbOoumg2Ymy3
	 rfKwtzllxspYSnIvftKXo1JEqUsyQaUhrHakQk+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfAWHG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:06:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfAWHG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:06:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 783D220870;
        Wed, 23 Jan 2019 07:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548227186;
        bh=pMRtiV+eKYNYWl3KqQuT9KdgOqO/6voqKLvnu2XJfWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zahsPpvQxQ6WwBZYrLaBwgb/f5yBfkOP8IaM9/q1Gs1pxDowrHI1R//fHp030Zg5B
         MjzD8uVDolnGZpM0N4VCwFGuOql7lAPYhrPyy+vubjGcGCHFDD59wbIUtfx8FSKSEu
         gmGChH7+fx+TUh3o/zJYqpOt+iMh9S4+Scdguw68=
Date:   Wed, 23 Jan 2019 08:06:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Antoine Robertson <antoinerbrtsn@gmail.com>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tty: moxa: Fix coding style issues
Message-ID: <20190123070623.GE27466@kroah.com>
References: <20190122223055.6877-1-antoinerbrtsn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122223055.6877-1-antoinerbrtsn@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 05:30:55PM -0500, Antoine Robertson wrote:
> Fix coding style issues

That is really vague, you need to say exactly what type of coding style
fixes you made here.

And if you made more than one "type" of fix, then you need to break the
patch up into a series, only doing one "type" of fix per patch.

Yeah, that's a pain for when there are only tiny things that need to be
changed, but that way it makes it easier for reviewers, and for fixing
if it turns out any of your changes was not ok.

I recommend, if you want to do coding style fixes, to do so in the
drivers/staging/ part of the kernel.  That area has a lot more work to
be done and you don't end up doing tiny things like this.

thanks,

greg k-h
