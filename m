Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754056AbeDTHsc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:48:32 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33837 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753765AbeDTHsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:48:30 -0400
X-Google-Smtp-Source: AIpwx49MBBGctUOSCB5a5UjMHeiufJwXlotyXPiOYWJHikpcyUQTssKlYfqBBLnAAkkk5pVDf0rU+A==
Date: Fri, 20 Apr 2018 09:48:26 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, afd@ti.com,
        linux-pm@vger.kernel.org
Subject: Re: bq27000: directory/files exists even when hardware is not
 available
Message-ID: <20180420074826.c7cy4z3tq7c56ccs@pali>
References: <20180420074036.GA16257@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180420074036.GA16257@amd>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 April 2018 09:40:36 Pavel Machek wrote:
> Hi!
> 
> On droid4 (4.17-rc1), /sys/class/power_supply/bq27000-battery exists
> even when hardware is not present (as on Droid 4).
> 
> Any ideas?
> 									Pavel

Somebody must have registered bq device into power_supply subsystem.
Maybe DT note is present?

-- 
Pali Rohár
pali.rohar@gmail.com
