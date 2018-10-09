Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FA8C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2A8214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2A8214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJIT14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:27:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbeJIT14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 15:27:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E258307D853;
        Tue,  9 Oct 2018 12:11:17 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BEF76A044;
        Tue,  9 Oct 2018 12:11:17 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 2E9F61809545;
        Tue,  9 Oct 2018 12:11:17 +0000 (UTC)
Date:   Tue, 9 Oct 2018 08:11:16 -0400 (EDT)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <1475121581.19397135.1539087076797.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181009075417.5bdfa00a@canb.auug.org.au>
References: <20181009075417.5bdfa00a@canb.auug.org.au>
Subject: Re: linux-next: Signed-off-by missing for commit in the gfs2 tree
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.116.116, 10.4.195.27]
Thread-Topic: linux-next: Signed-off-by missing for commit in the gfs2 tree
Thread-Index: PFObl+/OQMQjG7BrezcLttXmq9oPZA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 09 Oct 2018 12:11:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
> Hi all,
> 
> Commit
> 
>   b7f5a2cd27b7 ("GFS2: Flush the GFS2 delete workqueue before stopping the
>   kernel threads")
> 
> is missing a Signed-off-by from its committer.
> 
> --
> Cheers,
> Stephen Rothwell

Fixed now. Sorry about that.

Regards,

Bob Peterson
