Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 60WeEMFzGltpPwAAmS7hNA
	; Fri, 08 Jun 2018 12:19:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 98D55607E4; Fri,  8 Jun 2018 12:19:21 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AQg64rcl"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 14EBC601C3;
	Fri,  8 Jun 2018 12:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14EBC601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeFHMTS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:19:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55556 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbeFHMTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:19:17 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w58CGQgJ119174;
        Fri, 8 Jun 2018 12:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=yE0sKg2cLyfX+ZDu6bomiqkMYEtiX3wAmwG0VZiun9M=;
 b=AQg64rclA8JBj0ormVwo7QSkOqQBvTn2axK9KWZ7eQ/7x3KC0KhIU9VfQ6EKmhME7ilm
 HSNXWI5wHKZ6267JbSZdCaCU02H9sQZ6eJozPbwJkLoXg6jxh2DYV4Vd3ybLhnSG/jEU
 IKcq4djQJlDg82X2NC1W3V6ncz/0p/t18LtI/VQ57NZqSuf6JIuy24TQfFA2f6CrWvhN
 qcIKFKBwPlGx1VBgAYaSsTcEDo21yS0xhZQChfd6/JogelIwdB1ygHLDpv7G6jzyO++v
 3P14jma+79aCUYnEhUm8AsI3IB8Wf+vTT6j7YwIiSkPfJ4LQKxyGxCUt/S+k5qIHDnAu lA==
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2jbvypcwv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jun 2018 12:19:03 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w58CJ2t9028617
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Jun 2018 12:19:02 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w58CJ16T016992;
        Fri, 8 Jun 2018 12:19:01 GMT
Received: from mwanda (/41.202.241.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Jun 2018 05:19:00 -0700
Date: Fri, 8 Jun 2018 15:18:51 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: John Whitmore <johnfwhitmore@gmail.com>
Cc: linux-kernel@vger.kernel.org, kstewart@linuxfoundation.org,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        colin.king@canonical.com, tglx@linutronix.de
Subject: Re: [PATCH v6 8/8] staging: rtl8192e: remove unnecessary parentheses
 - Coding Style
Message-ID: <20180608121851.o7m3iihg2ibbgmxh@mwanda>
References: <20180606114003.22654-1-johnfwhitmore@gmail.com>
 <20180606114003.22654-9-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606114003.22654-9-johnfwhitmore@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8917 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=796
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806080141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 12:40:03PM +0100, John Whitmore wrote:
> @@ -1072,10 +1072,10 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
>  	pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
>  
>  	// Initialize all of the parameters related to 11n
> -	memset((void *)(&(pHTInfo->SelfHTCap)), 0, sizeof(pHTInfo->SelfHTCap));
> -	memset((void *)(&(pHTInfo->SelfHTInfo)), 0, sizeof(pHTInfo->SelfHTInfo));
> -	memset((void *)(&(pHTInfo->PeerHTCapBuf)), 0, sizeof(pHTInfo->PeerHTCapBuf));
> -	memset((void *)(&(pHTInfo->PeerHTInfoBuf)), 0, sizeof(pHTInfo->PeerHTInfoBuf));
> +	memset((void *)(&pHTInfo->SelfHTCap), 0, sizeof(pHTInfo->SelfHTCap));
> +	memset((void *)(&pHTInfo->SelfHTInfo), 0, sizeof(pHTInfo->SelfHTInfo));
> +	memset((void *)(&pHTInfo->PeerHTCapBuf), 0, sizeof(pHTInfo->PeerHTCapBuf));
> +	memset((void *)(&pHTInfo->PeerHTInfoBuf), 0, sizeof(pHTInfo->PeerHTInfoBuf));

You should write these like so:

	memset(&pHTInfo->PeerHTInfoBuf, 0, sizeof(pHTInfo->PeerHTInfoBuf));

The first 7 patches look fine, but can you resend this last one?

regards,
dan carpenter
