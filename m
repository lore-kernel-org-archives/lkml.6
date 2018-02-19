Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753377AbeBSRhU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:37:20 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:45722 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753186AbeBSRhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:37:18 -0500
X-Google-Smtp-Source: AH8x225egm65ize33/AkN9cpM7ur47I+fzcsTlbXPydz8M06dHfC2gy2KW7c/8WOB498W3u4b1mVHA==
Date: Mon, 19 Feb 2018 09:37:14 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "'Colin King'" <colin.king@canonical.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][V2] net: dsa: mv88e6xxx: avoid unintended sign extension
 on a 16 bit shift
Message-ID: <20180219173714.6frfl3nfq3gi4jsv@localhost>
References: <20180216165505.20058-1-colin.king@canonical.com>
 <a97bab4dc79c4b7da76826843909cae9@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a97bab4dc79c4b7da76826843909cae9@AcuMS.aculab.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 12:19:16PM +0000, David Laight wrote:
> This seems to be somewhat excessive 64bit maths on a 32bit system.
> It is more than enough to make timelo/timehi 'unsigned int'.

Do you see a difference in the generated code?

Thanks,
Richard
