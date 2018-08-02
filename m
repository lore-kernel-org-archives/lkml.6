Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B30C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD09621582
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD09621582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbeHCAWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:22:03 -0400
Received: from nautica.notk.org ([91.121.71.147]:53220 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbeHCAWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:22:03 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id DDD43C009; Fri,  3 Aug 2018 00:28:50 +0200 (CEST)
Date:   Fri, 3 Aug 2018 00:28:35 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     piaojun <piaojun@huawei.com>
Cc:     Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        Ron Minnich <rminnich@sandia.gov>
Subject: Re: [V9fs-developer] About the V9fs-developer list (Was: [PATCH] 9p:
 fix multiple
Message-ID: <20180802222835.GB18901@nautica>
References: <20180728055945.GA16684@nautica>
 <5B5C0D12.3070208@huawei.com>
 <20180728063248.GA24054@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180728063248.GA24054@nautica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet wrote on Sat, Jul 28, 2018:
> piaojun wrote on Sat, Jul 28, 2018:
> > Could we cancel the limitation of recipients' number?
> 
> I think it's hard-coded by source-forge...
> I'm not list admin for v9fs-developer but we've had problems with
> another sf list on another project and the options are fairly limited
> from what I can recall...

I've got the list password from Eric (thanks!) and had a look.

It's actually more open than I remembered, in particular I have found
this maximum number of recipients setting and have lifted the limit.


You probably noticed I've also accepted a bunch of messages just now,
sorry for the spam if these were messages you had already seen, but
let's look forward to a more active list ;)

-- 
Dominique
