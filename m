Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E712C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE59D2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w4iX55sw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE59D2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeH3M1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:27:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36750 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeH3M1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:27:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7U8NpPA032303;
        Thu, 30 Aug 2018 08:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=uRN7nvtYA/92MyfQQiAIIPhcLs6C1Z1PA8EUc5y6Lhs=;
 b=w4iX55sw0IG/RcMyBmQKCq0KLSa7G1Ij8FHTqUQiPWXEOStJD1XcaVMtqikRr/qZ8qbt
 kCGsRDZ2n2ZdHXrWwhjzqhgk9OIYDh9MTyC2kAkbPsYsUbm260aP42NPSixufHAkHtZ/
 XPThMS/ybZQFiH5XRObSaUTyAWJ6MrJd2IWZblWl6f/sq4D8w7a5ShN9+xOij0Kq2apl
 MwHQSeNE+YIoy0O9b8TBXB2aFsayXh56A4k8bVzI1QllyqcIb3RXlvE92k4kpFNKoT0A
 6eym3sidivdA+SBbnXddNVCf92Ennjjz8usi8FzHzniy2/tvmnFaQCIEo9t8d8JlJRjk wQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2m2y2pr442-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 08:26:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7U8QidN002204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 08:26:44 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7U8Qioj009234;
        Thu, 30 Aug 2018 08:26:44 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 01:26:43 -0700
Date:   Thu, 30 Aug 2018 11:26:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/21] staging:rtl8192u: Rename AdvCoding - Style
Message-ID: <20180830082628.ff5x3tzvd2wdrbir@mwanda>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
 <20180829203547.15650-2-johnfwhitmore@gmail.com>
 <20180830082305.umqtq3fdexlyvn65@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830082305.umqtq3fdexlyvn65@mwanda>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9000 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 11:23:05AM +0300, Dan Carpenter wrote:
> On Wed, Aug 29, 2018 at 09:35:27PM +0100, John Whitmore wrote:
> > Rename the bit field element AdvCoding, as it causes a checkpatch issue
> > with CamelCase naming. As the element is not actually used in code it
> > has been renamed to 'not_used_adv_coding'.
> > 
> > The single line of code which initialises the bit has been removed,
> > as the  field is unused.
> > 
> > This is a purely coding style change which should have no impact
> > on runtime code execution.
> > 
> > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
> >  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 1 -
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> > index 64d5359cf7e2..66a0274077d3 100644
> > --- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> > +++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> > @@ -39,7 +39,7 @@ enum ht_extension_chan_offset {
> >  
> >  struct ht_capability_ele {
> >  	//HT capability info
> > -	u8	AdvCoding:1;
> > +	u8	not_used_adv_coding:1;
> 
> I can't review any more of this patchset when this is the first line...
> 

That email wasn't very clear.  If you think some of your patches are
going to be more controversial than others, put them at the very end so
we can at least apply part of the patchset.

regards,
dan carpenter

