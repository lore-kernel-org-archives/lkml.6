Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9011FC282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670612145D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfBJUcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:32:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725971AbfBJUcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:32:41 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1AKSWRP065499
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 15:32:39 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qjrwa4nrx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 15:32:39 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 10 Feb 2019 20:32:38 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 10 Feb 2019 20:32:36 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1AKWZfW24117460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Feb 2019 20:32:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2570FB2066;
        Sun, 10 Feb 2019 20:32:35 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03E6CB2065;
        Sun, 10 Feb 2019 20:32:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.196.105])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 10 Feb 2019 20:32:34 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7FA9816C35A3; Sun, 10 Feb 2019 12:32:35 -0800 (PST)
Date:   Sun, 10 Feb 2019 12:32:35 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: rectify two issues in KEYS-TRUSTED entry
Reply-To: paulmck@linux.ibm.com
References: <20190210190009.9995-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210190009.9995-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19021020-0064-0000-0000-000003A6BD6E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010572; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01159183; UDB=6.00604896; IPR=6.00939720;
 MB=3.00025517; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-10 20:32:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021020-0065-0000-0000-00003C5EE468
Message-Id: <20190210203235.GN4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-10_17:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902100158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 08:00:09PM +0100, Lukas Bulwahn wrote:
> Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen as
> further maintainer to the KEYS-TRUSTED section entry. Paul McKenney also
> introduced a typo in Mimi Zohar's email address in the KEYS-TRUSTED section
> entry.
> 
> The two issues were detected when writing a script that parses MAINTAINERS.
> 
> Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for trusted keys")
> Fixes: 1dfddcdb95c4 ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com")
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Good catch!

Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>

> ---
> Mimi, please pick up this patch instead of
>   "[PATCH] MAINTAINERS: use tab instead of spaces". Thanks.
> 
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf4965d6d5de..b4b62ea78eeb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8405,8 +8405,8 @@ F:	security/keys/encrypted-keys/
> 
>  KEYS-TRUSTED
>  M:	James Bottomley <jejb@linux.ibm.com>
> -M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> -M:	Mimi Zohar <zohar@linuxibm.com>
> +M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> +M:	Mimi Zohar <zohar@linux.ibm.com>
>  L:	linux-integrity@vger.kernel.org
>  L:	keyrings@vger.kernel.org
>  S:	Supported
> -- 
> 2.17.1
> 

