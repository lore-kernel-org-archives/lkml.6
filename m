Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD987C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67ED20854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfANBw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 20:52:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfANBw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 20:52:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 784DA80F6D;
        Mon, 14 Jan 2019 01:52:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-115.pek2.redhat.com [10.72.12.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D4900183D8;
        Mon, 14 Jan 2019 01:52:18 +0000 (UTC)
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        k-hagio@ab.jp.nec.com, anderson@redhat.com,
        linux-doc@vger.kernel.org
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190110121944.6050-2-lijiang@redhat.com> <20190111123300.GE4729@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <93c1969f-dcc7-4e34-75ff-b14f2ec15269@redhat.com>
Date:   Mon, 14 Jan 2019 09:52:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190111123300.GE4729@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 14 Jan 2019 01:52:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年01月11日 20:33, Borislav Petkov 写道:
> On Thu, Jan 10, 2019 at 08:19:43PM +0800, Lianbo Jiang wrote:
>> +init_uts_ns.name.release
>> +------------------------
>> +
>> +The version of the Linux kernel. Used to find the corresponding source
>> +code from which the kernel has been built.
>> +
> 
> ...
> 
>> +
>> +init_uts_ns
>> +-----------
>> +
>> +This is the UTS namespace, which is used to isolate two specific
>> +elements of the system that relate to the uname(2) system call. The UTS
>> +namespace is named after the data structure used to store information
>> +returned by the uname(2) system call.
>> +
>> +User-space tools can get the kernel name, host name, kernel release
>> +number, kernel version, architecture name and OS type from it.
> 
> Already asked this but no reply so lemme paste my question again:
> 
> "And this document already fulfills its purpose - those two vmcoreinfo
> exports are redundant and the first one can be removed.
> 
> And now that we agreed that VMCOREINFO is not an ABI and is very tightly
> coupled to the kernel version, init_uts_ns.name.release can be removed,
> yes?
> 
> Or is there anything speaking against that?"
> 

Sorry for this, that is my mistake. Thanks for your reminder.

I agree on your point of view. But i forgot that i should remove this variable
in this post.

I would like to remove this variable and post again. 

Thanks.
Lianbo
