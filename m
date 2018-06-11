Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id o5dCCpdmHlvqFQAAmS7hNA
	; Mon, 11 Jun 2018 12:11:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id ACDCA607BB; Mon, 11 Jun 2018 12:11:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4A1F160791;
	Mon, 11 Jun 2018 12:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A1F160791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933091AbeFKMLv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 08:11:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:43235 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932834AbeFKMLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:11:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B9A7DAC50;
        Mon, 11 Jun 2018 12:11:48 +0000 (UTC)
Date: Mon, 11 Jun 2018 14:11:47 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Nicolas Boichat <drinkcat@chromium.org>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: google: Add support for whiskers
In-Reply-To: <20180608001450.76836-1-drinkcat@chromium.org>
Message-ID: <nycvar.YFH.7.76.1806111411390.6203@cbobk.fhfr.pm>
References: <20180608001450.76836-1-drinkcat@chromium.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2018, Nicolas Boichat wrote:

> Another device in the hammer class, with USB id 0x5030.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
