Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF56C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E3D2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E3D2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbeGZLYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:24:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56438 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbeGZLYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:24:13 -0400
Received: from localhost (85-69-146-4.rev.numericable.fr [85.69.146.4])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EC30FC77;
        Thu, 26 Jul 2018 10:08:05 +0000 (UTC)
Date:   Thu, 26 Jul 2018 12:08:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        bryanh@codeaurora.org, ckadabi@codeaurora.org,
        David Keitel <dkeitel@codeaurora.org>
Subject: Re: [PATCH] checkpatch: Warn when a patch doesn't have a description
Message-ID: <20180726100801.GE7872@kroah.com>
References: <1531518027-13318-1-git-send-email-pheragu@codeaurora.org>
 <6799952fbd3639c764c112bde961b5e00270a52d.camel@perches.com>
 <6ed46f85a7577e1d4a48e81f67fd7581@codeaurora.org>
 <1b099f4d8373aa583a17011992676bf0f3f09eee.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b099f4d8373aa583a17011992676bf0f3f09eee.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 07:22:47PM -0700, Joe Perches wrote:
> Potential patches should have a commit description.
> Emit a warning when there isn't one.
> 
> Suggested-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
> Signed-off-by: Joe Perches <joe@perches.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
