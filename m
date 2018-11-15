Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEFAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6172145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRPA3h1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6172145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeKPJNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:13:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:54016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeKPJNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:13:14 -0500
Received: from localhost (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 925A92087A;
        Thu, 15 Nov 2018 23:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542323004;
        bh=iN+HcPVrVTG76ymFJ7JIRGrfv7ZyuKMv6oeuH3TUUpk=;
        h=Date:From:To:Cc:Subject:From;
        b=BRPA3h1afd+BzrJj2Hoy9rujPsxUDYbsKrlCkSrZSBDms883zHKijQqi7t8q0Bavb
         05wB6R12fY2Qy8EO8CwCh1O96qCTPsgOqF/Aaz55CQDw5U6le1E8Jth2aFGKh7T44H
         b3pjEUMBGkeOHRNM1JFNVnahNqpxo8vzp1H1gGxk=
Date:   Thu, 15 Nov 2018 15:03:24 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sasha Levin <sashal@kernel.org>
Subject: [PATCH] MAINTAINERS: Add Sasha as a stable branch maintainer
Message-ID: <20181115230324.GA26439@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha has somehow been convinced into helping me with the stable kernel
maintenance.  Codify this slip in good judgement before he realizes what
he really signed up for :)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Sasha Levin <sashal@kernel.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 0abecc528dac..a46c1aa82398 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14078,6 +14078,7 @@ F:	Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
 
 STABLE BRANCH
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+M:	Sasha Levin <sashal@kernel.org>
 L:	stable@vger.kernel.org
 S:	Supported
 F:	Documentation/process/stable-kernel-rules.rst
