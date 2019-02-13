Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65321C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BD32086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404664AbfBMRtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:49:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:36686 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727548AbfBMRtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:49:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28BB2AFE4;
        Wed, 13 Feb 2019 17:49:21 +0000 (UTC)
Subject: Re: [PATCH] mm/page_owner: move config option to mm/Kconfig.debug
To:     Changbin Du <changbin.du@gmail.com>, akpm@linux-foundation.org
Cc:     yamada.masahiro@socionext.com, mingo@kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20190120024254.6270-1-changbin.du@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b34e8745-daf5-64df-449c-4ddef8f0ed23@suse.cz>
Date:   Wed, 13 Feb 2019 18:49:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190120024254.6270-1-changbin.du@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/19 3:42 AM, Changbin Du wrote:
> Move the PAGE_OWNER option from submenu "Compile-time checks and compiler
> options" to dedicated submenu "Memory Debugging".
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
