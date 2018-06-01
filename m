Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeFAQkd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:40:33 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:36074 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752641AbeFAQkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:40:31 -0400
Date: Fri, 1 Jun 2018 09:40:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Bastian Germann <bastiangermann@fishpost.de>
Cc: Luca Tettamanti <kronos.it@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] hwmon: (asus_atk0110) Make use of device managed
 memory
Message-ID: <20180601164029.GC4946@roeck-us.net>
References: <8afcabf0-94c2-8068-5252-491494108a0c@roeck-us.net>
 <20180601151419.15820-1-bastiangermann@fishpost.de>
 <20180601151419.15820-3-bastiangermann@fishpost.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601151419.15820-3-bastiangermann@fishpost.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 05:14:19PM +0200, Bastian Germann wrote:
> Use devm_* variants of kstrdup and kzalloc. Get rid of kfree cleanups.
> 
> Signed-off-by: Bastian Germann <bastiangermann@fishpost.de>

Thanks a lot for the cleanup and fast turnaround.

Applied to hwmon-next.

Thanks,
Guenter
