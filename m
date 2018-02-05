Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752912AbeBELQT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 06:16:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48384 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752870AbeBELQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 06:16:03 -0500
Date: Mon, 5 Feb 2018 11:00:08 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Andi Kleen <ak@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] Fix typo IBRS_ATT, which should be IBRS_ALL
Message-ID: <20180205110008.j42yy4ncs3jogynx@starbug-vm.ie.oracle.com>
References: <20180202191220.blvgkgutojecxr3b@starbug-vm.ie.oracle.com>
 <1517614932.31953.80.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1517614932.31953.80.camel@infradead.org>
User-Agent: NeoMutt/20171215
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8795 signatures=668662
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=806
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802050143
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 11:42:12PM +0000, David Woodhouse wrote:
>On Fri, 2018-02-02 at 19:12 +0000, Darren Kenny wrote:
>> Fixes a typo in commit 117cc7a908c83697b0b737d15ae1eb5943afe35b
>> ("x86/retpoline: Fill return stack buffer on vmexit")
>>
>> Signed-off-by: Darren Kenny <darren.kenny@oracle.com>
>> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>
>Not strictly a typo; that was the original name for it. "IBRS all the
>time". But yes, it should be IBRS_ALL now.
>
>Acked-by: David Woodhouse <dwmw@amazon.co.uk>

Thanks David.

I'll send out another patch with this snippet of information in it
too, and including your Acked-by.

(The subject like will be slightly different)

Thanks,

Darren.
