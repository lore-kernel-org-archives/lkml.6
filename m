Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037CCC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B952C20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B952C20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbeKAUhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:37:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55286 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbeKAUhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:37:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00E9BA78;
        Thu,  1 Nov 2018 04:35:09 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23EE23F71D;
        Thu,  1 Nov 2018 04:35:06 -0700 (PDT)
Date:   Thu, 1 Nov 2018 11:35:04 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     robh+dt@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        andy@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH V5 3/8]  misc/pvpanic: revmove unnecessary header file
Message-ID: <20181101113504.ukz2ynjegafeu6pf@lakrids.cambridge.arm.com>
References: <1541085002-42993-1-git-send-email-peng.hao2@zte.com.cn>
 <1541085002-42993-3-git-send-email-peng.hao2@zte.com.cn>
 <20181101113428.h7i5ku54jpwxlc7q@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101113428.h7i5ku54jpwxlc7q@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 11:34:29AM +0000, Mark Rutland wrote:
> On Thu, Nov 01, 2018 at 11:09:57PM +0800, Peng Hao wrote:
> > remove unnecessary header file init.h.
> > 
> > Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

... though please fix the title:

s/revmove/remove/

Mark.
