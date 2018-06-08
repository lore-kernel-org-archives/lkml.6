Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lhQeD4mIGlucDAAAmS7hNA
	; Fri, 08 Jun 2018 13:45:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2C5786089E; Fri,  8 Jun 2018 13:45:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C59C960590;
	Fri,  8 Jun 2018 13:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C59C960590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbeFHNpn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:45:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:53435 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbeFHNpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:45:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D4E51AEFB;
        Fri,  8 Jun 2018 13:45:40 +0000 (UTC)
Date: Fri, 8 Jun 2018 15:45:39 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        =?ISO-8859-15?Q?Cl=E9ment_VUCHENER?= <clement.vuchener@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH] HID: steam: use hid_device.driver_data instead of
 hid_set_drvdata()
In-Reply-To: <20180601182750.GA23501@casa>
Message-ID: <nycvar.YFH.7.76.1806081545070.6203@cbobk.fhfr.pm>
References: <20180522201006.14003-1-rodrigorivascosta@gmail.com> <20180601182750.GA23501@casa>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2018, Rodrigo Rivas Costa wrote:

> Could you check my previous patch to see if it makes any sense?
> My machine currently crashes without it, but I'm not sure why. If you
> think it is worth it I can try and bisect it.

I sent a pull request to Linus earlier today, I'll stage this for 2nd wave 
so that it still goes in for 4.18.

-- 
Jiri Kosina
SUSE Labs
