Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeCZSmC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 14:42:02 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42566 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751908AbeCZSmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 14:42:01 -0400
Date: Mon, 26 Mar 2018 20:41:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Subject: Re: [PATCH v2] of_net: Implement of_get_nvmem_mac_address helper
Message-ID: <20180326184159.GA5862@lunn.ch>
References: <1521815074-30424-1-git-send-email-mike.looijmans@topic.nl>
 <20180323151101.GB24361@lunn.ch>
 <1522046489-19652-1-git-send-email-mike.looijmans@topic.nl>
 <20180326155010.GC3014@lunn.ch>
 <e151482e-7f67-c072-e946-95f6819c3bc2@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e151482e-7f67-c072-e946-95f6819c3bc2@topic.nl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> fwnode_get_mac_address looks really new, there's only one user so far. Is it
> the intention that all drivers eventually migrate to that?

Hi Mike

Probably not. But any driver which needs to work with both ACPI and OF
is likely to use this API. So server class ARM64 chips for example.

   Andrew
