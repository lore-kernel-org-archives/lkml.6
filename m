Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03348C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B7024D57
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B7024D57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754359AbeGCG27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:28:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754080AbeGCG26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:28:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84C921B6F;
        Tue,  3 Jul 2018 06:28:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-220.phx2.redhat.com [10.3.116.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F36EA16D23;
        Tue,  3 Jul 2018 06:28:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3EF5C17442; Tue,  3 Jul 2018 08:28:57 +0200 (CEST)
Date:   Tue, 3 Jul 2018 08:28:57 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, svptas.linux@gmail.com,
        ajitn.linux@gmail.com, brajeswar.linux@gmail.com,
        sabyasachi.linux@gmail.com
Subject: Re: [PATCH] gpu: drm: virito: code cleanup
Message-ID: <20180703062857.6fdjg5trv4a7z5zl@sirius.home.kraxel.org>
References: <20180702182728.GA6015@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702182728.GA6015@jordon-HP-15-Notebook-PC>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 03 Jul 2018 06:28:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 11:57:28PM +0530, Souptick Joarder wrote:
> The fault handler code is commented since v4.2.
> If there is no plan to enable the fault handler
> code in future, we can remove this dead code.

Indeed, but please without tyops in the $subject line.

cheers,
  Gerd

