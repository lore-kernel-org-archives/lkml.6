Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeBEG5L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:57:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752228AbeBEG5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:57:02 -0500
Date: Mon, 5 Feb 2018 07:56:51 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com,
        egtvedt@samfundet.no, linus.walleij@linaro.org, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com,
        yamada.masahiro@socionext.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 08/20] s390/kconfig: Remove
 ARCH_WANTS_PROT_NUMA_PROT_NONE select
References: <20180205012146.23981-1-ulfalizer@gmail.com>
 <20180205012146.23981-9-ulfalizer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205012146.23981-9-ulfalizer@gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 18020506-0040-0000-0000-0000042C67F4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020506-0041-0000-0000-000020D01197
Message-Id: <20180205065651.GA4415@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-05_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802050088
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 02:21:20AM +0100, Ulf Magnusson wrote:
> The ARCH_WANTS_PROT_NUMA_PROT_NONE symbol was removed by
> commit 6a33979d5bd7 ("mm: remove misleading ARCH_USES_NUMA_PROT_NONE"),
> but S390 still selects it.
> 
> Remove the ARCH_WANTS_PROT_NUMA_PROT_NONE select from the S390 symbol.
> 
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.
> 
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
>  arch/s390/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks!
