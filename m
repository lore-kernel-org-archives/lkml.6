Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754369AbeEaKL5 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:11:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56708 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754227AbeEaKL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:11:56 -0400
Date: Thu, 31 May 2018 15:41:48 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc: Add support for function error injection
To: Josef Bacik <jbacik@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
        <5ad23690185a90a887514d702ecb45783090d7c0.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
        <87h8mozajv.fsf@concordia.ellerman.id.au>
In-Reply-To: <87h8mozajv.fsf@concordia.ellerman.id.au>
User-Agent: astroid/0.11.1 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18053110-0028-0000-0000-000002CB4DCF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053110-0029-0000-0000-00002381BE9E
Message-Id: <1527761352.z5jz8jg2d5.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-31_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=753 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805310117
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>> ...
> 
> A change log is always nice even if it's short :)

I tried, but really couldn't come up with anything more to write. I'll 
try harder for v2 :)

> 
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/Kconfig                       | 1 +
>>  arch/powerpc/include/asm/error-injection.h | 9 +++++++++
>>  arch/powerpc/include/asm/ptrace.h          | 5 +++++
>>  3 files changed, 15 insertions(+)
>>  create mode 100644 arch/powerpc/include/asm/error-injection.h
> 
> This looks fine to me, it's probably easiest if it goes in via tip along
> with patch 1.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks for the review. I'll base v2 on -tip


- Naveen
