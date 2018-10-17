Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A17ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB88214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWNZeOoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB88214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJQPmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbeJQPmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:42:21 -0400
Received: from localhost (unknown [188.88.119.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C71D214C3;
        Wed, 17 Oct 2018 07:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539762476;
        bh=lc22DSBCQiwwRjLBgavSvKhKQNJ7zhOweyGfqdrIOgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GWNZeOoj1wRZ2wkqwerOIpoKMygsg6SaelBeYb0LEou3y1QQeHx2uXTk3PqYOsFY1
         MroksXQJkkfQnP58gCbk782U/VeqyASWJX5CnQ1eq1W8Jd+0of3rlF0QIHwtNkhUgI
         ca8UiKOCFhQzM+XMMNTLxnzN93eeOEmM6H3TrTOY=
Date:   Wed, 17 Oct 2018 09:47:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jay Kamat <jgkamat@fb.com>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.18 079/135] Add tests for memory.oom.group
Message-ID: <20181017074752.GE25537@kroah.com>
References: <20181016170515.447235311@linuxfoundation.org>
 <20181016170520.617155900@linuxfoundation.org>
 <20181016193903.GA25938@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016193903.GA25938@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 07:39:10PM +0000, Roman Gushchin wrote:
> On Tue, Oct 16, 2018 at 07:05:09PM +0200, Greg Kroah-Hartman wrote:
> > 4.18-stable review patch.  If anyone has any objections, please let me know.
> 
> Memory.oom.group has been merged into 4.19, so the test will fail on 4.18.
> I see no reasons to backport this patch, let's drop it.

Thanks for letting me know, now dropped.

greg k-h
