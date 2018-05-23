Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933772AbeEWQ6K (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:58:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53584 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933742AbeEWQ6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:58:02 -0400
Subject: Re: [PATCH v7 0/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
To: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, jgross@suse.com, hpa@zytor.com, mingo@redhat.com,
        tglx@linutronix.de
Cc: boris.ostrovsky@oracle.com, bp@suse.de, dave.hansen@linux.intel.com,
        davem@davemloft.net, gregkh@linuxfoundation.org, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, luto@kernel.org, mchehab@kernel.org,
        rdunlap@infradead.org, thomas.lendacky@amd.com, hch@infradead.org,
        roger.pau@citrix.com, rkrcmar@redhat.com
References: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
 <505290b7-416f-cc97-35ff-e416ceb532c2@oracle.com>
 <911f4739-1a92-8ad3-4c0c-5541312c39fb@redhat.com>
From: Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <798dbae2-89ae-5ce3-9054-34f0f9bf1996@oracle.com>
Date: Wed, 23 May 2018 09:56:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <911f4739-1a92-8ad3-4c0c-5541312c39fb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8902 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=985
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805230165
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/2018 4:31 AM, Paolo Bonzini wrote:
> On 16/05/2018 22:27, Maran Wilson wrote:
>> Friendly ping. I am hopeful one of the x86 and/or KVM maintainers has a
>> few cycles to spare to look this over.
>>
>> And thanks to everyone who has helped thus far by providing valuable
>> feedback and reviewing.
>>
>>     https://lkml.org/lkml/2018/4/16/1002
> KVM bits look fine.  This would be the right time to post the QEMU
> patches...

Thanks Paolo. Yes, we will have the Qemu patches out soon. It is being 
actively worked. We have had one implementation in place, but decided to 
re-implement things slightly based on some preliminary feedback before 
sending it out to the wider community.

Thanks,
-Maran

> Paolo
