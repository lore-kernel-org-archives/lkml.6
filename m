Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C77C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 08:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F2424B3B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 08:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fPEzbJ7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F2424B3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbeFWIkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 04:40:41 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34234 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeFWIkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 04:40:39 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5N8eR4G117979;
        Sat, 23 Jun 2018 08:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=Kf1bSwHiWP8V3WlsXHy5UHU3yYs/bJhvDIgYVx3Y7EI=;
 b=fPEzbJ7dklFAJSO9kdtLH/7hU82ZcW5lGv2A5wJY3gNBD5wp0qwGFHrBZ2GyQQZWwTAz
 6YWJ/iE2Io6R3/Bm3KvRGFgHfVrB0VKwbevfFUKnfnb+vkgEZgx8idfNh98ZWe8vRwlf
 N/1TIWt91Ml01tVEYW3iiAwA5B4yCs1vzVnmIrEtEggLFTzCkhjHAK7xDsTgJLw6Msda
 kLkkMUaewkm3qzXDNEPcw7M4OnTzCCs/lvPGbafi5jweVEcZdOhqJnCKdRIwF8F0o7x/
 JVFSRaYB4axlp6y0Y5xGk6BOJuVZRWTKfsggqIKTlfrLW21LEM2gaH6808+NnlVPZeSp 6g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jsfg0r69c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jun 2018 08:40:27 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5N8eQtK031787
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jun 2018 08:40:26 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5N8ePVo021129;
        Sat, 23 Jun 2018 08:40:25 GMT
Received: from mwanda (/41.202.241.39)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 23 Jun 2018 01:40:25 -0700
Date:   Sat, 23 Jun 2018 11:40:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <michael.straube@posteo.de>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix brace coding style issues
Message-ID: <20180623084018.l7ail4233xc4vw7z@mwanda>
References: <20180621182155.27769-1-michael.straube@posteo.de>
 <20180622102800.4p6wabmte4yf4rtp@mwanda>
 <bc244970-498d-c6e7-7ed0-3c3d77777ccc@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc244970-498d-c6e7-7ed0-3c3d77777ccc@posteo.de>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8932 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=789
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806230106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 03:27:46PM +0200, Michael Straube wrote:
> On 06/22/18 12:28, Dan Carpenter wrote:
> > >   	if (count < 1)
> > >   		return -EFAULT;
> > > -	if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp))) {
> > > +	if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp)))
> > >   		sscanf(tmp, "%u", &g_wait_hiq_empty);
> > > -	}
> > 
> > 
> > The original code is kind of bad.  The NULL check isn't required.
> 
> Just for clarification, NULL check refers to checking if buffer != NULL in the
> if condition?
> 
>        if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp)))
>            ~~~~~~

Yes.  If buffer is NULL that's just another invalid pointer which the
user cannot access, it's not special, and the copy will fail.

regards,
dan carpenter

