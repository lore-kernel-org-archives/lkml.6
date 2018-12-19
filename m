Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE3DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 01:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF3321873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 01:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeLSBTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 20:19:07 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:22008 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727160AbeLSBTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 20:19:07 -0500
X-IronPort-AV: E=Sophos;i="5.56,370,1539619200"; 
   d="scan'208";a="50105107"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Dec 2018 09:19:05 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id F236A4B734AB;
        Wed, 19 Dec 2018 09:19:04 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 19 Dec 2018 09:19:11 +0800
Date:   Wed, 19 Dec 2018 09:18:41 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Ingo Molnar <mingo@kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <keescook@chromium.org>, <bhe@redhat.com>,
        <msys.mizuma@gmail.com>, <indou.takao@jp.fujitsu.com>,
        <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v14 1/5] x86/boot: Introduce get_acpi_rsdp() to parse
 RSDP in cmdline from KEXEC
Message-ID: <20181219011841.GE31775@localhost.localdomain>
References: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
 <20181214093013.13370-2-fanc.fnst@cn.fujitsu.com>
 <20181217172510.GA90818@gmail.com>
 <20181218012704.GB31775@localhost.localdomain>
 <20181218112848.GC7485@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181218112848.GC7485@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: F236A4B734AB.AC68A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 12:28:48PM +0100, Borislav Petkov wrote:
>On Tue, Dec 18, 2018 at 09:27:04AM +0800, Chao Fan wrote:
>> The basic conflict is the kernel avoiding KASLR-randomizing into
>> hot-removable memory areas.
>
>And this should be in a prominent place in your commit message to give
>an idea *why* you're doing this in the first place.

Got it, I would complain more in the first PATH of this series.

Thanks,
Chao Fan
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


