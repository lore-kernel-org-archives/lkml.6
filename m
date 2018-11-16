Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DC8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F70208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F70208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeKPSDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:03:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbeKPSDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 13:03:35 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0AC3E3084244;
        Fri, 16 Nov 2018 07:52:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.36.118.1])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFDED103BAB6;
        Fri, 16 Nov 2018 07:52:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id DAABE76FA; Fri, 16 Nov 2018 08:52:19 +0100 (CET)
Date:   Fri, 16 Nov 2018 08:52:19 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Gurchetan Singh <gurchetansingh@chromium.org>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udmabuf: set read/write flag when exporting
Message-ID: <20181116075219.4asi7ficl5itnu6o@sirius.home.kraxel.org>
References: <20181114122029.16766-1-kraxel@redhat.com>
 <CAAfnVBmhpMDi8EVUNZxWTU38ZWoO61eyG1-=bRqoe3hoQ08E0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfnVBmhpMDi8EVUNZxWTU38ZWoO61eyG1-=bRqoe3hoQ08E0A@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 16 Nov 2018 07:52:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 05:46:30PM -0800, Gurchetan Singh wrote:
> Reviewed-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Tested-by: Gurchetan Singh <gurchetansingh@chromium.org>

Thanks.  Pushed to drm-misc-fixes.

cheers,
  Gerd

