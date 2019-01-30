Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAE5C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E0D20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfA3PWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:22:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbfA3PWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:22:25 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0UFFFr7024126
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:22:24 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qbeckrfky-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:22:23 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 30 Jan 2019 15:22:22 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 30 Jan 2019 15:22:19 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0UFMIYf23920828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Jan 2019 15:22:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA4C8B2064;
        Wed, 30 Jan 2019 15:22:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D267B205F;
        Wed, 30 Jan 2019 15:22:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.57])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 30 Jan 2019 15:22:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3FC3416C35BC; Wed, 30 Jan 2019 07:22:18 -0800 (PST)
Date:   Wed, 30 Jan 2019 07:22:18 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] rcu docs: repair some whitespace damage
Reply-To: paulmck@linux.ibm.com
References: <20190129220546.12934-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129220546.12934-1-tycho@tycho.ws>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19013015-0040-0000-0000-000004B9BBCD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010504; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153968; UDB=6.00593882; IPR=6.00934342;
 MB=3.00025354; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-30 15:22:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013015-0041-0000-0000-000008C4D133
Message-Id: <20190130152218.GU4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 03:05:46PM -0700, Tycho Andersen wrote:
> While reading the docs I noticed some whitespace damage in diagram. Let's
> fix it up to be consistent with elsewhere in the document: use one leading
> tab, followed by spaces for any additional whitespace required.
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>

Good eyes!  ;-)

Applied, thank you!

							Thanx, Paul

> ---
>  Documentation/RCU/whatisRCU.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
> index 4a6854318b17..419ec18b87bd 100644
> --- a/Documentation/RCU/whatisRCU.txt
> +++ b/Documentation/RCU/whatisRCU.txt
> @@ -310,7 +310,7 @@ reader, updater, and reclaimer.
>  
>  
>  	    rcu_assign_pointer()
> -	    			    +--------+
> +	                            +--------+
>  	    +---------------------->| reader |---------+
>  	    |                       +--------+         |
>  	    |                           |              |
> @@ -318,12 +318,12 @@ reader, updater, and reclaimer.
>  	    |                           |              | rcu_read_lock()
>  	    |                           |              | rcu_read_unlock()
>  	    |        rcu_dereference()  |              |
> -       +---------+                      |              |
> -       | updater |<---------------------+              |
> -       +---------+                                     V
> +	    +---------+                 |              |
> +	    | updater |<----------------+              |
> +	    +---------+                                V
>  	    |                                    +-----------+
>  	    +----------------------------------->| reclaimer |
> -	    				         +-----------+
> +	                                         +-----------+
>  	      Defer:
>  	      synchronize_rcu() & call_rcu()
>  
> -- 
> 2.19.1
> 

