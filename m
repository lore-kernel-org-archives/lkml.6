Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DAFC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D64B20684
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D64B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeKSSph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:45:37 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32777 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726784AbeKSSph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 13:45:37 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 2628BCBB03349;
        Mon, 19 Nov 2018 08:22:40 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 19 Nov
 2018 08:22:32 +0000
Subject: Re: [PATCH v5 7/7] tpm: pass an array of tpm_bank_list structures to
 tpm_pcr_extend()
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <david.safford@ge.com>,
        <monty.wiseman@ge.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
 <20181114153108.12907-8-roberto.sassu@huawei.com>
 <20181116150352.GA3612@linux.intel.com>
 <9c534ed1-7832-7a3b-3e69-5fcc25c565cc@huawei.com>
 <20181118072901.GB5897@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <5dd9fc97-2fb8-0e17-9ae0-88ce8db83903@huawei.com>
Date:   Mon, 19 Nov 2018 09:22:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181118072901.GB5897@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/2018 8:29 AM, Jarkko Sakkinen wrote:
> On Fri, Nov 16, 2018 at 04:55:36PM +0100, Roberto Sassu wrote:
>> I understood from a previous email that you want to include all API
>> changes for crypto agility in the same patch set.
> 
> Hmm.. maybe there is some misunderstading. Can you point me to the
> comment? Thanks.

---
On Thu, Nov 08, 2018 at 03:24:46PM +0100, Roberto Sassu wrote:
 > Should I include the patch for tpm_pcr_extend() in this patch set, even
 > if the set fixes the digest size issue?

Just add some note to the cover letter. Makes sense here to have a
prequel patch for that because otherwise the implementation will be
a bit messy and half-baked.
---

Roberto


> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
