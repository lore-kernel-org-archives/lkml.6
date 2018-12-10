Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B62C67838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4041F205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4041F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbeLJH4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:56:10 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32806 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbeLJH4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:56:10 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 7968868A04D82;
        Mon, 10 Dec 2018 07:56:06 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 10 Dec
 2018 07:56:00 +0000
Subject: Re: [PATCH v6 4/7] tpm: modify tpm_pcr_read() definition to pass a
 TPM hash algorithm
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <david.safford@ge.com>, <monty.wiseman@ge.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
 <20181204082138.24600-5-roberto.sassu@huawei.com>
 <20181204234024.GC1233@linux.intel.com>
 <1544041904.4017.8.camel@linux.ibm.com>
 <1544125756.4017.70.camel@linux.ibm.com>
 <2f6c0365-6c17-2da1-9f5b-3c8e5cc301b2@huawei.com>
 <1544387571.3794.17.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <ff17326e-26c4-3fbc-41ab-b13754064d0b@huawei.com>
Date:   Mon, 10 Dec 2018 08:55:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1544387571.3794.17.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/2018 9:32 PM, Mimi Zohar wrote:
> On Fri, 2018-12-07 at 15:51 +0100, Roberto Sassu wrote:
>> On 12/6/2018 8:49 PM, Mimi Zohar wrote:
> 
>>> PCRs for sha1 and sha256 algorithms are being updated and the
>>> measurement list verifies against the SHA1 PCR-10.
>>>
>>> Roberto, have you added support in ima-evm-utils to validate the other
>>> banks?
>>
>> I modified IMA LTP.
> 
> I'm not finding it.  Was the test for the current code, where the same
> value is being padded for different algorithms, or for walking the
> proposed hash agile format?

I did not send the patch yet.

Roberto


> Mimi
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
