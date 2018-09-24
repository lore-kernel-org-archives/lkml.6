Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDF6C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE2B2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE2B2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbeIYAAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:00:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53756 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbeIYAAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:00:23 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5AEBCFF1;
        Mon, 24 Sep 2018 17:57:03 +0000 (UTC)
Date:   Mon, 24 Sep 2018 19:56:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.18 207/235] rcu: Fix grace-period hangs due to race
 with CPU offline
Message-ID: <20180924175659.GA19402@kroah.com>
References: <20180924113103.999624566@linuxfoundation.org>
 <20180924113124.637508442@linuxfoundation.org>
 <20180924164406.GE4222@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924164406.GE4222@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 09:44:06AM -0700, Paul E. McKenney wrote:
> On Mon, Sep 24, 2018 at 01:53:13PM +0200, Greg Kroah-Hartman wrote:
> > 4.18-stable review patch.  If anyone has any objections, please let me know.
> 
> This should not be needed in 4.18 because of a number of crude but
> effective grace-period forward-progress failsafes.  I have not tested
> it in isolation.  It looks harmless enough, but all testing has been in
> conjunction with a large number of preceding patches.
> 
> I therefore strongly recommend against backporting this one.

Now dropped from all 3 queues, thanks for letting me know.

greg k-h
