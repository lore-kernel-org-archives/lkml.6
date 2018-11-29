Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1825C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE8C20832
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE8C20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeK2NSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:18:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbeK2NSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:18:16 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 278B4307CDDA;
        Thu, 29 Nov 2018 02:14:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-62.pek2.redhat.com [10.72.12.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC8FC5D787;
        Thu, 29 Nov 2018 02:14:19 +0000 (UTC)
Subject: Re: [PATCH 1/2 RESEND v7] resource: add the new I/O resource
 descriptor 'IORES_DESC_RESERVED'
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-ia64@vger.kernel.org, linux-efi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, ard.biesheuvel@linaro.org,
        tony.luck@intel.com, fenghua.yu@intel.com, dyoung@redhat.com,
        bhe@redhat.com
References: <20181124051223.19994-1-lijiang@redhat.com>
 <20181124051223.19994-2-lijiang@redhat.com>
 <ae405fe9-94fd-3fb7-decd-c7821cf95b7d@intel.com>
 <460c5552-a48e-3523-275a-7f94d0f08f9b@redhat.com>
 <703ce20d-be09-9b8d-d457-5b002a50dff7@intel.com>
 <d84fbefb-f856-c600-5207-c63f48b1b308@redhat.com>
 <4ff951f6-c1bf-ff98-b70b-a138e54488af@intel.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <4e072e7c-52d2-9ead-2494-4c90b5465ea1@redhat.com>
Date:   Thu, 29 Nov 2018 10:14:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4ff951f6-c1bf-ff98-b70b-a138e54488af@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 29 Nov 2018 02:14:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年11月29日 00:02, Dave Hansen 写道:
> On 11/27/18 7:51 PM, lijiang wrote:
>> But now, the 'E820_TYPE_RESERVED' type is converted to the descriptor 'IORES_DESC_RESERVED'
>> instead of 'IORES_DESC_NONE', it has been changed and the value of 'mem_flags.desc_other'
>> is equal to 'true'. This is wrong.
> 
> Thanks for the improved description of the problem.  Seems to all make
> sense now.
> 
> Could you include this in the changelog for the next version?
> 

Ok, i will include these changes in patch v8. Also thanks for your advice.

Regards,
Lianbo
