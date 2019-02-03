Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27A9C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 04:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8CB2083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 04:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfBCEKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 23:10:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbfBCEKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 23:10:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA827C059B88;
        Sun,  3 Feb 2019 04:10:35 +0000 (UTC)
Received: from localhost (ovpn-112-14.rdu2.redhat.com [10.10.112.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 954427B644;
        Sun,  3 Feb 2019 04:10:32 +0000 (UTC)
Date:   Sat, 02 Feb 2019 20:10:31 -0800 (PST)
Message-Id: <20190202.201031.939725225267845792.davem@redhat.com>
To:     alex.williams@ettus.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mdf@kernel.org,
        mcgrof@kernel.org, keescook@chromium.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williams@ni.com
Subject: Re: [PATCH v2 net-next 2/2] net: nixge: Update device-tree
 bindings with v3.00
From:   David Miller <davem@redhat.com>
In-Reply-To: <20190131213328.11236-2-alex.williams@ettus.com>
References: <20190131213328.11236-1-alex.williams@ettus.com>
        <20190131213328.11236-2-alex.williams@ettus.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sun, 03 Feb 2019 04:10:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: alex.williams@ettus.com
Date: Thu, 31 Jan 2019 13:33:28 -0800

> From: Alex Williams <alex.williams@ni.com>
> 
> Now the DMA engine is free to float elsewhere in the system map.
> 
> Signed-off-by: Alex Williams <alex.williams@ni.com>

Applied.
