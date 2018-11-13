Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7E3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FEB2243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FEB2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbeKMXGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:06:51 -0500
Received: from nautica.notk.org ([91.121.71.147]:40132 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732728AbeKMXGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:06:51 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 17925C009; Tue, 13 Nov 2018 14:08:46 +0100 (CET)
Date:   Tue, 13 Nov 2018 14:08:31 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        v9fs-developer@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/9p: include trans_common.h to fix missing prototype
 warning.
Message-ID: <20181113130831.GA8673@nautica>
References: <20181113055324.GB5116@nautica>
 <b1c4df8f21689b10d451c28fe38e860722d20e71.1542089696.git.dato@net.com.org.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1c4df8f21689b10d451c28fe38e860722d20e71.1542089696.git.dato@net.com.org.es>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adeodato Simó wrote on Tue, Nov 13, 2018:
> This silences -Wmissing-prototypes when defining p9_release_pages.
> 
> Signed-off-by: Adeodato Simó <dato@net.com.org.es>
> ---
>  net/9p/trans_common.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> It was suggested in the kernel-janitors mailing list that silencing
> -Wmissing-prototypes would make for a worthy cause.
> 
> https://www.spinics.net/lists/linux-kernel-janitors/msg43981.html
> 
> Resending w/ Cc: linux-kernel as requested by Dominique.

Great, pushed to my for-next branch, it'll probably get in there today
or tomorrow.

Thanks!
-- 
Dominique
