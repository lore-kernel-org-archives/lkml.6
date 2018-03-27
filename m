Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeC0Aew (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 20:34:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751776AbeC0Aev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 20:34:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A264217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AIpwx482/+fpuCtrRD0mQPqU/EC2J1bFmUnGCPgid3vKAzZKZ0l2OaFtXohXnBEOSh/gORAfy3PicoGqjM0WtYrnXxY=
MIME-Version: 1.0
In-Reply-To: <20180326225020.GF5862@lunn.ch>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-5-alexandre.belloni@bootlin.com> <a5db6109-c5d9-f573-893c-f7d66c3168c2@gmail.com>
 <20180326222514.4eciw66aihhcjgtw@rob-hp-laptop> <20180326225020.GF5862@lunn.ch>
From: Rob Herring <robh@kernel.org>
Date: Mon, 26 Mar 2018 19:34:29 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+T+TpoLixbi+jrrtUSp_wRSwrrP2Oe2igbapoFonx1FA@mail.gmail.com>
Message-ID: <CAL_Jsq+T+TpoLixbi+jrrtUSp_wRSwrrP2Oe2igbapoFonx1FA@mail.gmail.com>
Subject: Re: [PATCH net-next 4/8] dt-bindings: net: add DT bindings for
 Microsemi Ocelot Switch
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        Po Liu <po.liu@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 5:50 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> ports and port collide with the OF graph binding. It would be good if
>> this moved to ethernet-port(s) or similar.
>
> Hi Rob
>
> Well, we have been using port in DSA since March 2013. ports is a bit
> newer, June 2016.

Yes, understood.

>
> Changing DSA is not going to happen. But new switch bindings could use
> ethernet-port(s). It just makes them inconsistent with existing switch
> drivers.

I'm not saying to change existing bindings, but evolve to something
that doesn't collide on new bindings if you don't have dependencies on
what the node names are. It's mainly so we can have something to key
off of to validate bindings better.

Rob
