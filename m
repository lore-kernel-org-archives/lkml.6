Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C88C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F403218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBGK6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:58:33 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32888 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbfBGK6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:58:32 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id DA24A86FF9E37E45DFA9;
        Thu,  7 Feb 2019 10:58:29 +0000 (GMT)
Received: from [10.204.65.155] (10.204.65.155) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 7 Feb
 2019 10:58:19 +0000
Subject: Re: [PATCH v10 0/6] tpm: retrieve digest size of unknown algorithms
 from TPM
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <david.safford@ge.com>,
        <monty.wiseman@ge.com>, <matthewgarrett@google.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>
References: <20190206105724.14495-1-roberto.sassu@huawei.com>
 <20190206125725.GA9257@linux.intel.com>
 <1fff7b54-cc9a-7705-4c26-819bdd1286f2@huawei.com>
 <20190206135450.GA20061@linux.intel.com>
 <2dea31e3-0796-e21f-5625-1ddc78485c71@huawei.com>
 <20190206153445.GA23970@linux.intel.com>
 <3cd14c24-9de2-d347-b40c-22ca87d9df87@huawei.com>
 <20190206171027.GA25668@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <11187952-3ba3-4f30-3081-cbdfd0986eed@huawei.com>
Date:   Thu, 7 Feb 2019 11:58:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190206171027.GA25668@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.155]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/2019 6:10 PM, Jarkko Sakkinen wrote:
> On Wed, Feb 06, 2019 at 05:07:49PM +0100, Roberto Sassu wrote:
>> Seems ok to me. I'll send patch 3/6 and 4/6.
> 
> Your series has been applied to master and next. Thank you.

Thanks.

Roberto


> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
