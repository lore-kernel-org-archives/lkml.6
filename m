Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38717C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E122420B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A4wADGrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E122420B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388691AbeGKOeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:34:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53272 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388075AbeGKOeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:34:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6BEO46o155212;
        Wed, 11 Jul 2018 14:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=g5MNdq+e4GJEMm7TyrEc0QqC0pFqYgzZKMuVUkYRpr0=;
 b=A4wADGrzSUiKzJL5UtkTsMLmx27A3oFJS3LcyEpdS7fXwZNoWJjaDe/5rOM4fnCtepLf
 WWDmdD+3T0Mzvmh4i51ATfvYdds7YHQGtfova1273L+QI3y0fSU/SqgHTiE5kv4OzWYO
 KEf6Qzw/2sd34EB0LE6ideVh0YCu585X37ZkL3etAywle90XykykCpURzL8rqeVYTsOb
 MwpBEQn5va8V6GQ9BmSNYDukVwqCiFvsXT2TtBrhah3ZUJja9wIStt4I/qMlop4lNU40
 MnHE7c6QGW84DCYkocv47FGUepPK38zSAkzdUzr9/ky8w4g030NQyB03G45YHQIoizEF Lw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2k2p7dxf13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 14:29:56 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6BETs0W012128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 14:29:55 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6BETrru014371;
        Wed, 11 Jul 2018 14:29:54 GMT
Received: from mwanda (/41.202.241.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 07:29:53 -0700
Date:   Wed, 11 Jul 2018 17:29:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     John Whitmore <arigead@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        kstewart@linuxfoundation.org, keescook@chromium.org,
        aastha.gupta4104@gmail.com, linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH v2 3/8] staging:rtl8192u: Correct spacing before and
 after parenthesis - Style
Message-ID: <20180711142943.chjedee3m7v6yogh@mwanda>
References: <20180710150523.17384-1-johnfwhitmore@gmail.com>
 <20180710150523.17384-4-johnfwhitmore@gmail.com>
 <20180711111349.GA28836@kroah.com>
 <20180711140935.GC26416@xux707-tw>
 <20180711142250.GA3907@kroah.com>
 <20180711142710.GA12935@xux707-tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711142710.GA12935@xux707-tw>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8950 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=548
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 03:27:11PM +0100, John Whitmore wrote:
> On Wed, Jul 11, 2018 at 04:22:50PM +0200, Greg KH wrote:
> > On Wed, Jul 11, 2018 at 03:09:37PM +0100, John Whitmore wrote:
> > > On Wed, Jul 11, 2018 at 01:13:49PM +0200, Greg KH wrote:
> > > > On Tue, Jul 10, 2018 at 04:05:18PM +0100, John Whitmore wrote:
> > > > > Corrected coding style issues aroung opening and closed parenthesis. Spaces, or blank line, removed from after '(' or before ')'
> > > > 
> > > > Wrap your changelog text at 72 columns like your editor asked you to :(
> > > > 
> > > > I'll fix it up this time...
> > > 
> > > Oops sorry and thanks. I thought the magic number was 75 which I got from:
> > > 
> > > https://www.kernel.org/doc/html/v4.16/process/submitting-patches.html
> > 
> > 75 works as well :)
> > 
> 
> Well if I went over 75, which I knew about I'm very sorry I messed up. I'll
> keep an eye out in future. Might be using the wrong editor but let's not go
> there.

Here is the line:

Corrected coding style issues aroung opening and closed parenthesis. Spaces, or blank line, removed from after '(' or before ')'

It's 128 characters.

regards,
dan carpenter

