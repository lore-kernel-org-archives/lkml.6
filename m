Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2076FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 08:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8075218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 08:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="F34a0Jm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeL2IA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 03:00:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47254 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbeL2IA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 03:00:26 -0500
Received: from nazgul.tnic (unknown [88.128.80.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3EAAE1EC0429;
        Sat, 29 Dec 2018 09:00:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1546070425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OUxAJrlCGKrViu+NH4NoBgU6v5CM+9s8VqQ9fI23JjI=;
        b=F34a0Jm2vadS31sW9Fs8V675ubK3qs1aI/DEqTqrACKBWKsSCW3d5UNuBcugGN/qa7gpd4
        kTv6uopGcTiW7AUaaoW4/OEn1Wa4rHOT6ENpCvmKQf2JpM9tZxjR9sRS65QBRv5lZ6EXpz
        sSKlhdxgx3Rx6OlyPi51a9N3VG6qty0=
Date:   Sat, 29 Dec 2018 09:00:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     dave.hansen@linux.intel.com, peterz@infradead.org,
        tglx@linutronix.de, luto@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  x86/mm/mem_encrypt_identity : fix error useage to sizeof
Message-ID: <20181229080013.GB15816@nazgul.tnic>
References: <1546065252-97996-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1546065252-97996-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 02:34:12PM +0800, Peng Hao wrote:
> Fix error usage to sizeof. It should not use sizeof to pointer.

... because?

The commit message needs to explain what the potential issue could be
and why it doesn't matter in this case.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
