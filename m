Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F994C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2603C20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2603C20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390072AbeHASCW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:02:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48566 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389854AbeHASCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:02:21 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PkKVguBIzg_q; Wed,  1 Aug 2018 18:15:53 +0200 (CEST)
Received: from [10.218.170.191] (x2f7fabf.dyn.telefonica.de [2.247.250.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 55D551EC0856;
        Wed,  1 Aug 2018 18:15:53 +0200 (CEST)
Date:   Wed, 01 Aug 2018 19:14:49 +0300
User-Agent: K-9 Mail for Android
In-Reply-To: <84058a7359c55f2af16a85398df85a36@natalenko.name>
References: <d8ac835211e5649b5494141a0decc3bc@natalenko.name> <b84518d4-fc78-ca2a-7bde-ad6b5f6a7d83@redhat.com> <0a4c663887ecc1672d9927ed7256485b@natalenko.name> <20180801152926.GB13988@nazgul.tnic> <3908561D78D1C84285E8C5FCA982C28F7D38B681@ORSMSX110.amr.corp.intel.com> <84058a7359c55f2af16a85398df85a36@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2] arch/x86: Fix boot_cpu_data.microcode version output
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Luck, Tony" <tony.luck@intel.com>
CC:     Prarit Bhargava <prarit@redhat.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, sironi@amazon.de
From:   Boris Petkov <bp@alien8.de>
Message-ID: <D0F737F0-64AD-4F61-86B3-F8FFA9C6B9BA@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 1, 2018 7:01:50 PM GMT+03:00, Oleksandr Natalenko <oleksandr@natalenko.name> wrote:
>I don't mind doing the right thing at all. It is just to inform you
>that 
>it was found to be useful.

I don't think it would've worked if you did a second microcode upgrade on the system.
 
-- 
Sent from a small device: formatting sux and brevity is inevitable. 
