Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeERN20 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:28:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751526AbeERN2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:28:24 -0400
Subject: Re: [PATCH v3] vfio/mdev: Check globally for duplicate devices
To: Cornelia Huck <cohuck@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: kwankhede@nvidia.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dong Jia Shi <bjsdjshi@linux.ibm.com>
References: <20180517031746.32242.17768.stgit@gimli.home>
 <20180517100928.5949b11e.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 18 May 2018 15:28:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517100928.5949b11e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18051813-0008-0000-0000-000004F7EE0A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051813-0009-0000-0000-00001E8C6B0C
Message-Id: <a8747941-9d6c-9a45-46d2-3a4dd8431726@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805180147
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/17/2018 10:09 AM, Cornelia Huck wrote:
> [Dong Jia, Halil: Can you please take a look whether vfio-ccw is really
> ok? I don't think we open up any new races, but I'd appreciate a second
> or third opinion.]

I will wait for things to settle a bit before I start reviewing the synchronization
for mdev and vfio-ccw. I suspect there will be a v4. I would appreciate a cc,
so I don't miss it.

Halil
