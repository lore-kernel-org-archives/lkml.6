Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0B4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E8D206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E8D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeGTK6Z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:58:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53586 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbeGTK6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:58:25 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tk_JOf6JJ928; Fri, 20 Jul 2018 12:10:53 +0200 (CEST)
Received: from [10.254.79.108] (x2f7fb6c.dyn.telefonica.de [2.247.251.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 78EA01EC0853;
        Fri, 20 Jul 2018 12:10:52 +0200 (CEST)
Date:   Fri, 20 Jul 2018 13:08:36 +0300
User-Agent: K-9 Mail for Android
In-Reply-To: <562d8611-750d-3624-1a1b-df21f39812d6@redhat.com>
References: <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com> <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com> <20180703111428.GB5748@zn.tnic> <4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com> <e7357038-08bd-7ba8-5357-7c91d21d10fe@redhat.com> <20180709092901.GA22182@nazgul.tnic> <fc6a47ca-1b16-eba5-d15e-ca294e01af93@redhat.com> <20180713170857.GB17896@nazgul.tnic> <33453712-9b0b-e8b9-08a6-de09e0806dd6@redhat.com> <20180720052304.GA9146@dhcp-128-65.nay.redhat.com> <20180720073245.GA26926@nazgul.tnic> <562d8611-750d-3624-1a1b-df21f39812d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when AMD sme enabled
To:     lijiang <lijiang@redhat.com>, Dave Young <dyoung@redhat.com>
CC:     bhe@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, ebiederm@xmission.com,
        joro@8bytes.org, thomas.lendacky@amd.com,
        kexec@lists.infradead.org, iommu@lists.linux-foundation.org
From:   Boris Petkov <bp@alien8.de>
Message-ID: <54D39850-F883-4EC6-B160-0CD88D47A997@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 20, 2018 12:55:04 PM GMT+03:00, lijiang <lijiang@redhat.com> wrote:>
>Thanks for your advice, I will rewrite the log and send them again.

Do not send them again - explain the problem properly first!

-- 
Sent from a small device: formatting sux and brevity is inevitable. 
