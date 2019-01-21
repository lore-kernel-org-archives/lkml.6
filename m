Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD22C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913FA20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfAUNvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:51:04 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32832 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730691AbfAUNvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:51:00 -0500
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 84163744E17931957A84;
        Mon, 21 Jan 2019 13:50:58 +0000 (GMT)
Received: from [10.204.65.149] (10.204.65.149) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 21 Jan
 2019 13:50:50 +0000
Subject: Re: [PATCH v7 5/5] tpm: pass an array of tpm_extend_digest structures
 to tpm_pcr_extend()
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <david.safford@ge.com>,
        <monty.wiseman@ge.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        "Matthew Garrett" <matthewgarrett@google.com>
References: <20181213102945.30946-1-roberto.sassu@huawei.com>
 <20181213102945.30946-6-roberto.sassu@huawei.com>
 <20181220152122.GB10652@linux.intel.com>
 <c6a3f3e4-bd9d-d060-9ee1-f84310857ba0@huawei.com>
 <20190118151253.GH4080@linux.intel.com>
 <de1cd369-c06c-0107-80cc-fe3967799849@huawei.com>
 <20190121123739.GD9423@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <e97d1377-b8d8-6ecb-4c7f-1b08235c6864@huawei.com>
Date:   Mon, 21 Jan 2019 14:50:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190121123739.GD9423@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.149]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/2019 1:37 PM, Jarkko Sakkinen wrote:
> 3. The would be nothing wrong exposing struct tpm_chip in
>     include/linux/tpm.h. I would be totally fine with that.

Should I do it in a separate patch (before 5/5)?

Is it fine to call tpm_default_chip() only in pcrlock() for trusted
keys?

Thanks

Roberto


> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
