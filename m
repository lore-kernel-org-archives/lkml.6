Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62205C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329C72084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329C72084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jonmasters.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeJDUnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:43:08 -0400
Received: from edison.jonmasters.org ([173.255.233.168]:43586 "EHLO
        edison.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeJDUnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:43:07 -0400
X-Greylist: delayed 2475 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Oct 2018 16:43:07 EDT
Received: from boston.jonmasters.org ([74.92.29.237] helo=tonnant.bos.jonmasters.org)
        by edison.jonmasters.org with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <jcm@jonmasters.org>)
        id 1g83Ms-0001np-0Z; Thu, 04 Oct 2018 13:08:38 +0000
To:     Jirka Hladky <jhladky@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        =?UTF-8?Q?Jakub_Ra=c4=8dek?= <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kkolakow@redhat.com" <kkolakow@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <CAE4VaGC+FcE4cTUwzTLuCRd8rnd-=MhSZHfjKstiRTKcYq-39g@mail.gmail.com>
From:   Jon Masters <jcm@jonmasters.org>
Message-ID: <47e91887-089b-ba71-5f13-5acca0c8c5ad@jonmasters.org>
Date:   Thu, 4 Oct 2018 09:08:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAE4VaGC+FcE4cTUwzTLuCRd8rnd-=MhSZHfjKstiRTKcYq-39g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 74.92.29.237
X-SA-Exim-Mail-From: jcm@jonmasters.org
Subject: Re: [SCHEDULER] Performance drop in 4.19 compared to 4.18 kernel
X-SA-Exim-Version: 4.2.1 (built Sun, 08 Nov 2009 07:31:22 +0000)
X-SA-Exim-Scanned: Yes (on edison.jonmasters.org)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/18 5:34 AM, Jirka Hladky wrote:

> We would also be more than happy to test the new patches for the
> performance - please let us know if you are interested.  We have a
> pool of 1 NUMA up to 8 NUMA boxes for that, both AMD and Intel,
> covering different CPU generations from Sandy Bridge till Skylake.

I've followed up internally on ensuring Arm is added to your mix. Can
get you suitable 1 and 2P systems for internal use.

Jon.


