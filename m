Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B11C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DA42086B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DA42086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbeKGHbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:31:06 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53826 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeKGHbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:31:06 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A502F13E2C632;
        Tue,  6 Nov 2018 14:03:44 -0800 (PST)
Date:   Tue, 06 Nov 2018 14:03:42 -0800 (PST)
Message-Id: <20181106.140342.2112465101629771510.davem@davemloft.net>
To:     adrian.hunter@intel.com
Cc:     acme@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        mathieu.poirier@linaro.org
Subject: Re: [PATCH V2 1/3] perf tools: Add fallback functions for cases
 where cpumode is insufficient
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181106210712.12098-2-adrian.hunter@intel.com>
References: <20181106210712.12098-1-adrian.hunter@intel.com>
        <20181106210712.12098-2-adrian.hunter@intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 06 Nov 2018 14:03:44 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>
Date: Tue,  6 Nov 2018 23:07:10 +0200

> For branch stacks or branch samples, the sample cpumode might not be
> correct because it applies only to the sample 'ip' and not necessary to
> 'addr' or branch stack addresses. Add fallback functions that can be used
> to deal with those cases
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: David S. Miller <davem@davemloft.net>
