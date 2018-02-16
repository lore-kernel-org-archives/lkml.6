Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758420AbeBPPxv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:53:51 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:45677 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758270AbeBPPxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:53:48 -0500
X-Google-Smtp-Source: AH8x227ZpBtALbqqZJkedqRkaR8YP4bkUxcK7f9FkaxAFMuw/8PLcT8ReN48dpTovc7MIhD49/IjFg==
Date: Fri, 16 Feb 2018 07:53:45 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: dsa: mv88e6xxx: avoid unintended sign
 extension on a 16 bit shift
Message-ID: <20180216155345.zlgmmna7u47xgb36@localhost>
References: <20180215191218.27936-1-colin.king@canonical.com>
 <20180215202757.GB3080@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215202757.GB3080@lunn.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 09:27:57PM +0100, Andrew Lunn wrote:
> Do you prefer this, or making timehi and timelo a u64?

The latter.

While you are at it, please move the definition of 'ns' to the start
of the function.

Thanks,
Richard
