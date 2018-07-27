Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657C8C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B8F208AC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B8F208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388654AbeG0QVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:21:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730561AbeG0QVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:21:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B665272628;
        Fri, 27 Jul 2018 14:58:50 +0000 (UTC)
Received: from localhost (unknown [10.43.2.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B9BC2166BA3;
        Fri, 27 Jul 2018 14:58:49 +0000 (UTC)
Date:   Fri, 27 Jul 2018 16:56:02 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, helmut.schaa@googlemail.com,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] rt2x00:  remove redundant functions
 rt2x00mac_sta_{add/remove}
Message-ID: <20180727145602.GA5048@redhat.com>
References: <20180727130549.12980-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727130549.12980-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 27 Jul 2018 14:58:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 27 Jul 2018 14:58:50 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'sgruszka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 09:05:49PM +0800, YueHaibing wrote:
> Only rt2800 subdriver of rt2x00 implement sta_add() and sta_remove(),
> rt2x00mac_sta_add and rt2x00mac_sta_remove has no callers after
> commit 9c87758cf089 ("rt2x00: call sta_add/remove directly in rt2800").
> So can be removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Stanislaw Gruszka <sgruszka@redhat.com>
