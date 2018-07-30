Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC388FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CF120894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CF120894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeG3Rvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:51:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40820 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbeG3Rvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:51:42 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RE3BHCysCdyk; Mon, 30 Jul 2018 18:16:00 +0200 (CEST)
Received: from nazgul.tnic (95-42-131-245.ip.btc-net.bg [95.42.131.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F9EA1EC00F4;
        Mon, 30 Jul 2018 18:16:00 +0200 (CEST)
Date:   Mon, 30 Jul 2018 18:16:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, Filippo Sironi <sironi@amazon.de>
Subject: Re: [PATCH] x86/MCE: Fix CPU microcode version output
Message-ID: <20180730161604.GC11890@nazgul.tnic>
References: <20180703164844.9742-1-prarit@redhat.com>
 <20180703165849.GA17773@agluck-desk>
 <20180703214300.GA15087@zn.tnic>
 <e76c74b6-4008-9f7d-83bf-dd48433a7ea3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e76c74b6-4008-9f7d-83bf-dd48433a7ea3@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:23:18AM -0400, Prarit Bhargava wrote:
> Filippo & Borislav, did the patch get committed to a -next tree?

No, I'm still waiting for it - looks like Filippo is busy.

Care to send one instead as suggested here?

https://lore.kernel.org/lkml/20180601121939.GA23298@nazgul.tnic/

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
