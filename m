Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641CEC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025D52083F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025D52083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeGaVvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:51:01 -0400
Received: from namei.org ([65.99.196.166]:41286 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbeGaVvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:51:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w6VK8x2C008220;
        Tue, 31 Jul 2018 20:08:59 GMT
Date:   Wed, 1 Aug 2018 06:08:59 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     linux-security-module@vger.kernel.org, serge@hallyn.com,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] security: Add LSM fixup hooks to set*gid syscalls.
In-Reply-To: <CAJ-EccNNCNrA7to85WrYFjRUP7Z1XC+sJ2JXkargiEvXd11AVg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1808010608080.8072@namei.org>
References: <CAJ-EccNNCNrA7to85WrYFjRUP7Z1XC+sJ2JXkargiEvXd11AVg@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018, Micah Morton wrote:

> +static inline int security_task_fix_setgid(struct cred *new,
> +    const struct cred *old,
> +    int flags)
> +{
> + return 0;
> +}
> +

This looks whitespace-damaged.  Please send patches as plain text.


-- 
James Morris
<jmorris@namei.org>

