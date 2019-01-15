Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63303C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3279520656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfAOJlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:41:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbfAOJlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:41:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B75EC81F0F;
        Tue, 15 Jan 2019 09:41:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-83.pek2.redhat.com [10.72.12.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54FFB19C7E;
        Tue, 15 Jan 2019 09:41:19 +0000 (UTC)
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        k-hagio@ab.jp.nec.com, anderson@redhat.com,
        linux-doc@vger.kernel.org
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190110121944.6050-2-lijiang@redhat.com> <20190111145650.GG4729@zn.tnic>
 <be8fbb64-7748-c7da-55f7-99fe69796a94@redhat.com>
 <20190114091509.GC2773@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <718e6763-8606-1778-de41-c6bc9f9e8c92@redhat.com>
Date:   Tue, 15 Jan 2019 17:41:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190114091509.GC2773@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 15 Jan 2019 09:41:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年01月14日 17:15, Borislav Petkov 写道:
> On Mon, Jan 14, 2019 at 01:30:30PM +0800, lijiang wrote:
>> I noticed that the checkpatch was coded in Perl. But i am not familiar with
>> the Perl program language, that would be beyond my ability to do this, i have
>> to learn the Perl program language step by step. :-)
> 
> You could give it a try - it is not hard :-)
> 

Thank you for encouraging me to do the things.

> And there's no hurry for this, take your time.
> 
OK. I would like to put this task in my queue. Once i have free time, i will work
on this issue. 

>> Do you mean this one 'KERNEL_IMAGE_SIZE'?
> 
> I mean, all those which are unused. Optimally, you should look at the
> tools and see whether they're using those exports and if not, remove
> them. But no hurry here too, take your time.
> 
OK. I will check it again, But, basically they are used by Makedumpfile or Crash tools.


> My final goal is to have this up-to-date documentation of what is
> exported and what is used by user tools so that people can look at it
> first before carelessly exporting yet another thing.
> 
Agree.

Thanks,
Lianbo
> Thx.
> 
