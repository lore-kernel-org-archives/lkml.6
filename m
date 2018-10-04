Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6184EC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F0D20856
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F0D20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJDKC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 06:02:29 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:35175 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727439AbeJDKC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 06:02:29 -0400
Received: from [192.168.0.4] (ip5f5bd26f.dynamic.kabel-deutschland.de [95.91.210.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8952F2012D0DC1;
        Thu,  4 Oct 2018 05:11:17 +0200 (CEST)
Subject: Re: x86/mm: Found insecure W+X mapping at address (ptrval)/0xc00a0000
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-mm@kvack.org, x86@kernel.org,
        lkml <linux-kernel@vger.kernel.org>
References: <e75fa739-4bcc-dc30-2606-25d2539d2653@molgen.mpg.de>
 <alpine.DEB.2.21.1809191004580.1468@nanos.tec.linutronix.de>
 <0922cc1b-ed51-06e9-df81-57fd5aa8e7de@molgen.mpg.de>
 <alpine.DEB.2.21.1809210045220.1434@nanos.tec.linutronix.de>
 <c8da5778-3957-2fab-69ea-42f872a5e396@molgen.mpg.de>
 <alpine.DEB.2.21.1809281653270.2004@nanos.tec.linutronix.de>
 <20181003212255.GB28361@zn.tnic>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <18bf13a4-2853-358e-594f-27533193757c@molgen.mpg.de>
Date:   Thu, 4 Oct 2018 05:11:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003212255.GB28361@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Borislav,

Am 03.10.2018 um 23:22 schrieb Borislav Petkov:
> On Fri, Sep 28, 2018 at 04:55:19PM +0200, Thomas Gleixner wrote:
>> Sorry for the delay and thanks for the data. A quick diff did not reveal
>> anything obvious. I'll have a closer look and we probably need more (other)
>> information to nail that down.
> 
> Just a brain dump of what I've found out so far.

Thank you for looking into this. On what board are you able to reproduce 
this? Do you build for 32-bit or 64-bit?


Kind regards,

Paul
