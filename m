Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935442AbeEYGxr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 02:53:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751960AbeEYGxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 02:53:46 -0400
Subject: Re: [PATCH] powerpc/modules: remove unused mod_arch_specific.toc
 field
To: Josh Poimboeuf <jpoimboe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <2892e4f57d03caf1b3d6c14bc456b2f9a116b32a.1527220066.git.jpoimboe@redhat.com>
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Fri, 25 May 2018 12:23:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2892e4f57d03caf1b3d6c14bc456b2f9a116b32a.1527220066.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18052506-0044-0000-0000-0000055686F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052506-0045-0000-0000-000028988DA2
Message-Id: <872c9b94-62ea-c9cc-78aa-09ae74e44d0c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-25_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805250084
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 May 2018 09:18 AM, Josh Poimboeuf wrote:
> The toc field in the mod_arch_specific struct isn't actually used
> anywhere, so remove it.
> 
> Also the ftrace-specific fields are now common between 32-bit and
> 64-bit, so simplify the struct definition a bit by moving them out of
> the __powerpc64__ #ifdef.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
