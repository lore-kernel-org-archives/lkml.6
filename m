Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFA5C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C97F2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C97F2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeJPBWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:22:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726588AbeJPBWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:22:46 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9FHTA86027144
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 13:36:33 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n4w32eu0m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 13:36:33 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 15 Oct 2018 13:36:31 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Oct 2018 13:36:29 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9FHaSBx23134310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Oct 2018 17:36:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25EDFB2065;
        Mon, 15 Oct 2018 13:34:24 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0882CB2064;
        Mon, 15 Oct 2018 13:34:24 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.109])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 15 Oct 2018 13:34:23 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 40F9A16C0EC1; Mon, 15 Oct 2018 10:36:33 -0700 (PDT)
Date:   Mon, 15 Oct 2018 10:36:33 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: rcu: Fix code listing in performance and
 scalability requirements
Reply-To: paulmck@linux.ibm.com
References: <20181015022942.224250-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015022942.224250-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18101517-0040-0000-0000-00000480E003
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009881; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01103107; UDB=6.00570957; IPR=6.00883159;
 MB=3.00023765; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-15 17:36:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101517-0041-0000-0000-00000888F548
Message-Id: <20181015173633.GA2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 07:29:42PM -0700, Joel Fernandes (Google) wrote:
> The code listing under this section has a quick quiz that says line 19
> uses rcu_access_pointer, but the code listing itself does not. Fix this.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Good eyes!  Queued for the merge window after this coming one,
thank you!

							Thanx, Paul

> ---
>  .../RCU/Design/Requirements/Requirements.html    |  2 +-
>  kernel/sys.c                                     | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
> index 4fae55056c1d..f74a2233865c 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.html
> +++ b/Documentation/RCU/Design/Requirements/Requirements.html
> @@ -1596,7 +1596,7 @@ used in place of <tt>synchronize_rcu()</tt> as follows:
>  16   struct foo *p;
>  17
>  18   spin_lock(&amp;gp_lock);
> -19   p = rcu_dereference(gp);
> +19   p = rcu_access_pointer(gp);
>  20   if (!p) {
>  21     spin_unlock(&amp;gp_lock);
>  22     return false;
> -- 
> 2.19.0.605.g01d371f741-goog
> 

