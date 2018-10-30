Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19346C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD88920827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD88920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJ3VjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:39:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbeJ3VjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:39:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9UCdTCf125022
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:46:00 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nep2gvj0m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:45:59 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 30 Oct 2018 08:45:58 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 30 Oct 2018 08:45:56 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9UCjtMN33357974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Oct 2018 12:45:55 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7346EB2066;
        Tue, 30 Oct 2018 12:45:55 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53233B205F;
        Tue, 30 Oct 2018 12:45:55 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.194.11])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Oct 2018 12:45:55 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7005116C3120; Tue, 30 Oct 2018 05:45:55 -0700 (PDT)
Date:   Tue, 30 Oct 2018 05:45:55 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] doc: correct parameter in stallwarn
Reply-To: paulmck@linux.ibm.com
References: <20181030051559.256849-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030051559.256849-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18103012-0068-0000-0000-00000355FFA5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009953; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01110134; UDB=6.00575196; IPR=6.00890226;
 MB=3.00023963; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-30 12:45:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103012-0069-0000-0000-000046403770
Message-Id: <20181030124555.GD4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=963 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810300111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:15:59PM -0700, Joel Fernandes (Google) wrote:
> The stallwarn document incorrectly mentions 'fps=' instead of 'fqs='.
> Correct that.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Good catch, queued, thank you!

							Thanx, Paul

> ---
>  Documentation/RCU/stallwarn.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/stallwarn.txt b/Documentation/RCU/stallwarn.txt
> index b01bcafc64aa..073dbc12d1ea 100644
> --- a/Documentation/RCU/stallwarn.txt
> +++ b/Documentation/RCU/stallwarn.txt
> @@ -205,7 +205,7 @@ handlers are no longer able to execute on this CPU.  This can happen if
>  the stalled CPU is spinning with interrupts are disabled, or, in -rt
>  kernels, if a high-priority process is starving RCU's softirq handler.
>  
> -The "fps=" shows the number of force-quiescent-state idle/offline
> +The "fqs=" shows the number of force-quiescent-state idle/offline
>  detection passes that the grace-period kthread has made across this
>  CPU since the last time that this CPU noted the beginning of a grace
>  period.
> -- 
> 2.19.1.568.g152ad8e336-goog
> 

