Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 116CFC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8FB208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PlYj3BfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8FB208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755314AbeFNStR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 14:49:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58736 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754877AbeFNStQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 14:49:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5EIdZMP112845;
        Thu, 14 Jun 2018 18:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=YIcMDINivkdD1n1YO5xKA8NTihSMU4Pj8COioGiDcNA=;
 b=PlYj3BfO7e6U3+B3o5H8abuWpyQcPrJ1Dxr7HeTkoKXbXgMAexVtpz4pzBm/EetkcvEE
 R1hbZbxwlDFBlMjiR9ke2X0mJCEnUWbSmRSE9CteNQZ7wkzNXKU4Yy7EZRfe4FfZcEvx
 fFr2CpULuTMjfZVEDVrt49h8WEta5SSrFqUudnvi9fuw/l1g48WP2XCe4t7eBQJ+6g7D
 c1kTAulJNxk+rzNnd67euHVws2IImuQs5wLLxYiIVrxMLZu6MF91JotHdfSoV2Yh/EDZ
 Q6ILMgWnEFX0IxW7nYqM7OW5W22XqBsXKk1ouDcWKg63nMP2mbOxAZylWVyLt5i7TtgL eQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2jk0xreak7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 18:49:11 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5EInAF5024271
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 18:49:10 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5EIn9Yd006321;
        Thu, 14 Jun 2018 18:49:09 GMT
Received: from [10.154.136.90] (/10.154.136.90)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jun 2018 11:49:09 -0700
Subject: Re: [PATCH] selftests: sparc64: Add missing SPDX License Identifiers
To:     "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        gregkh@linuxfoundation.org, allen.pais@oracle.com,
        davem@davemloft.net
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180614010559.5144-1-shuah@kernel.org>
From:   Tom Hromatka <tom.hromatka@oracle.com>
Message-ID: <2f9d0d78-067f-7a25-dc10-f4476a7ae54c@oracle.com>
Date:   Thu, 14 Jun 2018 12:49:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180614010559.5144-1-shuah@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806140204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/13/2018 07:05 PM, Shuah Khan (Samsung OSG) wrote:
> Add missing SPDX License Identifiers to Makefile(s).
>
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

Reviewed-by: Tom Hromatka <tom.hromatka@oracle.com>

> ---
>   tools/testing/selftests/sparc64/Makefile         | 1 +
>   tools/testing/selftests/sparc64/drivers/Makefile | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/sparc64/Makefile b/tools/testing/selftests/sparc64/Makefile
> index 76b2206932c3..a19531dba4dc 100644
> --- a/tools/testing/selftests/sparc64/Makefile
> +++ b/tools/testing/selftests/sparc64/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   uname_M := $(shell uname -m 2>/dev/null || echo not)
>   ARCH ?= $(shell echo $(uname_M) | sed -e s/x86_64/x86/)
>   
> diff --git a/tools/testing/selftests/sparc64/drivers/Makefile b/tools/testing/selftests/sparc64/drivers/Makefile
> index 6264f40bbdbc..deb0df415565 100644
> --- a/tools/testing/selftests/sparc64/drivers/Makefile
> +++ b/tools/testing/selftests/sparc64/drivers/Makefile
> @@ -1,4 +1,4 @@
> -
> +# SPDX-License-Identifier: GPL-2.0
>   INCLUDEDIR := -I.
>   CFLAGS := $(CFLAGS) $(INCLUDEDIR) -Wall -O2 -g
>   

