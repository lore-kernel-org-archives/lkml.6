Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E196C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEEE218AE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfAGQQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:16:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729292AbfAGQQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:16:23 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x07GEGIs079479
        for <linux-kernel@vger.kernel.org>; Mon, 7 Jan 2019 11:16:22 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pv8mwwqjb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 11:16:21 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Mon, 7 Jan 2019 16:16:19 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 7 Jan 2019 16:16:17 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x07GGFII5177700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 16:16:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8A57AE045;
        Mon,  7 Jan 2019 16:16:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50C9AAE053;
        Mon,  7 Jan 2019 16:16:15 +0000 (GMT)
Received: from [9.152.96.120] (unknown [9.152.96.120])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Jan 2019 16:16:15 +0000 (GMT)
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v5 02/15] KVM: s390: coding style issue
 kvm_s390_gisa_init/clear()
To:     pmorel@linux.ibm.com, KVM Mailing List <kvm@vger.kernel.org>
Cc:     Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        kvm390-list@tuxmaker.boeblingen.de.ibm.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-3-mimu@linux.ibm.com>
 <0c41bb2c-aa6c-ccbc-752b-c73f74fdd12b@linux.ibm.com>
From:   Michael Mueller <mimu@linux.ibm.com>
Organization: IBM
Date:   Mon, 7 Jan 2019 17:16:15 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <0c41bb2c-aa6c-ccbc-752b-c73f74fdd12b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010716-0012-0000-0000-000002E36DB6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010716-0013-0000-0000-0000211A77BD
Message-Id: <951277df-bb77-4981-7ec6-bc271aa453a7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02.01.19 17:50, Pierre Morel wrote:
> On 19/12/2018 20:17, Michael Mueller wrote:
>> The change hepls to reduce line length and
>> icreases code readability.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/kvm/interrupt.c | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index fcb55b02990e..9a3aed608914 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -2886,20 +2886,20 @@ int kvm_s390_get_irq_state(struct kvm_vcpu 
>> *vcpu, __u8 __user *buf, int len)
>>   void kvm_s390_gisa_clear(struct kvm *kvm)
>>   {
>> -    if (kvm->arch.gisa) {
>> -        memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
>> -        kvm->arch.gisa->next_alert = (u32)(u64)kvm->arch.gisa;
>> -        VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
>> -    }
>> +    if (!kvm->arch.gisa)
>> +        return;
>> +    memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
>> +    kvm->arch.gisa->next_alert = (u32)(u64)kvm->arch.gisa;
>> +    VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
>>   }
>>   void kvm_s390_gisa_init(struct kvm *kvm)
>>   {
>> -    if (css_general_characteristics.aiv) {
>> -        kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
>> -        VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
>> -        kvm_s390_gisa_clear(kvm);
>> -    }
>> +    if (!css_general_characteristics.aiv)
>> +        return;
>> +    kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
>> +    VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
> 
> to be annoying, shouldn't the trace be done after the clear?

sure, I will address that

> 
>> +    kvm_s390_gisa_clear(kvm);
>>   }
>>   void kvm_s390_gisa_destroy(struct kvm *kvm)
>>
> 
> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
> 
> 

-- 

