Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44271C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 17:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA60424C90
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 17:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA60424C90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751543AbeFWRE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 13:04:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751345AbeFWREZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 13:04:25 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5NH3jCe027432
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 13:04:25 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jsjrf45a7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 13:04:25 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 23 Jun 2018 13:04:23 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 23 Jun 2018 13:04:20 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5NH4KDl4194732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 23 Jun 2018 17:04:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C18DFB2065;
        Sat, 23 Jun 2018 13:04:17 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C48DB205F;
        Sat, 23 Jun 2018 13:04:17 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.148.28])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 23 Jun 2018 13:04:17 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D0FB016C69EF; Sat, 23 Jun 2018 10:06:22 -0700 (PDT)
Date:   Sat, 23 Jun 2018 10:06:22 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Documentation: RCU: Fix broken link to LKML archive
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180623044055.118383-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180623044055.118383-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062317-2213-0000-0000-000002BF0655
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009247; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01051236; UDB=6.00538806; IPR=6.00829908;
 MB=3.00021826; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-23 17:04:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062317-2214-0000-0000-00005A955C28
Message-Id: <20180623170622.GC3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806230204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 09:40:55PM -0700, Joel Fernandes wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> While going through the RCU requirements for interrupts, I noticed that
> one of the LKML links is broken. This patch changes it to use the
> archive from lore.kernel.org which works fine.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Good catch, queued for further review, thank you!

							Thanx, Paul

> ---
>  Documentation/RCU/Design/Requirements/Requirements.html | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
> index 9b808402f8ce..58b6557007a3 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.html
> +++ b/Documentation/RCU/Design/Requirements/Requirements.html
> @@ -2269,10 +2269,10 @@ Thankfully, RCU update-side primitives, including
>  The name notwithstanding, some Linux-kernel architectures
>  can have nested NMIs, which RCU must handle correctly.
>  Andy Lutomirski
> -<a href="https://lkml.kernel.org/g/CALCETrXLq1y7e_dKFPgou-FKHB6Pu-r8+t-6Ds+8=va7anBWDA@mail.gmail.com">surprised me</a>
> +<a href="https://lkml.kernel.org/r/CALCETrXLq1y7e_dKFPgou-FKHB6Pu-r8+t-6Ds+8=va7anBWDA@mail.gmail.com">surprised me</a>
>  with this requirement;
>  he also kindly surprised me with
> -<a href="https://lkml.kernel.org/g/CALCETrXSY9JpW3uE6H8WYk81sg56qasA2aqmjMPsq5dOtzso=g@mail.gmail.com">an algorithm</a>
> +<a href="https://lkml.kernel.org/r/CALCETrXSY9JpW3uE6H8WYk81sg56qasA2aqmjMPsq5dOtzso=g@mail.gmail.com">an algorithm</a>
>  that meets this requirement.
> 
>  <p>
> -- 
> 2.18.0.rc2.346.g013aa6912e-goog
> 

