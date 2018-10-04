Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88562C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59117206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59117206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeJDXmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:42:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60292 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeJDXmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:42:00 -0400
Received: from localhost (unknown [104.132.1.111])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3574F7A1;
        Thu,  4 Oct 2018 16:47:55 +0000 (UTC)
Date:   Thu, 4 Oct 2018 09:47:53 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, sandeen@sandeen.net
Subject: Re: [GIT PULL] xfs: fixes for 4.19-rc6
Message-ID: <20181004164753.GB5849@kroah.com>
References: <20181004010311.GU31060@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004010311.GU31060@dastard>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 11:03:12AM +1000, Dave Chinner wrote:
> Hi Greg,
> 
> Can you please pull the XFS from the tag listed below. It's a bit
> bigger than that I'd like this late in the cycle, but we've had a
> few challenges getting ourselves sorted out this cycle. Details
> of the contents are in the pull-req output below. This has been be
> run through xfstests over the past week, and merges against 4.19-rc6
> cleanly.
> 
> FYI, there is likely to be one more XFS fix for this cycle - we've
> just tracked down the source of a clone_file_range() data corruption
> so I'll send that as a separate pullreq once Darrick's fix is
> reviewed and tested.

Now merged, and thanks for the heads-up on a future patch.

greg k-h
