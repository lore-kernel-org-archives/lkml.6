Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE14C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB242075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB242075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbeIGTgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:36:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50284 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbeIGTgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:36:01 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1-eneF8xV7NP; Fri,  7 Sep 2018 16:54:43 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCC4300329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:4300:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 379B01EC0104;
        Fri,  7 Sep 2018 16:54:43 +0200 (CEST)
Date:   Fri, 7 Sep 2018 16:54:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/paravirt] x86/paravirt: Move the pv_irq_ops under the
 PARAVIRT_XXL umbrella
Message-ID: <20180907145441.GE12849@zn.tnic>
References: <20180828074026.820-14-jgross@suse.com>
 <tip-6da63eb241a05b0e676d68975e793c0521387141@git.kernel.org>
 <20180907144939.GA1662@zn.tnic>
 <2585d868-29c1-ec6d-39b1-5346e51c72dc@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2585d868-29c1-ec6d-39b1-5346e51c72dc@suse.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 04:52:20PM +0200, Juergen Gross wrote:
> And the fixing patch is already there:

Yeah, tglx just told me :)

Thx!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
