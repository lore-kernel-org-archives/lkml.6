Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 58687C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F70208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JPckNE5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F70208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755316AbeFNTl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:41:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43158 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754783AbeFNTly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:41:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5EJd7BN152840;
        Thu, 14 Jun 2018 19:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=WvY3Q8+loLGioZ4ir2o44KKapF8Wh5U0mVrNRbg0gpM=;
 b=JPckNE5ah69iOf6c0h+Ad+Y/HNiRP+GcY2sUr34FEAy4CY2xL7yg9D8MRTGFSno2QJIz
 +Yc8fFYY4ldBE6g0HJ8lqwvioDyr/2uKmfhnfQBRpLQVWfifW6UpHH4X0ceqRysPhlg9
 OomgWfnLfx1705Wy4A3fjIx2F4PR1OsAbDuAMEt6pBGqiMyj/Ljq1JCFbhbsMJ/3mGCT
 K/9SZvggDDJBsB1QN4P2eoEJWCP4bnIeOL6jTJz8T/aybVKQrHs1csJxlRN+XXXFWfXL
 9lsOneNTv0SdfEerjhrsnG0Zbvl7vqQ34ykivJpQtVmi1NFJS14hASqBp5hk+7LR5z5E Rw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2jk0xrefnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 19:41:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5EJfmJ6008900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 19:41:49 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5EJfmut007344;
        Thu, 14 Jun 2018 19:41:48 GMT
Received: from mwanda (/41.202.241.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jun 2018 12:41:47 -0700
Date:   Thu, 14 Jun 2018 22:41:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Javier Martinez <javiermlinux@gmail.com>
Cc:     abbotti@mev.co.uk, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] Staging: comedi: ssv_dnp: Remove unnecessary comment
Message-ID: <20180614194139.ou3cha5pgtvbbm2u@mwanda>
References: <20180614171911.GA1945@javier-Z97X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614171911.GA1945@javier-Z97X>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=690
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806140216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 01:19:12PM -0400, Javier Martinez wrote:
> Removal of a comment that was not needed at all.
> We can clearly see that they are include/header files.
> 
> Signed-off-by: Javier Martinez <javiermlinux@gmail.com>
> ---
>  drivers/staging/comedi/drivers/ssv_dnp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/drivers/ssv_dnp.c b/drivers/staging/comedi/drivers/ssv_dnp.c
> index 0628060e42ca..50de018ab9bb 100644
> --- a/drivers/staging/comedi/drivers/ssv_dnp.c
> +++ b/drivers/staging/comedi/drivers/ssv_dnp.c
> @@ -16,7 +16,6 @@
>   * Status: unknown
>   */
>  
> -/* include files ----------------------------------------------------------- */
>  

You need to remove a blank line or I think checkpatch.pl will complain
if you re-run it over the whole file.  (You aren't allowed to have
multiple blank lines in a row).

regards,
dan carpenter


