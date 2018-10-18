Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33A4ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF912098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF912098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbeJRWXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:23:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbeJRWXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:23:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F3091CF3C;
        Thu, 18 Oct 2018 14:22:36 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42F4C60150;
        Thu, 18 Oct 2018 14:22:36 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 6308F3BAD; Thu, 18 Oct 2018 11:22:29 -0300 (BRT)
Date:   Thu, 18 Oct 2018 11:22:29 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Set PLT entry/header sizes properly on Sparc.
Message-ID: <20181018142229.GD3254@redhat.com>
References: <20181017.120859.2268840244308635255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017.120859.2268840244308635255.davem@davemloft.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 18 Oct 2018 14:22:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 17, 2018 at 12:08:59PM -0700, David Miller escreveu:
> 
> Using the sh_entsize for both values isn't correct.  It happens
> to be correct on x86...
> 
> For both 32-bit and 64-bit sparc, there are four PLT entries in the
> PLT section.

Thanks, applied.

- Arnaldo
