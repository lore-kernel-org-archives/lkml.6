Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5909EC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 04:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C262084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 04:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfBCEPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 23:15:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfBCEPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 23:15:07 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7973F356CA;
        Sun,  3 Feb 2019 04:15:07 +0000 (UTC)
Received: from localhost (ovpn-112-14.rdu2.redhat.com [10.10.112.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58C76A63D1;
        Sun,  3 Feb 2019 04:15:05 +0000 (UTC)
Date:   Sat, 02 Feb 2019 20:15:04 -0800 (PST)
Message-Id: <20190202.201504.696180725335612120.davem@redhat.com>
To:     colin.king@canonical.com
Cc:     jcliburn@gmail.com, chris.snook@gmail.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atl1c: fix indentation issue on an if statement
From:   David Miller <davem@redhat.com>
In-Reply-To: <20190202114129.18275-1-colin.king@canonical.com>
References: <20190202114129.18275-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 03 Feb 2019 04:15:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Sat,  2 Feb 2019 11:41:29 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> An if statement is indented one level too deep, fix this by removing
> the extra tabs. Also add some spaces to the dev_warn arguments to clean
> up checkpatch warnings.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
