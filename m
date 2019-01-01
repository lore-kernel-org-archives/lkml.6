Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9480C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 17:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7D32075D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 17:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbfAARy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 12:54:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726190AbfAARy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 12:54:59 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x01HsD93093131
        for <linux-kernel@vger.kernel.org>; Tue, 1 Jan 2019 12:54:57 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pr54n0dxc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 12:54:57 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 1 Jan 2019 17:54:57 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 1 Jan 2019 17:54:54 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x01Hsrxg17694774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Jan 2019 17:54:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 159C5B2065;
        Tue,  1 Jan 2019 17:54:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7EC6B2064;
        Tue,  1 Jan 2019 17:54:52 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Jan 2019 17:54:52 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5F06416C3373; Tue,  1 Jan 2019 09:55:10 -0800 (PST)
Date:   Tue, 1 Jan 2019 09:55:10 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Junchang Wang <junchangwang@gmail.com>
Cc:     dave@stgolabs.net, josh@joshtriplett.org, corbet@lwn.net,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] torture.txt: update the list of supported torture
 types
Reply-To: paulmck@linux.ibm.com
References: <1546351400-16389-1-git-send-email-junchangwang@gmail.com>
 <1546351400-16389-3-git-send-email-junchangwang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546351400-16389-3-git-send-email-junchangwang@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19010117-0064-0000-0000-0000038EDE5B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010329; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000272; SDB=6.01140283; UDB=6.00593363; IPR=6.00920498;
 MB=3.00024931; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-01 17:54:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010117-0065-0000-0000-00003BDE8B0B
Message-Id: <20190101175510.GW4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901010164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2019 at 10:03:20PM +0800, Junchang Wang wrote:
> Torture types "rcu_bh" and "sched" were removed in commit "c770c82a23".
> The name of torture type "rcu_busted" was changed to "busted" in commit
> "b3c983142d". Two other types, "srcud" and "busted_srcud" were added in
> commits "ca1d51ed98" and "2397d072f7", respectively. This patch updates
> torture.txt accordingly.
> 
> Signed-off-by: Junchang Wang <junchangwang@gmail.com>

Given that this section of this file duplicates the rcutorture kernel boot
parameters called out in Documentation/admin-guide/kernel-parameters.txt,
perhaps the best way forward is to instead remove this information from
Documentation/RCU/torture.txt in favor of a reference to the information
(with search string) in Documentation/admin-guide/kernel-parameters.txt.

Thoughts?

							Thanx, Paul

> ---
>  Documentation/RCU/torture.txt | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/RCU/torture.txt b/Documentation/RCU/torture.txt
> index 55918b5..6395f0b 100644
> --- a/Documentation/RCU/torture.txt
> +++ b/Documentation/RCU/torture.txt
> @@ -155,20 +155,19 @@ torture_type	The type of RCU to test, with string values as follows:
>  			along with expedited, synchronous, and polling
>  			variants.
>  
> -		"rcu_bh": rcu_read_lock_bh(), rcu_read_unlock_bh(), and
> -			call_rcu_bh(), along with expedited and synchronous
> -			variants.
> -
> -		"rcu_busted": This tests an intentionally incorrect version
> +		"busted": This tests an intentionally incorrect version
>  			of RCU in order to help test rcutorture itself.
>  
>  		"srcu": srcu_read_lock(), srcu_read_unlock() and
>  			call_srcu(), along with expedited and
>  			synchronous variants.
>  
> -		"sched": preempt_disable(), preempt_enable(), and
> -			call_rcu_sched(), along with expedited,
> -			synchronous, and polling variants.
> +		"srcud": A second form of srcu that dynamically allocates
> +			and frees srcu_struct to test srcu cleanup code path.
> +
> +		"busted_srcud": This torture type verifies rcutorture's ability
> +			to detect extensions of RCU read-side critical sections
> +			that are not handled.
>  
>  		"tasks": voluntary context switch and call_rcu_tasks(),
>  			along with expedited and synchronous variants.
> -- 
> 2.7.4
> 

