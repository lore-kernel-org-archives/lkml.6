Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AD8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076CB21763
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076CB21763
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbeHCPpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:45:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729367AbeHCPpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:45:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 549DA7DAC3;
        Fri,  3 Aug 2018 13:49:24 +0000 (UTC)
Received: from localhost (unknown [10.43.2.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDBE510CD79E;
        Fri,  3 Aug 2018 13:49:23 +0000 (UTC)
Date:   Fri, 3 Aug 2018 15:49:22 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlegacy: fix spelling mistake "acumulative" ->
 "accumulative"
Message-ID: <20180803134921.GA1961@redhat.com>
References: <20180803134224.2609-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803134224.2609-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 03 Aug 2018 13:49:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 03 Aug 2018 13:49:24 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'sgruszka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 02:42:24PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> fix spelling mistake in rx stats text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Stanislaw Gruszka <sgruszka@redhat.com>

