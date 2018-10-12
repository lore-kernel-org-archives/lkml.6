Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7835FC67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3305F205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3305F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeJMBAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:00:45 -0400
Received: from ms.lwn.net ([45.79.88.28]:51138 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbeJMBAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:00:45 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9DDBA9B1;
        Fri, 12 Oct 2018 17:27:13 +0000 (UTC)
Date:   Fri, 12 Oct 2018 11:27:12 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     John Garry <john.garry@huawei.com>
Cc:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>
Subject: Re: [PATCH] docs/completion.txt: Fix a couple of punctuation nits
Message-ID: <20181012112712.64ae0e72@lwn.net>
In-Reply-To: <1539183392-239389-1-git-send-email-john.garry@huawei.com>
References: <1539183392-239389-1-git-send-email-john.garry@huawei.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018 22:56:32 +0800
John Garry <john.garry@huawei.com> wrote:

> This patch fixes a couple of punctuation nits which can make the document
> more correct and readable.
> 
> Also missing "()" are added to some function references for consistency.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Applied, thanks.

I agree with the suggestion to move it to RST - happily, it's already a
valid RST file, and would really only requires a few small tweaks.  Of
course, perhaps the existing RST-compatible markup already renders it
"inferior" :)

jon
