Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E88DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAE621473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAE621473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=supermicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbeHPU2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:28:52 -0400
Received: from mgb.supermicro.com ([207.212.57.85]:54800 "EHLO
        mgb.supermicro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeHPU2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:28:52 -0400
Received: from pps.filterd (MGB.supermicro.com [127.0.0.1])
        by MGB.supermicro.com (8.16.0.22/8.16.0.22) with SMTP id w7GHP1p6021884;
        Thu, 16 Aug 2018 10:29:02 -0700
Received: from ex2013-mbx1.supermicro.com (ex2013-mbx1.supermicro.com [10.2.1.36])
        by MGB.supermicro.com with ESMTP id 2kukby0fum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 16 Aug 2018 10:29:02 -0700
Received: from [172.16.95.100] (10.2.0.41) by EX2013-MBX1.supermicro.com
 (10.2.1.36) with Microsoft SMTP Server (TLS) id 15.0.1236.3; Thu, 16 Aug 2018
 10:27:57 -0700
Subject: Re: [RFC] x86, tsc: Add kcmdline args for skipping tsc calibration
 sequences
From:   patrickg <patrickg@supermicro.com>
To:     "Brown, Len" <len.brown@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "Du, Alek" <alek.du@intel.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "Tang, Feng" <feng.tang@intel.com>
References: <fdf96605-a4a0-049b-51c9-1e68cc2a9b93@supermicro.com>
 <1A7043D5F58CCB44A599DFD55ED4C94849A1AACF@FMSMSX126.amr.corp.intel.com>
 <c7582a8c-8cc1-eff3-2452-a8d42d23fea1@supermicro.com>
 <cb798dcd-8cd6-8a92-9f6c-50bec0afe204@supermicro.com>
 <94bebaa1-992b-572b-0d24-e08037611358@supermicro.com>
Message-ID: <70cdf321-cef7-aa26-1ca8-33378b3afdd9@supermicro.com>
Date:   Thu, 16 Aug 2018 10:28:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <94bebaa1-992b-572b-0d24-e08037611358@supermicro.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.2.0.41]
X-ClientProxiedBy: EX2013-CA1.supermicro.com (10.2.1.31) To
 EX2013-MBX1.supermicro.com (10.2.1.36)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-16_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So it's been pretty quiet here... anything?  Even just to call me nuts or explicitly state that the hardware is doing something totally wrong?
