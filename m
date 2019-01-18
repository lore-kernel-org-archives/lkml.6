Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CAFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DD22086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfARQ5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:57:31 -0500
Received: from atl4mhob17.registeredsite.com ([209.17.115.110]:54084 "EHLO
        atl4mhob17.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727587AbfARQ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:57:30 -0500
Received: from mailpod.hostingplatform.com (atl4qobmail01pod2.registeredsite.com [10.30.77.35])
        by atl4mhob17.registeredsite.com (8.14.4/8.14.4) with ESMTP id x0IGvRL3001869
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 11:57:27 -0500
Received: (qmail 46093 invoked by uid 0); 18 Jan 2019 16:57:27 -0000
X-TCPREMOTEIP: 174.118.245.214
X-Authenticated-UID: dclarke@blastwave.org
Received: from unknown (HELO ?172.16.35.3?) (dclarke@blastwave.org@174.118.245.214)
  by 0 with ESMTPA; 18 Jan 2019 16:57:26 -0000
Subject: Re: [PATCH v2 00/29] y2038: add time64 syscalls
To:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@libc.org,
        davem@davemloft.net, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        jcmvbkbc@gmail.com, akpm@linux-foundation.org,
        deepa.kernel@gmail.com, ebiederm@xmission.com,
        firoz.khan@linaro.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20190118161835.2259170-1-arnd@arndb.de>
From:   Dennis Clarke <dclarke@blastwave.org>
Message-ID: <be3863ae-d903-8e9e-5e6c-e4a58fac189d@blastwave.org>
Date:   Fri, 18 Jan 2019 11:57:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 11:18 AM, Arnd Bergmann wrote:
> This is a minor update of the patches I posted last week, I
> would like to add this into linux-next now, but would still do
> changes if there are concerns about the contents. The first
> version did not see a lot of replies, which could mean that
> either everyone is happy with it, or that it was largely ignored.
> 
> See also the article at https://lwn.net/Articles/776435/.

I would be happy to read "Approaching the kernel year-2038 end game"
however it is behind a pay wall.  Perhaps it may be best to just
host interesting articles about open source idea elsewhere.

Dennis Clarke

