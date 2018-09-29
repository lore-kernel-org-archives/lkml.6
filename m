Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8F5C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195372073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KunjB0VQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195372073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeI2GeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 02:34:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54418 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeI2GeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 02:34:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8T05tpY061547;
        Sat, 29 Sep 2018 00:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=A/OfJA6AvtML2NZ+y5hTa3EkkBJMjW3nDyvrcggykIo=;
 b=KunjB0VQ75xOJGtwwHtlcI9RZKKbszSDWy7YYheEVDWJomDnN6bmOeWsWpjh978BKKgX
 87K98z997uGJro/fdrPLwG3Gp0ksNMAqpM8T4Eg5/69qBT/Jn49ypIyvqcbjAaS6oYFb
 jqqVfu6BMbbBx9NBa2oPxj3jVJBaNuGc0d8vDsSX1xdZSxTr+OT3SLJ6QtgeJViYtZW0
 27Pw8Magt8yMPlr3QxvDPU57oERqzNXzfkq9juFamY/S2fZeSgYnbhxnqI96KClyzQap
 tCbO8nGQf4jby4LrYymCjqkXag5ve2aQwUPMP1dNVN3mtm0J1t2ut1N8tG7xAjSeGVVd ng== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mnd5u3531-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Sep 2018 00:07:42 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8T07faS016483
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Sep 2018 00:07:41 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8T07e3K009758;
        Sat, 29 Sep 2018 00:07:41 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Sep 2018 17:07:40 -0700
Subject: Re: [PATCH] MAINTAINERS: Drop dt-bindings/genpd/k2g.h
To:     "arm@kernel.org" <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, Dave Gerlach <d-gerlach@ti.com>,
        Tero Kristo <t-kristo@ti.com>
References: <20180928224615.19862-1-nm@ti.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <19176740-b38f-8ae9-a9a2-85d6f7a9c590@oracle.com>
Date:   Fri, 28 Sep 2018 17:07:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928224615.19862-1-nm@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9030 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=910
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809280236
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anrd, Olof,

On 9/28/2018 3:46 PM, Nishanth Menon wrote:
> Drop include/dt-bindings/genpd/k2g.h which disappeared from kernel tree
> some time back, however MAINTAINERS file was missed to be updated.
> 
> Fixes: d16645054d2f ("dt-bindings: Drop k2g genpd device ID macros")
> Cc: Rob Herring <robh@kernel.org>
> Cc: Dave Gerlach <d-gerlach@ti.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> A big oops.. Sorry about that. will do better next time. I tried to relook and
> I think we have'nt missed any other files.
> 
> Based off next-20180928 tag.
> 
> Santosh, any chance you could pick this up -> Thread:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1776470.html
> 
Could you please apply this to arm-soc tree if its not too
late ?


Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
