Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79295C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 05:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C8B20854
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 05:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfAGFKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 00:10:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbfAGFKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 00:10:41 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3E619E62D;
        Mon,  7 Jan 2019 05:10:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A55619741;
        Mon,  7 Jan 2019 05:10:29 +0000 (UTC)
Subject: Re: [PATCH 1/2 v8] resource: add the new I/O resource descriptor
 'IORES_DESC_RESERVED'
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org,
        linux-ia64@vger.kernel.org, linux-efi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        ard.biesheuvel@linaro.org, tony.luck@intel.com,
        fenghua.yu@intel.com, bhe@redhat.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Toshi Kani <toshi.kani@hp.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20181129080956.20776-1-lijiang@redhat.com>
 <20181129080956.20776-2-lijiang@redhat.com>
 <20181130033703.GA23624@dhcp-128-65.nay.redhat.com>
 <bbf6352b-b060-4cb8-dfd2-99166b0149a7@redhat.com>
 <20181206201147.GG3986@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <9e994396-4bf9-ed96-a8e7-c4ca2f69170d@redhat.com>
Date:   Mon, 7 Jan 2019 13:10:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181206201147.GG3986@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 07 Jan 2019 05:10:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年12月07日 04:11, Borislav Petkov 写道:
> On Fri, Nov 30, 2018 at 03:04:44PM +0800, lijiang wrote:
>> I have noticed the changes on x86, but for IA64, i'm not sure whether it should do the same
>> thing, so keep it as before.
>>
>> If IA64 people would like to give any comment, that will be appreciated.
> 
> I think you should not touch ia64 and not make Tony unnecessarily power
> up the old rust.
> 

Ok, i will get rid of previous changes to IA64 in next post.

Thanks.

> :-)
> 
