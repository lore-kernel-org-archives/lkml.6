Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C58C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 04:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5092083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 04:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfBCEKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 23:10:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfBCEKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 23:10:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B222356D2;
        Sun,  3 Feb 2019 04:10:30 +0000 (UTC)
Received: from localhost (ovpn-112-14.rdu2.redhat.com [10.10.112.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05F7D80283;
        Sun,  3 Feb 2019 04:10:26 +0000 (UTC)
Date:   Sat, 02 Feb 2019 20:10:25 -0800 (PST)
Message-Id: <20190202.201025.1831371623652661602.davem@redhat.com>
To:     alex.williams@ettus.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mdf@kernel.org,
        mcgrof@kernel.org, keescook@chromium.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williams@ni.com
Subject: Re: [PATCH v2 net-next 1/2] net: nixge: Separate ctrl and dma
 resources
From:   David Miller <davem@redhat.com>
In-Reply-To: <20190131213328.11236-1-alex.williams@ettus.com>
References: <20190131213328.11236-1-alex.williams@ettus.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 03 Feb 2019 04:10:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: alex.williams@ettus.com
Date: Thu, 31 Jan 2019 13:33:27 -0800

> From: Alex Williams <alex.williams@ni.com>
> 
> The DMA engine is a separate entity altogether, and this allows the DMA
> controller's address to float elsewhere in the FPGA's map.
> 
> Signed-off-by: Alex Williams <alex.williams@ni.com>

Applied.
