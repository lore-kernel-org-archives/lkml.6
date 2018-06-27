Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68B6C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47665265EF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G9a+r12e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47665265EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933594AbeF0Ik7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:40:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44046 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932234AbeF0Ik4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:40:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5R8cWSB050892;
        Wed, 27 Jun 2018 08:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=Tdg+Mm4DW4Eu1QIZ+97ekPXK/RxBSPjHWzzo6vvQS0k=;
 b=G9a+r12eNr5ep5lcZKWmqLm4bIgMS5yEHlvRupimNiO1UAz97jvlNx6RwN1u3rUesAL4
 cviW5DFr9ZrVCee/N7UDfOFq8vNyzPffQQ0eFuYk/3pYsSnE7V8tr3PQcX8WWA/+XX3S
 k4RwQc3/l2HkkoWeKCyQvpYoTX9Y08LQM5N9UXROiH8hBv9q08FmXDj4ukJkmoK/i+Qn
 qgzuBOyLYQfFqgnV1/xV4pckKW5GQXOzkxox4rsEAL3qNXaiWvT+SKPpENTBM/HPrUkx
 ePD2xPeC0j4tDqYGdbD7Enfp6jC0pMfX2osaSzksd6muWKnvgAZgsc9fvxaeYgJKEEXI 6A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2jum0a3sdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jun 2018 08:40:31 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5R8eRIb022885
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jun 2018 08:40:29 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5R8eMNI018546;
        Wed, 27 Jun 2018 08:40:23 GMT
Received: from mwanda (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Jun 2018 01:40:22 -0700
Date:   Wed, 27 Jun 2018 11:40:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Daniel Graefe <daniel.graefe@fau.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devel@driverdev.osuosl.org, linux-kernel@i4.cs.fau.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Roman Sommer <roman.sommer@fau.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2] staging: media: omap4iss: Added SPDX license
 identifiers
Message-ID: <20180627084013.ybnbxbgha77cdujn@mwanda>
References: <1529932892-9036-1-git-send-email-daniel.graefe@fau.de>
 <1530048656-4074-1-git-send-email-daniel.graefe@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530048656-4074-1-git-send-email-daniel.graefe@fau.de>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8936 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=546
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806270102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:30:56PM +0200, Daniel Graefe wrote:
> Changes in v2:
> - replaced "GPL-2.0-or-later" with "GPL-2.0+"

We should make checkpatch.pl complain when people use wrong tags like
GPL-2.0-or-later.

regards,
dan carpenter

