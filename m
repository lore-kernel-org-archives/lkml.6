Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756090AbeDQQQn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:16:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755923AbeDQQQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:16:41 -0400
Subject: Re: [PATCH v4 15/15] s390: doc: detailed specifications for AP
 virtualization
To: Cornelia Huck <cohuck@redhat.com>,
        Pierre Morel <pmorel@linux.vnet.ibm.com>, buendgen@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-16-git-send-email-akrowiak@linux.vnet.ibm.com>
 <04a0cf49-71a1-214a-7261-d8e55adee1de@linux.vnet.ibm.com>
 <20180416155353.01bee181.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Tue, 17 Apr 2018 12:16:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180416155353.01bee181.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18041716-0044-0000-0000-00000405F670
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008871; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01019283; UDB=6.00519986; IPR=6.00798524;
 MB=3.00020619; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-17 16:16:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041716-0045-0000-0000-00000837FAC4
Message-Id: <c7c9b2d6-cea6-157c-b5fd-e9ac11705599@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170142
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16/2018 09:53 AM, Cornelia Huck wrote:
> On Mon, 16 Apr 2018 15:13:59 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> On 15/04/2018 23:22, Tony Krowiak wrote:
>>> +* Register with the ap_bus for AP queue devices of type CEX4, CEX5 and
>>> +  CEX6 and to provide the vfio_ap driver's probe and remove callback interfaces.
>> I wonder why the type of card has anything to do with this driver.
>> It should be transparent, the driver should be able to provide the
>> matrix (APM/AQM/ADM)
>> independently from the type of card in the slot.
> Would also be interested why this is limited to certain, newer cards.
> Did some kind of interface change (I dimly recall something like that),
> or are simply no old systems with those older card types around to check
> whether it works?

That was a restriction recommended by our crypto architect.

>
> In either case, a short note would be good (does not need to go into
> any details).

I can do that.

>
