Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755485AbeEHQ11 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:27:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755349AbeEHQ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:27:26 -0400
Date: Tue, 8 May 2018 09:27:15 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com
Subject: Re: [PATCH 4/8] mm/pkeys, powerpc, x86: Provide an empty vma_pkey()
 in linux/pkeys.h
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180508145948.9492-1-mpe@ellerman.id.au>
 <20180508145948.9492-5-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508145948.9492-5-mpe@ellerman.id.au>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18050816-0008-0000-0000-000004F47248
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050816-0009-0000-0000-00001E88B4F6
Message-Id: <20180508162715.GB5474@ram.oc3035372033.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805080158
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 12:59:44AM +1000, Michael Ellerman wrote:
> Consolidate the pkey handling by providing a common empty definition
> of vma_pkey() in pkeys.h when CONFIG_ARCH_HAS_PKEYS=n.
> 
> This also removes another entanglement of pkeys.h and
> asm/mmu_context.h.
>

Reviewed-by: Ram Pai <linuxram@us.ibm.com>


> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/mmu_context.h | 5 -----
>  arch/x86/include/asm/mmu_context.h     | 5 -----
>  include/linux/pkeys.h                  | 5 +++++
>  3 files changed, 5 insertions(+), 10 deletions(-)

RP
