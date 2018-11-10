Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B675C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 09:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3927F20883
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 09:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3927F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbeKJTMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 14:12:01 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:51244 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbeKJTMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 14:12:01 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42sWrq2fPcz1rFDL;
        Sat, 10 Nov 2018 10:27:39 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42sWrq1DDxz1qqkp;
        Sat, 10 Nov 2018 10:27:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id EyLIgyuXSaAx; Sat, 10 Nov 2018 10:27:38 +0100 (CET)
X-Auth-Info: fKt/te7k6DgIZCBURoNTRPzVKbtVtwZ1zl+kGJttNrarnqVy6MPWfiakUGS8krlZ
Received: from linux.local (ppp-188-174-147-181.dynamic.mnet-online.de [188.174.147.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 10 Nov 2018 10:27:38 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
        id 58B1E1E586D; Sat, 10 Nov 2018 10:27:36 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Paul Moore <paul@paul-moore.com>, eparis@redhat.com,
        Elvira Khabirova <lineprinter@altlinux.org>,
        linux-riscv@lists.infradead.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] riscv: define syscall_get_arch()
References: <20181109031303.GA20906@altlinux.org>
        <20181109031712.GL21511@altlinux.org>
        <CAEn-LTpbzdpeWv8wqo_ptBw2t3Ypzzp0JcB+TGMG4NZbEGBnkw@mail.gmail.com>
        <20181109222839.GB2054@altlinux.org>
X-Yow:  That's a decision that can only be made between you & SY SPERLING!!
Date:   Sat, 10 Nov 2018 10:27:36 +0100
In-Reply-To: <20181109222839.GB2054@altlinux.org> (Dmitry V. Levin's message
        of "Sat, 10 Nov 2018 01:28:39 +0300")
Message-ID: <m28t21jn93.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 10 2018, "Dmitry V. Levin" <ldv@altlinux.org> wrote:

> P.S. It would be great if you replied to me as well.

You are explicitly forbidding that.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
