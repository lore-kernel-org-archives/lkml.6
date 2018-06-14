Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 40CE0C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA54F20020
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QdGn41TF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA54F20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755266AbeFNNqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:46:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43216 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754965AbeFNNqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:46:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5EDhtTG070092;
        Thu, 14 Jun 2018 13:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=mIDKYxqDnqGgu2cbk5F1TWltEojxF6W28Fjd0XSW1yM=;
 b=QdGn41TF+xCgVNCoh75n2lvTYaPhnwtpID+fuBUCGD2k+reCAsv+0ZW+9U5sRWaMgfxN
 eEqU9XSxD5kTkZTx4hv8tZuhUQbVHhAwU0oqM/mXAFghNkUuNcXWaZ/3YH+bHtSBNTWG
 zY14eBH1Cw2QFkdU1yxiSkCVqLcQgss2d97MyMDe1To5DBOQKaLc2hrwKy944/MiQ4CM
 2k5BIvIT0nNUE86JYnOfUNCPeuGEsm1AcRzHcwADG0yqWN+loskJQqRXgrK3pBv3UBGu
 NiTRd6qUICgQ/9cqrJCAgekGl/13RxtApaPPFyZRCpNc5Jgv99vJ7CVKLbgqf6rkoT6S XA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2jk0xrd62j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 13:46:39 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5EDkcqn030090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 13:46:38 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5EDkbYC026152;
        Thu, 14 Jun 2018 13:46:37 GMT
Received: from mwanda (/41.202.241.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jun 2018 06:46:36 -0700
Date:   Thu, 14 Jun 2018 16:46:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Javier Martinez <javiermlinux@gmail.com>
Cc:     abbotti@mev.co.uk, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] Staging: comedi: ssv_dnp: fixed style line length warning
Message-ID: <20180614134623.235jmndljwij3vh2@mwanda>
References: <20180613190108.GA14435@javier-Z97X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613190108.GA14435@javier-Z97X>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8923 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=820
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806140154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 03:01:08PM -0400, Javier Martinez wrote:
> Fixed style line length warning detected by checkpatch.pl in the file
> ssv_dnp.c.
> 
> Signed-off-by: Javier Martinez <javiermlinux@gmail.com>
> ---
>  drivers/staging/comedi/drivers/ssv_dnp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/drivers/ssv_dnp.c b/drivers/staging/comedi/drivers/ssv_dnp.c
> index 0628060e42ca..87f46e0eb9ee 100644
> --- a/drivers/staging/comedi/drivers/ssv_dnp.c
> +++ b/drivers/staging/comedi/drivers/ssv_dnp.c
> @@ -16,7 +16,7 @@
>   * Status: unknown
>   */
>  
> -/* include files ----------------------------------------------------------- */
> +/* include files ------------------------------------------------------ */

Just delete the line.  It's not useful.

regards,
dan carpenter


