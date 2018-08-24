Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73363C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F352156B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0wNJtwgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F352156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeHXGGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 02:06:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60604 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeHXGGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 02:06:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7O2T8BF164628;
        Fri, 24 Aug 2018 02:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=3Ot3uNO+bB/hajG72i0TJjWTz7pvru2Qa27ALEPmDco=;
 b=0wNJtwgNG7nL/FhYHdlMzwsQDFCkZ8qnCpNakIBCeyQTJMEQwmDNJK3r9mozkTP4WUXC
 OEGf9MP3jZLhf6NohDD/JWvsUd47BvlvOp9hgweI66Lyfb4tima0A/JlAnWNCmB8X29l
 UVi7/hitTTlQVkpxf8IfVELPl/TQiPHLdZU0oCzfweWJJy6iS9dxFMQo2/b3OxZ8JyW7
 op4OOmX73V5nttmJIkmk2yNyKqTYG2Yud9HTsc1KVHVOAe5ixZj7voUfjOmAuLaYVteO
 s0w5Yu80fpBUYBbI1sDJEhpQfDoBTEC0RJ0JoXHhGQcBabbdDGUHa9HRoudDKFJxfd/h DA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2kxc3r4n48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 02:34:07 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7O2Y6D3025047
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 02:34:07 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7O2Y6vH019823;
        Fri, 24 Aug 2018 02:34:06 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Aug 2018 19:34:05 -0700
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Tejun Heo <tj@kernel.org>, Jason Yan <yanaijie@huawei.com>,
        "Signed-off-by \: Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata: Add missing newline at end of file
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180823212306.17134-1-geert@linux-m68k.org>
Date:   Thu, 23 Aug 2018 22:34:03 -0400
In-Reply-To: <20180823212306.17134-1-geert@linux-m68k.org> (Geert
        Uytterhoeven's message of "Thu, 23 Aug 2018 23:23:06 +0200")
Message-ID: <yq1sh348pd0.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8994 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=679
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808240025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Geert,

> With gcc 4.1.2:
>
>     drivers/ata/libata-core.c:7396:33: warning: no newline at end of file

Applied to 4.19/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
