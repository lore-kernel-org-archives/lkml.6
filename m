Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11322C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B1220839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B1220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeIKMwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:52:16 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36349 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726353AbeIKMwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:52:16 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="44768040"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Sep 2018 15:54:10 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 3CDE24B6ADFF;
        Tue, 11 Sep 2018 15:54:08 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 11 Sep 2018 15:54:11 +0800
Date:   Tue, 11 Sep 2018 15:53:46 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, <bhe@redhat.com>,
        <indou.takao@jp.fujitsu.com>, Cao jin <caoj.fnst@cn.fujitsu.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v6 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory.
Message-ID: <20180911075345.GE8519@localhost.localdomain>
References: <20180910124015.18073-1-fanc.fnst@cn.fujitsu.com>
 <20180911011331.GB8519@localhost.localdomain>
 <CAJZ5v0g2SaGJLFM=Gb3Qr2JzGV_KiNW3xq3xP342YnNWkym=EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g2SaGJLFM=Gb3Qr2JzGV_KiNW3xq3xP342YnNWkym=EQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 3CDE24B6ADFF.AD728
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 09:28:44AM +0200, Rafael J. Wysocki wrote:
>On Tue, Sep 11, 2018 at 3:13 AM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>>
>> sorry, the cover letter forwand to rafael.
>
>Thanks, but the relevant information still needs to go to the
>changelog of the patch adding the extra ACPI tables parsing code.
>Your cover letter will not be there in the git log.
>
>I also would suggest to CC the entire series to linux-acpi along with
>the cover letter.

OK, I will add more in next version.

Thanks,
Chao Fan

>
>Thanks,
>Rafael
>
>


