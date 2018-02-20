Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbeBTNpg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:45:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750732AbeBTNpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:45:35 -0500
Subject: Re: [PATCH v3 0/3] Enable CONFIG_VT support for S390
To: Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, tomi.valkeinen@ti.com, thuth@redhat.com,
        b.zolnierkie@samsung.com
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
 <c4319571-96fd-8f5b-68e3-c06b7968203f@de.ibm.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Tue, 20 Feb 2018 08:45:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <c4319571-96fd-8f5b-68e3-c06b7968203f@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022013-0024-0000-0000-0000032981A7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008563; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992492; UDB=6.00504227; IPR=6.00771838;
 MB=3.00019655; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-20 13:45:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022013-0025-0000-0000-00004716FB7A
Message-Id: <276a4dfc-c234-0576-ee52-08ac2748c610@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802200176
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/20/2018 04:43 AM, Christian Borntraeger wrote:
> Added to my linux next tree to check for any fallout.
> 
Thanks!
