Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C33BC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DB721946
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DB721946
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbeFUR6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:58:32 -0400
Received: from gateway30.websitewelcome.com ([192.185.151.58]:45576 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752650AbeFUR6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:58:30 -0400
X-Greylist: delayed 1310 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jun 2018 13:58:30 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id F17C4D0E1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 12:36:39 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id W3VEfv4k079N3W3VUfMOLm; Thu, 21 Jun 2018 12:36:39 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=41012 helo=[192.168.1.71])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fW3VE-0045B8-Ce; Thu, 21 Jun 2018 12:36:12 -0500
Subject: Re: [PATCH] CIFS: fix structurally dead code in smb311_posix_mkdir
To:     Steve French <smfrench@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Aurelien Aptel <aaptel@suse.com>, Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180621133523.GA30313@embeddedor.com>
 <CAH2r5mur0tSLZiUkThB8b5fKbaDyguXT87f5J+V1buCv-Ep73g@mail.gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <8474f81b-2471-db10-1893-dc9784a4f8ee@embeddedor.com>
Date:   Thu, 21 Jun 2018 12:36:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAH2r5mur0tSLZiUkThB8b5fKbaDyguXT87f5J+V1buCv-Ep73g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fW3VE-0045B8-Ce
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.250.65.56]:41012
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/21/2018 11:59 AM, Steve French wrote:
> Folded this patch and the equivalent one from Dan in with the comments
> from Aurelien  into one patch and repushed to cifs-2.6.git for-next -
> see attached.
> 

Fine. You can add my Signed-off-by

Thanks
--
Gustavo
