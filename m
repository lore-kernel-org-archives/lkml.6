Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753832AbeCPLZM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:25:12 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:57204 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753536AbeCPLZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:25:10 -0400
Date: Fri, 16 Mar 2018 12:09:07 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Kenneth Chan <kenneth.t.chan@gmail.com>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86: panasonic-laptop: add support to mute and
 hardware optical switch
Message-ID: <20180316110907.GK3523@nataraja>
References: <CAPqSeKv0Q+ocBYeonxi5w8XB0vaM27O1hcDm9ZDdXxCt7Py=Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPqSeKv0Q+ocBYeonxi5w8XB0vaM27O1hcDm9ZDdXxCt7Py=Pw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kenneth,

thanks for your fix.  I'm not currently using any Panasonic Laptop devices
anymore (After the CF-R series was discontinued), so I'm not able to properly
maintain this driver anymore.

However, your changes look sound to me (aside from that we don't use C++ style
comments in kernel source code), hence:

Acked-by: Harald Welte <laforge@gnumonks.org>

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
