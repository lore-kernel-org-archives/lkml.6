Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68659ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166A320C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166A320C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbeGQJbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:31:38 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35840 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728089AbeGQJbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:31:38 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42323762"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Jul 2018 17:00:02 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 985EE4B5CF67;
        Tue, 17 Jul 2018 17:00:02 +0800 (CST)
Received: from localhost.localdomain (10.167.226.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Tue, 17 Jul 2018 17:00:02 +0800
Subject: Re: [PATCH v13 13/18] x86/tsc: calibrate tsc only once
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
CC:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        <linux@armlinux.org.uk>, <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, <sboyd@codeaurora.org>,
        <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <tglx@linutronix.de>, <hpa@zytor.com>,
        <peterz@infradead.org>, <prarit@redhat.com>, <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>, <gnomes@lxorguk.ukuu.org.uk>,
        <linux-s390@vger.kernel.org>, <boris.ostrovsky@oracle.com>,
        <jgross@suse.com>
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
 <20180712000419.5165-14-pasha.tatashin@oracle.com>
 <928b8490-89d2-46a3-8596-16751bcd12db@cn.fujitsu.com>
 <CAGM2reb-MwiT8qoiSkXCjAAM46JOYL9BP+U3q7PMTcxp9EiK7w@mail.gmail.com>
 <01812492-b88b-4436-570b-ef776eaafc6a@cn.fujitsu.com>
 <CAGM2reaU1GouLvUfW_dbs7gFiYCMX=X+Vag2RnuofmmgS4_TdA@mail.gmail.com>
From:   Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <4f6b295d-c88b-2204-0557-ae85ed443a31@cn.fujitsu.com>
Date:   Tue, 17 Jul 2018 16:59:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGM2reaU1GouLvUfW_dbs7gFiYCMX=X+Vag2RnuofmmgS4_TdA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 985EE4B5CF67.AB088
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



At 07/16/2018 09:35 PM, Pavel Tatashin wrote:
[...]
> v13 has xen patches, so xen timestamps work early as well now.
> 

Oops, yes, my mistake. I will test the patchset with Thomas's kvm patch
for you.

Thanks,
	dou

> Thank you,
> Pavel
> 
> 
> 


