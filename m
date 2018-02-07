Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbeBGXao (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 18:30:44 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:43029 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeBGXam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 18:30:42 -0500
X-Google-Smtp-Source: AH8x226n/U7cPj+OAHUEwLA42jDoNBqXgJ2axnCaMwDkecra6VPi3DGN2bf0GkmiIIdCc7NP4YTBdA==
Date: Thu, 8 Feb 2018 01:30:38 +0200
From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To: Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix net watchdog timeout
Message-ID: <20180207233037.GC7883@khorivan>
Mail-Followup-To: Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
References: <20180207011706.13393-1-grygorii.strashko@ti.com>
 <20180207030316.GA7883@khorivan>
 <20180207133105.GB7883@khorivan>
 <ed2d0226-05ac-3d9f-1ca6-1e7063f54d41@ti.com>
 <20180207230704.GA3489@khorivan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207230704.GA3489@khorivan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rechecked once again, seems it covers every case, at this moment, so

Reviewed-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

-- 
Regards,
Ivan Khoronzhuk
