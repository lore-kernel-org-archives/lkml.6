Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbeCNVWg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 17:22:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751170AbeCNVWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 17:22:34 -0400
References: <0dd9d938-8d89-f0e0-f05f-9a3e5dc42a57@users.sourceforge.net>
User-agent: mu4e 1.0; emacs 25.3.1
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>,
        Josh Sklar <sklar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] powerpc: Use common error handling code in setup_new_fdt()
In-reply-to: <0dd9d938-8d89-f0e0-f05f-9a3e5dc42a57@users.sourceforge.net>
Date: Wed, 14 Mar 2018 18:22:07 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18031421-0040-0000-0000-00000407946F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008675; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003084; UDB=6.00510459; IPR=6.00782414;
 MB=3.00020036; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 21:22:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031421-0041-0000-0000-00000808956D
Message-Id: <87fu52jqtc.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140228
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


SF Markus Elfring <elfring@users.sourceforge.net> writes:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 11 Mar 2018 09:03:42 +0100
>
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/powerpc/kernel/machine_kexec_file_64.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)

I liked it. Thanks!

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
