Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbeCNVMe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 17:12:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750950AbeCNVMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 17:12:33 -0400
Subject: Re: [PATCH 1/2, pci] pci: Addition of PCI_DEV_FLAGS_QUIET_PCI_REALIGN
 attribute to the PCI subsystem
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        ruscur@russell.cc, aik@ozlabs.ru, david@gibson.dropbear.id.au,
        fbarrat@linux.vnet.ibm.com, brking@linux.vnet.ibm.com
References: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com>
 <20180314163455.15854-2-desnesn@linux.vnet.ibm.com>
 <20180314180642.GC179719@bhelgaas-glaptop.roam.corp.google.com>
 <30c63477-620b-3f8b-82df-fd1e34cd99b8@linux.vnet.ibm.com>
 <20180314185508.GE179719@bhelgaas-glaptop.roam.corp.google.com>
From: =?UTF-8?Q?Desnes_Augusto_Nunes_do_Ros=c3=a1rio?=
        <desnesn@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 18:12:23 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180314185508.GE179719@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18031421-0056-0000-0000-0000042D9175
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008674; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003080; UDB=6.00510457; IPR=6.00782410;
 MB=3.00020036; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 21:12:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031421-0057-0000-0000-0000086F9281
Message-Id: <442e2ae9-9423-8bf3-a7c1-a35381781145@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140226
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/14/2018 03:55 PM, Bjorn Helgaas wrote:

>>> As far as I'm concerned, we can just remove these messages completely.
>>> I don't think there's any real value there.
>>
>> After I found out that this was happening to all PCI devices on powerpc due
>> to the __weak
>> pcibios_default_alignment() interface (necessary for VFIO passthrough and
>> performance), I confess that this was my first approach to this matter;
>> however I couldn't vouch the need of these messages on other architectures.
>>
>> If there are no further concerns, I definitely prefer sending a second
>> version of this patch only eliminating these messages and attesting the
>> reason why.
>>
>> Thank you very much for your review Bjorn,
> 
> No problem, welcome to PCI, and I hope we see more of your work!

Bjorn,

Awesome! A second version of this fix has been sent with a new title: 
"[PATCH, pci, v2] pci: Delete PCI disabling informational messages"

Thanks for the review and warm welcome!

-- 
Desnes A. Nunes do Rosário
--------------------------
