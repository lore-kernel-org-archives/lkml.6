Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED92EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC7024049
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mQ0WM7nF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC7024049
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934550AbeGDMSs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:18:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34938 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934466AbeGDMSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:18:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w64CEamR188343;
        Wed, 4 Jul 2018 12:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=z7+MyRL1uEjIPQel5Citb0Arhxq3nwlgKlaEOnmYK+E=;
 b=mQ0WM7nFTO3nFNN34HTycnC8YhQBGdlnZVewiEv2uHFR10K3JK7Jh2LwQLD+1CI89dMz
 1KyySuNLdSFj/yI6feSZF6Cq89uXs1OifOxtXptzH72JE+GfoDfEgRer9ZkkKXMdzKVw
 I2egbaM1FVwMMubr01Wup7ZD4eurdo2m2+23AwAymSWitZ1RZpVto4FCXAM+XZDNfUkl
 ElEjhiiTDusYR9XDvZVNX+vtIAosnPZyBKSz35CLz2KePOJ25G/t5M7ApCFUpf7Lj39f
 guB+fExkEUelWY0kVwKHywGciMFcgZqx3++n4PTqQtchwNLOwzxNUkK/LkIdk70Wx839 IA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2k0dnt2kjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jul 2018 12:18:38 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w64CIbKI007727
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Jul 2018 12:18:37 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w64CIZvx007159;
        Wed, 4 Jul 2018 12:18:36 GMT
Received: from mwanda (/197.157.34.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Jul 2018 05:18:35 -0700
Date:   Wed, 4 Jul 2018 15:18:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        insafonov@gmail.com, gregkh@linuxfoundation.org,
        baijiaju1990@gmail.com, joe@perches.com, colin.king@canonical.com,
        keescook@chromium.org
Subject: Re: [PATCH 3/5] staging: rtl8192u: Remove unused variable.
Message-ID: <20180704121822.p2s6nzenq5psi3cd@mwanda>
References: <20180704115925.28024-1-johnfwhitmore@gmail.com>
 <20180704115925.28024-3-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704115925.28024-3-johnfwhitmore@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8943 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=638
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807040141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 12:59:23PM +0100, John Whitmore wrote:
> Removed the unused variable from previously removed loop.
> 
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>

This is fixing a warning that was introduced in a previous patch in this
series.  That's not allowed.  Just fix the original patch instead.

regards,
dan carpenter

