Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6FDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB64208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB64208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbeHWLz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:55:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53626 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727410AbeHWLz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:55:56 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id A0M5xkTKHADr; Thu, 23 Aug 2018 10:27:06 +0200 (CEST)
Received: from nazgul.tnic (77-85-47-250.ip.btc-net.bg [77.85.47.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B87AB1EC0253;
        Thu, 23 Aug 2018 10:27:05 +0200 (CEST)
Date:   Thu, 23 Aug 2018 10:27:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        thomas.lendacky@amd.com, mchehab@kernel.org, mikhail.jin@gmail.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v4 15/16] driver/edac: enable Hygon support to AMD64 EDAC
 driver
Message-ID: <20180823082715.GA11742@nazgul.tnic>
References: <cover.1534599097.git.puwen@hygon.cn>
 <6275a5a0a0cfbd2c1abc09a5bb41caabecd02e27.1534599097.git.puwen@hygon.cn>
 <20180821081331.GC24940@nazgul.tnic>
 <ccbc6572-c16f-7a9b-ab27-54fffac1ba0d@hygon.cn>
 <20180821112020.GB29972@nazgul.tnic>
 <6e17958a-6cd8-4c6c-c890-f5f48b084d6f@redhat.com>
 <20180821130430.GB30528@nazgul.tnic>
 <36de11c7-8448-2967-2032-ef31d8e8a979@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36de11c7-8448-2967-2032-ef31d8e8a979@hygon.cn>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 09:07:20PM +0800, Pu Wen wrote:
> Current I think we'd better try to follow the following way:
> For current version, we will try to minimize the modification and share
> codes,
> For later big modification, will try to split codes to make code path
> more clear.

Yes, makes sense.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
