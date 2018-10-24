Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AFDC46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC2E20832
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oJiQextp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC2E20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeJXLMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:12:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60406 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeJXLMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GzvlbInIEenb4t4cktctSOM1By8IR/+SJiQe1YMgMV0=; b=oJiQextpiMNIP0fKlzpwkpyd3z
        AhlwOMj8CEZ5tQZTT7Kz3A1ZI2lsK1wEM5fbVrdQmtUymXhxnWkehu4x/PkW9XAoetpPscjfON3zX
        NBZ1gxcjTV6iL6WCoYk4b42ww039+f74YOFgNciBfTThFd4MhgR27C0j5xz4TjRq+m3xY7lIdEX9z
        EZGrBlmmB+kNIDTPGHgOTkvYuBDJLSgyLkAgHUlACrORwgfWzGbxHe5DNQwqFHNVlkKrW58MgxvxP
        3iB8uTx3SoojXQ5hogCUFltqbDB5Fx+AlaP9h4Ly/ou5f4YI94sWLKCjHtYlLm//iVZ/jrRcTPPDT
        AMbY6Wcw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gF8Bt-0005Pb-FG; Wed, 24 Oct 2018 01:42:33 +0000
To:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation/x86: fix typo in zero_page.txt
Message-ID: <9bfc5f5d-46ba-ed67-47f8-991c895ecca7@infradead.org>
Date:   Tue, 23 Oct 2018 18:42:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix a typo in Documentation/x86/zero_page.txt.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/x86/zero-page.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-419.orig/Documentation/x86/zero-page.txt
+++ lnx-419/Documentation/x86/zero-page.txt
@@ -25,7 +25,7 @@ Offset	Proto	Name		Meaning
 0C8/004	ALL	ext_cmd_line_ptr  cmd_line_ptr high 32bits
 140/080	ALL	edid_info	Video mode setup (struct edid_info)
 1C0/020	ALL	efi_info	EFI 32 information (struct efi_info)
-1E0/004	ALL	alk_mem_k	Alternative mem check, in KB
+1E0/004	ALL	alt_mem_k	Alternative mem check, in KB
 1E4/004	ALL	scratch		Scratch field for the kernel setup code
 1E8/001	ALL	e820_entries	Number of entries in e820_table (below)
 1E9/001	ALL	eddbuf_entries	Number of entries in eddbuf (below)


