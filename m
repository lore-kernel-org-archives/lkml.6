Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CBAC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 04:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD8C2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 04:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfBCEPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 23:15:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbfBCEPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 23:15:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C4D5E77DB;
        Sun,  3 Feb 2019 04:15:02 +0000 (UTC)
Received: from localhost (ovpn-112-14.rdu2.redhat.com [10.10.112.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AAFF5F724;
        Sun,  3 Feb 2019 04:14:59 +0000 (UTC)
Date:   Sat, 02 Feb 2019 20:14:58 -0800 (PST)
Message-Id: <20190202.201458.1447579059028146414.davem@redhat.com>
To:     colin.king@canonical.com
Cc:     rmody@marvell.com, skalluru@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bna: fix indentation issue on call to bfa_ioc_pf_failed
From:   David Miller <davem@redhat.com>
In-Reply-To: <20190202113707.18005-1-colin.king@canonical.com>
References: <20190202113707.18005-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 03 Feb 2019 04:15:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Sat,  2 Feb 2019 11:37:07 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> The call to bfa_ioc_pf_failed is indented too far, fix this by
> removing a tab.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
