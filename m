Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4D5C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0FF21A52
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ye3xTZrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0FF21A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbeHHVrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:47:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35784 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHVrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:47:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w78JO9SG167970;
        Wed, 8 Aug 2018 19:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=x3Pjgp8p/m567N9YabC6XELBW68+GYu6T15sRdn5jUc=;
 b=Ye3xTZrQvHE+WbW0ngWnBJiEYZEUb2RL16ez9haX9eBK4XHQmRXnir9JMQJ9uKV9m48W
 vw01z7RLwM163i0xAHIZehTxIuq1pxFMdHrBD94i09oUvSNrvhMNio1R5oKF2rB1DE0E
 rVtv+HaSz724fIrnMG4RYozJwqXQsPy/wVeKZDLDuCDT+gc3klIZbEN3thfxcRQck697
 /+WIcX2vPJ4llmSgNYRNcZ1VO/K6gmuLbEwQPeUZhYi4k3B4FPJHQYHBoOgJwuHLmYBl
 74QxesUGcpOaf8bw67IZim013z+aj0+vPzYe32QVDAb/IgCyqDdawTLeP/99RBPamKU+ 9A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2kn3jt787t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Aug 2018 19:26:05 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w78JQ3fj021035
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Aug 2018 19:26:04 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w78JQ36s008179;
        Wed, 8 Aug 2018 19:26:03 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Aug 2018 12:26:02 -0700
Date:   Wed, 8 Aug 2018 22:25:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     devel@driverdev.osuosl.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging:rtl8712: Style - Removed inline block comment to
 fix "Statements should start on a tapstop"
Message-ID: <20180808192556.zdymsg3bkujmrnix@mwanda>
References: <1533498066-31466-1-git-send-email-mail@kripp.ch>
 <20180808092257.GA4097@kroah.com>
 <9b6d5aa1-dc6b-8d0a-78a1-b46d888db54f@lwfinger.net>
 <20180808192212.kboucbzcggchru22@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808192212.kboucbzcggchru22@mwanda>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8979 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=632
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808080196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, yeah.  Greg's comments were very clear.

regards,
dan carpenter

