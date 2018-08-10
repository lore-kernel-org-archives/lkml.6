Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D425CC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 05:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9EC223E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 05:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9EC223E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbeHJIJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 04:09:38 -0400
Received: from ozlabs.org ([203.11.71.1]:33075 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbeHJIJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 04:09:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41mvB71Wcqz9s5b;
        Fri, 10 Aug 2018 15:41:19 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH 2/3] perf report: Add raw report support for s390 auxiliary trace
In-Reply-To: <20180809151422.GB5395@kernel.org>
References: <20180802074622.13641-1-tmricht@linux.ibm.com> <20180802074622.13641-3-tmricht@linux.ibm.com> <87r2j9bkax.fsf@concordia.ellerman.id.au> <eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com> <20180808155328.GA9543@kernel.org> <20180808155921.GB9543@kernel.org> <20180808160843.GC9543@kernel.org> <20180808161451.GD9543@kernel.org> <20180808164214.GE9543@kernel.org> <252202b1-bc08-a035-8de1-91136016d021@linux.ibm.com> <20180809151422.GB5395@kernel.org>
Date:   Fri, 10 Aug 2018 15:41:18 +1000
Message-ID: <87va8i93sx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> Em Thu, Aug 09, 2018 at 06:35:58AM +0200, Thomas-Mich Richter escreveu:
>> On 08/08/2018 06:42 PM, Arnaldo Carvalho de Melo wrote:
>> > So for those I applied this, seems to pass the ones that were failing,
>> > restarting tests...
>
>> I just updated the perf/core branch, compiled it and all works fine.
>
> Thanks for checking!

Yep all building OK here too.

Thanks all.

cheers
