Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503E6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086762082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="epvc3joD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086762082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbeH3MYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:24:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33950 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbeH3MYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:24:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7U8Impv028317;
        Thu, 30 Aug 2018 08:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=OiZs4G6ixA2A/wsOsZoCHq3D71FSNXFqz1lz6LwjJu8=;
 b=epvc3joDO3JP/EZ4XcEjlkSnVKIAlYByvX/r/4+AEt04V3N3J4ERJtLpQpDYvr47k5sW
 Yo0YRNNXTc2+12sIhQttJI3M98jdD75iUXwL2/te2tjeMJbfq99HuX8sA+zV4pzfj8yE
 CqmtmYw1P8YkPJpx95pKjSDu8VazT28PJ2qGtVR/EuRxSdzDZJNJW4M65ZrTMzJqEkMU
 EK1G5eUDGREyXvxaUksX8PfWJQqBJsiaM/MIufO/8KNUIGAqzwnjyR8G/sY2ZdoCENTg
 ew0EQt4fplk2+LE7gcJh7osRGfk7AtpUhGF80HJ1vgzS2lMZQTO78to/W1CGKMFNC1Hy 6A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2m2y2pr3m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 08:23:13 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7U8NCOU005053
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 08:23:13 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7U8NCg4022948;
        Thu, 30 Aug 2018 08:23:12 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 01:23:11 -0700
Date:   Thu, 30 Aug 2018 11:23:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 01/21] staging:rtl8192u: Rename AdvCoding - Style
Message-ID: <20180830082305.umqtq3fdexlyvn65@mwanda>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
 <20180829203547.15650-2-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829203547.15650-2-johnfwhitmore@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9000 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=871
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 09:35:27PM +0100, John Whitmore wrote:
> Rename the bit field element AdvCoding, as it causes a checkpatch issue
> with CamelCase naming. As the element is not actually used in code it
> has been renamed to 'not_used_adv_coding'.
> 
> The single line of code which initialises the bit has been removed,
> as the  field is unused.
> 
> This is a purely coding style change which should have no impact
> on runtime code execution.
> 
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
>  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> index 64d5359cf7e2..66a0274077d3 100644
> --- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> +++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> @@ -39,7 +39,7 @@ enum ht_extension_chan_offset {
>  
>  struct ht_capability_ele {
>  	//HT capability info
> -	u8	AdvCoding:1;
> +	u8	not_used_adv_coding:1;

I can't review any more of this patchset when this is the first line...

:(

regards,
dan carpenter

