Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667F3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36199214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36199214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbeKNWRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:17:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbeKNWRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:17:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A9C030014DA;
        Wed, 14 Nov 2018 12:14:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-219.ams2.redhat.com [10.36.116.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F9BF1001914;
        Wed, 14 Nov 2018 12:14:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7FAA4944; Wed, 14 Nov 2018 13:14:12 +0100 (CET)
Date:   Wed, 14 Nov 2018 13:14:12 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Robert Foss <robert.foss@collabora.com>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Subject: Re: [PATCH v5 0/4] virgl: fence fd support
Message-ID: <20181114121412.zm24ua4np3yi5gxx@sirius.home.kraxel.org>
References: <20181112165157.32765-1-robert.foss@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112165157.32765-1-robert.foss@collabora.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 14 Nov 2018 12:14:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 05:51:53PM +0100, Robert Foss wrote:
> 
> This series implements fence support for drm/virtio and
> has been tested using qemu, kmscube and the below branches.
> 
> Rob Herring solved a reference counting issue and
> suggested a context check for the execbuf ioctl, his
> changes have been included in the below commits to
> keep the tree working at all commits.

Patches added to qemu queue, should land in drm-misc-next soon.

thanks,
  Gerd

