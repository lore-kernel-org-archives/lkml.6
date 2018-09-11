Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40873C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E526B206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E526B206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeILBeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:34:00 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:54361 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeILBeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:34:00 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 428xSB31t6z1qwJF;
        Tue, 11 Sep 2018 22:32:58 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 428xSB0Hpxz1qqkV;
        Tue, 11 Sep 2018 22:32:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id cEQj9uejzm2D; Tue, 11 Sep 2018 22:32:57 +0200 (CEST)
X-Auth-Info: eQJlLCd1K61PxAsmeCbHuDWr+gvoz4zHcj4v/wdV6B2Kqvh+1Cza8+ZolxUZjI1l
Received: from igel.home (ppp-188-174-159-203.dynamic.mnet-online.de [188.174.159.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 11 Sep 2018 22:32:56 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 649312C115D; Tue, 11 Sep 2018 22:32:56 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, hch@infradead.org, anup@brainfault.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Damien.LeMoal@wdc.com, marc.zyngier@arm.com, jeremy.linton@arm.com,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        catalin.marinas@arm.com, dmitriy@oss-tech.org,
        ard.biesheuvel@linaro.org
Subject: Re: [PATCH v4 10/12] RISC-V: User WRITE_ONCE instead of direct access
References: <1536696339-15204-1-git-send-email-atish.patra@wdc.com>
        <1536696339-15204-11-git-send-email-atish.patra@wdc.com>
X-Yow:  I call it a "SARDINE ON WHEAT"!
Date:   Tue, 11 Sep 2018 22:32:56 +0200
In-Reply-To: <1536696339-15204-11-git-send-email-atish.patra@wdc.com> (Atish
        Patra's message of "Tue, 11 Sep 2018 13:05:37 -0700")
Message-ID: <87o9d3vkp3.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/User/Use/

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
