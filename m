Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754904AbeEWSV7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:21:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754820AbeEWSV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:21:58 -0400
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Balbir Singh <bsingharora@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Breno Leitao <leitao@debian.org>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/xmon: Also setup debugger hooks when single-stepping
In-Reply-To: <20180523180054.9937-1-msuchanek@suse.de>
References: <20180523180054.9937-1-msuchanek@suse.de>
Date: Wed, 23 May 2018 23:51:45 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18052318-0008-0000-0000-000004FA6395
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052318-0009-0000-0000-00001E8E6845
Message-Id: <877enuxmfa.fsf@vajain21.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230178
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Suchanek <msuchanek@suse.de> writes:

> When single-stepping kernel code from xmon without a debug hook enabled
> the kernel crashes. This can happen when kernel starts with xmon on
> crash disabled but xmon is entered using sysrq.
>
> Call force_enable_xmon when single-stepping in xmon to install the xmon
> debug hooks.
>
> Fixes: e1368d0c9edb ("powerpc/xmon: Setup debugger hooks when first
> break-point is set")
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
LGTM,

Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>

-- 
Vaibhav Jain <vaibhav@linux.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
