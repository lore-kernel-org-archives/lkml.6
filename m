Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752300AbeCZWub (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:50:31 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42870 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751674AbeCZWu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:50:29 -0400
Date: Tue, 27 Mar 2018 00:50:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rob Herring <robh@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 4/8] dt-bindings: net: add DT bindings for
 Microsemi Ocelot Switch
Message-ID: <20180326225020.GF5862@lunn.ch>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-5-alexandre.belloni@bootlin.com>
 <a5db6109-c5d9-f573-893c-f7d66c3168c2@gmail.com>
 <20180326222514.4eciw66aihhcjgtw@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326222514.4eciw66aihhcjgtw@rob-hp-laptop>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> ports and port collide with the OF graph binding. It would be good if 
> this moved to ethernet-port(s) or similar.

Hi Rob

Well, we have been using port in DSA since March 2013. ports is a bit
newer, June 2016.

Changing DSA is not going to happen. But new switch bindings could use
ethernet-port(s). It just makes them inconsistent with existing switch
drivers.

       Andrew
