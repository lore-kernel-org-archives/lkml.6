Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C93C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E1A20883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbeLQB1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 20:27:53 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:5979 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731106AbeLQB1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 20:27:53 -0500
X-IronPort-AV: E=Sophos;i="5.56,363,1539619200"; 
   d="scan'208";a="49933851"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Dec 2018 09:27:52 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 8B57C4B734CA;
        Mon, 17 Dec 2018 09:27:51 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 17 Dec 2018 09:27:56 +0800
Date:   Mon, 17 Dec 2018 09:27:28 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <keescook@chromium.org>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v13 1/6] x86/boot: Introduce kstrtoull() to boot
 directory instead of simple_strtoull()
Message-ID: <20181217012728.GA31775@localhost.localdomain>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
 <20181212031053.1815-2-fanc.fnst@cn.fujitsu.com>
 <20181212041218.GA28286@localhost.localdomain>
 <20181212080312.GP17340@MiWiFi-R3L-srv>
 <20181213132603.GD25287@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181213132603.GD25287@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 8B57C4B734CA.AA2AE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 02:26:03PM +0100, Borislav Petkov wrote:
>On Wed, Dec 12, 2018 at 04:03:12PM +0800, Baoquan He wrote:
>> Surely, using the old simple_strtoull() is fine too, we can take its
>> replacement into TODO list.
>
>Yes, that would be nice.

Oops, I thought you agree with what Baoquan said, so I send the new version
and use simple_strtoull() back.

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


