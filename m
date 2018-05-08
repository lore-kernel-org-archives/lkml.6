Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754533AbeEHIIS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 04:08:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:37329 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753856AbeEHIIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 04:08:15 -0400
Date: Tue, 8 May 2018 10:08:13 +0200
From: Johannes Thumshirn <jth@kernel.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: mena21_wdt: Drop unnecessary mutex lock
Message-ID: <20180508080813.vhdkko2a4vmb4avz@linux-x5ow.site>
References: <20180508071206.13375-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180508071206.13375-1-baijiaju1990@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,
Reviewed-by: Johannes Thumshirn <jth@kernel.org>
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
