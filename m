Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753908AbeDYLUE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:20:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50656 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753378AbeDYLT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:19:57 -0400
Subject: Re: [PATCH v2 1/5] vfio: ccw: fix cleanup if cp_prefetch fails
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com,
        pmorel@linux.ibm.com, Halil Pasic <pasic@linux.vnet.ibm.com>
References: <20180423110113.59385-1-bjsdjshi@linux.vnet.ibm.com>
 <20180423110113.59385-2-bjsdjshi@linux.vnet.ibm.com>
 <20180424113147.139e2e0b.cohuck@redhat.com>
 <20180425024341.GY12194@bjsdjshi@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 25 Apr 2018 13:19:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180425024341.GY12194@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18042511-0040-0000-0000-00000432B04C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042511-0041-0000-0000-00002636E4EE
Message-Id: <584f24d1-2dc1-4100-7919-3314b8142534@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804250108
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/25/2018 04:43 AM, Dong Jia Shi wrote:
>> [Some procedural notes: I've created a new vfio-ccw-fixes branch based
>> on the s390 fixes branch for easier handling. Things targeted for the
>> next release will go on the vfio-ccw branch on top of the s390 features
>> branch, as before. Does that work for everybody?
> I don't see a reason that why it doesn't work for me.
> 

Works for me.

>> (And I am the only vfio-ccw maintainer with a kernel.org account,
>> right?)]
>>
> I don't have such an account, and don't know if I need to apply for one.

Neither do I have a kernel.org account -- at least for now.

Regards,
Halil
