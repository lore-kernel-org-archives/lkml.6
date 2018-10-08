Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAB2C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644B220878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644B220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeJHUQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:16:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:42606 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbeJHUQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:16:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 81D57AC1F;
        Mon,  8 Oct 2018 13:04:35 +0000 (UTC)
Date:   Mon, 8 Oct 2018 15:04:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     zhe.he@windriver.com
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] printk: Add KBUILD_MODNAME and remove a redundant
 print prefix
Message-ID: <20181008130435.2xkbeqv5vvx7erir@pathway.suse.cz>
References: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
 <1538239553-81805-3-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538239553-81805-3-git-send-email-zhe.he@windriver.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2018-09-30 00:45:52, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> Add KBUILD_MODNAME to make prints more clear.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>

JFYI, I have pushed this patch into printk.git, for-4.20 branch.

Best Regards,
Petr
