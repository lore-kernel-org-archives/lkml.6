Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E66C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BB22083A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BB22083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935610AbeFRR7y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:59:54 -0400
Received: from gateway20.websitewelcome.com ([192.185.62.46]:20454 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935347AbeFRR7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:59:53 -0400
X-Greylist: delayed 1483 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jun 2018 13:59:53 EDT
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 588A7400C40E8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 12:35:09 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Uy3AfL6ozbXuJUy3OfYA90; Mon, 18 Jun 2018 12:35:09 -0500
X-Authority-Reason: nr=8
Received: from [189.250.78.11] (port=50012 helo=[192.168.1.71])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fUy3A-003bj1-2O; Mon, 18 Jun 2018 12:34:44 -0500
Subject: Re: [smb3] unreachable code and memory leaks
To:     Steve French <smfrench@gmail.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180618130737.GA13880@embeddedor.com>
 <CAH2r5muZJkx0eR0uAyuRBkkTf7-97x5oSMWPXdfb1TUK4rwGJw@mail.gmail.com>
 <CAH2r5mvu7e2ec6fb0Aay5OAr8S31jy=j7_7sL_VRfi6U2G_mZA@mail.gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <c447e18b-439d-f125-f74c-9c50a0d55e5b@embeddedor.com>
Date:   Mon, 18 Jun 2018 12:34:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAH2r5mvu7e2ec6fb0Aay5OAr8S31jy=j7_7sL_VRfi6U2G_mZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.78.11
X-Source-L: No
X-Exim-ID: 1fUy3A-003bj1-2O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.250.78.11]:50012
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Steve,

On 06/18/2018 12:18 PM, Steve French wrote:
> Gustavo,
> Thx for pointing this out.  Let me know if this patch addresses what
> you found.  Code is experimental mount option but extremely important
> to get right due to move away from SMB1/CIFS which had posix
> extensions.
> 

Yep. It seems correct.

Reviewed-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks!
--
Gustavo
