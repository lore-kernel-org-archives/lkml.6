Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB39C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B7321727
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B7321727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeHCEED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:04:03 -0400
Received: from nautica.notk.org ([91.121.71.147]:47094 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725736AbeHCEED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:04:03 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 59211C01A; Fri,  3 Aug 2018 04:10:06 +0200 (CEST)
Date:   Fri, 3 Aug 2018 04:09:51 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     piaojun <piaojun@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH v2] net/9p/trans_virtio.c: add null
 terminal for mount tag
Message-ID: <20180803020951.GA16958@nautica>
References: <5B6262F4.9080601@huawei.com>
 <20180802015439.GA27403@nautica>
 <5B62658A.3010605@huawei.com>
 <20180802152339.194c2820@bahia.lan>
 <5B63B3CE.3040601@huawei.com>
 <20180803020608.GA15635@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180803020608.GA15635@nautica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet wrote on Fri, Aug 03, 2018:
> (the code is currently not safe if it returns an error, I'm sending
> another mail about it right after this one as we already have a partial
> fix)

I take that one back, ksys_mount() does check for error properly so just
the null checks we have in Tomas' patch[1] are enough ; sorry for the
double-mail

[1] http://lkml.kernel.org/r/20180727110558.5479-1-tomasbortoli@gmail.com

-- 
Dominique
