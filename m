Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5FBC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725352148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3BtuGejY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfA2Fce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:32:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59788 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfA2Fce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:32:34 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0T5O6rd056072;
        Tue, 29 Jan 2019 05:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=BEEIDna4m5f9/qSoFavB5KWRn03gy3kKEzy5uvV6YF8=;
 b=3BtuGejYXQ9B3GUg4947BlwW2cxltGt/IqurtlF2laG22kCfEYzRl1WNaOPINHSrWxWU
 WLyviX/KoPEOzz+bz8p0eHRGKfzUZxzoKbP778fuGuwVweF0V1w2XZiYgWF9KvXxty0R
 WFPLEW8HK59JqXnTYtRkniXzuCUxZjM5EkJ9eP2pd2oEkWXQqwqhMf7oNz9ypRhvkOBU
 kXS0OcQW0DPoki6GspFRuhpqRdyAn4QFfyFEC52Hc3PYSXcBE06fqVVfbNQbGq4l2ZQF
 rJl1/Mtcv0HW2HgwrtcW8fOexhFNE2fi9JFmcLIgjqHl4t8Tp9YlXMheH3dgyic2Om/D Pw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2q8g6r2382-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 05:32:29 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0T5WOSe015566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 05:32:24 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0T5WN0Z029634;
        Tue, 29 Jan 2019 05:32:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 21:32:23 -0800
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] MAINTAINERS: Move FCoE to Hannes Reinecke
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190128110634.17243-1-jthumshirn@suse.de>
Date:   Tue, 29 Jan 2019 00:32:21 -0500
In-Reply-To: <20190128110634.17243-1-jthumshirn@suse.de> (Johannes Thumshirn's
        message of "Mon, 28 Jan 2019 12:06:34 +0100")
Message-ID: <yq14l9sf2qi.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9150 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=708
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901290040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Johannes,

> I'll be moving on to different things in the storage stack and Hannes
> agreed to take over FCoE.

Applied to 5.1/scsi-queue. Thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
