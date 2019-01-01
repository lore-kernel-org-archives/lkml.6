Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28338C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 17:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37C72075D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 17:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfAARxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 12:53:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48708 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726203AbfAARxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 12:53:12 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x01Hn0R3059737
        for <linux-kernel@vger.kernel.org>; Tue, 1 Jan 2019 12:53:11 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2prb94b6qn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 12:53:10 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 1 Jan 2019 17:53:10 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 1 Jan 2019 17:53:06 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x01Hr5qg22151328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Jan 2019 17:53:05 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44734B205F;
        Tue,  1 Jan 2019 17:53:05 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2360BB2064;
        Tue,  1 Jan 2019 17:53:04 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Jan 2019 17:53:04 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 843DC16C3373; Tue,  1 Jan 2019 09:53:22 -0800 (PST)
Date:   Tue, 1 Jan 2019 09:53:22 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Junchang Wang <junchangwang@gmail.com>
Cc:     dave@stgolabs.net, josh@joshtriplett.org, corbet@lwn.net,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] whatisRCU.txt: fix outdated links
Reply-To: paulmck@linux.ibm.com
References: <1546351400-16389-1-git-send-email-junchangwang@gmail.com>
 <1546351400-16389-2-git-send-email-junchangwang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546351400-16389-2-git-send-email-junchangwang@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19010117-0040-0000-0000-000004AB0911
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010329; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000272; SDB=6.01140282; UDB=6.00592163; IPR=6.00920497;
 MB=3.00024931; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-01 17:53:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010117-0041-0000-0000-000008B60FDA
Message-Id: <20190101175322.GV4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901010163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2019 at 10:03:19PM +0800, Junchang Wang wrote:
> Fix outdated links in whatisRCU.txt.
> 
> Signed-off-by: Junchang Wang <junchangwang@gmail.com>

Queued and pushed, thank you!

							Thanx, Paul

> ---
>  Documentation/RCU/whatisRCU.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
> index 4a68543..1ace208 100644
> --- a/Documentation/RCU/whatisRCU.txt
> +++ b/Documentation/RCU/whatisRCU.txt
> @@ -302,7 +302,7 @@ rcu_dereference()
>  	must prohibit.	The rcu_dereference_protected() variant takes
>  	a lockdep expression to indicate which locks must be acquired
>  	by the caller. If the indicated protection is not provided,
> -	a lockdep splat is emitted.  See RCU/Design/Requirements.html
> +	a lockdep splat is emitted.  See RCU/Design/Requirements/Requirements.html
>  	and the API's code comments for more details and example usage.
>  
>  The following diagram shows how each API communicates among the
> @@ -560,7 +560,7 @@ presents two such "toy" implementations of RCU, one that is implemented
>  in terms of familiar locking primitives, and another that more closely
>  resembles "classic" RCU.  Both are way too simple for real-world use,
>  lacking both functionality and performance.  However, they are useful
> -in getting a feel for how RCU works.  See kernel/rcupdate.c for a
> +in getting a feel for how RCU works.  See kernel/rcu/update.c for a
>  production-quality implementation, and see:
>  
>  	http://www.rdrop.com/users/paulmck/RCU
> -- 
> 2.7.4
> 

