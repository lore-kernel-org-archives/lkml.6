Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754680AbeDPLM7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 07:12:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753252AbeDPLM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 07:12:57 -0400
Subject: Re: [PATCH v4 05/15] KVM: s390: enable/disable AP interpretive
 execution
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-6-git-send-email-akrowiak@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 16 Apr 2018 13:12:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1523827345-11600-6-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041611-0008-0000-0000-000004EB0E58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041611-0009-0000-0000-00001E7F24BF
Message-Id: <dbd7a1fa-a5c4-a931-5606-e9e2301589f2@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160106
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/15/2018 11:22 PM, Tony Krowiak wrote:
> The VFIO AP device model exploits interpretive execution of AP
> instructions (APIE) to provide guests passthrough access to AP
> devices. This patch introduces a new interface to enable and
> disable APIE.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>

LGTM, but should be squashed into #4. (Like this you have a
kernel that supports the cpu model feature 'ap' but does not
do 'interpretation is default'.) 
