Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C057FC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DCE20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oFkK+371"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64DCE20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933232AbeFTIxe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:53:34 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37152 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754586AbeFTIxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:53:18 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5K8nNfg181788;
        Wed, 20 Jun 2018 08:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=M/Q9RQQU7iqyWRIeq0B3daN8wStWMWosnZP+qO45Ye4=;
 b=oFkK+371zjp6EiCCJ8afXlwbjGc8gZ9CrQVqIYrLbeRSq9gAanxkJbvSIAhrcAKDR0UG
 A6rIk4mEZuK6ODtCvJAdkSkRA++pUPfhDAg4LA3xsg1vWdgqfomGh4NgrkIlW1cqgP/7
 JxKLIkzbJu7E24XD6PfxWPBOyUB/IfPBRGhTBWKyg24X4Pv8D5frvAk7p/y4jBkF7aK0
 1AB033VF4I9RmJrI3xdUzEy8Oqh73lFKKcB+UuvHLNWbOt+ws54tKUtQxiONyW9qVgc+
 YPN1rj7mWgM64Ro+LcT4MWZL+6Rvi/6BldUVWr9oQHCoVDaBF0Xe/nnCv0pLtxOl5gGE mg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jmr2mknw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 08:53:11 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5K8rAeE025828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 08:53:10 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5K8r9In029633;
        Wed, 20 Jun 2018 08:53:10 GMT
Received: from mwanda (/197.157.34.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 01:53:09 -0700
Date:   Wed, 20 Jun 2018 11:53:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] staging: rtl8192u: Correciton of block comments -
 Coding Style
Message-ID: <20180620085301.4yoqdux5s7shedsa@mwanda>
References: <20180619195605.31321-1-johnfwhitmore@gmail.com>
 <20180619195605.31321-8-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619195605.31321-8-johnfwhitmore@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=555
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 08:56:03PM +0100, John Whitmore wrote:
> @@ -734,16 +734,15 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
>  #ifdef TODO
>  #if (HAL_CODE_BASE == RTL8192 && DEV_BUS_TYPE == USB_INTERFACE)
>  	/*
> -	//Emily. If it is required to Ask Realtek AP to send AMPDU during AES mode, enable this
> -	   section of code.
> +	 * Emily. If it is required to Ask Realtek AP to send AMPDU during AES
> +	 * mode, enable this section of code.
> +	 */
> +#if 0
>  	if(IS_UNDER_11N_AES_MODE(Adapter))
> -	{
>  		posRT2RTAgg->Octet[5] |=RT_HT_CAP_USE_AMPDU;
> -	}else
> -	{
> +	else
>  		posRT2RTAgg->Octet[5] &= 0xfb;
> -	}
> -	*/
> +#endif
>  #else
>  	// Do Nothing
>  #endif

Please don't introduce new #if 0 blocks.  We should just be deleting
ifdeffed out code.  It's an almost mindless task.  And anyway the #ifdef
TODO works as an #if 0 anyway so this will never be compiled.

regards,
dan carpenter


