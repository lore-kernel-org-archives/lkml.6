Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED97C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C824220645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="GraVzwAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbeLQMNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:13:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54836 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbeLQMND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:13:03 -0500
Received: from zn.tnic (p200300EC2BC8CE0001731E093D136BFD.dip0.t-ipconnect.de [IPv6:2003:ec:2bc8:ce00:173:1e09:3d13:6bfd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 31D1C1EC0452;
        Mon, 17 Dec 2018 13:13:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545048782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sBUMPXyM0Bx8ARebV90kShPkwYyjTvobE4IIr2jqDu4=;
        b=GraVzwAUKUT94g64bLd7qiQHkWd4CS0M+8aSi9cG+R0v3d7gRUDGFKfmgP8Ikler0N2Jdi
        JCknB2/Vve39dRutJVpF8v6iFf3/sV8lJ9DhMYGOC0i9vO9FSYfDLYF7u5hMe3gRIflxOe
        fID4FruYRlZ93Cfb99W8yxmmWNd6mgc=
Date:   Mon, 17 Dec 2018 13:12:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2 v3] kdump: add the vmcoreinfo documentation
Message-ID: <20181217121255.GC12165@zn.tnic>
References: <20181216131617.2612-1-lijiang@redhat.com>
 <20181216131617.2612-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181216131617.2612-2-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 09:16:16PM +0800, Lianbo Jiang wrote:

This...

> +node_online_map
> +===============
> +It is a macro definition, actually it is an array node_states[N_ONLINE],
> +and it represents the set of online node in a system, one bit position
> +per node number.
> +
> +This is used to keep track of which nodes are in the system and online.

... and this...

> +nodemask_t
> +==========
> +The size of a 'nodemask_t' type. This value is used to compute the number
> +of online nodes.

sound redundant too?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
