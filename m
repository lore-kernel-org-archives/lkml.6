Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FA4C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA55259E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA55259E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933269AbeFYNOG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:14:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:48555 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755414AbeFYNOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:14:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C1AC3ABDF;
        Mon, 25 Jun 2018 13:14:03 +0000 (UTC)
Date:   Mon, 25 Jun 2018 15:14:02 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 0/2] Add another regulator to i2c-hid
In-Reply-To: <20180622022717.134300-1-swboyd@chromium.org>
Message-ID: <nycvar.YFH.7.76.1806251513510.6203@cbobk.fhfr.pm>
References: <20180622022717.134300-1-swboyd@chromium.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied both to for-4.19/i2c-hid. Thanks,

-- 
Jiri Kosina
SUSE Labs

