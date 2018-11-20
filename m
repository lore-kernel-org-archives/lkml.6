Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D434EC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A6220851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A6220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbeKUAaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:30:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:56752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725846AbeKUAaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:30:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7DB52B028;
        Tue, 20 Nov 2018 14:01:27 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] net: phy: mscc: fix locking in vsc85xx_default_config
References: <20181008100728.24959-1-quentin.schulz@bootlin.com>
        <20181008100728.24959-2-quentin.schulz@bootlin.com>
        <mvm8t1pazea.fsf@suse.de> <mvma7m3n9l6.fsf_-_@suse.de>
        <20181120135508.paxzs63cqy2llc7d@qschulz>
X-Yow:  CHUBBY CHECKER owns my BUILDING!
Date:   Tue, 20 Nov 2018 15:01:25 +0100
In-Reply-To: <20181120135508.paxzs63cqy2llc7d@qschulz> (Quentin Schulz's
        message of "Tue, 20 Nov 2018 14:55:08 +0100")
Message-ID: <mvm5zwrn8zu.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 20 2018, Quentin Schulz <quentin.schulz@bootlin.com> wrote:

> You also need to prefix your patch with [PATCH net-next] instead of only
> [PATCH]. This is specific to the net subsystem.

Why next?  This is a bug fix that needs to go in now, not next.

> Use scripts/get_maintainer.pl on your patch to get the people to put in
> Cc and in To.

The same people as the original patch the added the bug.  Why would it
be different now?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
