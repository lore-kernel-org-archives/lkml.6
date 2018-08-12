Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9214FC46470
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 06:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EF621A61
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 06:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EF621A61
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeHLJQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 05:16:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42706 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbeHLJQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 05:16:30 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5BF01941;
        Sun, 12 Aug 2018 06:39:34 +0000 (UTC)
Date:   Sun, 12 Aug 2018 08:39:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sumit Kumar <sumit686215@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gasket: remove null ptr check before kfree
Message-ID: <20180812063931.GC30798@kroah.com>
References: <20180811214753.GA14868@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180811214753.GA14868@ubuntu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 03:17:53AM +0530, Sumit Kumar wrote:
> Remove null ptr check before kfree because kfree is null ptr safe.
> Issue found by checkpatch.
> 
> Signed-off-by: Sumit Kumar <sumit686215@example.com>

Do not use fake email addresses in a signed-off-by line :(
