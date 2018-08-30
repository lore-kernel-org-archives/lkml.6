Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B206C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB85720835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="KXoy4cEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB85720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbeH3Su6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:50:58 -0400
Received: from mail.nic.cz ([217.31.204.67]:40012 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729084AbeH3Su4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:50:56 -0400
Received: from localhost (unknown [172.20.6.218])
        by mail.nic.cz (Postfix) with ESMTPS id 95232600EA;
        Thu, 30 Aug 2018 16:48:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1535640504; bh=22pmDJtI029jdykWn9sJOFEmVrYt8q36bmbHiSOtLlc=;
        h=Date:From:To;
        b=KXoy4cEKW2IwK3ET7OyUS+9wqcqjpt5svlBjZPtj8+R2crn+/TdsfdeTYrNIfEFI9
         eQY74ZhSp5meCsD2hTFZATk0U98hsb4/OEbyouOkc4/OdRzUV9shbiC7DO/9l/s3Tu
         J9JzYHW43Mg1EhZCLfgQszsIEDTGDBZzKv6mHjG0=
Date:   Thu, 30 Aug 2018 16:47:43 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH mfd+gpio] Request (Linus Walleij + Lee Jones)
Message-ID: <20180830164743.63c6e27d@nic.cz>
In-Reply-To: <20180830144151.13417-1-marek.behun@nic.cz>
References: <20180830144151.13417-1-marek.behun@nic.cz>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and Lee,
these two patches touch two different subsystems (mfd + gpio) and
should be applyied one after another (the gpio part is dependant on the
mfd part).
The patches are based on mfd-next-4.19. I can send another copy based
on gpio/devel.
Could you two, Linus and Lee, work together on applying these patches?
I don't know how this is usually solved...
Thanks.

Marek
