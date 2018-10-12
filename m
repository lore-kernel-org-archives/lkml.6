Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DB8C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DBB2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DBB2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbeJLXTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:19:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729209AbeJLXTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:19:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C0B4308FB8D;
        Fri, 12 Oct 2018 15:46:44 +0000 (UTC)
Received: from localhost (ovpn-116-193.ams2.redhat.com [10.36.116.193])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E41E82F48;
        Fri, 12 Oct 2018 15:46:38 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Joe Perches <joe@perches.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] MAINTAINERS: remove reference to bogus vsock file
Date:   Fri, 12 Oct 2018 16:46:37 +0100
Message-Id: <20181012154637.13242-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 12 Oct 2018 15:46:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file drivers/vhost/vsock.h never existed.  Remove the bogus
MAINTAINERS reference.

Fixes: 433fc58e6bf2c8bd97e57153ed28e64fd78207b8 ("VSOCK: Introduce vhost_vsock.ko")
Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40082e45b3da..05191d706bb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15529,7 +15529,6 @@ F:	net/vmw_vsock/virtio_transport_common.c
 F:	net/vmw_vsock/virtio_transport.c
 F:	drivers/net/vsockmon.c
 F:	drivers/vhost/vsock.c
-F:	drivers/vhost/vsock.h
 F:	tools/testing/vsock/
 
 VIRTIO CONSOLE DRIVER
-- 
2.17.2

