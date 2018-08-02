Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584D2C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1094620BED
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1094620BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbeHBIzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:55:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35742 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeHBIzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:55:02 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fl7fd-0000Fb-E2; Thu, 02 Aug 2018 09:05:13 +0200
Date:   Thu, 2 Aug 2018 09:05:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
cc:     Dou Liyang <douly.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        mingo@redhat.com, bhe@redhat.com, keescook@chromium.org,
        yasu.isimatu@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v4 3/4] x86/boot/KASLR: Walk srat tables to filter
 immovable memory
In-Reply-To: <20180802035413.GC6723@localhost.localdomain>
Message-ID: <alpine.DEB.2.21.1808020857130.1835@nanos.tec.linutronix.de>
References: <20180723092908.32656-1-fanc.fnst@cn.fujitsu.com> <20180723092908.32656-4-fanc.fnst@cn.fujitsu.com> <18d27595-43d8-d2a0-bfdf-bd731b77d1b9@cn.fujitsu.com> <20180802035413.GC6723@localhost.localdomain>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018, Chao Fan wrote:
> On Thu, Aug 02, 2018 at 11:47:13AM +0800, Dou Liyang wrote:

Removed 70 lines of complete useless information....

> >> +	table = (struct acpi_subtable_header *)
> >> +		((unsigned long)table_header + sizeof(struct acpi_table_srat));
> >> +
> >> +	table_size = sizeof(struct acpi_subtable_header);
> >
> >table_size isn't used, can be remove.
> >
> 
> Thank you very much, will update in next version.

And yet another 40 lines.

> 

Folks. Can you please both stop this annoying habit of keeping the full
context of the mail and then sprinkling a random sentence into the middle?

Thanks,

	tglx

