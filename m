Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752707AbeEVVC0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:02:26 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41278 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752365AbeEVVCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:02:25 -0400
Date: Tue, 22 May 2018 23:02:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Gerhard Wiesinger <lists@wiesinger.com>, linux-kernel@vger.kernel.org
Subject: Re: B53 DSA switch problem on Banana Pi-R1 on Fedora 26
Message-ID: <20180522210223.GC4396@lunn.ch>
References: <3bdb712d-38bd-e2ca-63cf-8406a7b5689d@wiesinger.com>
 <20180522201632.GB4396@lunn.ch>
 <59d6b55f-d50a-063c-90a9-31a758e01383@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59d6b55f-d50a-063c-90a9-31a758e01383@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 01:42:40PM -0700, Florian Fainelli wrote:
> On 05/22/2018 01:16 PM, Andrew Lunn wrote:
> >> Planned network structure will be as with 4.7.x kernels:
> >>
> >> br0 <=> eth0.101 <=> eth0 (vlan 101 tagged) <=> lan 1-lan4 (vlan 101
> >> untagged pvid)
> >>
> >> br1 <=> eth0.102 <=> eth0 (vlan 102 tagged) <=> wan (vlan 102 untagged pvid)
> > 
> > Do you even need these vlans?
> 
> Yes, remember, b53 does not currently turn on Broadcom tags, so the only
> way to segregate traffic is to have VLANs for that.

Ah, i didn't remember that.

    Andrew
