Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754765AbeDTL4I (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 07:56:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754631AbeDTL4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 07:56:06 -0400
Subject: Re: [PATCH 1/4] vfio: ccw: fix cleanup if cp_prefetch fails
To: Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
        Pierre Morel <pmorel@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        borntraeger@de.ibm.com
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
 <20180321020822.86255-2-bjsdjshi@linux.vnet.ibm.com>
 <682d8b1c-5aca-7015-043b-a3f1446bf378@linux.vnet.ibm.com>
 <20180322022248.GB12194@bjsdjshi@linux.vnet.ibm.com>
 <54fd02cd-bd0b-889b-c40f-f9a32aa25d77@linux.vnet.ibm.com>
 <20180326142839.23bfc4f6.cohuck@redhat.com>
 <20180327014200.GH12194@bjsdjshi@linux.vnet.ibm.com>
 <59687ed1-befb-a861-7b91-40859ac00bb7@linux.vnet.ibm.com>
 <20180420133614.20e3c6ae.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 20 Apr 2018 13:55:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180420133614.20e3c6ae.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18042011-0020-0000-0000-00000414124D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042011-0021-0000-0000-000042A86517
Message-Id: <c5416a0f-1506-80cc-7c9f-e1adfeef183a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804200117
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/20/2018 01:36 PM, Cornelia Huck wrote:
> On Fri, 20 Apr 2018 12:54:26 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> ping
>>
>> I think get this fixed. Better sooner than later.

[..]

> 
> Hm, it seems that drowned in other patches... can I get a re-send,
> please?

I guess Dong Jia will handle it. If not I will on Monday.

Regards,
Halil
