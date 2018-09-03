Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C4EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6338620856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6338620856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeIDDD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 23:03:58 -0400
Received: from nautica.notk.org ([91.121.71.147]:44292 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbeIDDD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 23:03:58 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 2863BC009; Tue,  4 Sep 2018 00:41:42 +0200 (CEST)
Date:   Tue, 4 Sep 2018 00:41:27 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
Subject: Re: [PATCH] 9p: Rename req to rreq
Message-ID: <20180903224127.GB25084@nautica>
References: <20180903160321.2181-1-tomasbortoli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180903160321.2181-1-tomasbortoli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Mon, Sep 03, 2018:
> Subject: Re: [PATCH] 9p: Rename req to rreq

I feel this is a bit too vague, how about either of these?
'9p: Rename req to rreq in trans_fd'
or
'9p/fd: Rename req to rreq'

We still have plenty of 'req' in client.c and all other transports, so
it would feel like a lie otherwise :)

> In struct p9_conn, rename req to rreq as it is used by the read routine.
>
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Suggested-by: Jun Piao <piaojun@huawei.com>

Nitpick on title aside LGTM, I've picked this up for linux-next

-- 
Dominique
