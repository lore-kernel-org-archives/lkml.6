Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84A1C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738D021522
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="flh244JP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738D021522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387676AbeHBQgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:36:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387611AbeHBQgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:36:09 -0400
Received: from [172.20.7.115] (unknown [209.119.211.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 551CF2151B;
        Thu,  2 Aug 2018 14:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533221078;
        bh=w4eWfQI35v6lksu+HxjO52DQLMEYrVPC9Ia2yezHfEg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=flh244JPezWPpPxbaGueRzZT2KqX90BVmPfEobyrPW04aiEBxJz4J+ppyr4WXr8j7
         RDuz2KUcq5rsoMEjdcloCcoC8p5VgquE2P+Zbn5c2WOCut0bjjpvja3Besx9Jo/wYh
         H3HRsRkTyZQ7WU5pedoE8hPidc+DXG9QkbCVRRfQ=
Subject: Re: [PATCH] watchdog: Reduce message verbosity
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Don Zickus <dzickus@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20180730190949.141996-1-okaya@kernel.org>
 <alpine.DEB.2.21.1808021418000.2037@nanos.tec.linutronix.de>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <4952f1f6-cbb0-83af-7189-1b0d96ea644b@kernel.org>
Date:   Thu, 2 Aug 2018 07:44:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1808021418000.2037@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/2018 5:18 AM, Thomas Gleixner wrote:
> On Mon, 30 Jul 2018, Sinan Kaya wrote:
> 
>> Reducing the verbosity level to debug for people that are interested in
>> debugging watchdog issues.
>>
>> [    0.152492] NMI watchdog: Perf event create on CPU 0 failed with -2
>> [    0.156002] NMI watchdog: Perf NMI watchdog permanently disabled
> 
> This changelog is utterly useless.

I'll capture my conversation with Don into the commit message and post
post V2.

> 
> Thanks,
> 
> 	tglx
> 

