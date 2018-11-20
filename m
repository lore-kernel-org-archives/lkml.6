Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193BCC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD0D20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD0D20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732847AbeKTSC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:02:27 -0500
Received: from a.mx.secunet.com ([62.96.220.36]:48650 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbeKTSC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:02:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id C21F6200A0;
        Tue, 20 Nov 2018 08:34:44 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y7nhkT9ojf7r; Tue, 20 Nov 2018 08:34:44 +0100 (CET)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 525702006E;
        Tue, 20 Nov 2018 08:34:44 +0100 (CET)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.408.0; Tue, 20 Nov 2018
 08:34:43 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id C116E318035F;
 Tue, 20 Nov 2018 08:34:43 +0100 (CET)
Date:   Tue, 20 Nov 2018 08:34:43 +0100
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Colin King <colin.king@canonical.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] af_key: fix indentation on declaration statement
Message-ID: <20181120073443.GB3581@gauss3.secunet.de>
References: <20181113142328.8322-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181113142328.8322-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 2FB20EDB-8212-442D-B6EA-E07059497BE2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 02:23:28PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is an indentation issue before the declaration of xfrm_ctx. Remove
> spaces and replace with a tab.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to ipsec-next.
