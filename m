Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2ADC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B3D20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B3D20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbeJaTDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:03:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59382 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbeJaTDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:03:12 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uSQ70_ELBPNG; Wed, 31 Oct 2018 11:05:44 +0100 (CET)
Received: from zn.tnic (p200300EC2BCE6000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:6000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4004F1EC00EB;
        Wed, 31 Oct 2018 11:05:44 +0100 (CET)
Date:   Wed, 31 Oct 2018 11:05:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v10 0/7] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181031100537.GA15955@zn.tnic>
References: <20181022093720.21426-1-fanc.fnst@cn.fujitsu.com>
 <20181031074234.GB6609@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181031074234.GB6609@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 03:42:34PM +0800, Chao Fan wrote:
> Hi all,
> 
> Sorry for disturbance.
> No reply to this version for more than one week,
> any comments?

You do realize that we're right in the merge window right now, right?

And people are busy sending pull requests and fixing fallout.

So sending new stuff during the two weeks of the merge window, will
kinda put you on the backburner. Try to remember that next time and be
patient.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
