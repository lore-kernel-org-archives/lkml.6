Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6135C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695802083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QRYb3mQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695802083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeJANtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:49:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50172 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbeJANtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:49:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9174HGM033237;
        Mon, 1 Oct 2018 07:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=glBHVJHCjHL47s4PuvFiGUyZAcpQ0ENLXjzRAU2jPxE=;
 b=QRYb3mQsnWnH+RJsXsoz2EqYi/yD5hJLtxXm3q399VoR3SJZdDXBcrxEvF1a9HDCLYQ9
 6qNznxtLaBxydDbcD00KoA+7TnJhWulN7gIcGW0H0uii/o7XBQ4vgjkzb7/LEE2myljZ
 rrDECg18ORq05K2mdPq9dKvBZYWDy13LuZ952Hhg0AcbYpCCPY1u3scILXx5Eq/AZJhC
 9fv5h8+iubqqMRaf86F/gzh8l2EypRRDK0OEhQ7LJDsXKZT2bujwyBejS2ypf8xVW+iM
 9lXdOpIIb8GSRCziJUQgjPPBV1Y361RCr6/JggHam0gI7I22pg35dedKUEsGUPK5CXsn lg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mt1bpn4yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Oct 2018 07:13:25 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w917DJgT029531
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Oct 2018 07:13:20 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w917DJHr003256;
        Mon, 1 Oct 2018 07:13:19 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Oct 2018 00:13:18 -0700
Date:   Mon, 1 Oct 2018 10:13:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Maxime Desroches <desroches.maxime@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Staging: rts5208: sd: Fixed multiple coding style
 issues Fixed multiple braces issues
Message-ID: <20181001071312.ungbsjba6wskysed@mwanda>
References: <20180929055850.25615-1-desroches.maxime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929055850.25615-1-desroches.maxime@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9032 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=576
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810010074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't just add a 4/4 after a 3/3.  Send it as a new series instead.
Also the patch discription and sign off are missing.

regards,
dan carpenter

