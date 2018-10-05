Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6152AC65BB9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EBC213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CxNnXw5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EBC213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeJFBKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:10:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55704 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbeJFBKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:10:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w95I9ZOE151854;
        Fri, 5 Oct 2018 18:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=5t68NkqHszAd8FzaLqCdRacqTD3iIgyZ3b8oZwvabc8=;
 b=CxNnXw5mOSm/THHWOEcUZ0CcZtyFgDyaZvtL7yn6+c6tmkTn7mZfUfMeXO+JOqAIcHHv
 38mOhmrpN9oe95d43rSLJO9BxacObEda3GxVlxA9c3KUrITrNpCVdf1FZrs05diz37AW
 UU9p8R/+aNU0E4np6JEjFg8LHNrWC5Fa0Sxp7PA63z5/7pLbMqG8SVkyIw91Lp1ZgwfP
 TJmspWdZ78oYMP215++LLf6o4hfqKtc9FzMSbGYXmtBsOad5i199pjAgSITS38mPUQUS
 VY6BfZuR+lboNaQi2883pwK5kBjxL9+6ZaC/Ltp0/gQb1NjTQl5YrepOzb2cZR+lDT7D rA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mt0tuc84e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Oct 2018 18:10:58 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w95IAvnL014675
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Oct 2018 18:10:58 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w95IAvLT006582;
        Fri, 5 Oct 2018 18:10:57 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Oct 2018 18:10:57 +0000
Subject: Re: [PATCH] clk: keystone: add missing MODULE_LICENSE
To:     Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20181005161126.704214-1-arnd@arndb.de>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <e33fad94-fa85-e151-9b29-e1c03ad8d1b9@oracle.com>
Date:   Fri, 5 Oct 2018 11:10:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005161126.704214-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9037 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810050178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/2018 9:11 AM, Arnd Bergmann wrote:
> A randconfig build showed that two clk modules have no license tag:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/clk/keystone/gate.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/clk/keystone/pll.o
> see include/linux/module.h for more information
> 
> Add the appropriate information from the comment at the start of the
> two files.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Thanks Arnd.
Acked-by: Santosh Shilimkar <ssantosh@krenel.org>
