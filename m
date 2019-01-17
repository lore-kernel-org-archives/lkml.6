Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA03C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4516020855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfAQJMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:12:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:44710 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726926AbfAQJMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:12:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9C488AC9C;
        Thu, 17 Jan 2019 09:12:08 +0000 (UTC)
Date:   Thu, 17 Jan 2019 10:12:08 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     jpoimboe@redhat.com, jeyu@kernel.org, jikos@kernel.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Periodic fake signal
Message-ID: <20190117091208.3zzdgvjxyf5huoey@pathway.suse.cz>
References: <20190115164507.14676-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115164507.14676-1-mbenes@suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-01-15 17:45:05, Miroslav Benes wrote:
> I somehow forgot about this patch set. The discussion about v1 was
> inconclusive, so I'm sending it again with changes according to the
> feedback I got. I still think it is useful, so please consider.
> 
> Changes since v1:
> - timeout changed to 15 seconds (Josh)
> - make it wait for 15 seconds, no more, no less (Josh)
> - the message in klp_send_signals() is printed only once per transition
>   (Josh)
> - the counter is zeroed in klp_start_transition(), so that even
>   klp_reverse_transition() starts correctly (Petr)
> 
> Miroslav Benes (2):
>   livepatch: Send a fake signal periodically
>   livepatch: Remove signal sysfs attribute

Both patches look fine to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
