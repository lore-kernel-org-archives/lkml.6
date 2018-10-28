Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26605C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D793720843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D793720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeJ2BMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 21:12:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeJ2BMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 21:12:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 030814E4C0;
        Sun, 28 Oct 2018 16:27:30 +0000 (UTC)
Received: from ovpn-120-181.rdu2.redhat.com (ovpn-120-181.rdu2.redhat.com [10.10.120.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89421620A8;
        Sun, 28 Oct 2018 16:27:29 +0000 (UTC)
Message-ID: <4d2e704a47284bd8daff1243a2a719f3cae40231.camel@redhat.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the c6x tree
From:   Mark Salter <msalter@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 28 Oct 2018 12:27:29 -0400
In-Reply-To: <20181028155304.0bbd1c70@canb.auug.org.au>
References: <20181028155304.0bbd1c70@canb.auug.org.au>
Organization: Red Hat, Inc
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 28 Oct 2018 16:27:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-10-28 at 15:53 +1100, Stephen Rothwell wrote:
> Hi Mark,
> 
> Commit
> 
>   fe381767b94f ("c6x: switch to NO_BOOTMEM")
> 
> is missing a Signed-off-by from its committer.
> 
Oops, fixed.


