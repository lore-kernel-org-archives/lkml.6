Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C25C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E332147C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E332147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbeLBHvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:51:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725726AbeLBHvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 02:51:01 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB1KXhVp099085
        for <linux-kernel@vger.kernel.org>; Sat, 1 Dec 2018 15:37:39 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p3pg6vbn3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 15:37:38 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 1 Dec 2018 20:37:37 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 1 Dec 2018 20:37:34 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB1KbXQw19923146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 1 Dec 2018 20:37:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9D82B2064;
        Sat,  1 Dec 2018 20:37:33 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7A39B2066;
        Sat,  1 Dec 2018 20:37:33 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.206.214])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat,  1 Dec 2018 20:37:33 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 01B1016C1B3E; Sat,  1 Dec 2018 12:37:33 -0800 (PST)
Date:   Sat, 1 Dec 2018 12:37:33 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com
Subject: Re: [PATCH] locktorture: style fix - spaces required around
Reply-To: paulmck@linux.ibm.com
References: <20181201084039.46125-1-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181201084039.46125-1-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18120120-2213-0000-0000-00000322EBD5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010154; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01125569; UDB=6.00584482; IPR=6.00905696;
 MB=3.00024410; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-01 20:37:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120120-2214-0000-0000-00005C73FFBD
Message-Id: <20181201203733.GX4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812010190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2018 at 04:40:39PM +0800, Wen Yang wrote:
> This patch fixes the following checkpatch.pl errors:
> 
> ERROR: spaces required around that ':' (ctx:VxW)
> +                torture_type, tag, cxt.debug_lock ? " [debug]": "",
>                                                                ^
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> CC: Davidlohr Bueso <dave@stgolabs.net>
> CC: "Paul E. McKenney" <paulmck@linux.ibm.com>
> CC: Josh Triplett <josh@joshtriplett.org>
> CC: linux-kernel@vger.kernel.org

Adding the current maintainers on CC.

							Thanx, Paul

> ---
>  kernel/locking/locktorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index cd95c01491d8..d1d8356b770a 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -790,7 +790,7 @@ lock_torture_print_module_parms(struct lock_torture_ops *cur_ops,
>  {
>  	pr_alert("%s" TORTURE_FLAG
>  		 "--- %s%s: nwriters_stress=%d nreaders_stress=%d stat_interval=%d verbose=%d shuffle_interval=%d stutter=%d shutdown_secs=%d onoff_interval=%d onoff_holdoff=%d\n",
> -		 torture_type, tag, cxt.debug_lock ? " [debug]": "",
> +		 torture_type, tag, cxt.debug_lock ? " [debug]" : "",
>  		 cxt.nrealwriters_stress, cxt.nrealreaders_stress, stat_interval,
>  		 verbose, shuffle_interval, stutter, shutdown_secs,
>  		 onoff_interval, onoff_holdoff);
> -- 
> 2.19.1
> 

