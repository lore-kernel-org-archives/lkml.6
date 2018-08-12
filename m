Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70B5C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 23:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25ADA21918
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 23:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25ADA21918
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeHMCPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 22:15:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727869AbeHMCPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 22:15:51 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7CNYAAd009911
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 19:36:11 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ktxjb06td-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 19:36:11 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 12 Aug 2018 19:36:10 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 12 Aug 2018 19:36:07 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7CNa6Kl56885330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 12 Aug 2018 23:36:06 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2331B2066;
        Sun, 12 Aug 2018 19:35:24 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1FF4B205F;
        Sun, 12 Aug 2018 19:35:24 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.219.61])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 12 Aug 2018 19:35:24 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id ABA0C16C14D8; Sun, 12 Aug 2018 16:36:08 -0700 (PDT)
Date:   Sun, 12 Aug 2018 16:36:08 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model: Fix a couple of typos
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180812052928.32354-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180812052928.32354-1-sj38.park@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18081223-0040-0000-0000-0000045DB89A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009532; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01072650; UDB=6.00552616; IPR=6.00852599;
 MB=3.00022676; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-12 23:36:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081223-0041-0000-0000-00000864BFAE
Message-Id: <20180812233608.GK24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808120263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 02:29:28PM +0900, SeongJae Park wrote:
> This commit fixes a couple of typos in README and recipies.txt.
> 
> Signed-off-by: SeongJae Park <sj38.park@gmail.com>

Good catch on the first "The the"!  (Why say it once when you can say
it twice?)

On the second, the quoted output doesn't have a comma, so the quote of
that output also needs not to have a comma.  So I applied the first
patch and left out the second.  But please let me know if I am missing
something.

							Thanx, Paul

> ---
>  tools/memory-model/Documentation/recipes.txt | 2 +-
>  tools/memory-model/README                    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
> index a40802fa1099..29df496c1c77 100644
> --- a/tools/memory-model/Documentation/recipes.txt
> +++ b/tools/memory-model/Documentation/recipes.txt
> @@ -311,7 +311,7 @@ The smp_wmb() macro orders prior stores against later stores, and the
>  smp_rmb() macro orders prior loads against later loads.  Therefore, if
>  the final value of r0 is 1, the final value of r1 must also be 1.
> 
> -The the xlog_state_switch_iclogs() function in fs/xfs/xfs_log.c contains
> +The xlog_state_switch_iclogs() function in fs/xfs/xfs_log.c contains
>  the following write-side code fragment:
> 
>  	log->l_curr_block -= log->l_logBBsize;
> diff --git a/tools/memory-model/README b/tools/memory-model/README
> index ee987ce20aae..73313faf4036 100644
> --- a/tools/memory-model/README
> +++ b/tools/memory-model/README
> @@ -89,7 +89,7 @@ The corresponding output includes:
>    Observation SB+fencembonceonces Never 0 2000000
>    Time SB+fencembonceonces 0.16
> 
> -The "Positive: 0 Negative: 2000000" and the "Never 0 2000000" indicate
> +The "Positive: 0, Negative: 2000000" and the "Never 0 2000000" indicate
>  that during two million trials, the state specified in this litmus
>  test's "exists" clause was not reached.
> 
> -- 
> 2.13.0
> 

