Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083A0C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F592073D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfBEN0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:26:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:39752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728690AbfBEN0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:26:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0191AE46;
        Tue,  5 Feb 2019 13:26:19 +0000 (UTC)
Date:   Tue, 5 Feb 2019 14:26:18 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] livepatch: return -ENOMEM on ptr_id() allocation
 failure
In-Reply-To: <20190204135653.31406-3-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1902051425550.21608@pobox.suse.cz>
References: <20190204135653.31406-1-pmladek@suse.com> <20190204135653.31406-3-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019, Petr Mladek wrote:

> From: Joe Lawrence <joe.lawrence@redhat.com>
> 
> Fixes the following smatch warning:
> 
>   lib/livepatch/test_klp_shadow_vars.c:47 ptr_id() warn: returning -1 instead of -ENOMEM is sloppy
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
