Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A65FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D35120861
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfAOLAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 06:00:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbfAOLAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 06:00:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B4ED80461;
        Tue, 15 Jan 2019 11:00:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-83.pek2.redhat.com [10.72.12.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 038D018E4B;
        Tue, 15 Jan 2019 11:00:15 +0000 (UTC)
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
To:     Dave Anderson <anderson@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        linux-doc@vger.kernel.org
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190114192144.GQ2773@zn.tnic>
 <134663991.69764038.1547494607008.JavaMail.zimbra@redhat.com>
 <20190114195940.GS2773@zn.tnic>
 <244986363.69770015.1547496453312.JavaMail.zimbra@redhat.com>
 <20190114201812.GT2773@zn.tnic>
 <221183717.69773903.1547497592624.JavaMail.zimbra@redhat.com>
 <20190114203500.GU2773@zn.tnic>
 <1862896935.69778880.1547498954956.JavaMail.zimbra@redhat.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <a1613510-658e-410c-7554-4b378ae2e756@redhat.com>
Date:   Tue, 15 Jan 2019 19:00:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1862896935.69778880.1547498954956.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 15 Jan 2019 11:00:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年01月15日 04:49, Dave Anderson 写道:
> 
> 
> ----- Original Message -----
>> On Mon, Jan 14, 2019 at 03:26:32PM -0500, Dave Anderson wrote:
>>> No.  It needs *both* the vmlinux file and the vmcore file in order to read
>>> kernel
>>> virtual memory, so just having a kernel virtual address is insufficient.
>>>
>>> So it's a chicken-and-egg situation.  This particular --osrelease option is used
>>> to determine *what* vmlinux file would be required for an actual crash analysis
>>> session.
>>
>> Ok, that makes sense. I could've used that explanation when reviewing
>> the documentation. Do you mind skimming through this:
>>
>> https://lkml.kernel.org/r/20190111145650.GG4729@zn.tnic
>>
>> in case we've missed explaining relevant usage - like that above - of
>> some of the vmcoreinfo members?
> 
> Yeah, I've been watching the thread, and the document looks fine to me.
> It's just that when I saw the discussion of this one being removed that
> I felt the need to respond...  ;-)

Thank you for explaining this issue. 

Regards,
Lianbo

> 
> Dave
> 
