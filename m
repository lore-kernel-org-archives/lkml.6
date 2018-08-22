Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7B5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D186021480
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qigtYbuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D186021480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeHVMr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:47:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42674 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbeHVMr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:47:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7M9No9l146018;
        Wed, 22 Aug 2018 09:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=CTAb7drnZHqTmEJLTn7n5wDwY+BkyQYM6YbndJbtjOM=;
 b=qigtYbuNmCnDKjCogN9BpKUE7oaeSoKGgyZ1GycZatLCUnF/qp7Wqw6cPUS33TAkBkWY
 H3iPe7epN2y3ttZ3GugBMFbystfQXwlivb5OH5TrskrpFVe4eF1tfWDuRCg8MKUnGd6+
 NACukdWJopYVtQXawbFaHZHKCbpR5PrPQF2Avi9fFq5w9EWzDBdtutUuODWdfe3bQu4h
 L7GvE/zSQXDn7US8xz6mhvZNbTr92BUVlRb6Hd1BxmAT9kwJx15Jt32HYLf9BiEt8fxe
 31q1PxurtQYIBaRbGbH9gZQjDqzeS31rOO+kNKLLcYDHMJzThE8kJfBzL7Rxg7g6RXQH bw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kxc3qs5d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Aug 2018 09:23:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7M9Nnow006797
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Aug 2018 09:23:49 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7M9NnAk029493;
        Wed, 22 Aug 2018 09:23:49 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Aug 2018 02:23:48 -0700
Date:   Wed, 22 Aug 2018 12:23:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bhaskar Singh <bhaskar.kernel@gmail.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Fix spelling mistake
Message-ID: <20180822092342.bzny5sts56cios7w@mwanda>
References: <20180821014428.GA7914@Gentoo-PC>
 <20180822081636.eu54b6z5g5s7wgfp@mwanda>
 <20180822090532.GA2715@Gentoo-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822090532.GA2715@Gentoo-PC>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8992 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=595
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808220096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 02:35:32PM +0530, Bhaskar Singh wrote:
> On Wed, Aug 22, 2018 at 11:16:36AM +0300, Dan Carpenter wrote:
> > On Tue, Aug 21, 2018 at 07:14:28AM +0530, Bhaskar Singh wrote:
> > > This patch fix spelling mistakes in TODO.
> > > 
> > 
> > Btw, it helps when you say which word you're changing, otherwise it
> > takes a while to spot the difference.  We changed "HGz" to "GHz".
> > 
> > Probably someone smarter than I am would have spotted it faster...
> > 
> > regards,
> > dan carpenter
> >
> 
> Apologies for the inconvenience and thanks a lot for your suggestion.
> 
> I will definitely follow that.
> 
> Should I send the patch again?

No.  It's fine.

regards,
dan carpenter

