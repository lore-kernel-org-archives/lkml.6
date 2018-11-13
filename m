Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA29C4161B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526682245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526682245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbeKMWhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:37:33 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32751 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732895AbeKMWhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:37:33 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id BFB3DB4EAD170;
        Tue, 13 Nov 2018 12:39:32 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 13 Nov
 2018 12:39:26 +0000
Subject: Re: [PATCH v4 4/6] tpm: modify tpm_pcr_read() definition to pass a
 TPM hash algorithm
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
CC:     <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
 <20181106150159.1136-5-roberto.sassu@huawei.com>
 <20181108140454.GE8922@linux.intel.com>
 <7a43680a-a216-a191-62a3-c2fb4e72d699@huawei.com>
 <20181108151504.GD14072@linux.intel.com>
 <289C0413-4FFB-4831-B82A-D0C3A965053D@gmx.de>
 <20181108190835.GF20608@linux.intel.com>
 <20181113123449.GA22356@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <0bbfd76f-67eb-52be-4475-7f8b57d198a1@huawei.com>
Date:   Tue, 13 Nov 2018 13:39:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181113123449.GA22356@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/2018 1:34 PM, Jarkko Sakkinen wrote:
> On Thu, Nov 08, 2018 at 09:08:35PM +0200, Jarkko Sakkinen wrote:
>> On Thu, Nov 08, 2018 at 04:19:09PM +0100, Peter Huewe wrote:
>>> Am 8. November 2018 16:15:04 MEZ schrieb Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>:
>>>> On Thu, Nov 08, 2018 at 03:16:03PM +0100, Roberto Sassu wrote:
>>>>>
>>>>> Unfortunately, I cannot fetch the repository as infradead.org only
>>>>> supports the git protocol (I'm behind a proxy).
>>>>>
>>>>> Roberto
>>>>
>>>> I use a proxy script similar to this:
>>>>
>>>> https://gist.github.com/sit/49288
>>>>
>>>> (random googling but gives the idea)
>>>>
>>>> /Jarkko
>>> Moving to a kernel.org repo would be really a benefit or convincing them to have a https interface as well.
>>> We have the same proxy issue with infradead.
>>> Peter
>>> -- 
>>> Sent from my mobile
>>
>> So you are unable to use core.gitproxy to configure the proxy?
> 
> AFAIK the kernel development process does not disallow to use direct
> git protocol for maintainer branches. Please, correct me if I'm
> mistaken.

I solved the issue by creating a mirror of your repository with gitlab.

Roberto


> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
