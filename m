Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF596C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4E42087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uOKcs93T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4E42087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbeIYBjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:39:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47460 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeIYBjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:39:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8OJYaKR160176;
        Mon, 24 Sep 2018 19:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=YD3BAeSl3gqtLdAOrRjYlIaJQOBTV01+1Eo8X66ZecU=;
 b=uOKcs93Th4xdJ4TDG3tXFVrEptpshSZlW1m9R92e5HkeXtJLgWLd8pMndOq4UXGUpHCJ
 vcyKOI2EeDMTo5GCzkB2Xz0sD9Ug+FT6xBicH2/ttIU34nXrq/rhikIv9xxpfO4zuGYI
 eujnsY5pusGT4gelom01JttdzxUmBRjYMOKlYiFaGUKBt/5LgLZfkgnsRHd/4XuEATr1
 bCkB0T7BPSIy2IOLRkZizv0VElXNKRbb9jGOMNlfK/EliXcuq6vJtimTCJ+YLrlWWeFi
 1HKwYSKO6KzEBE+ulttC6joNFVH58pFU3LLBQehl/EhbD269rRYxzxdZCz4Iwa2NXDLv Dw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mnvtuemh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 19:35:15 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8OJZE3s029929
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 19:35:14 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8OJZEL5022306;
        Mon, 24 Sep 2018 19:35:14 GMT
Received: from Santoshs-MacBook-Pro.local (/10.11.38.116)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Sep 2018 12:35:13 -0700
Subject: Re: [PATCH] soc: ti: fix spelling mistake "instace" -> "instance"
To:     Colin King <colin.king@canonical.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180923221436.7701-1-colin.king@canonical.com>
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <9ac6d488-5b19-0af6-a2e1-7a591a9b75bc@oracle.com>
Date:   Mon, 24 Sep 2018 12:35:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180923221436.7701-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9026 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=803
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809240187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/18 3:14 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in dev_err messages and comments
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
Thanks. I will fix this up.

Regards,
Santosh
