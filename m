Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AF3C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 07:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBEB21477
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 07:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0fBlIeUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBEB21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeHYKxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 06:53:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46534 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeHYKxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 06:53:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7P7EJh2148927;
        Sat, 25 Aug 2018 07:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=gSgbc5GuUqwRnCT033BgqzzRFRBIwkuqk3Si4UeEGYw=;
 b=0fBlIeUaCLSWpXJkilGorvG5np7cx11vP9gtuXyI5FltG0mK4ia4qbMvzLsUuXusyZWP
 kmOq0K/ryxa136mc/B8Z+ViqcetIWMPv6DHYDshcTRxOBtnSsagpuUwYB2AqZJrde5F7
 LhoSGt3DJsrBJFU9ZMbCcfF2QeWPqqR/eJmOuBST4M+lNe123J/1YZv4lEOI9zjRFdhW
 xL1/bOrS67qQV2c6d1f08QjZbidofrPk/SaZ7IqUl0pkgoZ1RRbbeFvHnkry8VvbuEsz
 jne1lsTxz/tcalhUAm7tD/D4zlxR35/KWhg941HfiUSTT8M+l7Jq6a9m56Tp8VpHo+BQ yw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2m2y2p07ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Aug 2018 07:15:43 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7P7FgOR000470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Aug 2018 07:15:42 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7P7FflZ004573;
        Sat, 25 Aug 2018 07:15:41 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 25 Aug 2018 00:15:41 -0700
Date:   Sat, 25 Aug 2018 10:15:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     GuyLuz <guyluz50@gmail.com>
Cc:     devel@driverdev.osuosl.org, guyluz11@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: cb_pcidas64 fixed '('  coding style
 issue
Message-ID: <20180825071535.igoxbyleusti6wyu@mwanda>
References: <20180824230701.9029-1-guyluz50@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824230701.9029-1-guyluz50@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8995 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808250077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 02:07:01AM +0300, GuyLuz wrote:
> From: Guy Luz <guyluz50@gmail.com>
> 
> Fixed a  Lines should not end with a '(' issue.
> 
> Signed-off-by: Guy Luz <guyluz50@gmail.com>
> ---
>  drivers/staging/comedi/drivers/cb_pcidas64.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/cb_pcidas64.c b/drivers/staging/comedi/drivers/cb_pcidas64.c
> index 63992c0babf7..a85334f53ff9 100644
> --- a/drivers/staging/comedi/drivers/cb_pcidas64.c
> +++ b/drivers/staging/comedi/drivers/cb_pcidas64.c
> @@ -2173,10 +2173,9 @@ static int ai_cmdtest(struct comedi_device *dev, struct comedi_subdevice *s,
>  			 * allows
>  			 */
>  			if (cmd->scan_begin_src == TRIG_TIMER) {
> -				err |= comedi_check_trigger_arg_min(
> -						&cmd->scan_begin_arg,
> -						cmd->convert_arg *
> -						cmd->chanlist_len);
> +				err |= comedi_check_trigger_arg_min
> +				(&cmd->scan_begin_arg, cmd->convert_arg *
> +				cmd->chanlist_len);

The original is better than the new version.  Please leave it as is.

regards,
dan carpenter

