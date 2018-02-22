Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932878AbeBVOvx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:51:53 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34255 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932696AbeBVOvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:51:51 -0500
X-Google-Smtp-Source: AH8x227VpaaTUKUXggmgUGGJAdMLHUXVr1Yt4c4topMS4G+xBxvDjKOMqunCcGYbuyFLdoCr//Qk6g==
Date: Thu, 22 Feb 2018 06:51:47 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Brandon Streiff <brandon.streiff@ni.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dsa: ptp; mark dummy helpers as 'inline'
Message-ID: <20180222145147.fwshubwqmxrshpav@localhost>
References: <20180222114459.1272945-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222114459.1272945-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 12:44:40PM +0100, Arnd Bergmann wrote:
> Declaring a static function in a header leads to a warning every
> time that header gets included without the function being used:

Acked-by: Richard Cochran <richardcochran@gmail.com>
