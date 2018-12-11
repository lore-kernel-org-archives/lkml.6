Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7F9C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509FC2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="usbgz9Nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509FC2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbeLKMwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:52:35 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49990 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbeLKMwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:52:34 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBBCmaND111451;
        Tue, 11 Dec 2018 12:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=R9uqR7jlEKU4KesGe4HhhERkjjbqX1A6BvMxYk/aaeI=;
 b=usbgz9NrcJ5HuVabmpCY8xLMJysO6UZnmWVydtxPiuL4x2juyzrx2sdKiOx3QTyoBWbi
 pzKPG5Dt7gI4lP1D4O4nBy+gaaIfN3KpqukCnHazYbemWCxXMD8tiMElG1aby9+m77E4
 SVN0J01YFsdxU+07WC8cOBRNOvk+0oSz/lcxLsnk+ILu9FSkeM8ooh/G1U5Mz3v/EQDL
 4+T88qkeRBDl7FPhqxiWfSAbFvk22lz5SYqZs+sHNZAuz3b+6jvVtHA1vjfrtvGVrjNp
 ONZNcpyHYC2DTFAXlkubhrpqcxXCFD9Fwfq62ZGzUonHaJz0HQ7c30n/AnkfhbYb4b2q OA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2p83fe3t30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Dec 2018 12:51:56 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBBCptaU021613
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Dec 2018 12:51:55 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBBCpng0009403;
        Tue, 11 Dec 2018 12:51:49 GMT
Received: from kadam (/10.175.36.120)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Dec 2018 04:51:49 -0800
Date:   Tue, 11 Dec 2018 15:51:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aaron Strahlberger <aaron.strahlberger@posteo.de>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, devel@driverdev.osuosl.org,
        Julius Wiedmann <julius.wiedmann@fau.de>,
        Chao Yu <yuchao0@huawei.com>, linux-kernel@vger.kernel.org,
        Dominik Huber <domi250@gmx.de>, linux-kernel@i4.cs.fau.de,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH] drivers: staging: erofs: Fix styling issues
Message-ID: <20181211125135.GD3116@kadam>
References: <20181211090627.2194-1-aaron.strahlberger@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211090627.2194-1-aaron.strahlberger@posteo.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9103 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=431
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812110117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the "drivers: " from the patch prefix.

You're not working from the latest code.  Write your patches on top of
staging-next or linux-next.

regards,
dan carpenter

